package wordchain

import (
	"context"
	"errors"
	"fmt"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
	userModule "ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"
	"sync"
	"time"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

var (
	errStaleState           = errors.New("word chain state changed")
	errStartWordUnavailable = errors.New("word chain start word unavailable")
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
	settings  Settings
	logger    *zap.SugaredLogger
	timerMu   sync.Mutex
	timer     *time.Timer
}

func NewService(dict *Dictionary, verifier *Verifier, store *Store, cache *services.CacheService, userCache *userModule.CacheService, publisher EventPublisher, wallet *Wallet, repo *Repository, settings *setting.Service, logger *zap.SugaredLogger) *Service {
	s := &Service{
		dict:      dict,
		verifier:  verifier,
		store:     store,
		cache:     cache,
		userCache: userCache,
		publisher: publisher,
		wallet:    wallet,
		scores:    repo,
		settings:  settings,
		logger:    logger.Named("[word_chain_service]"),
	}
	utils.SafeGo(s.logger, s.resumeExpiryTimer)
	return s
}

func (s *Service) sender(userID uuid.UUID) *models.User {
	u, err := s.userCache.GetUserCache(userID, true)
	if err != nil {
		return nil
	}
	return u
}

func expectedWord(req *MoveRequest, state GameState) wordRef {
	ref := state.ref()
	if req.SessionID != "" {
		ref.SessionID = req.SessionID
	}
	if req.Turn != nil {
		ref.Turn = *req.Turn
	}
	return ref
}

func (s *Service) HandleMove(ctx context.Context, userID uuid.UUID, req *MoveRequest) (*MoveResponse, error) {
	if _, err := s.enabledConfig(); err != nil {
		return nil, err
	}
	sender := s.sender(userID)
	oracle := liveOracle{ctx: ctx, service: s}
	state, err := s.activeState(ctx)
	if err != nil {
		return nil, err
	}
	expected := expectedWord(req, state)
	for attempt := 0; attempt < constants.WordChainMoveMaxAttempts; attempt++ {
		if attempt > 0 {
			if state, err = s.activeState(ctx); err != nil {
				return nil, err
			}
		}
		if !expected.matches(state) {
			return nil, ErrWordChanged
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

func buildMoveCommit(current GameState, userID uuid.UUID, sender *models.User, content string, res MoveResult, now time.Time) (*Mutation, *models.WordChainScore) {
	state := res.State
	if res.Scored {
		state.LastProgressAt = now
	}
	moveID := uuid.New()
	move := moveMessage(moveID, state.SessionID, userID.String(), sender, content, res, now)
	messages := []Message{move}
	switch {
	case res.Code == constants.WordChainCodeWin:
		started := gameStartedMessage(state.SessionID, state.Word, now)
		state.BotMessageID = started.ID
		messages = append(messages, winMessage(state.SessionID, move, now), started)
	case !res.Scored:
		messages = append(messages, wrongAnswerMessage(state.SessionID, state, res, now))
	}
	mutation := &Mutation{State: &state, Messages: messages}
	if !res.Scored {
		return mutation, nil
	}
	return mutation, &models.WordChainScore{
		MessageID:    moveID,
		SessionID:    state.SessionID,
		UserID:       userID,
		Word:         move.Word,
		PreviousWord: current.Word,
		Points:       constants.WordChainPointsPerWord,
		IsWin:        res.Code == constants.WordChainCodeWin,
		CreatedAt:    now.UTC(),
	}
}

func (s *Service) commitMove(ctx context.Context, userID uuid.UUID, sender *models.User, content string, revision int64, res MoveResult) (*MoveResponse, error) {
	var resp *MoveResponse
	var score *models.WordChainScore
	err := s.withLock(ctx, func(ctx context.Context, batch *eventBatch) error {
		current, err := s.store.LoadState(ctx)
		if err != nil {
			return err
		}
		if current.Revision != revision || !current.Active() {
			return errStaleState
		}
		var mutation *Mutation
		mutation, score = buildMoveCommit(current, userID, sender, content, res, time.Now())
		if err := s.store.Apply(ctx, mutation); err != nil {
			return err
		}
		s.trimMessages(ctx)

		state := *mutation.State
		for _, msg := range mutation.Messages {
			batch.message(msg)
		}
		batch.state(state)
		s.syncExpiryTimer(state)
		resp = &MoveResponse{
			Message:          mutation.Messages[0],
			BotMessages:      append([]Message{}, mutation.Messages[1:]...),
			State:            toStateView(state),
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
	points, err := s.scores.Points(ctx, userID)
	if err != nil {
		s.logger.Warnw("Failed to load word chain points after move", "user_id", userID, "error", err)
	}
	resp.Points = points
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
	refreshed, err := s.refreshState(ctx)
	if errors.Is(err, errStartWordUnavailable) {
		s.logger.Warnw("Word chain start word unavailable", "error", err)
		if state.Active() {
			return state, nil
		}
		return GameState{}, ErrVerifyFailed
	}
	return refreshed, err
}

func (s *Service) refreshState(ctx context.Context) (GameState, error) {
	word, err := s.pickStartWord(ctx)
	if err != nil {
		return GameState{}, fmt.Errorf("%w: %w", errStartWordUnavailable, err)
	}
	var state GameState
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
	if err := s.store.Apply(ctx, mutation); err != nil {
		return GameState{}, err
	}
	s.trimMessages(ctx)
	batch.state(state)
	batch.message(mutation.Messages[0])
	s.syncExpiryTimer(state)
	return state, nil
}

func (s *Service) Overview(ctx context.Context, userID uuid.UUID) (*OverviewResponse, error) {
	cfg, err := s.enabledConfig()
	if err != nil {
		return nil, err
	}
	state, err := s.activeState(ctx)
	if err != nil {
		return nil, err
	}
	points, err := s.scores.Points(ctx, userID)
	if err != nil {
		return nil, err
	}
	return &OverviewResponse{
		State:            toStateView(state),
		Points:           points,
		RemainingGuesses: state.RemainingGuesses(userID.String()),
		HintPrice:        cfg.HintPrice,
	}, nil
}

func (s *Service) Messages(ctx context.Context, limit int, beforeID string) (*MessageListResponse, error) {
	if _, err := s.enabledConfig(); err != nil {
		return nil, err
	}
	if _, err := s.activeState(ctx); err != nil {
		return nil, err
	}
	return s.messagePage(ctx, limit, beforeID)
}
