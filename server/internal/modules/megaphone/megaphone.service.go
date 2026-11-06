package megaphone

import (
	"context"
	"fmt"
	"math"
	"strings"
	"time"
	"unicode/utf8"

	"ola-chat-server/internal/apperr"
	megaphoneEvents "ola-chat-server/internal/domain/megaphone"
	"ola-chat-server/internal/models"
	contentfilter "ola-chat-server/internal/modules/content-filter"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/transport/kafka"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Service struct {
	repo      *Repository
	schedule  *Schedule
	settings  *setting.Service
	filter    *contentfilter.Service
	userCache *user.CacheService
	producer  *kafka.Producer
	wsServer  *websocket.Server
	wake      chan struct{}
	logger    *zap.SugaredLogger
}

func NewService(
	repo *Repository,
	schedule *Schedule,
	settings *setting.Service,
	filter *contentfilter.Service,
	userCache *user.CacheService,
	producer *kafka.Producer,
	wsServer *websocket.Server,
	logger *zap.SugaredLogger,
) *Service {
	return &Service{
		repo:      repo,
		schedule:  schedule,
		settings:  settings,
		filter:    filter,
		userCache: userCache,
		producer:  producer,
		wsServer:  wsServer,
		wake:      make(chan struct{}, 1),
		logger:    logger.Named("[megaphone_service]"),
	}
}

func (s *Service) config() setting.MegaphoneConfig {
	cfg, err := s.settings.GetMegaphone()
	if err != nil {
		s.logger.Warnw("Failed to read megaphone config, using default", "error", err.Error())
	}
	return cfg
}

func ceilSeconds(d time.Duration) int {
	if d <= 0 {
		return 0
	}
	return int(math.Ceil(d.Seconds()))
}

func dayStart(now time.Time) time.Time {
	start, _ := utils.VietnamPeriodStart(now, utils.PeriodDay)
	return start
}

func cooldownOf(cfg setting.MegaphoneConfig) time.Duration {
	return time.Duration(cfg.CooldownSeconds) * time.Second
}

func (s *Service) runningSlot(now time.Time) time.Duration {
	nextSlot, err := s.schedule.NextSlot()
	if err != nil {
		s.logger.Warnw("Failed to read megaphone slot", "error", err.Error())
		return 0
	}
	if nextSlot.After(now) {
		return nextSlot.Sub(now)
	}
	return 0
}

func (s *Service) cooldownRemaining(userID uuid.UUID, cooldown time.Duration, now time.Time) (time.Duration, error) {
	if cooldown <= 0 {
		return 0, nil
	}
	last, err := s.repo.LastSentAt(userID)
	if err != nil || last == nil {
		return 0, err
	}
	return last.Add(cooldown).Sub(now), nil
}

func (s *Service) Config(userID uuid.UUID) (*ConfigResponse, error) {
	cfg := s.config()
	now := time.Now().UTC()
	today, err := s.repo.CountSentSince(userID, dayStart(now))
	if err != nil {
		return nil, err
	}
	cooldownLeft, err := s.cooldownRemaining(userID, cooldownOf(cfg), now)
	if err != nil {
		return nil, err
	}
	waiting, err := s.repo.CountWaiting(now)
	if err != nil {
		return nil, err
	}
	return &ConfigResponse{
		Enabled:           cfg.Enabled,
		KenPrice:          cfg.KenPrice,
		MaxLength:         cfg.MaxLength,
		DisplaySeconds:    cfg.DisplaySeconds,
		LiveMinutes:       cfg.LiveMinutes,
		CooldownSeconds:   cfg.CooldownSeconds,
		DailyLimit:        cfg.DailyLimit,
		TodayCount:        int(today),
		CooldownRemaining: ceilSeconds(cooldownLeft),
		QueueWaitSeconds:  ceilSeconds(queueWait(waiting, cfg.SlotSeconds(), s.runningSlot(now))),
	}, nil
}

func (s *Service) validateContent(raw string, maxLength int) (string, error) {
	content := contentfilter.NormalizeContent(raw)
	if content == "" {
		return "", ErrMegaphoneContentEmpty
	}
	if utf8.RuneCountInString(content) > maxLength {
		return "", ErrMegaphoneContentTooLong
	}
	result := s.filter.Check(content)
	if !result.Blocked {
		return content, nil
	}
	if result.Reason == contentfilter.ReasonLink {
		return "", ErrMegaphoneLinkNotAllowed
	}
	return "", ErrMegaphoneContentBlocked
}

func (s *Service) Send(senderID uuid.UUID, req SendRequest) (*SendResponse, error) {
	clientRequestID := strings.TrimSpace(req.ClientRequestID)
	normalized := contentfilter.NormalizeContent(req.Content)
	if existing, err := s.repo.FindByClientRequest(senderID, clientRequestID); err != nil {
		return nil, err
	} else if existing != nil {
		return s.replay(existing, normalized)
	}

	cfg := s.config()
	if !cfg.Enabled {
		return nil, ErrMegaphoneDisabled
	}
	content, err := s.validateContent(req.Content, cfg.MaxLength)
	if err != nil {
		return nil, err
	}

	now := time.Now().UTC()
	result, err := s.repo.Send(SendParams{
		SenderID:        senderID,
		Content:         content,
		KenPrice:        cfg.KenPrice,
		Weight:          cfg.MessageWeight,
		DisplaySeconds:  cfg.DisplaySeconds,
		SlotSeconds:     cfg.SlotSeconds(),
		RunningSlot:     s.runningSlot(now),
		QueueLimit:      cfg.MessageQueueLimit(),
		ExpiresAt:       now.Add(cfg.LiveDuration()),
		DailyLimit:      cfg.DailyLimit,
		DayStart:        dayStart(now),
		Cooldown:        cooldownOf(cfg),
		ClientRequestID: clientRequestID,
		Now:             now,
	})
	if err != nil {
		if apperr.IsUniqueViolation(err) {
			if existing, findErr := s.repo.FindByClientRequest(senderID, clientRequestID); findErr == nil && existing != nil {
				return s.replay(existing, content)
			}
		}
		return nil, err
	}
	if result.Replayed {
		return s.replay(&result.Megaphone, content)
	}

	view := s.ToView(&result.Megaphone)
	s.afterSend(senderID, result.SenderBalance, view)
	return &SendResponse{Megaphone: view, KenBalance: result.SenderBalance, WaitSeconds: ceilSeconds(result.Wait)}, nil
}

func (s *Service) replay(existing *models.Megaphone, content string) (*SendResponse, error) {
	if existing.Content != content {
		return nil, ErrMegaphoneRequestConflict
	}
	balance, err := s.repo.KenBalance(existing.SenderID)
	if err != nil {
		return nil, err
	}
	return &SendResponse{Megaphone: s.ToView(existing), KenBalance: balance, WaitSeconds: s.replayWait(existing)}, nil
}

func (s *Service) replayWait(existing *models.Megaphone) int {
	if existing.FirstPlayedAt != nil {
		return 0
	}
	now := time.Now().UTC()
	waiting, err := s.repo.CountWaiting(now)
	if err != nil {
		s.logger.Warnw("Failed to count waiting megaphones", "error", err.Error())
		return 0
	}
	return ceilSeconds(queueWait(waiting, s.config().SlotSeconds(), s.runningSlot(now)))
}

func (s *Service) afterSend(senderID uuid.UUID, balance int, view megaphoneEvents.Megaphone) {
	s.wsServer.EmitKenUpdate(senderID, balance)
	if err := s.userCache.InvalidateUser(senderID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after megaphone", "user_id", senderID, "error", err.Error())
	}
	s.enqueue(view, s.config().MessageWeight)
}

func (s *Service) enqueue(view megaphoneEvents.Megaphone, weight int) {
	if err := s.schedule.Add(scheduledItem{Megaphone: view, Weight: weight}); err != nil {
		s.logger.Errorw("Failed to schedule megaphone, reconcile will retry", "megaphone_id", view.ID, "error", err.Error())
		return
	}
	select {
	case s.wake <- struct{}{}:
	default:
	}
}

type GiftAnnouncement struct {
	TransactionID uuid.UUID
	SenderID      uuid.UUID
	ReceiverID    uuid.UUID
	GiftName      string
	Quantity      int
	TotalKen      int
}

func giftContent(sender, receiver megaphoneEvents.Sender, giftName string, quantity int) string {
	content := fmt.Sprintf("%s tặng %s %s ×%d", senderName(sender), senderName(receiver), giftName, quantity)
	runes := []rune(content)
	if len(runes) > giftContentRunes {
		return string(runes[:giftContentRunes])
	}
	return content
}

func senderName(sender megaphoneEvents.Sender) string {
	if sender.FullName != "" {
		return sender.FullName
	}
	return sender.Username
}

func (s *Service) AnnounceGift(in GiftAnnouncement) bool {
	cfg := s.config()
	if !cfg.Enabled {
		return false
	}
	now := time.Now().UTC()
	people := s.senders([]uuid.UUID{in.SenderID, in.ReceiverID})
	record, err := s.repo.CreateGift(GiftParams{
		SenderID:          in.SenderID,
		GiftTransactionID: in.TransactionID,
		Content:           giftContent(people[in.SenderID], people[in.ReceiverID], in.GiftName, in.Quantity),
		Weight:            cfg.GiftWeight(in.TotalKen),
		DisplaySeconds:    cfg.DisplaySeconds,
		QueueLimit:        cfg.GiftQueueLimit(),
		ExpiresAt:         now.Add(cfg.LiveDuration()),
		Cooldown:          cooldownOf(cfg),
		Now:               now,
	})
	if err != nil {
		s.logger.Errorw("Failed to create gift megaphone", "gift_transaction_id", in.TransactionID, "error", err.Error())
		return false
	}
	if record == nil {
		return false
	}
	s.enqueue(s.ToView(record), record.Weight)
	return true
}

func (s *Service) GiftAnnounced(txID uuid.UUID) bool {
	item, err := s.repo.FindByGiftTransaction(txID)
	if err != nil {
		s.logger.Warnw("Failed to read gift megaphone", "gift_transaction_id", txID, "error", err.Error())
		return false
	}
	return item != nil
}

func (s *Service) PublishRemoved(id uuid.UUID) {
	if err := s.schedule.Remove(id.String()); err != nil {
		s.logger.Warnw("Failed to unschedule megaphone, reconcile will retry", "megaphone_id", id, "error", err.Error())
	}
	ctx, cancel := context.WithTimeout(context.Background(), publishTimeout)
	defer cancel()
	if err := s.producer.PublishMegaphoneRemoved(ctx, &megaphoneEvents.RemovedEvent{ID: id.String()}); err != nil {
		s.logger.Errorw("Failed to publish megaphone removed", "megaphone_id", id, "error", err.Error())
	}
}

func (s *Service) senders(ids []uuid.UUID) map[uuid.UUID]megaphoneEvents.Sender {
	users := s.userCache.GetUsersBatch(ids, true)
	out := make(map[uuid.UUID]megaphoneEvents.Sender, len(ids))
	for _, id := range ids {
		u, ok := users[id]
		if !ok || u == nil {
			out[id] = megaphoneEvents.Sender{ID: id.String(), Username: id.String()[:unknownSenderNameRunes]}
			continue
		}
		sender := megaphoneEvents.Sender{
			ID:       id.String(),
			Username: u.Username,
			FullName: u.FullName,
			Avatar:   u.Avatar,
			Gender:   u.Gender,
			VipUsed:  u.VipUsed,
		}
		if u.VipEndTime != nil {
			end := u.VipEndTime.UTC().Format(time.RFC3339)
			sender.VipEndTime = &end
		}
		out[id] = sender
	}
	return out
}

func toView(m *models.Megaphone, sender megaphoneEvents.Sender) megaphoneEvents.Megaphone {
	return megaphoneEvents.Megaphone{
		ID:             m.ID.String(),
		Type:           m.Type,
		Sender:         sender,
		Content:        m.Content,
		ShowAt:         m.ShowAt.UTC(),
		DisplaySeconds: m.DisplaySeconds,
		ExpiresAt:      m.ExpiresAt.UTC(),
		CreatedAt:      m.CreatedAt.UTC(),
	}
}

func (s *Service) ToView(m *models.Megaphone) megaphoneEvents.Megaphone {
	return s.toViews([]models.Megaphone{*m})[0]
}

func (s *Service) giftTransactions(items []models.Megaphone) map[uuid.UUID]models.GiftTransaction {
	ids := make([]uuid.UUID, 0, len(items))
	for i := range items {
		if items[i].GiftTransactionID != nil {
			ids = append(ids, *items[i].GiftTransactionID)
		}
	}
	txs, err := s.repo.GiftTransactions(ids)
	if err != nil {
		s.logger.Warnw("Failed to read gift transactions for megaphones", "error", err.Error())
	}
	return txs
}

func (s *Service) giftNamesEn(txs map[uuid.UUID]models.GiftTransaction) map[uuid.UUID]string {
	ids := make([]uuid.UUID, 0, len(txs))
	for _, tx := range txs {
		ids = append(ids, tx.GiftID)
	}
	names, err := s.repo.GiftNamesEn(ids)
	if err != nil {
		s.logger.Warnw("Failed to read gift names for megaphones", "error", err.Error())
	}
	return names
}

func (s *Service) toViews(items []models.Megaphone) []megaphoneEvents.Megaphone {
	txs := s.giftTransactions(items)
	namesEn := s.giftNamesEn(txs)
	seen := make(map[uuid.UUID]bool, len(items)+len(txs))
	ids := make([]uuid.UUID, 0, len(items)+len(txs))
	addID := func(id uuid.UUID) {
		if !seen[id] {
			seen[id] = true
			ids = append(ids, id)
		}
	}
	for i := range items {
		addID(items[i].SenderID)
	}
	for _, tx := range txs {
		addID(tx.ReceiverID)
	}
	people := s.senders(ids)
	out := make([]megaphoneEvents.Megaphone, 0, len(items))
	for i := range items {
		view := toView(&items[i], people[items[i].SenderID])
		if items[i].GiftTransactionID != nil {
			if tx, ok := txs[*items[i].GiftTransactionID]; ok {
				receiver := people[tx.ReceiverID]
				view.Receiver = &receiver
				view.Gift = &megaphoneEvents.GiftInfo{
					ID:       tx.GiftID.String(),
					Name:     tx.GiftName,
					NameEn:   namesEn[tx.GiftID],
					ImageURL: tx.GiftImageURL,
					Quantity: tx.Quantity,
				}
			}
		}
		out = append(out, view)
	}
	return out
}

func (s *Service) History(cursor string, limit int) (*HistoryResponse, error) {
	cursorAt, cursorID, err := utils.DecodeTimeCursor(cursor)
	if err != nil {
		return nil, utils.NewHTTPError(400, err.Error())
	}
	items, err := s.repo.History(time.Now().UTC(), cursorAt, cursorID, limit+1)
	if err != nil {
		return nil, err
	}
	resp := &HistoryResponse{}
	if len(items) > limit {
		items = items[:limit]
		last := items[len(items)-1]
		resp.NextCursor = utils.EncodeTimeCursor(last.ShowAt, last.ID)
	}
	resp.Items = s.toViews(items)
	return resp, nil
}
