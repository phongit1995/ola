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
	wallet    HintWallet
	scores    ScoreLog
	logger    *zap.SugaredLogger
	timerMu   sync.Mutex
	timer     *time.Timer
}

func NewService(dict *Dictionary, verifier *Verifier, store *Store, cache *services.CacheService, userCache *userModule.CacheService, publisher EventPublisher, wallet *Wallet, scores *ScoreRepository, logger *zap.SugaredLogger) *Service {
	s := &Service{
		dict:      dict,
		verifier:  verifier,
		store:     store,
		cache:     cache,
		userCache: userCache,
		publisher: publisher,
		wallet:    wallet,
		scores:    scores,
		logger:    logger.Named("[word_chain_service]"),
	}
	utils.SafeGo(s.logger, s.resumeExpiryTimer)
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
		if errors.Is(err, errOwnWord) {
			return nil, ErrWaitTurn
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
	var score *models.WordChainScore
	err := s.withLock(ctx, func(ctx context.Context, batch *eventBatch) error {
		state, err := s.store.LoadState(ctx)
		if err != nil {
			return err
		}
		now := time.Now()
		if state.Revision != revision || !state.Active() {
			return errStaleState
		}
		previousWord := state.Word

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
			if res.Code == CodeWin {
				mutation.WinUserID = userID.String()
			}
		} else if points, err = s.store.Score(ctx, CacheKeyPoints, userID.String()); err != nil {
			return err
		}

		move := moveMessage(state.SessionID, userID.String(), sender, content, res, now)
		mutation.Messages = append(mutation.Messages, move)
		switch {
		case res.Code == CodeWin:
			started := gameStartedMessage(state.SessionID, state.Word, now)
			state.BotMessageID = started.ID
			mutation.Messages = append(mutation.Messages, winMessage(state.SessionID, move, now), started)
		case !res.Scored:
			mutation.Messages = append(mutation.Messages, wrongAnswerMessage(state.SessionID, state, res, now))
		}
		total, err := s.store.Apply(ctx, mutation)
		if err != nil {
			return err
		}
		if res.Scored {
			points = total
			score = s.scoreRecord(userID, move, previousWord, now)
		}
		s.trimMessages(ctx)

		for _, msg := range mutation.Messages {
			batch.message(msg)
		}
		if res.StateChanged {
			batch.state(state)
			s.syncExpiryTimer(state)
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
	if score != nil {
		s.recordScore(ctx, score)
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
		if state.Active() {
			return state, nil
		}
		return GameState{}, ErrVerifyFailed
	}
	err = s.withLock(ctx, func(ctx context.Context, batch *eventBatch) error {
		current, err := s.store.LoadState(ctx)
		if err != nil {
			return err
		}
		state, err = s.refreshStateLocked(ctx, batch, current, word)
		return err
	})
	return state, err
}

func (s *Service) refreshStateLocked(ctx context.Context, batch *eventBatch, current GameState, word string) (GameState, error) {
	now := time.Now()
	switch {
	case !current.Active():
		state := newSession(word, now)
		return s.announceBotWordLocked(ctx, batch, state, sessionStartedMessage(state), "")
	case current.Expired(now):
		state := current.withBotWord(word, now)
		return s.announceBotWordLocked(ctx, batch, state, gameStartedMessage(state.SessionID, word, now), current.BotMessageID)
	}
	s.syncExpiryTimer(current)
	return current, nil
}

func (s *Service) announceBotWordLocked(ctx context.Context, batch *eventBatch, state GameState, announcement Message, replacedID string) (GameState, error) {
	if replacedID != "" {
		announcement.ID = replacedID
	}
	state.BotMessageID = announcement.ID
	mutation := &Mutation{State: &state, Messages: []Message{announcement}}
	if _, err := s.store.Apply(ctx, mutation); err != nil {
		return GameState{}, err
	}
	s.trimMessages(ctx)
	batch.state(state)
	batch.message(mutation.Messages[0])
	s.syncExpiryTimer(state)
	return state, nil
}

func (s *Service) Overview(ctx context.Context, userID uuid.UUID) (*OverviewResponse, error) {
	state, err := s.activeState(ctx)
	if err != nil {
		return nil, err
	}
	points, err := s.store.Score(ctx, CacheKeyPoints, userID.String())
	if err != nil {
		return nil, err
	}
	return &OverviewResponse{
		State:            toStateView(state),
		Points:           points,
		RemainingGuesses: state.RemainingGuesses(userID.String()),
		HintPrice:        HintPriceKen,
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

func (s *Service) expireBotWord() {
	ctx, cancel := context.WithTimeout(context.Background(), BackgroundTimeout)
	defer cancel()

	state, err := s.store.LoadState(ctx)
	if err != nil {
		s.logger.Warnw("Failed to load word chain state, retrying", "error", err)
		s.scheduleExpiry(time.Now().Add(BotWordRetryDelay))
		return
	}
	if !state.CanExpire() {
		return
	}
	if !state.Expired(time.Now()) {
		s.scheduleExpiry(state.ExpiresAt())
		return
	}
	word, err := s.pickStartWord(ctx)
	if err != nil {
		s.logger.Warnw("Word chain replacement word unavailable, retrying", "error", err)
		s.scheduleExpiry(time.Now().Add(BotWordRetryDelay))
		return
	}
	err = s.withLock(ctx, func(ctx context.Context, batch *eventBatch) error {
		current, err := s.store.LoadState(ctx)
		if err != nil {
			return err
		}
		_, err = s.refreshStateLocked(ctx, batch, current, word)
		return err
	})
	if errors.Is(err, ErrBusy) {
		s.scheduleExpiry(time.Now().Add(LockRetryWait))
		return
	}
	if err != nil {
		s.logger.Errorw("Failed to replace word chain bot word, retrying", "error", err)
		s.scheduleExpiry(time.Now().Add(BotWordRetryDelay))
	}
}

func (s *Service) resumeExpiryTimer() {
	ctx, cancel := context.WithTimeout(context.Background(), BackgroundTimeout)
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

func toStateView(state GameState) *StateResponse {
	view := &StateResponse{
		SessionID:    state.SessionID,
		Revision:     state.Revision,
		Turn:         state.Turn,
		GuessLimit:   MaxWrongGuesses,
		Word:         state.Word,
		HistoryCount: len(state.History),
		WordOwnerID:  state.WordOwnerID,
	}
	if state.Word != "" {
		view.RequiredSyllable = lastWord(state.Word)
	}
	if state.Active() {
		view.SessionStartedAt = state.SessionStartedAt.UTC().Format(time.RFC3339)
		view.LastProgressAt = state.LastProgressAt.UTC().Format(time.RFC3339)
	}
	if state.CanExpire() {
		view.WordExpiresAt = state.ExpiresAt().UTC().Format(time.RFC3339)
	}
	return view
}
