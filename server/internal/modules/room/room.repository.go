package room

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

func (r *Repository) Create(room *models.Room) error {
	return r.db.Create(room).Error
}

func (r *Repository) Save(room *models.Room) error {
	return r.db.Save(room).Error
}

func (r *Repository) GetByID(id uuid.UUID) (*models.Room, error) {
	var room models.Room
	if err := r.db.First(&room, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &room, nil
}

func (r *Repository) list(query string, limit, offset int, onlyEnabled bool) ([]*models.Room, int64, error) {
	db := r.db.Model(&models.Room{})
	if onlyEnabled {
		db = db.Where("enabled = ?", true)
	}
	if query != "" {
		db = db.Where("name ILIKE ?", "%"+query+"%")
	}

	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var rooms []*models.Room
	if err := db.Order(`"index" ASC, created_at DESC`).Limit(limit).Offset(offset).Find(&rooms).Error; err != nil {
		return nil, 0, err
	}
	return rooms, total, nil
}

func (r *Repository) ListPublic(query string, limit, offset int) ([]*models.Room, int64, error) {
	return r.list(query, limit, offset, true)
}

func (r *Repository) ListAll(query string, limit, offset int) ([]*models.Room, int64, error) {
	return r.list(query, limit, offset, false)
}

func (r *Repository) SoftDelete(id uuid.UUID) error {
	return r.db.Delete(&models.Room{}, "id = ?", id).Error
}
