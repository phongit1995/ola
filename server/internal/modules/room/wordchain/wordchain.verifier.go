package wordchain

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"ola-chat-server/internal/services"
	"sync"

	"github.com/redis/go-redis/v9"
)

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

type Verifier struct {
	lexicon *Lexicon
	redis   *redis.Client
}

func NewVerifier(lexicon *Lexicon, cache *services.CacheService) *Verifier {
	return &Verifier{lexicon: lexicon, redis: cache.GetClient()}
}

func (v *Verifier) Lookup(ctx context.Context, word string) (*DictLookup, error) {
	word = normalizeVietnamese(word)
	if cached, ok := v.CachedLookup(ctx, word); ok {
		return cached, nil
	}
	var out *DictLookup
	for _, spelling := range spellingVariants(word) {
		result := v.lexicon.Lookup(spelling)
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

func hasVietnamese(result *DictLookup) bool {
	if !result.Exists {
		return false
	}
	for _, r := range result.Results {
		if r.LangCode == WordChainLookupLangVietnamese {
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
	_ = v.redis.Set(ctx, lookupCacheKey(word), data, WordChainLookupTTL).Err()
}

func lookupCacheKey(word string) string {
	return fmt.Sprintf(CacheKeyWordChainLookup, normalizeVietnamese(word))
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
	_ = v.redis.Set(ctx, fmt.Sprintf(CacheKeyWordChainWordExists, word), value, WordChainWordExistsTTL).Err()
	return exists, nil
}

func (v *Verifier) Known(ctx context.Context, words []string) map[string]bool {
	known := make(map[string]bool, len(words))
	if len(words) == 0 {
		return known
	}
	keys := make([]string, len(words))
	for i, word := range words {
		keys[i] = fmt.Sprintf(CacheKeyWordChainWordExists, word)
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
	slots := make(chan struct{}, WordChainContinuationConcurrency)
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
		for _, suggestion := range v.lexicon.Suggest(spelling+" ", WordChainSuggestLimit) {
			normalized := normalizeVietnamese(suggestion)
			parts := splitSyllables(normalized)
			if len(parts) == WordChainWordLength && syllableKey(parts[0]) == key {
				words = append(words, normalized)
			}
		}
	}
	return words, nil
}
