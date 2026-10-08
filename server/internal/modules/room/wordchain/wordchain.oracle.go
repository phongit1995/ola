package wordchain

import (
	"context"
	"errors"
	"ola-chat-server/internal/constants"
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

func unusedCandidates(used map[string]struct{}, groups ...[]string) []string {
	seen := make(map[string]struct{})
	candidates := make([]string, 0)
	for _, group := range groups {
		for _, word := range group {
			key := wordKey(word)
			if _, ok := used[key]; ok {
				continue
			}
			if _, ok := seen[key]; ok {
				continue
			}
			seen[key] = struct{}{}
			candidates = append(candidates, word)
		}
	}
	return candidates
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
	for _, word := range unusedCandidates(used, suggested, local) {
		if exists, ok := known[word]; !ok || exists {
			candidates = append(candidates, word)
		}
	}
	found, err := s.verifier.ExistingWords(ctx, candidates, 1)
	return len(found) > 0, err
}

func (s *Service) pickStartWord(ctx context.Context) (string, error) {
	for attempt := 0; attempt < constants.WordChainStartWordMaxAttempts; attempt++ {
		word := s.dict.NewWord()
		if word == "" {
			break
		}
		if misspelledY(word) {
			continue
		}
		exists, err := s.verifier.Exists(ctx, word)
		if err != nil {
			return "", err
		}
		if !exists {
			continue
		}
		ok, err := s.hasContinuation(ctx, lastWord(word), map[string]struct{}{wordKey(word): {}})
		if err != nil {
			return "", err
		}
		if ok {
			return word, nil
		}
	}
	return "", errNoPlayableStartWord
}
