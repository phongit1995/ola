package wordchain

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"ola-chat-server/internal/constants"
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
		client:     &http.Client{Timeout: constants.WordChainLookupTimeout},
		redis:      cache.GetClient(),
		lookupURL:  constants.WordChainLookupURL,
		suggestURL: constants.WordChainSuggestURL,
	}
}

func (v *Verifier) Lookup(ctx context.Context, word string) (*DictLookup, error) {
	word = normalizeVietnamese(word)
	if cached, ok := v.CachedLookup(ctx, word); ok {
		return cached, nil
	}
	var out *DictLookup
	for _, spelling := range spellingVariants(word) {
		result, err := v.fetchLookup(ctx, spelling)
		if err != nil {
			return nil, err
		}
		if out == nil {
			out = result
		}
		if hasVietnamese(result) {
			out = result
			break
		}
	}
	v.cacheLookup(ctx, word, out)
	return out, nil
}

func (v *Verifier) fetchLookup(ctx context.Context, word string) (*DictLookup, error) {
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

func hasVietnamese(result *DictLookup) bool {
	if !result.Exists {
		return false
	}
	for _, r := range result.Results {
		if r.LangCode == constants.WordChainLookupLangVietnamese {
			return true
		}
	}
	return false
}

func (v *Verifier) CachedLookup(ctx context.Context, word string) (*DictLookup, bool) {
	raw, err := v.redis.Get(ctx, lookupCacheKey(word)).Bytes()
	if err != nil {
		return nil, false
	}
	var out DictLookup
	if err := json.Unmarshal(raw, &out); err != nil {
		return nil, false
	}
	return &out, true
}

func (v *Verifier) cacheLookup(ctx context.Context, word string, result *DictLookup) {
	data, err := json.Marshal(result)
	if err != nil {
		return
	}
	_ = v.redis.Set(ctx, lookupCacheKey(word), data, constants.WordChainLookupTTL).Err()
}

func lookupCacheKey(word string) string {
	return fmt.Sprintf(constants.CacheKeyWordChainLookup, normalizeVietnamese(word))
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
	_ = v.redis.Set(ctx, fmt.Sprintf(constants.CacheKeyWordChainWordExists, word), value, constants.WordChainWordExistsTTL).Err()
	return exists, nil
}

func (v *Verifier) Known(ctx context.Context, words []string) map[string]bool {
	known := make(map[string]bool, len(words))
	if len(words) == 0 {
		return known
	}
	keys := make([]string, len(words))
	for i, word := range words {
		keys[i] = fmt.Sprintf(constants.CacheKeyWordChainWordExists, word)
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

type existence struct {
	checked bool
	exists  bool
	err     error
}

func (v *Verifier) ExistingWords(ctx context.Context, words []string, limit int) ([]string, error) {
	if len(words) == 0 || limit <= 0 {
		return []string{}, nil
	}
	checkCtx, cancel := context.WithCancel(ctx)
	defer cancel()
	var (
		wg      sync.WaitGroup
		mu      sync.Mutex
		results = make([]existence, len(words))
		settled int
		found   int
	)
	slots := make(chan struct{}, constants.WordChainContinuationConcurrency)
launch:
	for i, word := range words {
		select {
		case slots <- struct{}{}:
		case <-checkCtx.Done():
			break launch
		}
		wg.Add(1)
		go func() {
			defer func() {
				<-slots
				wg.Done()
			}()
			exists, err := v.Exists(checkCtx, word)
			mu.Lock()
			defer mu.Unlock()
			results[i] = existence{checked: true, exists: exists, err: err}
			for settled < len(results) && results[settled].checked {
				if results[settled].exists {
					found++
				}
				settled++
			}
			if found >= limit {
				cancel()
			}
		}()
	}
	wg.Wait()

	out := make([]string, 0, limit)
	var errs []error
	for i := 0; i < len(results) && len(out) < limit; i++ {
		switch {
		case results[i].exists:
			out = append(out, words[i])
		case results[i].err != nil:
			errs = append(errs, results[i].err)
		}
	}
	if len(out) >= limit {
		return out, nil
	}
	if err := errors.Join(errs...); err != nil {
		return nil, err
	}
	return out, ctx.Err()
}

func (v *Verifier) lookupExists(ctx context.Context, word string) (bool, error) {
	result, err := v.Lookup(ctx, word)
	if err != nil {
		return false, err
	}
	return hasVietnamese(result), nil
}

func (v *Verifier) Continuations(ctx context.Context, syllable string) ([]string, error) {
	key := syllableKey(syllable)
	words := make([]string, 0)
	for _, spelling := range spellingVariants(syllable) {
		suggestions, err := v.suggest(ctx, spelling)
		if err != nil {
			return nil, err
		}
		for _, suggestion := range suggestions {
			normalized := normalizeVietnamese(suggestion)
			parts := splitSyllables(normalized)
			if len(parts) == constants.WordChainWordLength && syllableKey(parts[0]) == key {
				words = append(words, normalized)
			}
		}
	}
	return words, nil
}

func (v *Verifier) suggest(ctx context.Context, syllable string) ([]string, error) {
	body, status, err := v.get(ctx, v.suggestURL, url.Values{"q": {syllable + " "}, "limit": {constants.WordChainSuggestLimit}})
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
	return out.Suggestions, nil
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
	body, err := io.ReadAll(io.LimitReader(resp.Body, constants.WordChainLookupMaxBytes+1))
	if err != nil {
		return nil, 0, fmt.Errorf("%w: %v", ErrDictionaryUnavailable, err)
	}
	if len(body) > constants.WordChainLookupMaxBytes {
		return nil, 0, fmt.Errorf("%w: response too large", ErrDictionaryUnavailable)
	}
	return body, resp.StatusCode, nil
}
