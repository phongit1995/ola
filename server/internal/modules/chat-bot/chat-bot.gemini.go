package chatbot

import (
	"bytes"
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"regexp"
	"strconv"
	"strings"
	"time"

	"ola-chat-server/internal/constants"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

var (
	ErrUpstreamRejected = errors.New("chat bot upstream rejected request")
	ErrStreamChanged    = errors.New("chat bot stream content changed during retry")
	ErrEmptyResponse    = errors.New("chat bot returned an empty response")
)

var (
	codeBlockNoisePattern = regexp.MustCompile("(?s)```(?:python|javascript|text)\\?code_(?:reference|stdout)&code_event_index=\\d+\\n.*?```\\n?")
	cardContentPattern    = regexp.MustCompile(`http://googleusercontent\.com/card_content/\d+\n?`)
	bardErrorPattern      = regexp.MustCompile(`BardErrorInfo\s*\[(\d+)\]`)
)

type GeminiClient struct {
	logger *zap.SugaredLogger
	client *http.Client
	origin string
}

func NewGeminiClient(logger *zap.SugaredLogger) *GeminiClient {
	return &GeminiClient{
		logger: logger.Named("[chat_bot_gemini]"),
		origin: constants.ChatBotGeminiOrigin,
		client: &http.Client{
			Timeout: constants.ChatBotTimeout,
		},
	}
}

func marshalNoEscape(v interface{}) (string, error) {
	var buf bytes.Buffer
	enc := json.NewEncoder(&buf)
	enc.SetEscapeHTML(false)
	if err := enc.Encode(v); err != nil {
		return "", err
	}
	return strings.TrimRight(buf.String(), "\n"), nil
}

func (g *GeminiClient) applyHeaders(req *http.Request) {
	req.Header.Set("Content-Type", "application/x-www-form-urlencoded")
	req.Header.Set("Origin", g.origin)
	req.Header.Set("Referer", g.origin+constants.ChatBotGeminiAppPath)
	req.Header.Set("X-Same-Domain", "1")
	req.Header.Set("User-Agent", constants.ChatBotUserAgent)
}

func buildPayload(prompt string) (string, error) {
	inner := make([]interface{}, 102)

	inner[0] = []interface{}{prompt, 0, nil, nil, nil, nil, 0}
	inner[1] = []interface{}{"en"}
	inner[2] = []interface{}{"", "", "", nil, nil, nil, nil, nil, nil, ""}
	inner[6] = []interface{}{0}
	inner[7] = 1
	inner[10] = 1
	inner[11] = 0
	inner[17] = []interface{}{[]interface{}{constants.ChatBotModelThink}}
	inner[18] = 0
	inner[27] = 1
	inner[30] = []interface{}{4}
	inner[41] = []interface{}{2}
	inner[53] = 0
	inner[59] = uuid.NewString()
	inner[61] = []interface{}{}
	inner[68] = 1
	inner[79] = constants.ChatBotModelMode

	innerJSON, err := marshalNoEscape(inner)
	if err != nil {
		return "", err
	}

	outerJSON, err := marshalNoEscape([]interface{}{nil, innerJSON})
	if err != nil {
		return "", err
	}

	form := url.Values{}
	form.Set("f.req", outerJSON)
	return form.Encode(), nil
}

func (g *GeminiClient) streamURL() string {
	reqID := time.Now().Unix() % 1000000
	return fmt.Sprintf(
		"%s%s?bl=%s&hl=en&_reqid=%d&rt=c",
		g.origin,
		constants.ChatBotGeminiStreamPath,
		url.QueryEscape(constants.ChatBotGeminiBL),
		reqID,
	)
}

func cleanText(text string, trim bool) string {
	text = codeBlockNoisePattern.ReplaceAllString(text, "")
	text = cardContentPattern.ReplaceAllString(text, "")
	if trim {
		return strings.TrimSpace(text)
	}
	return text
}

func upstreamError(raw string) error {
	match := bardErrorPattern.FindStringSubmatch(raw)
	if match == nil {
		return nil
	}
	return fmt.Errorf("%w: BardErrorInfo [%s]", ErrUpstreamRejected, match[1])
}

func extractTextsFromLine(line string) []string {
	if !strings.Contains(line, `"wrb.fr"`) || len(line) < 200 {
		return nil
	}

	var envelope []json.RawMessage
	if err := json.Unmarshal([]byte(line), &envelope); err != nil || len(envelope) == 0 {
		return nil
	}

	var frame []json.RawMessage
	if err := json.Unmarshal(envelope[0], &frame); err != nil || len(frame) < 3 {
		return nil
	}

	var payloadJSON string
	if err := json.Unmarshal(frame[2], &payloadJSON); err != nil || len(payloadJSON) < 50 {
		return nil
	}

	var payload []json.RawMessage
	if err := json.Unmarshal([]byte(payloadJSON), &payload); err != nil || len(payload) < 5 {
		return nil
	}

	var candidates []json.RawMessage
	if err := json.Unmarshal(payload[4], &candidates); err != nil {
		return nil
	}

	var texts []string
	for _, rawCandidate := range candidates {
		var candidate []json.RawMessage
		if err := json.Unmarshal(rawCandidate, &candidate); err != nil || len(candidate) < 2 {
			continue
		}
		var chunks []json.RawMessage
		if err := json.Unmarshal(candidate[1], &chunks); err != nil {
			continue
		}
		for _, rawChunk := range chunks {
			var text string
			if err := json.Unmarshal(rawChunk, &text); err != nil || text == "" {
				continue
			}
			texts = append(texts, text)
		}
	}
	return texts
}

func extractResponseText(raw string) (string, error) {
	if err := upstreamError(raw); err != nil {
		return "", err
	}
	longest := ""
	for _, line := range strings.Split(raw, "\n") {
		for _, text := range extractTextsFromLine(line) {
			if len(text) > len(longest) {
				longest = text
			}
		}
	}
	return cleanText(longest, true), nil
}

func (g *GeminiClient) newRequest(ctx context.Context, body string) (*http.Request, error) {
	req, err := http.NewRequestWithContext(ctx, http.MethodPost, g.streamURL(), strings.NewReader(body))
	if err != nil {
		return nil, err
	}
	g.applyHeaders(req)
	return req, nil
}

func (g *GeminiClient) Generate(ctx context.Context, prompt string) (string, error) {
	body, err := buildPayload(prompt)
	if err != nil {
		return "", err
	}

	var lastErr error
	for attempt := 0; attempt < constants.ChatBotRetryAttempts; attempt++ {
		text, err := g.generateOnce(ctx, body)
		if err == nil {
			return text, nil
		}
		lastErr = err
		if ctx.Err() != nil {
			return "", ctx.Err()
		}
		// Lỗi không thể phục hồi sẽ không thay đổi khi gửi lại cùng payload.
		if errors.Is(err, ErrUpstreamRejected) {
			return "", err
		}
		if attempt < constants.ChatBotRetryAttempts-1 {
			g.logger.Warnw("generate retry", "attempt", attempt+1, "max", constants.ChatBotRetryAttempts, "error", err)
			if err := waitForRetry(ctx); err != nil {
				return "", err
			}
		}
	}
	return "", lastErr
}

func (g *GeminiClient) generateOnce(ctx context.Context, body string) (string, error) {
	req, err := g.newRequest(ctx, body)
	if err != nil {
		return "", err
	}

	resp, err := g.client.Do(req)
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()

	raw, err := io.ReadAll(resp.Body)
	if err != nil {
		return "", err
	}
	if resp.StatusCode >= http.StatusBadRequest {
		return "", upstreamStatusError(resp.StatusCode)
	}
	return extractResponseText(string(raw))
}

// GenerateStream phát từng delta text. Trả về khi upstream đóng kết nối.
// emit trả error để dừng sớm (client ngắt kết nối).
func (g *GeminiClient) GenerateStream(ctx context.Context, prompt string, emit func(delta string) error) error {
	body, err := buildPayload(prompt)
	if err != nil {
		return err
	}

	emitted := ""
	var lastErr error
	for attempt := 0; attempt < constants.ChatBotRetryAttempts; attempt++ {
		err := g.streamOnce(ctx, body, &emitted, emit)
		if err == nil {
			return nil
		}
		lastErr = err
		if ctx.Err() != nil {
			return ctx.Err()
		}
		if errors.Is(err, errEmitAborted) {
			return err
		}
		// Lỗi không thể phục hồi sẽ không thay đổi khi gửi lại cùng payload.
		if errors.Is(err, ErrUpstreamRejected) || errors.Is(err, ErrStreamChanged) {
			return err
		}
		if attempt < constants.ChatBotRetryAttempts-1 {
			g.logger.Warnw("stream retry", "attempt", attempt+1, "max", constants.ChatBotRetryAttempts, "error", err)
			if err := waitForRetry(ctx); err != nil {
				return err
			}
		}
	}
	return lastErr
}

var errEmitAborted = errors.New("chat bot stream consumer aborted")

func waitForRetry(ctx context.Context) error {
	timer := time.NewTimer(constants.ChatBotRetryDelay)
	defer timer.Stop()

	select {
	case <-timer.C:
		return nil
	case <-ctx.Done():
		return ctx.Err()
	}
}

func (g *GeminiClient) streamOnce(ctx context.Context, body string, emitted *string, emit func(delta string) error) error {
	req, err := g.newRequest(ctx, body)
	if err != nil {
		return err
	}

	resp, err := g.client.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	if resp.StatusCode >= http.StatusBadRequest {
		return upstreamStatusError(resp.StatusCode)
	}

	var buf strings.Builder
	chunk := make([]byte, 8192)
	for {
		n, readErr := resp.Body.Read(chunk)
		if n > 0 {
			buf.Write(chunk[:n])

			pending := buf.String()
			if strings.Contains(pending, "BardErrorInfo") {
				if err := upstreamError(pending); err != nil {
					return err
				}
			}

			for {
				line, rest, found := strings.Cut(pending, "\n")
				if !found {
					break
				}
				pending = rest
				if err := g.emitLine(line, emitted, emit); err != nil {
					return err
				}
			}

			buf.Reset()
			buf.WriteString(pending)
		}

		if readErr != nil {
			if errors.Is(readErr, io.EOF) {
				return g.emitLine(buf.String(), emitted, emit)
			}
			return readErr
		}
	}
}

func upstreamStatusError(status int) error {
	statusText := strconv.Itoa(status)
	if status == http.StatusRequestTimeout || status == http.StatusTooManyRequests || status >= http.StatusInternalServerError {
		return fmt.Errorf("chat bot upstream status %s", statusText)
	}
	return fmt.Errorf("%w: upstream status %s", ErrUpstreamRejected, statusText)
}

func (g *GeminiClient) emitLine(line string, emitted *string, emit func(delta string) error) error {
	for _, text := range extractTextsFromLine(line) {
		if text == *emitted || strings.HasPrefix(*emitted, text) {
			continue
		}
		if !strings.HasPrefix(text, *emitted) {
			return ErrStreamChanged
		}
		delta := cleanText(text[len(*emitted):], false)
		*emitted = text
		if delta == "" {
			continue
		}
		if err := emit(delta); err != nil {
			return fmt.Errorf("%w: %v", errEmitAborted, err)
		}
	}
	return nil
}
