package ken

import (
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/relationships"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"golang.org/x/crypto/bcrypt"
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

func (s *Service) History(userID uuid.UUID, direction string, limit, offset int) (*KenHistoryResponse, error) {
	items, total, err := s.repo.ListTransactions(userID, direction, limit, offset)
	if err != nil {
		return nil, err
	}
	counterpartyIDs := make([]uuid.UUID, 0)
	for i := range items {
		if items[i].RefType == "user" && items[i].RefID != nil {
			counterpartyIDs = append(counterpartyIDs, *items[i].RefID)
		}
	}
	names, err := s.repo.FindUsernames(counterpartyIDs)
	if err != nil {
		return nil, err
	}

	out := make([]KenTransactionItem, 0, len(items))
	for i := range items {
		item := toKenTransactionItem(&items[i])
		if items[i].RefType == "user" && items[i].RefID != nil {
			item.CounterpartyID = items[i].RefID.String()
			item.CounterpartyName = names[*items[i].RefID]
		}
		out = append(out, item)
	}
	return &KenHistoryResponse{
		Total:  int(total),
		Limit:  limit,
		Offset: offset,
		Items:  out,
	}, nil
}

func toKenTransactionItem(t *models.KenTransaction) KenTransactionItem {
	return KenTransactionItem{
		ID:           t.ID.String(),
		Direction:    string(t.Direction),
		Type:         string(t.Type),
		Amount:       t.Amount,
		BalanceAfter: t.BalanceAfter,
		Description:  t.Description,
		CreatedAt:    t.CreatedAt.UTC().Format(time.RFC3339),
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

	hash, err := s.repo.GetPasswordHash(fromID)
	if err != nil {
		return nil, err
	}
	if bcrypt.CompareHashAndPassword([]byte(hash), []byte(req.Password)) != nil {
		return nil, ErrWrongPassword
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
