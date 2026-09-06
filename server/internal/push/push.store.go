package push

import (
	"errors"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type gormStore struct {
	db     *gorm.DB
	logger *zap.SugaredLogger
}

func newGormStore(db *gorm.DB, logger *zap.SugaredLogger) *gormStore {
	return &gormStore{db: db, logger: logger}
}

func (s *gormStore) ActiveTokens(userID string) ([]models.DeviceToken, error) {
	var tokens []models.DeviceToken
	err := s.db.
		Joins("JOIN user_sessions ON user_sessions.id = device_tokens.session_id").
		Where("device_tokens.user_id = ? AND device_tokens.platform = ? AND user_sessions.revoked_at IS NULL", userID, "android").
		Find(&tokens).Error
	return tokens, err
}

func (s *gormStore) DeleteToken(token string) error {
	return s.db.Where("token = ?", token).Delete(&models.DeviceToken{}).Error
}

func (s *gormStore) PushEnabled() bool {
	var item models.AppSetting
	if err := s.db.Where("key = ?", setting.KeyPushNotification).First(&item).Error; err != nil {
		if !errors.Is(err, gorm.ErrRecordNotFound) {
			s.logger.Warnw("Failed to load push_notification app setting", "error", err.Error())
		}
		return false
	}
	enabled, _ := item.Value["enabled"].(bool)
	return enabled
}

func (s *gormStore) NotifMessageEnabled(userID string) bool {
	uid, err := uuid.Parse(userID)
	if err != nil {
		return true
	}
	var setting models.UserSetting
	if err := s.db.Where("user_id = ?", uid).First(&setting).Error; err != nil {
		if !errors.Is(err, gorm.ErrRecordNotFound) {
			s.logger.Warnw("Failed to load user setting for push gate", "user_id", userID, "error", err.Error())
		}
		return true
	}
	return setting.NotifMessage
}
