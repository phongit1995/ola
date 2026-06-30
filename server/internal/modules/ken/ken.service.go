package ken

import (
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/modules/relationships"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Service struct {
	repo      *Repository
	relRepo   *relationships.Repository
	userCache *user.CacheService
	wsServer  *websocket.Server
	logger    *zap.SugaredLogger
}

func NewService(repo *Repository, relRepo *relationships.Repository, userCache *user.CacheService, wsServer *websocket.Server, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:      repo,
		relRepo:   relRepo,
		userCache: userCache,
		wsServer:  wsServer,
		logger:    logger.Named("[ken_service]"),
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

func (s *Service) invalidate(userID uuid.UUID) {
	if err := s.userCache.InvalidateUser(userID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after ken transfer", "user_id", userID, "error", err.Error())
	}
}

func (s *Service) Transfer(fromID uuid.UUID, req TransferRequest) (*TransferResponse, error) {
	toID, err := uuid.Parse(req.ToUserID)
	if err != nil {
		return nil, ErrCannotTransfer
	}
	if toID == fromID {
		return nil, ErrSelfTransfer
	}

	blocked, err := s.relRepo.IsBlockedEither(fromID, toID)
	if err != nil {
		return nil, err
	}
	if blocked {
		return nil, ErrBlockedTransfer
	}

	result, err := s.repo.Transfer(TransferParams{
		FromID:      fromID,
		ToID:        toID,
		Amount:      req.Amount,
		Description: "transfer ken",
	})
	if err != nil {
		return nil, err
	}

	s.invalidate(fromID)
	s.invalidate(toID)
	s.emitKenUpdate(fromID, result.SenderBalance)
	s.emitKenUpdate(toID, result.ReceiverBalance)

	s.logger.Infow("User transferred ken",
		"from_id", fromID,
		"to_id", toID,
		"amount", req.Amount,
		"sender_balance_after", result.SenderBalance,
	)

	return &TransferResponse{
		ToUserID:   toID.String(),
		Amount:     req.Amount,
		KenBalance: result.SenderBalance,
	}, nil
}
