package marriage_diary

import (
	"errors"

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

func briefSelect(tx *gorm.DB) *gorm.DB {
	return tx.Select("id", "username", "full_name", "avatar")
}

func (r *Repository) GetActiveMarriageID(userID uuid.UUID) (uuid.UUID, bool, error) {
	var m models.Marriage
	err := r.db.
		Where("(user_low_id = ? OR user_high_id = ?) AND status = ?", userID, userID, models.MarriageStatusActive).
		First(&m).Error
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return uuid.Nil, false, nil
		}
		return uuid.Nil, false, err
	}
	return m.ID, true, nil
}

func (r *Repository) Create(entry *models.MarriageDiaryEntry) error {
	return r.db.Create(entry).Error
}

func (r *Repository) ListByMarriage(marriageID uuid.UUID, limit, offset int) ([]models.MarriageDiaryEntry, int64, error) {
	q := r.db.Model(&models.MarriageDiaryEntry{}).Where("marriage_id = ?", marriageID)

	var total int64
	if err := q.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var items []models.MarriageDiaryEntry
	err := q.
		Preload("Author", briefSelect).
		Order("created_at DESC").
		Limit(limit).
		Offset(offset).
		Find(&items).Error
	return items, total, err
}

func (r *Repository) FindByID(id uuid.UUID) (*models.MarriageDiaryEntry, error) {
	var e models.MarriageDiaryEntry
	if err := r.db.Preload("Author", briefSelect).First(&e, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &e, nil
}

func (r *Repository) SoftDelete(id uuid.UUID) error {
	return r.db.Delete(&models.MarriageDiaryEntry{}, "id = ?", id).Error
}
