package kenchest

import (
	"context"
	"errors"
	"time"

	"ola-chat-server/internal/constants"
	kenChestEvents "ola-chat-server/internal/domain/kenchest"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/transport/kafka"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

var (
	ErrChestNotFound     = errors.New("ken chest not found")
	ErrChestExpired      = errors.New("ken chest expired")
	ErrChestActiveExists = errors.New("a ken chest is already active")
	ErrInvalidReward     = errors.New("invalid ken chest configuration")
)

type Service struct {
	repo      *Repository
	userCache *user.CacheService
	wsServer  *websocket.Server
	producer  *kafka.Producer
	logger    *zap.SugaredLogger
}

func NewService(repo *Repository, userCache *user.CacheService, wsServer *websocket.Server, producer *kafka.Producer, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:      repo,
		userCache: userCache,
		wsServer:  wsServer,
		producer:  producer,
		logger:    logger.Named("[ken_chest_service]"),
	}
}

func (s *Service) CreateAndBroadcast(ctx context.Context, adminID uuid.UUID, req CreateChestRequest) (*ChestView, error) {
	if err := normalizeAndValidate(&req); err != nil {
		return nil, err
	}

	now := time.Now()
	active, err := s.repo.HasActiveChest(now)
	if err != nil {
		return nil, err
	}
	if active {
		return nil, ErrChestActiveExists
	}

	chest := models.KenChest{
		RewardMode:      models.KenChestRewardMode(req.RewardMode),
		KenAmount:       req.KenAmount,
		KenMin:          req.KenMin,
		KenMax:          req.KenMax,
		MaxRecipients:   req.MaxRecipients,
		DurationSeconds: req.DurationSeconds,
		Status:          models.KenChestStatusActive,
		StartedAt:       now,
		ExpiresAt:       now.Add(time.Duration(req.DurationSeconds) * time.Second),
		CreatedBy:       &adminID,
	}
	if err := s.repo.CreateChest(&chest); err != nil {
		return nil, err
	}

	s.broadcastAvailable(ctx, &chest)

	view := toChestView(&chest)
	return &view, nil
}

func (s *Service) ListChests(limit, offset int) (*ChestListResponse, error) {
	chests, total, err := s.repo.ListChests(limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]ChestView, len(chests))
	for i := range chests {
		items[i] = toChestView(&chests[i])
	}
	return &ChestListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) ListClaims(chestID uuid.UUID, limit, offset int) (*ClaimListResponse, error) {
	rows, total, err := s.repo.ListClaims(chestID, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]ClaimView, len(rows))
	for i := range rows {
		items[i] = ClaimView{
			ID:        rows[i].ID,
			KenAmount: rows[i].KenAmount,
			IsEmpty:   rows[i].IsEmpty,
			CreatedAt: rows[i].CreatedAt,
			User: ClaimUserView{
				ID:       rows[i].UserID,
				Username: rows[i].Username,
				FullName: rows[i].FullName,
				Avatar:   rows[i].Avatar,
			},
		}
	}
	return &ClaimListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) GetChest(id uuid.UUID) (*ChestView, error) {
	chest, err := s.repo.FindByID(id)
	if err != nil {
		return nil, ErrChestNotFound
	}
	view := toChestView(chest)
	return &view, nil
}

func (s *Service) DeleteChest(ctx context.Context, id uuid.UUID) error {
	chest, err := s.repo.FindByID(id)
	if err != nil {
		return ErrChestNotFound
	}
	if err := s.repo.SoftDeleteChest(id); err != nil {
		return err
	}
	if err := s.producer.PublishKenChestClosed(ctx, &kenChestEvents.ChestClosedEvent{ID: chest.ID.String()}); err != nil {
		s.logger.Errorw("Failed to publish ken chest closed", "chest_id", chest.ID, "error", err.Error())
	}
	return nil
}

func (s *Service) ListActiveForUser(userID uuid.UUID) (*ActiveChestListResponse, error) {
	rows, err := s.repo.ListActiveForUser(userID, time.Now())
	if err != nil {
		return nil, err
	}
	items := make([]ActiveChestView, 0, len(rows))
	for i := range rows {
		items = append(items, ActiveChestView{
			ID:              rows[i].ID,
			ExpiresAt:       rows[i].ExpiresAt,
			DurationSeconds: rows[i].DurationSeconds,
			Opened:          rows[i].Opened,
		})
	}
	return &ActiveChestListResponse{Items: items}, nil
}

func (s *Service) Open(userID, chestID uuid.UUID) (*OpenChestResult, error) {
	chest, err := s.repo.FindByID(chestID)
	if err != nil || chest.Status == models.KenChestStatusDeleted {
		return nil, ErrChestNotFound
	}

	if existing, ok := s.existingClaimResult(chestID, userID); ok {
		return existing, nil
	}

	if chest.Status != models.KenChestStatusActive || time.Now().After(chest.ExpiresAt) {
		return nil, ErrChestExpired
	}

	rolled := s.rollAmount(chest)
	outcome, err := s.repo.ApplyClaim(userID, chest, rolled)
	if err != nil {
		if existing, ok := s.existingClaimResult(chestID, userID); ok {
			return existing, nil
		}
		return nil, err
	}

	if !outcome.IsEmpty {
		s.invalidateUser(userID)
		s.emitKenUpdate(userID, outcome.KenBalance)
	}

	return &OpenChestResult{
		ChestID:    chestID,
		IsEmpty:    outcome.IsEmpty,
		KenAmount:  outcome.KenAmount,
		KenBalance: outcome.KenBalance,
	}, nil
}

func (s *Service) rollAmount(chest *models.KenChest) int {
	if chest.RewardMode == models.KenChestRewardFixed {
		if chest.KenAmount != nil {
			return *chest.KenAmount
		}
		return 0
	}
	if chest.KenMin == nil || chest.KenMax == nil {
		return 0
	}
	lo, hi := *chest.KenMin, *chest.KenMax
	if hi <= lo {
		return lo
	}
	return lo + int(utils.CryptoFloat()*float64(hi-lo+1))
}

func (s *Service) broadcastAvailable(ctx context.Context, chest *models.KenChest) {
	event := &kenChestEvents.ChestAvailableEvent{
		ID:              chest.ID.String(),
		ExpiresAt:       chest.ExpiresAt,
		DurationSeconds: chest.DurationSeconds,
	}
	if err := s.producer.PublishKenChestAvailable(ctx, event); err != nil {
		s.logger.Errorw("Failed to publish ken chest available", "chest_id", chest.ID, "error", err.Error())
	}
}

func (s *Service) emitKenUpdate(userID uuid.UUID, ken int) {
	if s.wsServer == nil {
		return
	}
	payload := utils.WrapWebSocketMessage(constants.WebSocketEventKenUpdated, map[string]interface{}{
		"ken": ken,
	})
	s.wsServer.EmitToUser(userID.String(), constants.WebSocketMessageEvent, payload)
}

func (s *Service) invalidateUser(userID uuid.UUID) {
	if err := s.userCache.InvalidateUser(userID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after ken chest open", "user_id", userID, "error", err.Error())
	}
}

func normalizeAndValidate(req *CreateChestRequest) error {
	if req.RewardMode == string(models.KenChestRewardFixed) {
		if req.KenAmount == nil || *req.KenAmount <= 0 {
			return ErrInvalidReward
		}
		req.KenMin = nil
		req.KenMax = nil
	} else {
		if req.KenMin == nil || req.KenMax == nil || *req.KenMin <= 0 || *req.KenMax < *req.KenMin {
			return ErrInvalidReward
		}
		req.KenAmount = nil
	}
	if req.MaxRecipients <= 0 {
		return ErrInvalidReward
	}
	if req.DurationSeconds == 0 {
		req.DurationSeconds = 90
	}
	if req.DurationSeconds < 30 || req.DurationSeconds > 600 {
		return errors.New("ken chest duration must be between 30 and 600 seconds")
	}
	return nil
}

func toChestView(c *models.KenChest) ChestView {
	return ChestView{
		ID:                c.ID,
		RewardMode:        string(c.RewardMode),
		KenAmount:         c.KenAmount,
		KenMin:            c.KenMin,
		KenMax:            c.KenMax,
		MaxRecipients:     c.MaxRecipients,
		ClaimedRecipients: c.ClaimedRecipients,
		DurationSeconds:   c.DurationSeconds,
		Status:            string(c.Status),
		StartedAt:         c.StartedAt,
		ExpiresAt:         c.ExpiresAt,
		ClaimsCount:       c.ClaimsCount,
		TotalKenGiven:     c.TotalKenGiven,
		CreatedAt:         c.CreatedAt,
	}
}

func (s *Service) existingClaimResult(chestID, userID uuid.UUID) (*OpenChestResult, bool) {
	claim, err := s.repo.FindClaim(chestID, userID)
	if err != nil {
		return nil, false
	}
	balance, _ := s.repo.GetUserKen(userID)
	return &OpenChestResult{
		ChestID:    chestID,
		IsEmpty:    claim.IsEmpty,
		KenAmount:  claim.KenAmount,
		KenBalance: balance,
	}, true
}
