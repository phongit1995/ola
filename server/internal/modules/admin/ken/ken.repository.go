package adminken

import (
	"time"

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

type AdjustParams struct {
	UserID      uuid.UUID
	Direction   models.KenDirection
	Type        models.KenTxType
	Amount      int
	Description string
	ActorID     uuid.UUID
	Metadata    models.JSONB
}

func (r *Repository) ListByUser(userID uuid.UUID, limit, offset int) ([]models.KenTransaction, int64, error) {
	var items []models.KenTransaction
	var total int64
	if err := r.db.Model(&models.KenTransaction{}).Where("user_id = ?", userID).Count(&total).Error; err != nil {
		return nil, 0, err
	}
	err := r.db.
		Where("user_id = ?", userID).
		Order("created_at DESC").
		Limit(limit).
		Offset(offset).
		Find(&items).Error
	return items, total, err
}

func (r *Repository) FindUsersByIDs(ids []uuid.UUID) (map[uuid.UUID]models.User, error) {
	result := make(map[uuid.UUID]models.User, len(ids))
	if len(ids) == 0 {
		return result, nil
	}
	var users []models.User
	if err := r.db.Unscoped().
		Select("id", "username", "full_name", "avatar").
		Where("id IN ?", ids).
		Find(&users).Error; err != nil {
		return nil, err
	}
	for i := range users {
		result[users[i].ID] = users[i]
	}
	return result, nil
}

func transferScope(f TransferFilter) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		db = db.Where("ken_transactions.deleted_at IS NULL").
			Where("ken_transactions.type = ?", models.KenTxTypeTransferOut)
		if f.SenderID != nil {
			db = db.Where("ken_transactions.user_id = ?", *f.SenderID)
		}
		if f.ReceiverID != nil {
			db = db.Where("ken_transactions.ref_id = ?", *f.ReceiverID)
		}
		if f.UserID != nil {
			db = db.Where("(ken_transactions.user_id = ? OR ken_transactions.ref_id = ?)", *f.UserID, *f.UserID)
		}
		if f.MinAmount != nil {
			db = db.Where("ken_transactions.amount >= ?", *f.MinAmount)
		}
		if f.MaxAmount != nil {
			db = db.Where("ken_transactions.amount <= ?", *f.MaxAmount)
		}
		if f.From != nil {
			db = db.Where("ken_transactions.created_at >= ?", *f.From)
		}
		if f.To != nil {
			db = db.Where("ken_transactions.created_at <= ?", *f.To)
		}
		return db
	}
}

type transferRow struct {
	ID               uuid.UUID  `gorm:"column:id"`
	SenderID         uuid.UUID  `gorm:"column:sender_id"`
	ReceiverID       *uuid.UUID `gorm:"column:receiver_id"`
	Amount           int        `gorm:"column:amount"`
	Description      string     `gorm:"column:description"`
	CreatedAt        time.Time  `gorm:"column:created_at"`
	SenderUsername   string     `gorm:"column:sender_username"`
	SenderFullName   string     `gorm:"column:sender_full_name"`
	SenderAvatar     string     `gorm:"column:sender_avatar"`
	ReceiverUsername string     `gorm:"column:receiver_username"`
	ReceiverFullName string     `gorm:"column:receiver_full_name"`
	ReceiverAvatar   string     `gorm:"column:receiver_avatar"`
}

func (r *Repository) ListTransfers(f TransferFilter, limit, offset int) ([]transferRow, int64, error) {
	var total int64
	if err := r.db.Table("ken_transactions").Scopes(transferScope(f)).Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var rows []transferRow
	err := r.db.Table("ken_transactions").
		Select(`ken_transactions.id, ken_transactions.user_id AS sender_id, ken_transactions.ref_id AS receiver_id,
			ken_transactions.amount, ken_transactions.description, ken_transactions.created_at,
			sender.username AS sender_username, sender.full_name AS sender_full_name, sender.avatar AS sender_avatar,
			receiver.username AS receiver_username, receiver.full_name AS receiver_full_name, receiver.avatar AS receiver_avatar`).
		Joins("LEFT JOIN users AS sender ON sender.id = ken_transactions.user_id").
		Joins("LEFT JOIN users AS receiver ON receiver.id = ken_transactions.ref_id").
		Scopes(transferScope(f)).
		Order("ken_transactions.created_at DESC, ken_transactions.id DESC").
		Limit(limit).
		Offset(offset).
		Scan(&rows).Error
	return rows, total, err
}

var transferUserSorts = map[string]string{
	"sentTotal":     "sent_total",
	"receivedTotal": "received_total",
	"netKen":        "net_ken",
	"transfers":     "transfers",
}

type transferUserRow struct {
	UserID         uuid.UUID `gorm:"column:user_id"`
	Username       string    `gorm:"column:username"`
	FullName       string    `gorm:"column:full_name"`
	Avatar         string    `gorm:"column:avatar"`
	SentCount      int64     `gorm:"column:sent_count"`
	SentTotal      int64     `gorm:"column:sent_total"`
	ReceivedCount  int64     `gorm:"column:received_count"`
	ReceivedTotal  int64     `gorm:"column:received_total"`
	NetKen         int64     `gorm:"column:net_ken"`
	Partners       int64     `gorm:"column:partners"`
	LastTransferAt time.Time `gorm:"column:last_transfer_at"`
}

func (r *Repository) transferSideQuery(f TransferFilter, sent bool) *gorm.DB {
	uid, partner, sentFlag, recvFlag := "user_id", "ref_id", "1", "0"
	if !sent {
		uid, partner, sentFlag, recvFlag = "ref_id", "user_id", "0", "1"
	}
	sideFilter := TransferFilter{MinAmount: f.MinAmount, MaxAmount: f.MaxAmount, From: f.From, To: f.To}
	return r.db.Table("ken_transactions").
		Select(`ken_transactions.` + uid + ` AS uid,
			` + sentFlag + ` AS sent, ` + recvFlag + ` AS received,
			CASE WHEN ` + sentFlag + ` = 1 THEN ken_transactions.amount ELSE 0 END AS sent_amount,
			CASE WHEN ` + recvFlag + ` = 1 THEN ken_transactions.amount ELSE 0 END AS received_amount,
			ken_transactions.` + partner + ` AS partner,
			ken_transactions.created_at`).
		Scopes(transferScope(sideFilter)).
		Where("ken_transactions.ref_id IS NOT NULL")
}

func (r *Repository) TransferUserStats(f TransferFilter, sortBy string, limit, offset int) ([]transferUserRow, int64, error) {
	base := func() *gorm.DB {
		q := r.db.Table("(? UNION ALL ?) AS t", r.transferSideQuery(f, true), r.transferSideQuery(f, false))
		if f.UserID != nil {
			q = q.Where("t.uid = ?", *f.UserID)
		}
		return q
	}

	var total int64
	if err := base().Distinct("t.uid").Count(&total).Error; err != nil {
		return nil, 0, err
	}

	order, ok := transferUserSorts[sortBy]
	if !ok {
		order = "sent_total"
	}

	var rows []transferUserRow
	err := base().
		Select(`t.uid AS user_id, users.username, users.full_name, users.avatar,
			sum(t.sent) as sent_count,
			coalesce(sum(t.sent_amount), 0) as sent_total,
			sum(t.received) as received_count,
			coalesce(sum(t.received_amount), 0) as received_total,
			coalesce(sum(t.received_amount), 0) - coalesce(sum(t.sent_amount), 0) as net_ken,
			count(distinct t.partner) as partners,
			max(t.created_at) as last_transfer_at,
			sum(t.sent) + sum(t.received) as transfers`).
		Joins("LEFT JOIN users ON users.id = t.uid").
		Group("t.uid, users.username, users.full_name, users.avatar").
		Order(order + " DESC, t.uid ASC").
		Limit(limit).
		Offset(offset).
		Scan(&rows).Error
	return rows, total, err
}

func (r *Repository) Adjust(p AdjustParams) (*models.User, *models.KenTransaction, error) {
	var updatedUser models.User
	var kenTx models.KenTransaction

	err := r.db.Transaction(func(tx *gorm.DB) error {
		var u models.User
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&u, "id = ?", p.UserID).Error; err != nil {
			return err
		}

		before := u.Ken
		after := before + p.Amount
		if p.Direction == models.KenDirectionDebit {
			if before < p.Amount {
				return ErrInsufficientKen
			}
			after = before - p.Amount
		}

		if err := tx.Model(&models.User{}).Where("id = ?", p.UserID).Update("ken", after).Error; err != nil {
			return err
		}

		actorID := p.ActorID
		kenTx = models.KenTransaction{
			UserID:        p.UserID,
			Direction:     p.Direction,
			Type:          p.Type,
			Amount:        p.Amount,
			BalanceBefore: before,
			BalanceAfter:  after,
			Description:   p.Description,
			ActorType:     models.KenActorAdmin,
			ActorID:       &actorID,
			Metadata:      p.Metadata,
		}
		if err := tx.Create(&kenTx).Error; err != nil {
			return err
		}

		u.Ken = after
		updatedUser = u
		return nil
	})
	if err != nil {
		return nil, nil, err
	}
	return &updatedUser, &kenTx, nil
}
