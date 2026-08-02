package call

import (
	"errors"
	"ola-chat-server/internal/models"
	"sort"
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func (r *Repository) Create(call *models.Call) error {
	return r.db.Create(call).Error
}

func (r *Repository) FindByID(id uuid.UUID) (*models.Call, error) {
	var call models.Call
	if err := r.db.First(&call, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &call, nil
}

func (r *Repository) FindByRoomName(roomName string) (*models.Call, error) {
	var call models.Call
	if err := r.db.First(&call, "room_name = ?", roomName).Error; err != nil {
		return nil, err
	}
	return &call, nil
}

func (r *Repository) UpdateStatus(id uuid.UUID, status models.CallStatus) error {
	return r.db.Model(&models.Call{}).
		Where("id = ?", id).
		Updates(map[string]interface{}{
			"status":     status,
			"updated_at": time.Now(),
		}).Error
}

func (r *Repository) MarkAnswered(id uuid.UUID) error {
	now := time.Now()
	return r.db.Model(&models.Call{}).
		Where("id = ?", id).
		Updates(map[string]interface{}{
			"status":      models.CallStatusActive,
			"answered_at": &now,
			"updated_at":  now,
		}).Error
}

func (r *Repository) MarkEnded(id uuid.UUID, finalStatus models.CallStatus) (*models.Call, error) {
	call, err := r.FindByID(id)
	if err != nil {
		return nil, err
	}
	now := time.Now()
	call.Status = finalStatus
	call.EndedAt = &now
	call.UpdatedAt = now

	if call.AnsweredAt != nil {
		dur := int(now.Sub(*call.AnsweredAt).Seconds())
		call.DurationSeconds = &dur
	} else {
		zero := 0
		call.DurationSeconds = &zero
	}

	if err := r.db.Save(call).Error; err != nil {
		return nil, err
	}
	return call, nil
}

func (r *Repository) FindOngoingByUser(userID uuid.UUID, ringingSince time.Time) (*models.Call, error) {
	return r.findOngoing(r.db, userID, ringingSince)
}

// findOngoing bounds only `ringing` by time: a ringing row past its timeout is
// abandoned state the ring timer never got to finalize, whereas an `active` row
// stays authoritative until something ends it. `participants` is uuid[], so the
// parameter needs an explicit ::uuid cast.
func (r *Repository) findOngoing(db *gorm.DB, userID uuid.UUID, ringingSince time.Time) (*models.Call, error) {
	var call models.Call
	err := db.
		Where(
			"(status = ? OR (status = ? AND started_at >= ?))",
			string(models.CallStatusActive),
			string(models.CallStatusRinging),
			ringingSince,
		).
		Where("?::uuid = ANY(participants)", userID.String()).
		Order("started_at DESC").
		First(&call).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &call, nil
}

// CreateIfNoOngoing serialises concurrent start-call attempts that involve the
// same people. Transaction-scoped advisory locks are taken over every
// participant in a stable order (so A→B and B→A cannot deadlock), which makes
// the "is anyone already busy" read and the insert one atomic step. Returns
// false when the check found an ongoing call and nothing was inserted.
func (r *Repository) CreateIfNoOngoing(
	call *models.Call,
	lockIDs []uuid.UUID,
	userID uuid.UUID,
	ringingSince time.Time,
) (bool, error) {
	ordered := make([]uuid.UUID, len(lockIDs))
	copy(ordered, lockIDs)
	sort.Slice(ordered, func(i, j int) bool {
		return ordered[i].String() < ordered[j].String()
	})

	created := false
	err := r.db.Transaction(func(tx *gorm.DB) error {
		for _, id := range ordered {
			if err := tx.Exec(
				"SELECT pg_advisory_xact_lock(hashtextextended(?::text, 0))",
				id.String(),
			).Error; err != nil {
				return err
			}
		}

		ongoing, err := r.findOngoing(tx, userID, ringingSince)
		if err != nil {
			return err
		}
		if ongoing != nil {
			return nil
		}
		if err := tx.Create(call).Error; err != nil {
			return err
		}
		created = true
		return nil
	})
	return created, err
}

func (r *Repository) ListByConversation(conversationID uuid.UUID, limit int) ([]models.Call, error) {
	var calls []models.Call
	if limit <= 0 || limit > 100 {
		limit = 50
	}
	err := r.db.Where("conversation_id = ?", conversationID).
		Order("started_at DESC").
		Limit(limit).
		Find(&calls).Error
	return calls, err
}
