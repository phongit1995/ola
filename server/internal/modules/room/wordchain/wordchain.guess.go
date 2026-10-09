package wordchain

import (
	"context"
	"errors"
	"ola-chat-server/internal/constants"

	"github.com/google/uuid"
)

func guessPurchaseAllowed(state GameState, userID string) error {
	if state.WordOwnerID == userID {
		return ErrWaitTurn
	}
	if state.RemainingGuesses(userID) > 0 {
		return ErrGuessesLeft
	}
	return nil
}

func (s *Service) loadBoughtGuesses(ctx context.Context, state GameState, userID uuid.UUID) (GameState, error) {
	uid := userID.String()
	if state.WrongCounts[uid] < constants.WordChainMaxWrongGuesses {
		return state, nil
	}
	bought, err := s.wallet.GuessesBought(ctx, userID, state.SessionID, state.Turn)
	if err != nil {
		return GameState{}, err
	}
	return state.withBoughtGuesses(uid, bought), nil
}

func (s *Service) BuyGuesses(ctx context.Context, userID uuid.UUID, req *GuessPurchaseRequest) (*GuessPurchaseResponse, error) {
	cfg, err := s.enabledConfig()
	if err != nil {
		return nil, err
	}
	if *req.Price != cfg.GuessPrice {
		return nil, ErrPriceChanged
	}
	if _, err := s.activeState(ctx); err != nil {
		return nil, err
	}
	expected := wordRef{SessionID: req.SessionID, Turn: *req.Turn}
	uid := userID.String()
	var resp *GuessPurchaseResponse
	err = s.withLock(ctx, func(ctx context.Context, batch *eventBatch) error {
		current, err := s.store.LoadState(ctx)
		if err != nil {
			return err
		}
		if !expected.matches(current) {
			return ErrWordChanged
		}
		if current, err = s.loadBoughtGuesses(ctx, current, userID); err != nil {
			return err
		}
		if err := guessPurchaseAllowed(current, uid); err != nil {
			return err
		}

		balance, err := s.wallet.ChargeGuesses(ctx, GuessCharge{
			UserID:    userID,
			SessionID: current.SessionID,
			Turn:      current.Turn,
			Price:     cfg.GuessPrice,
			Word:      current.Word,
			Bought:    current.BoughtGuesses[uid],
			Guesses:   constants.WordChainGuessPackSize,
		})
		if errors.Is(err, errKenShort) {
			return guessKenShortError(cfg.GuessPrice)
		}
		if errors.Is(err, errGuessesBought) {
			return ErrGuessesLeft
		}
		if err != nil {
			return err
		}

		next := current.withBoughtGuesses(uid, constants.WordChainGuessPackSize)
		batch.guesses(uid, next)
		resp = &GuessPurchaseResponse{
			SessionID:        current.SessionID.String(),
			Turn:             current.Turn,
			Guesses:          constants.WordChainGuessPackSize,
			RemainingGuesses: next.RemainingGuesses(uid),
			Price:            cfg.GuessPrice,
			KenBalance:       balance,
			State:            toStateView(next),
		}
		return nil
	})
	if err != nil {
		return nil, err
	}
	return resp, nil
}
