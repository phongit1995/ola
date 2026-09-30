package wordchain

import (
	"context"
	"fmt"
	"math"
	"strings"
	"time"
	"unicode/utf8"

	"github.com/google/uuid"
)

const lookupSource = "dict.minhqnd.com"

func (s *Service) Lookup(ctx context.Context, userID uuid.UUID, word string) (*LookupResponse, error) {
	trimmed := strings.TrimSpace(word)
	if trimmed == "" {
		return nil, ErrLookupEmpty
	}
	if utf8.RuneCountInString(trimmed) > LookupMaxWordRunes {
		return nil, ErrLookupTooLong
	}
	if err := s.acquireCooldown(fmt.Sprintf(CacheKeyLookupCooldown, userID.String()),
		LookupCooldownSeconds, "⏳ Vui lòng chờ %ds trước khi tra tiếp."); err != nil {
		return nil, err
	}

	result, err := s.verifier.Lookup(ctx, trimmed)
	if err != nil {
		s.logger.Warnw("Word chain lookup failed", "word", trimmed, "error", err)
		return nil, ErrLookupFailed
	}
	resp := &LookupResponse{Word: trimmed, Results: []LookupResult{}, Source: lookupSource}
	if result.Word != "" {
		resp.Word = result.Word
	}
	if !result.Exists || len(result.Results) == 0 {
		resp.Message = fmt.Sprintf("Không tìm thấy định nghĩa cho từ \"%s\", đây có thể là một từ ghép hán việt, vui lòng tra cứu ở các nguồn khác.", trimmed)
		return resp, nil
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

func (s *Service) acquireCooldown(key string, seconds int, template string) error {
	acquired, err := s.cache.SetNX(key, 1, time.Duration(seconds)*time.Second)
	if err != nil {
		return err
	}
	if acquired {
		return nil
	}
	return cooldownError(template, s.remainingSeconds(key, seconds))
}

func (s *Service) remainingSeconds(key string, fallback int) int {
	ttl, err := s.cache.GetTTL(key)
	if err != nil || ttl <= 0 {
		return fallback
	}
	return int(math.Ceil(ttl.Seconds()))
}

func deref(value *string) string {
	if value == nil {
		return ""
	}
	return *value
}
