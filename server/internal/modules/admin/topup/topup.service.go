package admintopup

import (
	"errors"
	"time"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/topup"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

var (
	ErrTopupTxNotFound   = errors.New("topup transaction not found")
	ErrTopupTxNotPending = errors.New("topup transaction cannot be credited")
	ErrUserNotFound      = apperr.ErrUserNotFound
)

type Service struct {
	repo      *Repository
	topupRepo *topup.Repository
	notifier  *topup.Notifier
	userCache *user.CacheService
	wsServer  *websocket.Server
	logger    *zap.SugaredLogger
}

func NewService(
	repo *Repository,
	topupRepo *topup.Repository,
	notifier *topup.Notifier,
	userCache *user.CacheService,
	wsServer *websocket.Server,
	logger *zap.SugaredLogger,
) *Service {
	return &Service{
		repo:      repo,
		topupRepo: topupRepo,
		notifier:  notifier,
		userCache: userCache,
		wsServer:  wsServer,
		logger:    logger.Named("[admin_topup_service]"),
	}
}

func (s *Service) List(f ListFilter, limit, offset int) (*TransactionListResponse, error) {
	items, total, err := s.repo.List(f, limit, offset)
	if err != nil {
		return nil, err
	}

	userIDs := make([]uuid.UUID, 0, len(items))
	for i := range items {
		if items[i].UserID != nil {
			userIDs = append(userIDs, *items[i].UserID)
		}
	}
	users, err := s.repo.FindUsersByIDs(userIDs)
	if err != nil {
		return nil, err
	}

	out := make([]TransactionItem, 0, len(items))
	for i := range items {
		item := toTransactionItem(&items[i])
		if items[i].UserID != nil {
			if u, ok := users[*items[i].UserID]; ok {
				item.User = &UserInfo{
					ID:       u.ID.String(),
					Username: u.Username,
					FullName: u.FullName,
					Avatar:   u.Avatar,
				}
			}
		}
		out = append(out, item)
	}
	return &TransactionListResponse{Total: total, Limit: limit, Offset: offset, Items: out}, nil
}

const monthlyBucketThreshold = 62 * 24 * time.Hour

func toStatsTotals(row statsTotalsRow) StatsTotals {
	return StatsTotals{Count: row.Count, Amount: row.Amount, Ken: row.Ken}
}

func (s *Service) Stats(from, to time.Time) (*StatsResponse, error) {
	bucket := "day"
	if to.Sub(from) > monthlyBucketThreshold {
		bucket = "month"
	}

	now := time.Now()
	startOfDay := time.Date(now.Year(), now.Month(), now.Day(), 0, 0, 0, 0, now.Location())
	startOfMonth := time.Date(now.Year(), now.Month(), 1, 0, 0, 0, 0, now.Location())

	today, err := s.repo.CreditedTotals(&startOfDay, nil)
	if err != nil {
		return nil, err
	}
	thisMonth, err := s.repo.CreditedTotals(&startOfMonth, nil)
	if err != nil {
		return nil, err
	}
	inRange, err := s.repo.CreditedTotals(&from, &to)
	if err != nil {
		return nil, err
	}
	pending, err := s.repo.PendingTotals()
	if err != nil {
		return nil, err
	}
	rows, err := s.repo.CreditedSeries(from, to, bucket)
	if err != nil {
		return nil, err
	}

	series := make([]StatsSeriesItem, len(rows))
	for i, row := range rows {
		series[i] = StatsSeriesItem{Date: row.Date, Amount: row.Amount, Ken: row.Ken, Count: row.Count}
	}
	return &StatsResponse{
		Bucket:    bucket,
		Today:     toStatsTotals(today),
		ThisMonth: toStatsTotals(thisMonth),
		Range:     toStatsTotals(inRange),
		Pending:   toStatsTotals(pending),
		Series:    series,
	}, nil
}

var manualCreditableStatuses = map[models.TopupTxStatus]bool{
	models.TopupTxStatusProcessing:      true,
	models.TopupTxStatusNoMatch:         true,
	models.TopupTxStatusBelowMin:        true,
	models.TopupTxStatusSkippedDisabled: true,
	models.TopupTxStatusFailed:          true,
}

func (s *Service) ManualCredit(rowID, adminID uuid.UUID, req ManualCreditRequest) (*ManualCreditResponse, error) {
	row, err := s.repo.FindByID(rowID)
	if err != nil {
		return nil, err
	}
	if row == nil {
		return nil, ErrTopupTxNotFound
	}
	if !manualCreditableStatuses[row.Status] || row.Type != "IN" || row.Amount <= 0 {
		return nil, ErrTopupTxNotPending
	}

	target, err := s.topupRepo.FindUserByUsernameCI(req.Username)
	if err != nil {
		return nil, err
	}
	if target == nil {
		return nil, ErrUserNotFound
	}

	quote := topup.StoredQuote(row)
	actorID := adminID
	updatedUser, kenTx, err := s.topupRepo.Credit(topup.CreditParams{
		RowID:        row.ID,
		UserID:       target.ID,
		KenAmount:    int(quote.Total),
		BonusKen:     quote.Bonus,
		BonusPercent: quote.BonusPercent,
		ProviderTxID: row.ProviderTxID,
		AmountVnd:    row.Amount,
		ActorType:    models.KenActorAdmin,
		ActorID:      &actorID,
		Description:  topup.CreditDescription("Nạp KEN qua chuyển khoản (admin duyệt)", quote),
	})
	if err != nil {
		if errors.Is(err, topup.ErrAlreadyCredited) {
			return nil, ErrTopupTxNotPending
		}
		return nil, err
	}

	if err := s.userCache.InvalidateUser(target.ID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after manual topup credit", "user_id", target.ID, "error", err.Error())
	}
	if s.wsServer != nil {
		payload := utils.WrapWebSocketMessage(constants.WebSocketEventKenUpdated, map[string]interface{}{
			"ken": updatedUser.Ken,
		})
		s.wsServer.EmitToUser(target.ID.String(), constants.WebSocketMessageEvent, payload)
	}
	s.notifier.NotifyCredited(topup.CreditedNotice{
		ProviderTxID:  row.ProviderTxID,
		Description:   row.Description,
		AmountVnd:     row.Amount,
		Username:      target.Username,
		BalanceBefore: kenTx.BalanceBefore,
		BalanceAfter:  kenTx.BalanceAfter,
		KenAmount:     kenTx.Amount,
		BonusKen:      quote.Bonus,
		BonusPercent:  quote.BonusPercent,
		Manual:        true,
	})
	s.logger.Infow("Admin manually credited topup",
		"admin_id", adminID,
		"topup_tx_id", row.ID,
		"provider_tx_id", row.ProviderTxID,
		"user_id", target.ID,
		"amount", row.Amount,
		"ken_amount", kenTx.Amount,
		"bonus_ken", quote.Bonus,
		"balance_after", updatedUser.Ken,
	)

	return &ManualCreditResponse{
		ID:           row.ID.String(),
		Status:       string(models.TopupTxStatusCredited),
		KenAmount:    int64(kenTx.Amount),
		BonusKen:     quote.Bonus,
		BonusPercent: quote.BonusPercent,
		BalanceAfter: updatedUser.Ken,
		User: UserInfo{
			ID:       target.ID.String(),
			Username: target.Username,
			FullName: target.FullName,
			Avatar:   target.Avatar,
		},
	}, nil
}

func toTransactionItem(t *models.TopupTransaction) TransactionItem {
	item := TransactionItem{
		ID:           t.ID.String(),
		ProviderTxID: t.ProviderTxID,
		Description:  t.Description,
		Amount:       t.Amount,
		Type:         t.Type,
		Status:       string(t.Status),
		KenAmount:    t.KenAmount,
		BonusKen:     t.BonusKen,
		BonusPercent: t.BonusPercent,
		CreatedAt:    t.CreatedAt.UTC().Format(time.RFC3339),
		UpdatedAt:    t.UpdatedAt.UTC().Format(time.RFC3339),
	}
	if t.MatchedUsername != nil {
		item.MatchedUsername = *t.MatchedUsername
	}
	if t.KenTxID != nil {
		item.KenTxID = t.KenTxID.String()
	}
	if t.Note != nil {
		item.Note = *t.Note
	}
	return item
}
