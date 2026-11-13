package megaphone

import (
	"database/sql"
	"errors"
	"time"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/ledger"
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

type SendParams struct {
	SenderID        uuid.UUID
	Content         string
	KenPrice        int
	Weight          int
	DisplaySeconds  int
	SlotSeconds     int
	RunningSlot     time.Duration
	QueueLimit      int
	ExpiresAt       time.Time
	DailyLimit      int
	DayStart        time.Time
	Cooldown        time.Duration
	ClientRequestID string
	Now             time.Time
}

type GiftParams struct {
	SenderID          uuid.UUID
	GiftTransactionID uuid.UUID
	Content           string
	Weight            int
	DisplaySeconds    int
	QueueLimit        int
	ExpiresAt         time.Time
	Cooldown          time.Duration
	Now               time.Time
}

type SendResult struct {
	Megaphone     models.Megaphone
	SenderBalance int
	Wait          time.Duration
	Replayed      bool
}

func (r *Repository) FindByID(id uuid.UUID) (*models.Megaphone, error) {
	var item models.Megaphone
	if err := r.db.First(&item, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &item, nil
}

func findByClientRequest(db *gorm.DB, senderID uuid.UUID, clientRequestID string) (*models.Megaphone, error) {
	var item models.Megaphone
	err := db.Where("sender_id = ? AND client_request_id = ?", senderID, clientRequestID).First(&item).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &item, nil
}

func (r *Repository) FindByClientRequest(senderID uuid.UUID, clientRequestID string) (*models.Megaphone, error) {
	return findByClientRequest(r.db, senderID, clientRequestID)
}

func countSentSince(db *gorm.DB, senderID uuid.UUID, since time.Time) (int64, error) {
	var count int64
	err := db.Model(&models.Megaphone{}).
		Where("sender_id = ? AND type = ? AND created_at >= ?", senderID, models.MegaphoneTypeMessage, since).
		Count(&count).Error
	return count, err
}

func (r *Repository) CountSentSince(senderID uuid.UUID, since time.Time) (int64, error) {
	return countSentSince(r.db, senderID, since)
}

func lastSentAt(db *gorm.DB, senderID uuid.UUID, megaphoneType string) (*time.Time, error) {
	var last sql.NullTime
	err := db.Model(&models.Megaphone{}).Where("sender_id = ? AND type = ?", senderID, megaphoneType).
		Select("MAX(created_at)").Row().Scan(&last)
	if err != nil || !last.Valid {
		return nil, err
	}
	at := last.Time.UTC()
	return &at, nil
}

func (r *Repository) LastSentAt(senderID uuid.UUID) (*time.Time, error) {
	return lastSentAt(r.db, senderID, models.MegaphoneTypeMessage)
}

func (r *Repository) KenBalance(userID uuid.UUID) (int, error) {
	var u models.User
	if err := r.db.Select("ken").First(&u, "id = ?", userID).Error; err != nil {
		return 0, err
	}
	return u.Ken, nil
}

func countWaiting(db *gorm.DB, now time.Time) (int, error) {
	var count int64
	err := db.Model(&models.Megaphone{}).
		Where("status = ? AND first_played_at IS NULL AND expires_at > ?", models.MegaphoneStatusActive, now).
		Count(&count).Error
	return int(count), err
}

func (r *Repository) CountWaiting(now time.Time) (int, error) {
	return countWaiting(r.db, now)
}

func lockQueue(tx *gorm.DB) error {
	return tx.Exec("SELECT pg_advisory_xact_lock(?)", queueAdvisoryLockKey).Error
}

func (r *Repository) Send(p SendParams) (*SendResult, error) {
	result := &SendResult{}
	err := r.db.Transaction(func(tx *gorm.DB) error {
		if err := lockQueue(tx); err != nil {
			return err
		}
		existing, err := findByClientRequest(tx, p.SenderID, p.ClientRequestID)
		if err != nil {
			return err
		}
		if existing != nil {
			result.Megaphone = *existing
			result.Replayed = true
			return nil
		}
		today, err := countSentSince(tx, p.SenderID, p.DayStart)
		if err != nil {
			return err
		}
		if int(today) >= p.DailyLimit {
			return ErrMegaphoneDailyLimit
		}
		if p.Cooldown > 0 {
			last, err := lastSentAt(tx, p.SenderID, models.MegaphoneTypeMessage)
			if err != nil {
				return err
			}
			if last != nil && p.Now.Sub(*last) < p.Cooldown {
				return ErrMegaphoneCooldown
			}
		}
		waiting, err := countWaiting(tx, p.Now)
		if err != nil {
			return err
		}
		if waiting >= p.QueueLimit {
			return ErrMegaphoneQueueFull
		}
		wait := queueWait(waiting, p.SlotSeconds, p.RunningSlot)
		if !p.Now.Add(wait).Before(p.ExpiresAt) {
			return ErrMegaphoneQueueFull
		}

		var sender models.User
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).Select("id", "ken").First(&sender, "id = ?", p.SenderID).Error; err != nil {
			if errors.Is(err, gorm.ErrRecordNotFound) {
				return apperr.ErrUserNotFound
			}
			return err
		}
		if sender.Ken < p.KenPrice {
			return ErrMegaphoneInsufficientKen
		}

		record := models.Megaphone{
			ID:              uuid.New(),
			SenderID:        p.SenderID,
			Type:            models.MegaphoneTypeMessage,
			Content:         p.Content,
			KenPrice:        p.KenPrice,
			Weight:          p.Weight,
			ShowAt:          p.Now,
			DisplaySeconds:  p.DisplaySeconds,
			ExpiresAt:       p.ExpiresAt,
			Status:          models.MegaphoneStatusActive,
			ClientRequestID: p.ClientRequestID,
			CreatedAt:       p.Now,
		}
		if err := tx.Create(&record).Error; err != nil {
			return err
		}

		if p.KenPrice > 0 {
			refID := record.ID
			actorID := p.SenderID
			if _, err := ledger.Debit(tx, &sender, p.KenPrice, ledger.Entry{
				Type:        models.KenTxTypeMegaphone,
				Description: "Phát loa",
				RefType:     KenRefTypeMegaphone,
				RefID:       &refID,
				ActorType:   models.KenActorUser,
				ActorID:     &actorID,
			}); err != nil {
				return err
			}
		}

		result.Megaphone = record
		result.SenderBalance = sender.Ken
		result.Wait = wait
		return nil
	})
	if err != nil {
		return nil, err
	}
	return result, nil
}

func (r *Repository) FindByGiftTransaction(txID uuid.UUID) (*models.Megaphone, error) {
	var item models.Megaphone
	err := r.db.Where("gift_transaction_id = ?", txID).First(&item).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &item, nil
}

func (r *Repository) CreateGift(p GiftParams) (*models.Megaphone, error) {
	var created *models.Megaphone
	err := r.db.Transaction(func(tx *gorm.DB) error {
		if err := lockQueue(tx); err != nil {
			return err
		}
		if p.Cooldown > 0 {
			last, err := lastSentAt(tx, p.SenderID, models.MegaphoneTypeGift)
			if err != nil {
				return err
			}
			if last != nil && p.Now.Sub(*last) < p.Cooldown {
				return nil
			}
		}
		waiting, err := countWaiting(tx, p.Now)
		if err != nil {
			return err
		}
		if waiting >= p.QueueLimit {
			return nil
		}
		txID := p.GiftTransactionID
		record := models.Megaphone{
			ID:                uuid.New(),
			SenderID:          p.SenderID,
			Type:              models.MegaphoneTypeGift,
			Content:           p.Content,
			Weight:            p.Weight,
			ShowAt:            p.Now,
			DisplaySeconds:    p.DisplaySeconds,
			ExpiresAt:         p.ExpiresAt,
			Status:            models.MegaphoneStatusActive,
			ClientRequestID:   giftRequestPrefix + txID.String(),
			GiftTransactionID: &txID,
			CreatedAt:         p.Now,
		}
		if err := tx.Create(&record).Error; err != nil {
			return err
		}
		created = &record
		return nil
	})
	return created, err
}

func (r *Repository) ListSchedulable(now time.Time) ([]models.Megaphone, error) {
	var items []models.Megaphone
	err := r.db.Joins("JOIN users ON users.id = megaphones.sender_id AND users.is_active AND users.deleted_at IS NULL").
		Where("megaphones.status = ? AND megaphones.expires_at > ?", models.MegaphoneStatusActive, now).
		Order("megaphones.created_at ASC, megaphones.id ASC").Find(&items).Error
	return items, err
}

func (r *Repository) MarkPlayed(id uuid.UUID, at time.Time) error {
	return r.db.Model(&models.Megaphone{}).
		Where("id = ? AND first_played_at IS NULL", id).
		Updates(map[string]interface{}{"first_played_at": at, "show_at": at}).Error
}

func (r *Repository) GiftTransactions(ids []uuid.UUID) (map[uuid.UUID]models.GiftTransaction, error) {
	out := make(map[uuid.UUID]models.GiftTransaction, len(ids))
	if len(ids) == 0 {
		return out, nil
	}
	var items []models.GiftTransaction
	if err := r.db.Where("id IN ?", ids).Find(&items).Error; err != nil {
		return out, err
	}
	for i := range items {
		out[items[i].ID] = items[i]
	}
	return out, nil
}

func (r *Repository) GiftNamesEn(ids []uuid.UUID) (map[uuid.UUID]string, error) {
	out := make(map[uuid.UUID]string, len(ids))
	if len(ids) == 0 {
		return out, nil
	}
	var gifts []models.Gift
	if err := r.db.Unscoped().Select("id", "name_en").Where("id IN ?", ids).Find(&gifts).Error; err != nil {
		return out, err
	}
	for i := range gifts {
		out[gifts[i].ID] = gifts[i].NameEn
	}
	return out, nil
}

func (r *Repository) History(now time.Time, cursorAt *time.Time, cursorID *uuid.UUID, limit int) ([]models.Megaphone, error) {
	q := r.db.Where("status = ? AND type = ? AND first_played_at IS NOT NULL AND show_at > ?",
		models.MegaphoneStatusActive, models.MegaphoneTypeMessage, now.Add(-HistoryWindow))
	if cursorAt != nil && cursorID != nil {
		q = q.Where("(show_at, id) < (?, ?)", *cursorAt, *cursorID)
	}
	var items []models.Megaphone
	err := q.Order("show_at DESC, id DESC").Limit(limit).Find(&items).Error
	return items, err
}

func (r *Repository) Remove(tx *gorm.DB, id, adminID uuid.UUID, reason string, at time.Time) (bool, error) {
	res := tx.Model(&models.Megaphone{}).
		Where("id = ? AND status = ?", id, models.MegaphoneStatusActive).
		Updates(map[string]interface{}{
			"status":         models.MegaphoneStatusRemoved,
			"removed_by":     adminID,
			"removed_reason": reason,
			"removed_at":     at,
		})
	if res.Error != nil {
		return false, res.Error
	}
	return res.RowsAffected > 0, nil
}

func (r *Repository) Transaction(fn func(tx *gorm.DB) error) error {
	return r.db.Transaction(fn)
}
