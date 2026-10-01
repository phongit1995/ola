package wordchain

import (
	"context"
	"errors"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/utils"
	"time"
)

func (s *Service) syncExpiryTimer(state GameState) {
	if !state.CanExpire() {
		s.stopTimer()
		return
	}
	s.scheduleExpiry(state.ExpiresAt())
}

func (s *Service) scheduleExpiry(at time.Time) {
	delay := max(time.Until(at), 0)
	s.timerMu.Lock()
	defer s.timerMu.Unlock()
	if s.timer != nil {
		s.timer.Stop()
	}
	s.timer = time.AfterFunc(delay, func() {
		utils.SafeGo(s.logger, s.expireBotWord)
	})
}

func (s *Service) stopTimer() {
	s.timerMu.Lock()
	defer s.timerMu.Unlock()
	if s.timer != nil {
		s.timer.Stop()
		s.timer = nil
	}
}

func (s *Service) retryExpiry(delay time.Duration) {
	s.scheduleExpiry(time.Now().Add(delay))
}

func (s *Service) expireBotWord() {
	if _, err := s.enabledConfig(); err != nil {
		if !errors.Is(err, ErrDisabled) {
			s.retryExpiry(constants.WordChainBotWordRetryDelay)
		}
		return
	}
	ctx, cancel := context.WithTimeout(context.Background(), constants.WordChainBackgroundTimeout)
	defer cancel()

	state, err := s.store.LoadState(ctx)
	if err != nil {
		s.logger.Warnw("Failed to load word chain state, retrying", "error", err)
		s.retryExpiry(constants.WordChainBotWordRetryDelay)
		return
	}
	if !state.CanExpire() {
		return
	}
	if !state.Expired(time.Now()) {
		s.scheduleExpiry(state.ExpiresAt())
		return
	}
	_, err = s.refreshState(ctx)
	switch {
	case err == nil:
	case errors.Is(err, ErrBusy):
		s.retryExpiry(constants.WordChainLockRetryWait)
	case errors.Is(err, errStartWordUnavailable):
		s.logger.Warnw("Word chain replacement word unavailable, retrying", "error", err)
		s.retryExpiry(constants.WordChainBotWordRetryDelay)
	default:
		s.logger.Errorw("Failed to replace word chain bot word, retrying", "error", err)
		s.retryExpiry(constants.WordChainBotWordRetryDelay)
	}
}

func (s *Service) resumeExpiryTimer() {
	ctx, cancel := context.WithTimeout(context.Background(), constants.WordChainBackgroundTimeout)
	defer cancel()
	state, err := s.store.LoadState(ctx)
	if err != nil {
		return
	}
	s.timerMu.Lock()
	idle := s.timer == nil
	s.timerMu.Unlock()
	if idle {
		s.syncExpiryTimer(state)
	}
}
