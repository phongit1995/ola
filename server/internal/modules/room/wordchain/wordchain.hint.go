package wordchain

import (
	"context"
	"errors"

	"github.com/google/uuid"
)

func (s *Service) Hint(ctx context.Context, userID uuid.UUID) (*HintResponse, error) {
	cfg, err := s.enabledConfig()
	if err != nil {
		return nil, err
	}
	state, err := s.activeState(ctx)
	if err != nil {
		return nil, err
	}
	uid := userID.String()
	if state.WordOwnerID == uid {
		return nil, ErrWaitTurn
	}
	if state.RemainingGuesses(uid) == 0 {
		return nil, ErrNoGuessesLeft
	}

	candidates, err := s.hintCandidates(ctx, state)
	if err != nil {
		s.logger.Warnw("Word chain hint suggestions unavailable", "error", err)
		return nil, ErrVerifyFailed
	}
	hints, err := s.verifier.ExistingWords(ctx, candidates, HintMaxWords)
	if err != nil {
		s.logger.Warnw("Word chain hint verification failed", "error", err)
		return nil, ErrVerifyFailed
	}
	if len(hints) == 0 {
		return nil, ErrNoHint
	}

	balance, err := s.wallet.ChargeHint(HintCharge{
		UserID: userID,
		Price:  cfg.HintPrice,
		Word:   state.Word,
		Turn:   state.Turn,
		Hints:  hints,
	})
	if errors.Is(err, errKenShort) {
		return nil, kenShortError(cfg.HintPrice)
	}
	if err != nil {
		return nil, err
	}
	return &HintResponse{
		SessionID:  state.SessionID,
		Turn:       state.Turn,
		Word:       state.Word,
		Hints:      hints,
		Price:      cfg.HintPrice,
		KenBalance: balance,
	}, nil
}

func (s *Service) hintCandidates(ctx context.Context, state GameState) ([]string, error) {
	syllable := lastWord(state.Word)
	used := state.historySet()
	suggested, err := s.verifier.Continuations(ctx, syllable)
	if err != nil {
		return nil, err
	}
	seen := make(map[string]struct{})
	candidates := make([]string, 0)
	for _, word := range append(s.dict.Continuations(syllable, used), suggested...) {
		if _, ok := used[word]; ok {
			continue
		}
		if _, ok := seen[word]; ok {
			continue
		}
		seen[word] = struct{}{}
		candidates = append(candidates, word)
	}
	return candidates, nil
}
