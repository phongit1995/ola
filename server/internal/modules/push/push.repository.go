package push

import (
	"ola-chat-server/internal/models"

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

func (r *Repository) FindActiveSession(userID, sessionID uuid.UUID) (*models.UserSession, error) {
	var sess models.UserSession
	err := r.db.
		Where("id = ? AND user_id = ? AND revoked_at IS NULL", sessionID, userID).
		First(&sess).Error
	if err != nil {
		return nil, err
	}
	return &sess, nil
}

func (r *Repository) RegisterToken(dt *models.DeviceToken) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		if err := tx.
			Where("token = ? AND NOT (user_id = ? AND device_id = ?)", dt.Token, dt.UserID, dt.DeviceID).
			Delete(&models.DeviceToken{}).Error; err != nil {
			return err
		}
		return tx.Clauses(clause.OnConflict{
			Columns: []clause.Column{{Name: "user_id"}, {Name: "device_id"}},
			DoUpdates: clause.Assignments(map[string]interface{}{
				"token":      dt.Token,
				"session_id": dt.SessionID,
				"platform":   dt.Platform,
				"updated_at": gorm.Expr("NOW()"),
			}),
		}).Create(dt).Error
	})
}
