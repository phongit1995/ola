package chatbot

import (
	"context"
	"errors"
	"strings"

	"ola-chat-server/internal/constants"

	"go.uber.org/zap"
)

var errEmptyPrompt = errors.New("chat bot prompt is empty")

type Service struct {
	gemini *GeminiClient
	logger *zap.SugaredLogger
}

func NewService(gemini *GeminiClient, logger *zap.SugaredLogger) *Service {
	return &Service{gemini: gemini, logger: logger.Named("[chat_bot_service]")}
}

func estimateTokens(text string) int {
	runes := len([]rune(text))
	if runes == 0 {
		return 0
	}
	return (runes + 3) / 4
}

func buildUsage(prompt, completion string) Usage {
	promptTokens := estimateTokens(prompt)
	completionTokens := estimateTokens(completion)
	return Usage{
		PromptTokens:     promptTokens,
		CompletionTokens: completionTokens,
		TotalTokens:      promptTokens + completionTokens,
	}
}

func (s *Service) Complete(ctx context.Context, req *CompletionRequest) (*CompletionResponse, string, error) {
	prompt, err := buildPrompt(req)
	if err != nil {
		return nil, "", err
	}

	text, err := s.gemini.Generate(ctx, prompt)
	if err != nil {
		return nil, prompt, err
	}
	if strings.TrimSpace(text) == "" {
		return nil, prompt, ErrEmptyResponse
	}

	return &CompletionResponse{
		Model:        constants.ChatBotModelName,
		Content:      text,
		FinishReason: constants.ChatBotFinishReasonStop,
		Usage:        buildUsage(prompt, text),
	}, prompt, nil
}

// Stream đẩy từng delta qua emit và trả về prompt + full text đã sinh.
func (s *Service) Stream(ctx context.Context, req *CompletionRequest, emit func(delta string) error) (string, string, error) {
	prompt, err := buildPrompt(req)
	if err != nil {
		return "", "", err
	}

	var full strings.Builder
	err = s.gemini.GenerateStream(ctx, prompt, func(delta string) error {
		full.WriteString(delta)
		return emit(delta)
	})
	return prompt, full.String(), err
}
