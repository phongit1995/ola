package wordchain

import (
	"context"
	"fmt"
	"math"
	"ola-chat-server/internal/constants"
	"strings"
	"time"
	"unicode/utf8"

	"github.com/google/uuid"
)

func (s *Service) Lookup(ctx context.Context, userID uuid.UUID, word string) (*LookupResponse, error) {
	trimmed := strings.TrimSpace(word)
	if trimmed == "" {
		return nil, ErrLookupEmpty
	}
	if utf8.RuneCountInString(trimmed) > constants.WordChainLookupMaxWordRunes {
		return nil, ErrLookupTooLong
	}
	result, cached := s.verifier.CachedLookup(ctx, trimmed)
	if !cached {
		if err := s.acquireLookupCooldown(userID); err != nil {
			return nil, err
		}
		var err error
		if result, err = s.verifier.Lookup(ctx, trimmed); err != nil {
			s.logger.Warnw("Word chain lookup failed", "word", trimmed, "error", err)
			return nil, ErrLookupFailed
		}
	}
	resp := &LookupResponse{Word: trimmed, Results: []LookupResult{}, Source: constants.WordChainLookupSource}
	if !result.Exists || len(result.Results) == 0 {
		resp.Message = fmt.Sprintf("Không tìm thấy định nghĩa cho từ \"%s\", đây có thể là một từ ghép hán việt, vui lòng tra cứu ở các nguồn khác.", trimmed)
		return resp, nil
	}
	if result.Word != "" {
		resp.Word = result.Word
	}
	resp.Found = true
	for _, r := range result.Results {
		item := LookupResult{
			LangCode:     r.LangCode,
			LangName:     r.LangName,
			Meanings:     make([]LookupMeaning, 0, len(r.Meanings)),
			Translations: make([]LookupTranslation, 0, len(r.Translations)),
			Relations:    make([]LookupRelation, 0, len(r.Relations)),
		}
		for _, m := range r.Meanings {
			item.Meanings = append(item.Meanings, LookupMeaning{Definition: m.Definition, Pos: deref(m.Pos), SubPos: deref(m.SubPos), Example: deref(m.Example)})
		}
		for _, t := range r.Translations {
			item.Translations = append(item.Translations, LookupTranslation{Translation: t.Translation, LangName: t.LangName})
		}
		for _, rel := range r.Relations {
			item.Relations = append(item.Relations, LookupRelation{Word: rel.RelatedWord, Type: rel.RelationType})
		}
		resp.Results = append(resp.Results, item)
	}
	return resp, nil
}

func (s *Service) acquireLookupCooldown(userID uuid.UUID) error {
	key := fmt.Sprintf(constants.CacheKeyWordChainLookupCooldown, userID.String())
	window := constants.WordChainLookupCooldownSeconds * time.Second
	acquired, err := s.cache.SetNX(key, 1, window)
	if err != nil {
		return err
	}
	if acquired {
		return nil
	}
	seconds := constants.WordChainLookupCooldownSeconds
	if ttl, err := s.cache.GetTTL(key); err == nil && ttl > 0 {
		seconds = int(math.Ceil(ttl.Seconds()))
	}
	return cooldownError(seconds)
}

func deref(value *string) string {
	if value == nil {
		return ""
	}
	return *value
}
