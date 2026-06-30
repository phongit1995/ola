package adminauth

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

func (r *Repository) FindByUsername(username string) (*models.AdminUser, error) {
	var admin models.AdminUser
	err := r.db.Where("LOWER(username) = LOWER(?)", username).First(&admin).Error
	if err != nil {
		return nil, err
	}
	return &admin, nil
}

func (r *Repository) FindByID(id uuid.UUID) (*models.AdminUser, error) {
	var admin models.AdminUser
	err := r.db.First(&admin, "id = ?", id).Error
	if err != nil {
		return nil, err
	}
	return &admin, nil
}

func (r *Repository) UpdateLoginInfo(id uuid.UUID, ip, refreshToken string) error {
	return r.db.Model(&models.AdminUser{}).
		Where("id = ?", id).
		Updates(map[string]interface{}{
			"last_login_ip": ip,
			"last_login_at": gorm.Expr("NOW()"),
			"refresh_token": refreshToken,
		}).Error
}
