package sociallimit

import (
	"time"

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

func (r *Repository) HasActiveVip(userID uuid.UUID, now time.Time) (bool, error) {
	var user models.User
	if err := r.db.Select("id", "vip_end_time").Where("id = ?", userID).Take(&user).Error; err != nil {
		return false, err
	}
	return user.HasActiveVip(now), nil
}
