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
	Type     string
	PaidWith string
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
		if f.Type != "" {
			db = db.Where("type = ?", f.Type)
		}
		switch f.PaidWith {
		case PaidWithTicket:
			db = db.Where("ticket_id IS NOT NULL")
		case PaidWithKen:
			db = db.Where("ticket_id IS NULL AND ken_price > 0")
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

func (r *Repository) AdminNames(ids []uuid.UUID) (map[uuid.UUID]string, error) {
	out := make(map[uuid.UUID]string, len(ids))
	if len(ids) == 0 {
		return out, nil
	}
	var admins []models.AdminUser
	if err := r.db.Unscoped().Select("id", "username").Where("id IN ?", ids).Find(&admins).Error; err != nil {
		return out, err
	}
	for i := range admins {
		out[admins[i].ID] = admins[i].Username
	}
	return out, nil
}

func (r *Repository) CampaignNames(ids []uuid.UUID) (map[uuid.UUID]string, error) {
	out := make(map[uuid.UUID]string, len(ids))
	if len(ids) == 0 {
		return out, nil
	}
	var campaigns []models.GiftCodeCampaign
	if err := r.db.Unscoped().Select("id", "name").Where("id IN ?", ids).Find(&campaigns).Error; err != nil {
		return out, err
	}
	for i := range campaigns {
		out[campaigns[i].ID] = campaigns[i].Name
	}
	return out, nil
}
