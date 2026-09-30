package wordchain

import (
	"context"
	"errors"
	"ola-chat-server/internal/constants"
	roomEvents "ola-chat-server/internal/domain/room"
	"ola-chat-server/internal/models"
	userModule "ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"
	"sync"
	"time"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Service struct {
	dict      *Dictionary
	verifier  *Verifier
	store     *Store
	cache     *services.CacheService
	userCache *userModule.CacheService
	publisher EventPublisher
	logger    *zap.SugaredLogger
	timerMu   sync.Mutex
	timer     *time.Timer
}

func NewService(dict *Dictionary, verifier *Verifier, store *Store, cache *services.CacheService, userCache *userModule.CacheService, publisher EventPublisher, logger *zap.SugaredLogger) *Service {
	s := &Service{
		dict:      dict,
		verifier:  verifier,
		store:     store,
		cache:     cache,
		userCache: userCache,
		publisher: publisher,
		logger:    logger.Named("[word_chain_service]"),
	}
	utils.SafeGo(s.logger, s.resumeSessionTimer)
	return s
}

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

func (s *Service) withLock(ctx context.Context, fn func(ctx context.Context, batch *eventBatch) error) error {
	unlock, err := s.lock(ctx)
	if err != nil {
		return err
	}
	workCtx, cancelWork := context.WithTimeout(context.WithoutCancel(ctx), LockTTL)
	defer cancelWork()
	batch := &eventBatch{}
	err = fn(workCtx, batch)
	unlock()

	publishCtx, cancelPublish := context.WithTimeout(context.WithoutCancel(ctx), BackgroundTimeout)
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
	deadline := time.Now().Add(LockWait)
	for {
		acquired, err := s.cache.SetNX(CacheKeyLock, token, LockTTL)
		if err != nil {
			return nil, err
		}
		if acquired {
			return func() {
				if _, err := s.cache.DeleteIfValue(CacheKeyLock, token); err != nil {
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
		case <-time.After(LockRetryWait):
		}
	}
}

func (s *Service) sender(userID uuid.UUID) *models.User {
	u, err := s.userCache.GetUserCache(userID, true)
	if err != nil {
		return nil
	}
	return u
}

var errStaleState = errors.New("word chain state changed")

func (s *Service) HandleMove(ctx context.Context, userID uuid.UUID, req *MoveRequest) (*MoveResponse, error) {
	sender := s.sender(userID)
	oracle := liveOracle{ctx: ctx, service: s}
	for attempt := 0; attempt < MoveMaxAttempts; attempt++ {
		state, err := s.activeState(ctx)
		if err != nil {
			return nil, err
		}
		res, err := processMove(state, userID.String(), req.Content, oracle)
		if errors.Is(err, errNoGuessesLeft) {
			return nil, ErrNoGuessesLeft
		}
		if err != nil {
			s.logger.Warnw("Word chain dictionary verification failed", "error", err)
			return nil, ErrVerifyFailed
		}
		resp, err := s.commitMove(ctx, userID, sender, req.Content, state.Revision, res)
		if errors.Is(err, errStaleState) {
			continue
		}
		return resp, err
	}
	return nil, ErrBusy
}

func (s *Service) commitMove(ctx context.Context, userID uuid.UUID, sender *models.User, content string, revision int64, res MoveResult) (*MoveResponse, error) {
	var resp *MoveResponse
	err := s.withLock(ctx, func(ctx context.Context, batch *eventBatch) error {
		state, err := s.store.LoadState(ctx)
		if err != nil {
			return err
		}
		now := time.Now()
		if state.Revision != revision || !state.Active() || state.Expired(now) {
			return errStaleState
		}

		mutation := &Mutation{}
		if res.StateChanged {
			state = res.State
			if res.Scored {
				state.LastProgressAt = now
			}
			mutation.State = &state
		}
		var points int64
		if res.Scored {
			mutation.ScoreUserID = userID.String()
		} else if points, err = s.store.Points(ctx, userID.String()); err != nil {
			return err
		}

		move := moveMessage(state.SessionID, userID.String(), sender, content, res, now)
		mutation.Messages = append(mutation.Messages, move)
		switch {
		case res.Code == CodeWin:
			mutation.Messages = append(mutation.Messages,
				winMessage(state.SessionID, move, now),
				gameStartedMessage(state.SessionID, state.Word, now),
			)
		case !res.Scored:
			mutation.Messages = append(mutation.Messages, wrongAnswerMessage(state.SessionID, state, res, now))
		}
		total, err := s.store.Apply(ctx, mutation)
		if err != nil {
			return err
		}
		if res.Scored {
			points = total
		}
		s.trimMessages(ctx)

		for _, msg := range mutation.Messages {
			batch.message(msg)
		}
		if res.StateChanged {
			batch.state(state)
			s.scheduleSessionExpiry(state.SessionID, state.ExpiresAt())
		}
		resp = &MoveResponse{
			Message:          mutation.Messages[0],
			BotMessages:      append([]Message{}, mutation.Messages[1:]...),
			State:            toStateView(state),
			Points:           points,
			RemainingGuesses: res.RemainingGuesses,
		}
		return nil
	})
	if err != nil {
		return nil, err
	}
	return resp, nil
}

func (s *Service) trimMessages(ctx context.Context) {
	if err := s.store.TrimMessages(ctx); err != nil {
		s.logger.Warnw("Failed to trim word chain messages", "error", err)
	}
}

func (s *Service) activeState(ctx context.Context) (GameState, error) {
	state, err := s.store.LoadState(ctx)
	if err != nil {
		return GameState{}, err
	}
	if state.Active() && !state.Expired(time.Now()) {
		return state, nil
	}
	word, err := s.pickStartWord(ctx)
	if err != nil {
		s.logger.Warnw("Word chain start word unavailable", "error", err)
		return GameState{}, ErrVerifyFailed
	}
	err = s.withLock(ctx, func(ctx context.Context, batch *eventBatch) error {
		current, err := s.store.LoadState(ctx)
		if err != nil {
			return err
		}
		if current.Active() && !current.Expired(time.Now()) {
			state = current
			return nil
		}
		state, err = s.startSessionLocked(ctx, batch, word)
		return err
	})
	return state, err
}

func (s *Service) startSessionLocked(ctx context.Context, batch *eventBatch, word string) (GameState, error) {
	state := newSession(word, time.Now())
	mutation := &Mutation{State: &state, ResetMessages: true, Messages: []Message{sessionStartedMessage(state)}}
	if _, err := s.store.Apply(ctx, mutation); err != nil {
		return GameState{}, err
	}
	batch.state(state)
	batch.message(mutation.Messages[0])
	s.scheduleSessionExpiry(state.SessionID, state.ExpiresAt())
	return state, nil
}

func (s *Service) Overview(ctx context.Context, userID uuid.UUID) (*OverviewResponse, error) {
	state, err := s.activeState(ctx)
	if err != nil {
		return nil, err
	}
	points, err := s.store.Points(ctx, userID.String())
	if err != nil {
		return nil, err
	}
	return &OverviewResponse{
		State:            toStateView(state),
		Points:           points,
		RemainingGuesses: state.RemainingGuesses(userID.String()),
	}, nil
}

func (s *Service) Messages(ctx context.Context, limit int, beforeID string) (*MessageListResponse, error) {
	if _, err := s.activeState(ctx); err != nil {
		return nil, err
	}
	stored, err := s.store.ListMessages(ctx, limit, beforeID)
	if err != nil {
		return nil, err
	}
	idSet := make(map[uuid.UUID]struct{})
	for _, m := range stored {
		if id, err := uuid.Parse(m.SenderID); err == nil {
			idSet[id] = struct{}{}
		}
	}
	ids := make([]uuid.UUID, 0, len(idSet))
	for id := range idSet {
		ids = append(ids, id)
	}
	users := s.userCache.GetUsersBatch(ids, true)

	items := make([]Message, 0, len(stored))
	for _, m := range stored {
		var sender *models.User
		if id, err := uuid.Parse(m.SenderID); err == nil {
			sender = users[id]
		}
		items = append(items, m.toMessage(sender))
	}
	resp := &MessageListResponse{Items: items, HasMore: len(stored) == limit}
	if len(items) > 0 {
		resp.NextBefore = items[len(items)-1].ID
	}
	return resp, nil
}

func (s *Service) Leaderboard(ctx context.Context, userID uuid.UUID) (*LeaderboardResponse, error) {
	top, total, err := s.store.TopPoints(ctx, LeaderboardLimit)
	if err != nil {
		return nil, err
	}
	rank, points, ranked, err := s.store.Rank(ctx, userID.String())
	if err != nil {
		return nil, err
	}

	ids := make([]uuid.UUID, 0, len(top)+1)
	for _, entry := range top {
		if id, err := uuid.Parse(entry.UserID); err == nil {
			ids = append(ids, id)
		}
	}
	ids = append(ids, userID)
	users := s.userCache.GetUsersBatch(ids, true)
	toEntry := func(rank int, id string, points int64) LeaderboardEntry {
		entry := LeaderboardEntry{Rank: rank, UserID: id, Points: points}
		if uid, err := uuid.Parse(id); err == nil {
			if u := users[uid]; u != nil {
				entry.Username, entry.FullName, entry.Avatar = u.Username, u.FullName, u.Avatar
			}
		}
		return entry
	}

	resp := &LeaderboardResponse{Items: make([]LeaderboardEntry, 0, len(top)), Total: total}
	for i, entry := range top {
		resp.Items = append(resp.Items, toEntry(i+1, entry.UserID, entry.Points))
	}
	if ranked {
		me := toEntry(int(rank), userID.String(), points)
		resp.Me = &me
	}
	return resp, nil
}

func (s *Service) scheduleSessionExpiry(sessionID string, at time.Time) {
	delay := max(time.Until(at), 0)
	s.timerMu.Lock()
	defer s.timerMu.Unlock()
	if s.timer != nil {
		s.timer.Stop()
	}
	s.timer = time.AfterFunc(delay, func() {
		utils.SafeGo(s.logger, func() { s.expireSession(sessionID) })
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

func (s *Service) expireSession(sessionID string) {
	ctx, cancel := context.WithTimeout(context.Background(), BackgroundTimeout)
	defer cancel()

	state, err := s.store.LoadState(ctx)
	if err != nil || state.SessionID != sessionID {
		return
	}
	if !state.Expired(time.Now()) {
		s.scheduleSessionExpiry(sessionID, state.ExpiresAt())
		return
	}
	word, err := s.pickStartWord(ctx)
	if err != nil {
		s.logger.Warnw("Word chain start word unavailable, retrying", "error", err)
		s.scheduleSessionExpiry(sessionID, time.Now().Add(SessionRetryDelay))
		return
	}
	err = s.withLock(ctx, func(ctx context.Context, batch *eventBatch) error {
		state, err := s.store.LoadState(ctx)
		if err != nil || state.SessionID != sessionID {
			return err
		}
		if !state.Expired(time.Now()) {
			s.scheduleSessionExpiry(sessionID, state.ExpiresAt())
			return nil
		}
		_, err = s.startSessionLocked(ctx, batch, word)
		return err
	})
	if errors.Is(err, ErrBusy) {
		s.scheduleSessionExpiry(sessionID, time.Now().Add(LockRetryWait))
		return
	}
	if err != nil {
		s.logger.Errorw("Failed to start new word chain session", "error", err)
	}
}

func (s *Service) resumeSessionTimer() {
	ctx, cancel := context.WithTimeout(context.Background(), BackgroundTimeout)
	defer cancel()
	state, err := s.store.LoadState(ctx)
	if err != nil || !state.Active() {
		return
	}
	s.timerMu.Lock()
	idle := s.timer == nil
	s.timerMu.Unlock()
	if idle {
		s.scheduleSessionExpiry(state.SessionID, state.ExpiresAt())
	}
}

func toStateView(state GameState) *StateResponse {
	view := &StateResponse{
		SessionID:    state.SessionID,
		Revision:     state.Revision,
		Turn:         state.Turn,
		GuessLimit:   MaxWrongGuesses,
		Word:         state.Word,
		HistoryCount: len(state.History),
	}
	if state.Word != "" {
		view.RequiredSyllable = lastWord(state.Word)
	}
	if state.Active() {
		view.SessionStartedAt = state.SessionStartedAt.UTC().Format(time.RFC3339)
		view.LastProgressAt = state.LastProgressAt.UTC().Format(time.RFC3339)
		view.SessionExpiresAt = state.ExpiresAt().UTC().Format(time.RFC3339)
	}
	return view
}
