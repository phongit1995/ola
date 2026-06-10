package adminuser

import (
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

func (r *Repository) List(query string, limit, offset int) ([]*models.User, int64, error) {
	db := r.db.Model(&models.User{})
	if query != "" {
		like := "%" + query + "%"
		db = db.Where("username ILIKE ? OR full_name ILIKE ? OR email ILIKE ?", like, like, like)
	}

	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var users []*models.User
	err := db.Order("created_at DESC").Limit(limit).Offset(offset).Find(&users).Error
	if err != nil {
		return nil, 0, err
	}

	return users, total, nil
}

func (r *Repository) FindByID(id uuid.UUID) (*models.User, error) {
	var user models.User
	err := r.db.First(&user, "id = ?", id).Error
	if err != nil {
		return nil, err
	}
	return &user, nil
}

func (r *Repository) SetActive(id uuid.UUID, active bool) error {
	return r.db.Model(&models.User{}).
		Where("id = ?", id).
		Update("is_active", active).Error
}

func (r *Repository) SoftDelete(id uuid.UUID) error {
	return r.db.Delete(&models.User{}, "id = ?", id).Error
}
