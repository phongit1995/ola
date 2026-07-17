package notification

import (
	"context"
	"encoding/base64"
	"encoding/json"
	"errors"
	"strings"
	"time"

	appNotificationEvents "ola-chat-server/internal/domain/app-notification"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/transport/kafka"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Service struct {
	repo          *Repository
	kafkaProducer *kafka.Producer
	logger        *zap.SugaredLogger
}

func NewService(repo *Repository, kafkaProducer *kafka.Producer, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:          repo,
		kafkaProducer: kafkaProducer,
		logger:        logger.Named("[notification_service]"),
	}
}

func (s *Service) Create(recipientID uuid.UUID, actorID *uuid.UUID, ntype string, refID *uuid.UUID, preview string) {
	if actorID != nil && recipientID == *actorID {
		return
	}
	utils.SafeGo(s.logger, func() {
		n := &models.AppNotification{
			RecipientID: recipientID,
			ActorID:     actorID,
			Type:        ntype,
			RefID:       refID,
			Preview:     preview,
		}
		created, err := s.repo.Create(n)
		if err != nil {
			s.logger.Warnw("Failed to create app notification", "recipient_id", recipientID, "type", ntype, "error", err.Error())
			return
		}
		s.publishCreated(recipientID, created)
	})
}

func (s *Service) Remove(recipientID uuid.UUID, ntype string, refID uuid.UUID) {
	utils.SafeGo(s.logger, func() {
		removed, err := s.repo.Delete(recipientID, ntype, refID)
		if err != nil {
			s.logger.Warnw("Failed to remove app notification", "recipient_id", recipientID, "type", ntype, "error", err.Error())
			return
		}
		if removed == nil {
			return
		}
		s.publishRemoved(recipientID, removed.ID)
	})
}

func (s *Service) publishCreated(recipientID uuid.UUID, notif *models.AppNotification) {
	if s.kafkaProducer == nil {
		return
	}
	unread, err := s.repo.CountUnread(recipientID)
	if err != nil {
		s.logger.Warnw("Failed to count unread app notifications", "recipient_id", recipientID, "error", err.Error())
		return
	}
	notifBytes, err := json.Marshal(toAppNotificationResponse(notif))
	if err != nil {
		s.logger.Warnw("Failed to marshal app notification", "recipient_id", recipientID, "error", err.Error())
		return
	}
	event := &appNotificationEvents.Event{
		RecipientID:  recipientID.String(),
		Notification: notifBytes,
		UnreadCount:  unread,
	}
	utils.PublishAsync(s.logger, "app notification", func(ctx context.Context) error {
		return s.kafkaProducer.PublishAppNotification(ctx, event)
	})
}

func (s *Service) publishRemoved(recipientID, notificationID uuid.UUID) {
	if s.kafkaProducer == nil {
		return
	}
	unread, err := s.repo.CountUnread(recipientID)
	if err != nil {
		s.logger.Warnw("Failed to count unread app notifications", "recipient_id", recipientID, "error", err.Error())
		return
	}
	event := &appNotificationEvents.Event{
		RecipientID: recipientID.String(),
		RemovedID:   notificationID.String(),
		UnreadCount: unread,
	}
	utils.PublishAsync(s.logger, "app notification removal", func(ctx context.Context) error {
		return s.kafkaProducer.PublishAppNotification(ctx, event)
	})
}

func (s *Service) List(recipientID uuid.UUID, cursor string, limit int) (*AppNotificationListResponse, error) {
	cursorTime, cursorID, err := decodeCursor(cursor)
	if err != nil {
		return nil, err
	}

	items, hasMore, err := s.repo.ListPage(recipientID, cursorTime, cursorID, limit)
	if err != nil {
		return nil, err
	}
	unread, err := s.repo.CountUnread(recipientID)
	if err != nil {
		return nil, err
	}

	out := make([]AppNotificationResponse, 0, len(items))
	for _, it := range items {
		out = append(out, toAppNotificationResponse(it))
	}

	var nextCursor string
	if hasMore && len(items) > 0 {
		last := items[len(items)-1]
		nextCursor = encodeCursor(last.CreatedAt, last.ID)
	}

	return &AppNotificationListResponse{
		Items:       out,
		UnreadCount: unread,
		NextCursor:  nextCursor,
	}, nil
}

func (s *Service) UnreadCount(recipientID uuid.UUID) (int64, error) {
	return s.repo.CountUnread(recipientID)
}

func (s *Service) MarkAllRead(recipientID uuid.UUID) error {
	return s.repo.MarkAllRead(recipientID)
}

func toAppNotificationResponse(n *models.AppNotification) AppNotificationResponse {
	resp := AppNotificationResponse{
		ID:        n.ID.String(),
		Type:      n.Type,
		Preview:   n.Preview,
		IsRead:    n.IsRead,
		CreatedAt: n.CreatedAt.UTC().Format(time.RFC3339),
	}
	if n.RefID != nil {
		resp.RefID = n.RefID.String()
	}
	if n.Actor != nil {
		resp.Actor = &ActorResponse{
			ID:       n.Actor.ID.String(),
			Username: n.Actor.Username,
			FullName: n.Actor.FullName,
			Avatar:   n.Actor.Avatar,
		}
	}
	return resp
}

func Excerpt(s string) string {
	s = strings.TrimSpace(s)
	runes := []rune(s)
	if len(runes) <= 120 {
		return s
	}
	return string(runes[:120]) + "…"
}

func encodeCursor(t time.Time, id uuid.UUID) string {
	raw := t.UTC().Format(time.RFC3339Nano) + "|" + id.String()
	return base64.RawURLEncoding.EncodeToString([]byte(raw))
}

func decodeCursor(cursor string) (*time.Time, *uuid.UUID, error) {
	if cursor == "" {
		return nil, nil, nil
	}
	data, err := base64.RawURLEncoding.DecodeString(cursor)
	if err != nil {
		return nil, nil, errors.New("invalid cursor")
	}
	parts := strings.SplitN(string(data), "|", 2)
	if len(parts) != 2 {
		return nil, nil, errors.New("invalid cursor")
	}
	t, err := time.Parse(time.RFC3339Nano, parts[0])
	if err != nil {
		return nil, nil, errors.New("invalid cursor")
	}
	id, err := uuid.Parse(parts[1])
	if err != nil {
		return nil, nil, errors.New("invalid cursor")
	}
	return &t, &id, nil
}
