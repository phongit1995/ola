package giftcode

import (
	"errors"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func (r *Repository) Transaction(fn func(tx *gorm.DB) error) error {
	return r.db.Transaction(fn)
}

func (r *Repository) SessionDevice(sessionID uuid.UUID) (string, string, error) {
	if sessionID == uuid.Nil {
		return "", "", nil
	}
	var s models.UserSession
	err := r.db.Select("device_id", "device_name").First(&s, "id = ?", sessionID).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return "", "", nil
	}
	if err != nil {
		return "", "", err
	}
	return s.DeviceID, s.DeviceName, nil
}

func (r *Repository) HasActiveCampaign(platform string, now time.Time) (bool, error) {
	column := "allow_web"
	switch platform {
	case setting.PlatformAndroid:
		column = "allow_android"
	case setting.PlatformIOS:
		column = "allow_ios"
	}
	var count int64
	err := r.db.Model(&models.GiftCodeCampaign{}).
		Where("enabled = ?", true).
		Where(column+" = ?", true).
		Where("(starts_at IS NULL OR starts_at <= ?)", now).
		Where("ends_at > ?", now).
		Where("used_count < total_uses").
		Limit(1).
		Count(&count).Error
	return count > 0, err
}

func (r *Repository) RecordAttempt(a *models.GiftCodeAttempt) error {
	return r.db.Create(a).Error
}

func (r *Repository) DeleteAttemptsBefore(cutoff time.Time, batch int) (int64, error) {
	res := r.db.Exec(`DELETE FROM gift_code_attempts WHERE id IN (
		SELECT id FROM gift_code_attempts WHERE created_at < ? LIMIT ?
	)`, cutoff, batch)
	return res.RowsAffected, res.Error
}

func findCode(tx *gorm.DB, code string) (*models.GiftCode, error) {
	var gc models.GiftCode
	if err := tx.Select("id", "campaign_id").First(&gc, "code = ?", code).Error; err != nil {
		return nil, err
	}
	return &gc, nil
}

func lockCode(tx *gorm.DB, id, campaignID uuid.UUID) (*models.GiftCode, error) {
	var gc models.GiftCode
	if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&gc, "id = ? AND campaign_id = ?", id, campaignID).Error; err != nil {
		return nil, err
	}
	return &gc, nil
}

func lockCampaign(tx *gorm.DB, id uuid.UUID) (*models.GiftCodeCampaign, error) {
	var c models.GiftCodeCampaign
	if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&c, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &c, nil
}

func loadAccount(tx *gorm.DB, userID uuid.UUID) (*models.User, error) {
	var u models.User
	if err := tx.Select("id", "created_at", "email_verified").First(&u, "id = ?", userID).Error; err != nil {
		return nil, err
	}
	return &u, nil
}

func hasRedeemed(tx *gorm.DB, campaignID, userID uuid.UUID) (bool, error) {
	var count int64
	err := tx.Model(&models.GiftCodeRedemption{}).
		Where("campaign_id = ? AND user_id = ?", campaignID, userID).
		Limit(1).
		Count(&count).Error
	return count > 0, err
}

func deviceRedeemed(tx *gorm.DB, campaignID uuid.UUID, deviceID string) (bool, error) {
	var count int64
	err := tx.Model(&models.GiftCodeRedemption{}).
		Where("campaign_id = ? AND device_id = ?", campaignID, deviceID).
		Limit(1).
		Count(&count).Error
	return count > 0, err
}

func markRedeemed(tx *gorm.DB, campaign *models.GiftCodeCampaign, code *models.GiftCode, userID uuid.UUID, now time.Time) error {
	if err := tx.Model(&models.GiftCodeCampaign{}).
		Where("id = ?", campaign.ID).
		UpdateColumn("used_count", gorm.Expr("used_count + 1")).Error; err != nil {
		return err
	}
	if campaign.Kind != models.GiftCodeKindUnique {
		return nil
	}
	return tx.Model(&models.GiftCode{}).
		Where("id = ?", code.ID).
		Updates(map[string]interface{}{"used_by": userID, "used_at": now}).Error
}
