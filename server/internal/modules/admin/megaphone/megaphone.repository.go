package adminmegaphone

import (
	"time"

	"ola-chat-server/internal/models"
	admincommon "ola-chat-server/internal/modules/admin/common"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

type ListFilter struct {
	SenderID *uuid.UUID
	Status   string
	Query    string
	From     *time.Time
	To       *time.Time
	Limit    int
	Offset   int
}

type totals struct {
	Count int64
	Ken   int64
}

func listScope(f ListFilter) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		if f.SenderID != nil {
			db = db.Where("sender_id = ?", *f.SenderID)
		}
		if f.Status != "" {
			db = db.Where("status = ?", f.Status)
		}
		if f.Query != "" {
			db = db.Where("content ILIKE ?", utils.LikeContains(f.Query))
		}
		if f.From != nil {
			db = db.Where("created_at >= ?", *f.From)
		}
		if f.To != nil {
			db = db.Where("created_at <= ?", *f.To)
		}
		return db
	}
}

func (r *Repository) List(f ListFilter) ([]models.Megaphone, totals, error) {
	var t totals
	if err := r.db.Model(&models.Megaphone{}).Scopes(listScope(f)).
		Select("COUNT(*) AS count, COALESCE(SUM(ken_price), 0) AS ken").
		Scan(&t).Error; err != nil {
		return nil, t, err
	}
	var items []models.Megaphone
	err := r.db.Scopes(listScope(f)).Order("created_at DESC, id DESC").Limit(f.Limit).Offset(f.Offset).Find(&items).Error
	return items, t, err
}

func (r *Repository) FindUsersByIDs(ids []uuid.UUID) (map[uuid.UUID]models.User, error) {
	return admincommon.FindUsersByIDs(r.db, ids)
}
