package megaphone

import (
	"context"
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
	settings  *setting.Service
	filter    *contentfilter.Service
	userCache *user.CacheService
	producer  *kafka.Producer
	wsServer  *websocket.Server
	logger    *zap.SugaredLogger
}

func NewService(
	repo *Repository,
	settings *setting.Service,
	filter *contentfilter.Service,
	userCache *user.CacheService,
	producer *kafka.Producer,
	wsServer *websocket.Server,
	logger *zap.SugaredLogger,
) *Service {
	return &Service{
		repo:      repo,
		settings:  settings,
		filter:    filter,
		userCache: userCache,
		producer:  producer,
		wsServer:  wsServer,
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
	end, err := s.repo.QueueEnd(now)
	if err != nil {
		return nil, err
	}
	return &ConfigResponse{
		Enabled:           cfg.Enabled,
		KenPrice:          cfg.KenPrice,
		MaxLength:         cfg.MaxLength,
		DisplaySeconds:    cfg.DisplaySeconds,
		CooldownSeconds:   cfg.CooldownSeconds,
		DailyLimit:        cfg.DailyLimit,
		TodayCount:        int(today),
		CooldownRemaining: ceilSeconds(cooldownLeft),
		QueueWaitSeconds:  ceilSeconds(end.Sub(now)),
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
		DisplaySeconds:  cfg.DisplaySeconds,
		MaxQueue:        time.Duration(cfg.MaxQueueSeconds) * time.Second,
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
	wait := existing.ShowAt.Sub(time.Now().UTC())
	return &SendResponse{Megaphone: s.ToView(existing), KenBalance: balance, WaitSeconds: ceilSeconds(wait)}, nil
}

func (s *Service) afterSend(senderID uuid.UUID, balance int, view megaphoneEvents.Megaphone) {
	s.wsServer.EmitKenUpdate(senderID, balance)
	if err := s.userCache.InvalidateUser(senderID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after megaphone", "user_id", senderID, "error", err.Error())
	}
	ctx, cancel := context.WithTimeout(context.Background(), publishTimeout)
	defer cancel()
	if err := s.producer.PublishMegaphoneCreated(ctx, &megaphoneEvents.CreatedEvent{Megaphone: view}); err != nil {
		s.logger.Errorw("Failed to publish megaphone created", "megaphone_id", view.ID, "error", err.Error())
	}
}

func (s *Service) PublishRemoved(id uuid.UUID) {
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
		Sender:         sender,
		Content:        m.Content,
		ShowAt:         m.ShowAt.UTC(),
		DisplaySeconds: m.DisplaySeconds,
		CreatedAt:      m.CreatedAt.UTC(),
	}
}

func (s *Service) ToView(m *models.Megaphone) megaphoneEvents.Megaphone {
	return toView(m, s.senders([]uuid.UUID{m.SenderID})[m.SenderID])
}

func (s *Service) toViews(items []models.Megaphone) []megaphoneEvents.Megaphone {
	seen := make(map[uuid.UUID]bool, len(items))
	ids := make([]uuid.UUID, 0, len(items))
	for i := range items {
		if !seen[items[i].SenderID] {
			seen[items[i].SenderID] = true
			ids = append(ids, items[i].SenderID)
		}
	}
	senders := s.senders(ids)
	out := make([]megaphoneEvents.Megaphone, 0, len(items))
	for i := range items {
		out = append(out, toView(&items[i], senders[items[i].SenderID]))
	}
	return out
}

func (s *Service) Active() (*ActiveResponse, error) {
	now := time.Now().UTC()
	items, err := s.repo.ListActive(now, ActiveLimit)
	if err != nil {
		return nil, err
	}
	return &ActiveResponse{Items: s.toViews(items), ServerTime: now.Format(time.RFC3339Nano)}, nil
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
