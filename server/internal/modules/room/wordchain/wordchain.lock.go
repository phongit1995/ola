package wordchain

import (
	"context"
	"ola-chat-server/internal/constants"
	roomEvents "ola-chat-server/internal/domain/room"
	"ola-chat-server/internal/utils"
	"time"

	"github.com/google/uuid"
)

type eventBatch struct {
	events []*roomEvents.WordChainEvent
}

func (b *eventBatch) message(msg Message) {
	b.events = append(b.events, &roomEvents.WordChainEvent{
		Event: constants.WebSocketEventWordChainNewMessage,
		Data:  map[string]any{"message": utils.MustToJSONMap(msg)},
	})
}

func (b *eventBatch) state(state GameState) {
	b.events = append(b.events, &roomEvents.WordChainEvent{
		Event: constants.WebSocketEventWordChainStateUpdated,
		Data:  map[string]any{"state": utils.MustToJSONMap(toStateView(state))},
	})
}

func (b *eventBatch) guesses(userID string, state GameState) {
	b.events = append(b.events, &roomEvents.WordChainEvent{
		Event:  constants.WebSocketEventWordChainGuessesUpdated,
		UserID: userID,
		Data: map[string]any{
			"state":            utils.MustToJSONMap(toStateView(state)),
			"remainingGuesses": state.RemainingGuesses(userID),
		},
	})
}

func (s *Service) withLock(ctx context.Context, fn func(ctx context.Context, batch *eventBatch) error) error {
	unlock, err := s.lock(ctx)
	if err != nil {
		return err
	}
	workCtx, cancelWork := context.WithTimeout(context.WithoutCancel(ctx), constants.WordChainLockTTL)
	defer cancelWork()
	batch := &eventBatch{}
	err = fn(workCtx, batch)
	unlock()

	publishCtx, cancelPublish := context.WithTimeout(context.WithoutCancel(ctx), constants.WordChainBackgroundTimeout)
	defer cancelPublish()
	for _, event := range batch.events {
		if pubErr := s.publisher.PublishWordChainEvent(publishCtx, event); pubErr != nil {
			s.logger.Errorw("Failed to publish word chain event", "event", event.Event, "error", pubErr)
		}
	}
	return err
}

func (s *Service) lock(ctx context.Context) (func(), error) {
	token := uuid.NewString()
	deadline := time.Now().Add(constants.WordChainLockWait)
	for {
		acquired, err := s.cache.SetNX(constants.CacheKeyWordChainLock, token, constants.WordChainLockTTL)
		if err != nil {
			return nil, err
		}
		if acquired {
			return func() {
				if _, err := s.cache.DeleteIfValue(constants.CacheKeyWordChainLock, token); err != nil {
					s.logger.Warnw("Failed to release word chain lock", "error", err)
				}
			}, nil
		}
		if time.Now().After(deadline) {
			return nil, ErrBusy
		}
		select {
		case <-ctx.Done():
			return nil, ctx.Err()
		case <-time.After(constants.WordChainLockRetryWait):
		}
	}
}
