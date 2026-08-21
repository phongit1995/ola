package announcement

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

func (r *Repository) LatestActive() (*models.Announcement, error) {
	var item models.Announcement
	err := r.db.
		Where("is_active = ?", true).
		Where("starts_at IS NULL OR starts_at <= NOW()").
		Where("ends_at IS NULL OR ends_at >= NOW()").
		Order("created_at DESC").
		First(&item).Error
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, nil
		}
		return nil, err
	}
	return &item, nil
}

func (r *Repository) List() ([]models.Announcement, error) {
	var items []models.Announcement
	if err := r.db.Order("created_at DESC").Find(&items).Error; err != nil {
		return nil, err
	}
	return items, nil
}

func (r *Repository) FindByID(id uuid.UUID) (*models.Announcement, error) {
	var item models.Announcement
	if err := r.db.First(&item, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &item, nil
}

func (r *Repository) Create(item *models.Announcement) error {
	return r.db.Create(item).Error
}

func (r *Repository) Save(item *models.Announcement) error {
	return r.db.Save(item).Error
}

func (r *Repository) Delete(id uuid.UUID) error {
	return r.db.Delete(&models.Announcement{}, "id = ?", id).Error
}
