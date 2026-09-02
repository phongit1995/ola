package push

import (
	"context"
	"fmt"
	"sync"
	"time"

	"firebase.google.com/go/v4/messaging"
	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"
)

var isUnregistered = messaging.IsUnregistered

type ConnectionCounter interface {
	GetConnectionCount(userID string) int
}

type fcmSender interface {
	Enabled() bool
	SendEach(ctx context.Context, msgs []*messaging.Message) (*messaging.BatchResponse, error)
}

type cacheStore interface {
	Exists(key string) (bool, error)
	SetNX(key string, value interface{}, expiration time.Duration) (bool, error)
	DeleteIfValue(key string, value interface{}) (bool, error)
	Get(key string, dest interface{}) error
}

type tokenStore interface {
	ActiveTokens(userID string) ([]models.DeviceToken, error)
	DeleteToken(token string) error
	NotifMessageEnabled(userID string) bool
	PushEnabled() bool
}

const pushEnabledCacheTTL = time.Minute

type Sender struct {
	fcm    fcmSender
	cache  cacheStore
	conns  ConnectionCounter
	store  tokenStore
	logger *zap.SugaredLogger
	jobs   chan func()

	enabledMu        sync.Mutex
	enabledVal       bool
	enabledCheckedAt time.Time

	workers   sync.WaitGroup
	closeMu   sync.RWMutex
	closed    bool
	closeOnce sync.Once
}

func NewSender(fcm *FCMClient, cache *services.CacheService, presence *websocket.PresenceService, db *gorm.DB, logger *zap.SugaredLogger) *Sender {
	log := logger.Named("[push_sender]")
	s := &Sender{
		fcm:    fcm,
		cache:  cache,
		conns:  presence,
		store:  newGormStore(db, log),
		logger: log,
		jobs:   make(chan func(), constants.PushDispatchQueueSize),
	}
	for i := 0; i < constants.PushDispatchWorkers; i++ {
		s.workers.Add(1)
		utils.SafeGo(log, s.worker)
	}
	return s
}

func (s *Sender) worker() {
	defer s.workers.Done()
	for job := range s.jobs {
		s.runJob(job)
	}
}

func (s *Sender) Close(timeout time.Duration) {
	s.closeOnce.Do(func() {
		s.closeMu.Lock()
		s.closed = true
		close(s.jobs)
		s.closeMu.Unlock()
	})
	done := make(chan struct{})
	go func() {
		s.workers.Wait()
		close(done)
	}()
	select {
	case <-done:
	case <-time.After(timeout):
		s.logger.Warnw("Push sender drain timed out, some queued pushes were dropped")
	}
}

func (s *Sender) runJob(job func()) {
	defer func() {
		if r := recover(); r != nil {
			s.logger.Errorw("Push job panicked", "panic", r)
		}
	}()
	job()
}

func (s *Sender) pushEnabled() bool {
	s.enabledMu.Lock()
	defer s.enabledMu.Unlock()
	if time.Since(s.enabledCheckedAt) > pushEnabledCacheTTL {
		s.enabledVal = s.store.PushEnabled()
		s.enabledCheckedAt = time.Now()
	}
	return s.enabledVal
}

func (s *Sender) enqueue(job func()) {
	if !s.pushEnabled() || s.fcm == nil || !s.fcm.Enabled() {
		return
	}
	s.closeMu.RLock()
	defer s.closeMu.RUnlock()
	if s.closed {
		return
	}
	select {
	case s.jobs <- job:
	default:
		s.logger.Warnw("Push dispatch queue full, dropping job")
	}
}

func (s *Sender) SendDM(recipients []string, in DMPush) {
	if in.ConversationType != constants.ConversationTypeDirect || in.ConversationID == "" {
		return
	}
	content := buildDMContent(in)
	source := "dm:" + in.ConversationID
	for _, uid := range recipients {
		if uid == in.SenderID || uid == "" {
			continue
		}
		recipientID := uid
		s.enqueue(func() {
			s.process(recipientID, source, in.MessageID, true, content)
		})
	}
}

func (s *Sender) SendMeNotification(recipientID string, notification map[string]interface{}) {
	if recipientID == "" || notification == nil {
		return
	}
	id, ntype, actorName, preview := parseNotifFields(notification)
	content := buildMeNotifContent(actorName, ntype, preview)
	s.enqueue(func() {
		s.process(recipientID, constants.PushSourceMeNotif, id, false, content)
	})
}

func (s *Sender) SendAppNotification(recipientID string, notification map[string]interface{}) {
	if recipientID == "" || notification == nil {
		return
	}
	id, ntype, actorName, preview := parseNotifFields(notification)
	content := buildAppNotifContent(actorName, ntype, preview)
	s.enqueue(func() {
		s.process(recipientID, constants.PushSourceAppNotif, id, false, content)
	})
}

func parseNotifFields(notification map[string]interface{}) (id, ntype, actorName, preview string) {
	id, _ = notification["id"].(string)
	ntype, _ = notification["type"].(string)
	preview, _ = notification["preview"].(string)
	if actor, ok := notification["actor"].(map[string]interface{}); ok {
		fullName, _ := actor["fullName"].(string)
		username, _ := actor["username"].(string)
		actorName = firstNonEmpty(fullName, username)
	}
	return id, ntype, actorName, preview
}

func (s *Sender) process(recipientID, source, eventID string, dmGate bool, content Content) {
	if s.conns.GetConnectionCount(recipientID) > 0 && !s.isBackground(recipientID) {
		return
	}
	if dmGate && !s.notifMessageEnabled(recipientID) {
		return
	}

	tokens, err := s.store.ActiveTokens(recipientID)
	if err != nil {
		s.logger.Warnw("Failed to load push tokens", "recipient_id", recipientID, "error", err.Error())
		return
	}
	if len(tokens) == 0 {
		return
	}

	owner := uuid.NewString()
	var eventKey string
	if eventID != "" {
		eventKey = fmt.Sprintf(constants.CacheKeyPushEvent, recipientID, eventID)
		if ok, err := s.cache.SetNX(eventKey, owner, time.Duration(constants.PushEventTTLSeconds)*time.Second); err == nil && !ok {
			return
		} else if err != nil {
			eventKey = ""
		}
	}

	throttleKey := fmt.Sprintf(constants.CacheKeyPushThrottle, recipientID, source)
	acquired, err := s.cache.SetNX(throttleKey, owner, time.Duration(constants.PushThrottleTTLSeconds)*time.Second)
	if err == nil && !acquired {
		s.rollbackKey(eventKey, owner)
		return
	}
	if err != nil {
		throttleKey = ""
	}

	if !s.store.PushEnabled() {
		s.rollbackKey(eventKey, owner)
		s.rollbackKey(throttleKey, owner)
		return
	}

	data := map[string]string{
		"notifId": content.NotifID,
		"channel": content.Channel,
		"title":   content.Title,
		"body":    content.Body,
	}
	for k, v := range content.Data {
		data[k] = v
	}

	ttl := constants.PushTTLHours * time.Hour
	msgs := make([]*messaging.Message, 0, len(tokens))
	for _, t := range tokens {
		msgs = append(msgs, &messaging.Message{
			Token: t.Token,
			Data:  data,
			Android: &messaging.AndroidConfig{
				Priority:    "high",
				CollapseKey: content.Collapse,
				TTL:         &ttl,
			},
		})
	}

	successCount, failureCount, sendErr := s.sendInChunks(recipientID, source, tokens, msgs)
	if sendErr != nil || successCount == 0 {
		s.rollbackKey(eventKey, owner)
		s.rollbackKey(throttleKey, owner)
	}
	if sendErr != nil {
		s.logger.Warnw("Push send failed", "recipient_id", recipientID, "source", source, "error", sendErr.Error())
		return
	}
	if successCount > 0 {
		s.logger.Infow("Push sent", "recipient_id", recipientID, "source", source, "success", successCount, "failure", failureCount)
	}
}

func (s *Sender) sendInChunks(recipientID, source string, tokens []models.DeviceToken, msgs []*messaging.Message) (successCount, failureCount int, firstErr error) {
	for start := 0; start < len(msgs); start += constants.PushSendBatchSize {
		end := start + constants.PushSendBatchSize
		if end > len(msgs) {
			end = len(msgs)
		}

		ctx, cancel := context.WithTimeout(context.Background(), time.Duration(constants.PushSendTimeoutSeconds)*time.Second)
		resp, err := s.fcm.SendEach(ctx, msgs[start:end])
		cancel()
		if err != nil {
			if firstErr == nil {
				firstErr = err
			}
			failureCount += end - start
			continue
		}

		successCount += resp.SuccessCount
		failureCount += resp.FailureCount
		for i, r := range resp.Responses {
			if r.Error == nil {
				continue
			}
			if isUnregistered(r.Error) {
				if delErr := s.store.DeleteToken(tokens[start+i].Token); delErr != nil {
					s.logger.Warnw("Failed to delete unregistered token", "recipient_id", recipientID, "error", delErr.Error())
				}
				continue
			}
			s.logger.Warnw("Push delivery failed for token", "recipient_id", recipientID, "source", source, "error", r.Error.Error())
		}
	}
	if successCount > 0 {
		firstErr = nil
	}
	return successCount, failureCount, firstErr
}

func (s *Sender) rollbackKey(key, owner string) {
	if key == "" {
		return
	}
	if _, err := s.cache.DeleteIfValue(key, owner); err != nil {
		s.logger.Warnw("Failed to rollback push key", "key", key, "error", err.Error())
	}
}

func (s *Sender) isBackground(userID string) bool {
	key := fmt.Sprintf(constants.CacheKeyPresenceBackground, userID)
	exists, err := s.cache.Exists(key)
	if err != nil {
		s.logger.Warnw("Failed to check background state", "user_id", userID, "error", err.Error())
		return false
	}
	return exists
}

func (s *Sender) notifMessageEnabled(userID string) bool {
	var cached struct {
		NotifMessage *bool `json:"notifMessage"`
	}
	key := fmt.Sprintf(constants.CacheKeyUserSettings, userID)
	if err := s.cache.Get(key, &cached); err == nil && cached.NotifMessage != nil {
		return *cached.NotifMessage
	}
	return s.store.NotifMessageEnabled(userID)
}
