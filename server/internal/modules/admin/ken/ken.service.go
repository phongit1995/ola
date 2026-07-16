package adminken

import (
	"errors"
	"time"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var (
	ErrUserNotFound    = apperr.ErrUserNotFound
	ErrInsufficientKen = errors.New("insufficient ken balance")
)

type Service struct {
	repo      *Repository
	userCache *user.CacheService
	wsServer  *websocket.Server
	logger    *zap.SugaredLogger
}

func NewService(repo *Repository, userCache *user.CacheService, wsServer *websocket.Server, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:      repo,
		userCache: userCache,
		wsServer:  wsServer,
		logger:    logger.Named("[admin_ken_service]"),
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
		s.logger.Warnw("Failed to invalidate user cache after ken adjust", "user_id", userID, "error", err.Error())
	}
}

func (s *Service) Adjust(targetID, adminID uuid.UUID, req AdjustRequest) (*AdjustResponse, error) {
	direction := models.KenDirectionCredit
	txType := models.KenTxTypeAdminGrant
	if req.Action == "deduct" {
		direction = models.KenDirectionDebit
		txType = models.KenTxTypeAdminDeduct
	}

	updatedUser, kenTx, err := s.repo.Adjust(AdjustParams{
		UserID:      targetID,
		Direction:   direction,
		Type:        txType,
		Amount:      req.Amount,
		Description: req.Description,
		ActorID:     adminID,
	})
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrUserNotFound
		}
		return nil, err
	}

	s.invalidate(targetID)
	s.emitKenUpdate(targetID, updatedUser.Ken)
	s.logger.Infow("Admin adjusted user ken",
		"admin_id", adminID,
		"user_id", targetID,
		"action", req.Action,
		"amount", req.Amount,
		"balance_after", updatedUser.Ken,
	)

	return &AdjustResponse{
		TransactionID: kenTx.ID.String(),
		UserID:        targetID.String(),
		Action:        req.Action,
		Direction:     string(direction),
		Type:          string(txType),
		Amount:        kenTx.Amount,
		BalanceBefore: kenTx.BalanceBefore,
		BalanceAfter:  kenTx.BalanceAfter,
	}, nil
}

func (s *Service) ListTransactions(userID uuid.UUID, limit, offset int) (*TransactionListResponse, error) {
	items, total, err := s.repo.ListByUser(userID, limit, offset)
	if err != nil {
		return nil, err
	}

	counterpartyIDs := make([]uuid.UUID, 0, len(items))
	for i := range items {
		if items[i].RefType == "user" && items[i].RefID != nil {
			counterpartyIDs = append(counterpartyIDs, *items[i].RefID)
		}
	}
	users, err := s.repo.FindUsersByIDs(counterpartyIDs)
	if err != nil {
		return nil, err
	}

	out := make([]TransactionItem, 0, len(items))
	for i := range items {
		item := toTransactionItem(&items[i])
		if items[i].RefType == "user" && items[i].RefID != nil {
			if u, ok := users[*items[i].RefID]; ok {
				item.Counterparty = &CounterpartyInfo{
					ID:       u.ID.String(),
					Username: u.Username,
					FullName: u.FullName,
					Avatar:   u.Avatar,
				}
			}
		}
		out = append(out, item)
	}
	return &TransactionListResponse{
		Total:  int(total),
		Limit:  limit,
		Offset: offset,
		Items:  out,
	}, nil
}

func toTransactionItem(t *models.KenTransaction) TransactionItem {
	item := TransactionItem{
		ID:            t.ID.String(),
		Direction:     string(t.Direction),
		Type:          string(t.Type),
		Amount:        t.Amount,
		BalanceBefore: t.BalanceBefore,
		BalanceAfter:  t.BalanceAfter,
		Description:   t.Description,
		RefType:       t.RefType,
		ActorType:     string(t.ActorType),
		CreatedAt:     t.CreatedAt.Format(time.RFC3339),
	}
	if t.RefID != nil {
		item.RefID = t.RefID.String()
	}
	if t.ActorID != nil {
		item.ActorID = t.ActorID.String()
	}
	return item
}
