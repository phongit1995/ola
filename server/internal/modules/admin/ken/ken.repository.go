package adminken

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
