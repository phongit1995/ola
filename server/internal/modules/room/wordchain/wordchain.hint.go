package wordchain

import (
	"context"
	"errors"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
)

func hintAllowed(state GameState, userID string) error {
	err := playable(state, userID)
	if errors.Is(err, errOwnWord) {
		return ErrWaitTurn
	}
	if errors.Is(err, errNoGuessesLeft) {
		return ErrNoGuessesLeft
	}
	return err
}

func hintResponse(ref wordRef, purchase models.WordChainHintPurchase, balance int, charged bool) *HintResponse {
	return &HintResponse{
		SessionID:  ref.SessionID,
		Turn:       ref.Turn,
		Word:       purchase.Word,
		Hints:      purchase.Hints,
		Price:      purchase.Price,
		KenBalance: balance,
		Charged:    charged,
	}
}

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
	if state, err = s.loadBoughtGuesses(ctx, state, userID); err != nil {
		return nil, err
	}
	if err := hintAllowed(state, uid); err != nil {
		return nil, err
	}
	if resp, err := s.purchasedHint(ctx, state, userID); resp != nil || err != nil {
		return resp, err
	}

	hints, err := s.findHints(ctx, state)
	if err != nil {
		return nil, err
	}

	ref := state.ref()
	var resp *HintResponse
	err = s.withLock(ctx, func(ctx context.Context, _ *eventBatch) error {
		current, err := s.store.LoadState(ctx)
		if err != nil {
			return err
		}
		if !ref.matches(current) {
			return ErrWordChanged
		}
		if current, err = s.loadBoughtGuesses(ctx, current, userID); err != nil {
			return err
		}
		if err := hintAllowed(current, uid); err != nil {
			return err
		}
		result, err := s.wallet.ChargeHint(ctx, HintCharge{
			UserID:    userID,
			SessionID: current.SessionID,
			Turn:      current.Turn,
			Price:     cfg.HintPrice,
			Word:      current.Word,
			Hints:     hints,
		})
		if errors.Is(err, errKenShort) {
			return kenShortError(cfg.HintPrice)
		}
		if err != nil {
			return err
		}
		resp = hintResponse(ref, result.Purchase, result.Balance, result.Charged)
		return nil
	})
	if err != nil {
		return nil, err
	}
	return resp, nil
}

func (s *Service) purchasedHint(ctx context.Context, state GameState, userID uuid.UUID) (*HintResponse, error) {
	purchase, err := s.wallet.Purchase(ctx, userID, state.SessionID, state.Turn)
	if err != nil || purchase == nil {
		return nil, err
	}
	balance, err := s.wallet.Balance(ctx, userID)
	if err != nil {
		return nil, err
	}
	return hintResponse(state.ref(), *purchase, balance, false), nil
}

func (s *Service) findHints(ctx context.Context, state GameState) ([]string, error) {
	syllable := lastWord(state.Word)
	used := state.historySet()
	suggested, err := s.verifier.Continuations(ctx, syllable)
	if err != nil {
		s.logger.Warnw("Word chain hint suggestions unavailable", "error", err)
		return nil, ErrVerifyFailed
	}
	candidates := unusedCandidates(used, s.dict.Continuations(syllable, used), suggested)
	hints, err := s.verifier.ExistingWords(ctx, candidates, constants.WordChainHintMaxWords)
	if err != nil {
		s.logger.Warnw("Word chain hint verification failed", "error", err)
		return nil, ErrVerifyFailed
	}
	if len(hints) == 0 {
		return nil, ErrNoHint
	}
	return hints, nil
}
