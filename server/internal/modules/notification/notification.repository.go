package notification

import (
	"errors"
	"time"

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

func dedupScope(db *gorm.DB, n *models.AppNotification) *gorm.DB {
	return db.Where("recipient_id = ? AND type = ? AND ref_id = ?", n.RecipientID, n.Type, *n.RefID)
}

func (r *Repository) Create(n *models.AppNotification) (*models.AppNotification, error) {
	if n.RefID != nil {
		res := dedupScope(r.db.Model(&models.AppNotification{}), n).
			Updates(map[string]interface{}{
				"is_read":    false,
				"preview":    n.Preview,
				"created_at": time.Now(),
				"updated_at": time.Now(),
			})
		if res.Error != nil {
			return nil, res.Error
		}
		if res.RowsAffected == 0 {
			if err := r.db.Create(n).Error; err != nil {
				return nil, err
			}
		}
		var row models.AppNotification
		if err := dedupScope(r.db.Preload("Actor"), n).First(&row).Error; err != nil {
			return nil, err
		}
		return &row, nil
	}

	if err := r.db.Create(n).Error; err != nil {
		return nil, err
	}
	var row models.AppNotification
	if err := r.db.Preload("Actor").First(&row, "id = ?", n.ID).Error; err != nil {
		return nil, err
	}
	return &row, nil
}

func (r *Repository) Delete(recipientID uuid.UUID, ntype string, refID uuid.UUID) (*models.AppNotification, error) {
	var row models.AppNotification
	err := r.db.Where("recipient_id = ? AND type = ? AND ref_id = ?", recipientID, ntype, refID).First(&row).Error
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, nil
		}
		return nil, err
	}
	if err := r.db.Unscoped().Delete(&models.AppNotification{}, "id = ?", row.ID).Error; err != nil {
		return nil, err
	}
	return &row, nil
}

func (r *Repository) ListPage(recipientID uuid.UUID, cursorTime *time.Time, cursorID *uuid.UUID, limit int) ([]*models.AppNotification, bool, error) {
	db := r.db.Model(&models.AppNotification{}).Where("recipient_id = ?", recipientID)
	if cursorTime != nil && cursorID != nil {
		db = db.Where("(created_at, id) < (?, ?)", *cursorTime, *cursorID)
	}

	var items []*models.AppNotification
	if err := db.Preload("Actor").
		Order("created_at DESC").Order("id DESC").
		Limit(limit + 1).
		Find(&items).Error; err != nil {
		return nil, false, err
	}

	hasMore := len(items) > limit
	if hasMore {
		items = items[:limit]
	}
	return items, hasMore, nil
}

func (r *Repository) CountUnread(recipientID uuid.UUID) (int64, error) {
	var count int64
	err := r.db.Model(&models.AppNotification{}).
		Where("recipient_id = ? AND is_read = ?", recipientID, false).
		Count(&count).Error
	return count, err
}

func (r *Repository) MarkAllRead(recipientID uuid.UUID) error {
	return r.db.Model(&models.AppNotification{}).
		Where("recipient_id = ? AND is_read = ?", recipientID, false).
		Update("is_read", true).Error
}
