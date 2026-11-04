package megaphone

import (
	"database/sql"
	"errors"
	"time"

	"ola-chat-server/internal/apperr"
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
	DisplaySeconds  int
	MaxQueue        time.Duration
	DailyLimit      int
	DayStart        time.Time
	Cooldown        time.Duration
	ClientRequestID string
	Now             time.Time
}

type SendResult struct {
	Megaphone     models.Megaphone
	SenderBalance int
	Wait          time.Duration
	Replayed      bool
}

func activeAt(db *gorm.DB, now time.Time) *gorm.DB {
	return db.Where("status = ? AND show_at > ? AND show_at + display_seconds * interval '1 second' > ?",
		models.MegaphoneStatusActive, now.Add(-queueLookback), now)
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
	err := db.Model(&models.Megaphone{}).Where("sender_id = ? AND created_at >= ?", senderID, since).Count(&count).Error
	return count, err
}

func (r *Repository) CountSentSince(senderID uuid.UUID, since time.Time) (int64, error) {
	return countSentSince(r.db, senderID, since)
}

func lastSentAt(db *gorm.DB, senderID uuid.UUID) (*time.Time, error) {
	var last sql.NullTime
	err := db.Model(&models.Megaphone{}).Where("sender_id = ?", senderID).
		Select("MAX(created_at)").Row().Scan(&last)
	if err != nil || !last.Valid {
		return nil, err
	}
	at := last.Time.UTC()
	return &at, nil
}

func (r *Repository) LastSentAt(senderID uuid.UUID) (*time.Time, error) {
	return lastSentAt(r.db, senderID)
}

func (r *Repository) KenBalance(userID uuid.UUID) (int, error) {
	var u models.User
	if err := r.db.Select("ken").First(&u, "id = ?", userID).Error; err != nil {
		return 0, err
	}
	return u.Ken, nil
}

func queueEnd(db *gorm.DB, now time.Time) (time.Time, error) {
	var end sql.NullTime
	err := activeAt(db.Model(&models.Megaphone{}), now).
		Select("MAX(show_at + display_seconds * interval '1 second')").
		Row().Scan(&end)
	if err != nil {
		return now, err
	}
	if !end.Valid || end.Time.Before(now) {
		return now, nil
	}
	return end.Time.UTC(), nil
}

func (r *Repository) QueueEnd(now time.Time) (time.Time, error) {
	return queueEnd(r.db, now)
}

func (r *Repository) Send(p SendParams) (*SendResult, error) {
	result := &SendResult{}
	err := r.db.Transaction(func(tx *gorm.DB) error {
		if err := tx.Exec("SELECT pg_advisory_xact_lock(?)", queueAdvisoryLockKey).Error; err != nil {
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
			last, err := lastSentAt(tx, p.SenderID)
			if err != nil {
				return err
			}
			if last != nil && p.Now.Sub(*last) < p.Cooldown {
				return ErrMegaphoneCooldown
			}
		}
		showAt, err := queueEnd(tx, p.Now)
		if err != nil {
			return err
		}
		wait := showAt.Sub(p.Now)
		if wait > p.MaxQueue {
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
			Content:         p.Content,
			KenPrice:        p.KenPrice,
			ShowAt:          showAt,
			DisplaySeconds:  p.DisplaySeconds,
			Status:          models.MegaphoneStatusActive,
			ClientRequestID: p.ClientRequestID,
			CreatedAt:       p.Now,
		}
		if err := tx.Create(&record).Error; err != nil {
			return err
		}

		balance := sender.Ken
		if p.KenPrice > 0 {
			balance = sender.Ken - p.KenPrice
			if err := tx.Model(&models.User{}).Where("id = ?", p.SenderID).Update("ken", balance).Error; err != nil {
				return err
			}
			refID := record.ID
			actorID := p.SenderID
			kenTx := models.KenTransaction{
				UserID:        p.SenderID,
				Direction:     models.KenDirectionDebit,
				Type:          models.KenTxTypeMegaphone,
				Amount:        p.KenPrice,
				BalanceBefore: sender.Ken,
				BalanceAfter:  balance,
				Description:   "Phát loa",
				RefType:       KenRefTypeMegaphone,
				RefID:         &refID,
				ActorType:     models.KenActorUser,
				ActorID:       &actorID,
			}
			if err := tx.Create(&kenTx).Error; err != nil {
				return err
			}
		}

		result.Megaphone = record
		result.SenderBalance = balance
		result.Wait = wait
		return nil
	})
	if err != nil {
		return nil, err
	}
	return result, nil
}

func (r *Repository) ListActive(now time.Time, limit int) ([]models.Megaphone, error) {
	var items []models.Megaphone
	err := activeAt(r.db, now).Order("show_at ASC, id ASC").Limit(limit).Find(&items).Error
	return items, err
}

func (r *Repository) History(now time.Time, cursorAt *time.Time, cursorID *uuid.UUID, limit int) ([]models.Megaphone, error) {
	q := r.db.Where("status = ? AND show_at > ? AND show_at <= ?", models.MegaphoneStatusActive, now.Add(-HistoryWindow), now)
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
