package admingift

import (
	"time"

	"ola-chat-server/internal/models"
	admincommon "ola-chat-server/internal/modules/admin/common"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

type TransactionFilter struct {
	UserID     *uuid.UUID
	SenderID   *uuid.UUID
	ReceiverID *uuid.UUID
	GiftID     *uuid.UUID
	From       *time.Time
	To         *time.Time
}

type TransactionTotals struct {
	Count int64
	Ken   int64
	Charm int64
}

func transactionScope(f TransactionFilter) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		if f.UserID != nil {
			db = db.Where("(sender_id = ? OR receiver_id = ?)", *f.UserID, *f.UserID)
		}
		if f.SenderID != nil {
			db = db.Where("sender_id = ?", *f.SenderID)
		}
		if f.ReceiverID != nil {
			db = db.Where("receiver_id = ?", *f.ReceiverID)
		}
		if f.GiftID != nil {
			db = db.Where("gift_id = ?", *f.GiftID)
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

func (r *Repository) ListTransactions(f TransactionFilter, limit, offset int) ([]models.GiftTransaction, TransactionTotals, error) {
	var totals TransactionTotals
	if err := r.db.Model(&models.GiftTransaction{}).Scopes(transactionScope(f)).
		Select("COUNT(*) AS count, COALESCE(SUM(total_ken), 0) AS ken, COALESCE(SUM(charm_points), 0) AS charm").
		Scan(&totals).Error; err != nil {
		return nil, totals, err
	}
	var items []models.GiftTransaction
	err := r.db.Scopes(transactionScope(f)).Order("created_at DESC, id DESC").Limit(limit).Offset(offset).Find(&items).Error
	return items, totals, err
}

func (r *Repository) FindUsersByIDs(ids []uuid.UUID) (map[uuid.UUID]models.User, error) {
	return admincommon.FindUsersByIDs(r.db, ids)
}
