package wordchain

import (
	"context"
	"errors"
)

var errNoPlayableStartWord = errors.New("word chain could not find a playable start word")

type liveOracle struct {
	ctx     context.Context
	service *Service
}

func (o liveOracle) Exists(word string) (bool, error) {
	return o.service.verifier.Exists(o.ctx, word)
}

func (o liveOracle) HasContinuation(syllable string, used map[string]struct{}) (bool, error) {
	return o.service.hasContinuation(o.ctx, syllable, used)
}

func (o liveOracle) StartWord() (string, error) {
	return o.service.pickStartWord(o.ctx)
}

func (s *Service) hasContinuation(ctx context.Context, syllable string, used map[string]struct{}) (bool, error) {
	local := s.dict.Continuations(syllable, used)
	known := s.verifier.Known(ctx, local)
	for _, word := range local {
		if known[word] {
			return true, nil
		}
	}

	suggested, err := s.verifier.Continuations(ctx, syllable)
	if err != nil {
		return false, err
	}
	candidates := make([]string, 0, len(suggested)+len(local))
	seen := make(map[string]struct{}, len(suggested)+len(local))
	for _, word := range append(suggested, local...) {
		if _, ok := used[word]; ok {
			continue
		}
		if _, ok := seen[word]; ok {
			continue
		}
		seen[word] = struct{}{}
		if exists, ok := known[word]; ok && !exists {
			continue
		}
		candidates = append(candidates, word)
	}
	return s.verifier.AnyExists(ctx, candidates)
}

func (s *Service) pickStartWord(ctx context.Context) (string, error) {
	for attempt := 0; attempt < StartWordMaxAttempts; attempt++ {
		word := s.dict.NewWord()
		if word == "" {
			break
		}
		ok, err := s.hasContinuation(ctx, lastWord(word), map[string]struct{}{word: {}})
		if err != nil {
			return "", err
		}
		if ok {
			return word, nil
		}
	}
	return "", errNoPlayableStartWord
}
