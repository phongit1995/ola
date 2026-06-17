package session

import (
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func (r *Repository) FindActiveByDevice(userID uuid.UUID, deviceID string) (*models.UserSession, error) {
	var sess models.UserSession
	err := r.db.
		Where("user_id = ? AND device_id = ? AND revoked_at IS NULL", userID, deviceID).
		Order("last_active_at DESC").
		First(&sess).Error
	if err != nil {
		return nil, err
	}
	return &sess, nil
}

func (r *Repository) ListActiveByUser(userID uuid.UUID) ([]models.UserSession, error) {
	var sessions []models.UserSession
	err := r.db.
		Where("user_id = ? AND revoked_at IS NULL", userID).
		Order("last_active_at DESC").
		Find(&sessions).Error
	return sessions, err
}

func (r *Repository) RevokeForUser(userID, sessionID uuid.UUID) (bool, error) {
	res := r.db.Model(&models.UserSession{}).
		Where("id = ? AND user_id = ? AND revoked_at IS NULL", sessionID, userID).
		Update("revoked_at", gorm.Expr("NOW()"))
	if res.Error != nil {
		return false, res.Error
	}
	return res.RowsAffected == 1, nil
}

func (r *Repository) ListActiveIDsExcept(userID, keepID uuid.UUID) ([]uuid.UUID, error) {
	var ids []uuid.UUID
	err := r.db.Model(&models.UserSession{}).
		Where("user_id = ? AND id <> ? AND revoked_at IS NULL", userID, keepID).
		Pluck("id", &ids).Error
	return ids, err
}

func (r *Repository) RevokeAllExcept(userID, keepID uuid.UUID) (int64, error) {
	res := r.db.Model(&models.UserSession{}).
		Where("user_id = ? AND id <> ? AND revoked_at IS NULL", userID, keepID).
		Update("revoked_at", gorm.Expr("NOW()"))
	return res.RowsAffected, res.Error
}

func (r *Repository) RotateRefreshToken(sessionID uuid.UUID, oldToken, newToken string) (bool, error) {
	res := r.db.Model(&models.UserSession{}).
		Where("id = ? AND refresh_token = ? AND revoked_at IS NULL", sessionID, oldToken).
		Updates(map[string]interface{}{
			"refresh_token":  newToken,
			"last_active_at": gorm.Expr("NOW()"),
		})
	if res.Error != nil {
		return false, res.Error
	}
	return res.RowsAffected == 1, nil
}

func (r *Repository) Revoke(sessionID uuid.UUID) error {
	return r.db.Model(&models.UserSession{}).
		Where("id = ? AND revoked_at IS NULL", sessionID).
		Update("revoked_at", gorm.Expr("NOW()")).Error
}

func (r *Repository) Upsert(sess *models.UserSession) error {
	res := r.db.Model(&models.UserSession{}).
		Where("id = ?", sess.ID).
		Updates(map[string]interface{}{
			"user_id":        sess.UserID,
			"refresh_token":  sess.RefreshToken,
			"device_name":    sess.DeviceName,
			"platform":       sess.Platform,
			"device_id":      sess.DeviceID,
			"app_version":    sess.AppVersion,
			"user_agent":     sess.UserAgent,
			"ip_address":     sess.IPAddress,
			"last_active_at": gorm.Expr("NOW()"),
			"revoked_at":     nil,
		})
	if res.Error != nil {
		return res.Error
	}
	if res.RowsAffected == 0 {
		return r.db.Create(sess).Error
	}
	return nil
}
