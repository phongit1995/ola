package wordchain

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"ola-chat-server/internal/services"
	"sync"

	"github.com/redis/go-redis/v9"
)

var ErrDictionaryUnavailable = errors.New("dictionary api unavailable")

type DictMeaning struct {
	Definition string  `json:"definition"`
	Pos        *string `json:"pos"`
	SubPos     *string `json:"sub_pos"`
	Example    *string `json:"example"`
}

type DictTranslation struct {
	Translation string `json:"translation"`
	LangName    string `json:"lang_name"`
}

type DictRelation struct {
	RelatedWord  string `json:"related_word"`
	RelationType string `json:"relation_type"`
}

type DictResult struct {
	LangCode     string            `json:"lang_code"`
	LangName     string            `json:"lang_name"`
	Meanings     []DictMeaning     `json:"meanings"`
	Translations []DictTranslation `json:"translations"`
	Relations    []DictRelation    `json:"relations"`
}

type DictLookup struct {
	Exists  bool         `json:"exists"`
	Word    string       `json:"word"`
	Results []DictResult `json:"results"`
}

type dictSuggest struct {
	Suggestions []string `json:"suggestions"`
}

type Verifier struct {
	client     *http.Client
	redis      *redis.Client
	lookupURL  string
	suggestURL string
}

func NewVerifier(cache *services.CacheService) *Verifier {
	return &Verifier{
		client:     &http.Client{Timeout: LookupTimeout},
		redis:      cache.GetClient(),
		lookupURL:  LookupURL,
		suggestURL: SuggestURL,
	}
}

func (v *Verifier) Lookup(ctx context.Context, word string) (*DictLookup, error) {
	body, status, err := v.get(ctx, v.lookupURL, url.Values{"word": {word}})
	if err != nil {
		return nil, err
	}
	if status == http.StatusNotFound {
		return &DictLookup{Exists: false, Word: word}, nil
	}
	if status != http.StatusOK {
		return nil, fmt.Errorf("%w: status %d", ErrDictionaryUnavailable, status)
	}
	var out DictLookup
	if err := json.Unmarshal(body, &out); err != nil {
		return nil, fmt.Errorf("%w: %v", ErrDictionaryUnavailable, err)
	}
	return &out, nil
}

func (v *Verifier) Exists(ctx context.Context, word string) (bool, error) {
	if known, ok := v.Known(ctx, []string{word})[word]; ok {
		return known, nil
	}
	exists, err := v.lookupExists(ctx, word)
	if err != nil {
		return false, err
	}
	value := "0"
	if exists {
		value = "1"
	}
	_ = v.redis.Set(ctx, fmt.Sprintf(CacheKeyWordExists, word), value, WordExistsCacheTTL).Err()
	return exists, nil
}

func (v *Verifier) Known(ctx context.Context, words []string) map[string]bool {
	known := make(map[string]bool, len(words))
	if len(words) == 0 {
		return known
	}
	keys := make([]string, len(words))
	for i, word := range words {
		keys[i] = fmt.Sprintf(CacheKeyWordExists, word)
	}
	values, err := v.redis.MGet(ctx, keys...).Result()
	if err != nil {
		return known
	}
	for i, value := range values {
		if text, ok := value.(string); ok {
			known[words[i]] = text == "1"
		}
	}
	return known
}

func (v *Verifier) AnyExists(ctx context.Context, words []string) (bool, error) {
	if len(words) == 0 {
		return false, nil
	}
	checkCtx, cancel := context.WithCancel(ctx)
	defer cancel()
	var (
		wg       sync.WaitGroup
		mu       sync.Mutex
		found    bool
		firstErr error
	)
	slots := make(chan struct{}, ContinuationConcurrency)
launch:
	for _, word := range words {
		select {
		case slots <- struct{}{}:
		case <-checkCtx.Done():
			break launch
		}
		wg.Add(1)
		go func(word string) {
			defer func() {
				<-slots
				wg.Done()
			}()
			exists, err := v.Exists(checkCtx, word)
			mu.Lock()
			defer mu.Unlock()
			switch {
			case exists:
				found = true
				cancel()
			case err != nil && firstErr == nil:
				firstErr = err
			}
		}(word)
	}
	wg.Wait()
	if found {
		return true, nil
	}
	if firstErr != nil {
		return false, firstErr
	}
	return false, ctx.Err()
}

func (v *Verifier) ExistingWords(ctx context.Context, words []string, limit int) ([]string, error) {
	found := make([]string, 0, limit)
	for start := 0; start < len(words) && len(found) < limit; start += ContinuationConcurrency {
		batch := words[start:min(start+ContinuationConcurrency, len(words))]
		exists := make([]bool, len(batch))
		errs := make([]error, len(batch))
		var wg sync.WaitGroup
		for i, word := range batch {
			wg.Add(1)
			go func() {
				defer wg.Done()
				exists[i], errs[i] = v.Exists(ctx, word)
			}()
		}
		wg.Wait()
		if err := errors.Join(errs...); err != nil {
			return nil, err
		}
		for i, word := range batch {
			if exists[i] && len(found) < limit {
				found = append(found, word)
			}
		}
	}
	return found, nil
}

func (v *Verifier) lookupExists(ctx context.Context, word string) (bool, error) {
	result, err := v.Lookup(ctx, word)
	if err != nil {
		return false, err
	}
	if !result.Exists {
		return false, nil
	}
	for _, r := range result.Results {
		if r.LangCode == LookupLangVietnamese {
			return true, nil
		}
	}
	return false, nil
}

func (v *Verifier) Continuations(ctx context.Context, syllable string) ([]string, error) {
	body, status, err := v.get(ctx, v.suggestURL, url.Values{"q": {syllable + " "}, "limit": {SuggestLimit}})
	if err != nil {
		return nil, err
	}
	if status == http.StatusNotFound {
		return nil, nil
	}
	if status != http.StatusOK {
		return nil, fmt.Errorf("%w: status %d", ErrDictionaryUnavailable, status)
	}
	var out dictSuggest
	if err := json.Unmarshal(body, &out); err != nil {
		return nil, fmt.Errorf("%w: %v", ErrDictionaryUnavailable, err)
	}
	words := make([]string, 0, len(out.Suggestions))
	for _, suggestion := range out.Suggestions {
		normalized := normalizeVietnamese(suggestion)
		parts := splitSyllables(normalized)
		if len(parts) == WordLength && parts[0] == syllable {
			words = append(words, normalized)
		}
	}
	return words, nil
}

func (v *Verifier) get(ctx context.Context, endpoint string, query url.Values) ([]byte, int, error) {
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, endpoint+"?"+query.Encode(), nil)
	if err != nil {
		return nil, 0, err
	}
	resp, err := v.client.Do(req)
	if err != nil {
		return nil, 0, fmt.Errorf("%w: %v", ErrDictionaryUnavailable, err)
	}
	defer resp.Body.Close()
	body, err := io.ReadAll(io.LimitReader(resp.Body, LookupMaxBytes+1))
	if err != nil {
		return nil, 0, fmt.Errorf("%w: %v", ErrDictionaryUnavailable, err)
	}
	if len(body) > LookupMaxBytes {
		return nil, 0, fmt.Errorf("%w: response too large", ErrDictionaryUnavailable)
	}
	return body, resp.StatusCode, nil
}
