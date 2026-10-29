package adminpushcampaign

import (
	"errors"

	pushBroadcastEvents "ola-chat-server/internal/domain/push-broadcast"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/push"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func (r *Repository) PushEnabled() (bool, error) {
	var item models.AppSetting
	if err := r.db.Where("key = ?", setting.KeyPushNotification).First(&item).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return false, nil
		}
		return false, err
	}
	enabled, _ := item.Value["enabled"].(bool)
	return enabled, nil
}

func (r *Repository) FindUserByUsername(username string) (*models.User, error) {
	var user models.User
	err := r.db.Select("id", "username", "full_name", "avatar").
		Where("LOWER(username) = LOWER(?)", username).
		First(&user).Error
	if err != nil {
		return nil, err
	}
	return &user, nil
}

func (r *Repository) CountAudience(audience string, targetUserID *uuid.UUID) (users int64, devices int64, err error) {
	if err = push.BroadcastTokens(r.db, audience, targetUserID).Count(&devices).Error; err != nil {
		return 0, 0, err
	}
	if err = push.BroadcastTokens(r.db, audience, targetUserID).Distinct("device_tokens.user_id").Count(&users).Error; err != nil {
		return 0, 0, err
	}
	return users, devices, nil
}

func (r *Repository) Create(campaign *models.PushCampaign) error {
	return r.db.Create(campaign).Error
}

func (r *Repository) MarkFailed(id uuid.UUID, reason string) error {
	return r.db.Model(&models.PushCampaign{}).Where("id = ?", id).Updates(map[string]interface{}{
		"status": pushBroadcastEvents.PushCampaignStatusFailed,
		"error":  reason,
	}).Error
}

func (r *Repository) FindByID(id uuid.UUID) (*models.PushCampaign, error) {
	var campaign models.PushCampaign
	if err := r.db.Preload("Creator").Preload("TargetUser").First(&campaign, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &campaign, nil
}

func (r *Repository) List(limit, offset int) ([]*models.PushCampaign, int64, error) {
	db := r.db.Model(&models.PushCampaign{})
	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}
	var campaigns []*models.PushCampaign
	err := db.Preload("Creator").Preload("TargetUser").
		Order("created_at DESC").Limit(limit).Offset(offset).
		Find(&campaigns).Error
	return campaigns, total, err
}
