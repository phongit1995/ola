package minigame

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

func (r *Repository) List(enabledOnly bool) ([]models.MiniGame, error) {
	var games []models.MiniGame
	q := r.db.Order("sort_order ASC").Order("created_at ASC")
	if enabledOnly {
		q = q.Where("is_enabled = ?", true)
	}
	if err := q.Find(&games).Error; err != nil {
		return nil, err
	}
	return games, nil
}

func (r *Repository) FindByID(id uuid.UUID) (*models.MiniGame, error) {
	var game models.MiniGame
	if err := r.db.First(&game, "id = ?", id).Error; err != nil {
		return nil, err
	}
	return &game, nil
}

func (r *Repository) SlugExists(slug string) (bool, error) {
	var count int64
	if err := r.db.Model(&models.MiniGame{}).Where("slug = ?", slug).Count(&count).Error; err != nil {
		return false, err
	}
	return count > 0, nil
}

func (r *Repository) Create(game *models.MiniGame) error {
	return r.db.Create(game).Error
}

func (r *Repository) Save(game *models.MiniGame) error {
	return r.db.Save(game).Error
}

func (r *Repository) Delete(id uuid.UUID) error {
	return r.db.Delete(&models.MiniGame{}, "id = ?", id).Error
}
