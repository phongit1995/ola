package push

import (
	"context"
	"encoding/json"
	"errors"
	"sync"
	"time"

	firebase "firebase.google.com/go/v4"
	"firebase.google.com/go/v4/messaging"
	"go.uber.org/zap"
	"google.golang.org/api/option"
	"gorm.io/gorm"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
)

const (
	fcmRetryCooldown   = time.Minute
	fcmRecheckInterval = time.Minute
)

type FCMClient struct {
	cfg    *config.Config
	db     *gorm.DB
	logger *zap.SugaredLogger

	mu               sync.Mutex
	messaging        *messaging.Client
	nextRetryAt      time.Time
	nextRecheckAt    time.Time
	settingUpdatedAt time.Time
	loggedDisabled   bool
}

func NewFCMClient(cfg *config.Config, db *gorm.DB, logger *zap.SugaredLogger) *FCMClient {
	return &FCMClient{
		cfg:    cfg,
		db:     db,
		logger: logger.Named("[fcm_client]"),
	}
}

func (c *FCMClient) Enabled() bool {
	return c != nil && c.client() != nil
}

func (c *FCMClient) SendEach(ctx context.Context, msgs []*messaging.Message) (*messaging.BatchResponse, error) {
	client := c.client()
	if client == nil {
		return nil, errors.New("fcm client is not configured")
	}
	return client.SendEach(ctx, msgs)
}

func (c *FCMClient) client() *messaging.Client {
	c.mu.Lock()
	defer c.mu.Unlock()
	if c.messaging != nil {
		if time.Now().After(c.nextRecheckAt) {
			c.nextRecheckAt = time.Now().Add(fcmRecheckInterval)
			if updatedAt, ok := c.settingUpdatedAtNow(); ok && updatedAt.After(c.settingUpdatedAt) {
				if next, nextUpdatedAt, ok := c.buildClient(); ok {
					c.messaging = next
					c.settingUpdatedAt = nextUpdatedAt
					c.logger.Infow("Push client reloaded with new Firebase credentials")
				} else {
					c.logger.Errorw("New Firebase credentials are invalid, keeping the previous push client")
				}
			}
		}
		return c.messaging
	}

	if time.Now().Before(c.nextRetryAt) {
		return nil
	}
	c.nextRetryAt = time.Now().Add(fcmRetryCooldown)

	next, updatedAt, ok := c.buildClient()
	if !ok {
		return nil
	}
	c.messaging = next
	c.settingUpdatedAt = updatedAt
	c.nextRecheckAt = time.Now().Add(fcmRecheckInterval)
	c.loggedDisabled = false
	c.logger.Infow("Push enabled")
	return c.messaging
}

func (c *FCMClient) buildClient() (*messaging.Client, time.Time, bool) {
	creds, updatedAt := c.loadCredentials()
	if creds == nil {
		if !c.loggedDisabled {
			c.loggedDisabled = true
			c.logger.Infow("Push disabled: no Firebase service account uploaded in admin settings; will keep checking")
		}
		return nil, time.Time{}, false
	}

	ctx := context.Background()
	app, err := firebase.NewApp(ctx, nil, option.WithCredentialsJSON(creds))
	if err != nil {
		c.logger.Errorw("Failed to init firebase app from stored credentials", "error", err.Error())
		return nil, time.Time{}, false
	}
	client, err := app.Messaging(ctx)
	if err != nil {
		c.logger.Errorw("Failed to init messaging client from stored credentials", "error", err.Error())
		return nil, time.Time{}, false
	}
	return client, updatedAt, true
}

func (c *FCMClient) settingUpdatedAtNow() (time.Time, bool) {
	if c.db == nil {
		return time.Time{}, false
	}
	var item models.AppSetting
	if err := c.db.Select("updated_at").Where("key = ?", setting.KeyPushFirebase).First(&item).Error; err != nil {
		return time.Time{}, false
	}
	return item.UpdatedAt, true
}

func (c *FCMClient) loadCredentials() ([]byte, time.Time) {
	if c.db == nil {
		return nil, time.Time{}
	}
	var item models.AppSetting
	if err := c.db.Where("key = ?", setting.KeyPushFirebase).First(&item).Error; err != nil {
		if !errors.Is(err, gorm.ErrRecordNotFound) {
			c.logger.Warnw("Failed to load push_firebase app setting", "error", err.Error())
		}
		return nil, time.Time{}
	}
	raw, err := json.Marshal(item.Value)
	if err != nil {
		return nil, time.Time{}
	}
	var stored setting.PushFirebaseStored
	if err := json.Unmarshal(raw, &stored); err != nil || stored.Enc == "" {
		c.logger.Warnw("push_firebase app setting has no encrypted credential")
		return nil, time.Time{}
	}
	creds, err := setting.DecryptPushCredential(c.cfg, stored.Enc)
	if err != nil {
		c.logger.Errorw("Failed to decrypt push_firebase credential (encryption secret mismatch between api and chat?)", "error", err.Error())
		return nil, time.Time{}
	}
	return creds, item.UpdatedAt
}
