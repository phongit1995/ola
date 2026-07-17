package auth

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

func (r *Repository) FindByUsername(username string) (*models.User, error) {
	var user models.User
	err := r.db.Where("LOWER(username) = LOWER(?)", username).First(&user).Error
	if err != nil {
		return nil, err
	}
	return &user, nil
}

func (r *Repository) UsernameExists(username string) (bool, error) {
	var count int64
	err := r.db.Unscoped().Model(&models.User{}).
		Where("LOWER(username) = LOWER(?)", username).
		Count(&count).Error
	if err != nil {
		return false, err
	}
	return count > 0, nil
}

func (r *Repository) Create(user *models.User) error {
	return r.db.Create(user).Error
}

func (r *Repository) FindByID(id uuid.UUID) (*models.User, error) {
	var user models.User
	err := r.db.First(&user, "id = ?", id).Error
	if err != nil {
		return nil, err
	}
	return &user, nil
}

func (r *Repository) UpdatePassword(userID uuid.UUID, hashedPassword string) error {
	return r.db.Model(&models.User{}).
		Where("id = ?", userID).
		Update("password", hashedPassword).Error
}

func (r *Repository) UpdateLastLogin(userID uuid.UUID, ip string) error {
	return r.db.Model(&models.User{}).
		Where("id = ?", userID).
		Updates(map[string]interface{}{
			"last_login_ip": ip,
			"last_login_at": gorm.Expr("NOW()"),
		}).Error
}

func (r *Repository) ClearRefreshToken(userID uuid.UUID) error {
	return r.db.Model(&models.User{}).
		Where("id = ?", userID).
		Update("refresh_token", "").Error
}

func (r *Repository) EmailVerifiedByOther(email string, excludeID uuid.UUID) (bool, error) {
	var count int64
	err := r.db.Model(&models.User{}).
		Where("LOWER(email) = LOWER(?) AND email_verified = true AND id <> ?", email, excludeID).
		Count(&count).Error
	if err != nil {
		return false, err
	}
	return count > 0, nil
}

func (r *Repository) SetEmailVerified(userID uuid.UUID, email string) (bool, error) {
	fields := map[string]interface{}{
		"email":             email,
		"email_verified":    true,
		"email_verified_at": gorm.Expr("NOW()"),
	}

	res := r.db.Model(&models.User{}).
		Where("id = ? AND email_verified_at IS NULL", userID).
		Updates(fields)
	if res.Error != nil {
		return false, res.Error
	}
	if res.RowsAffected > 0 {
		return true, nil
	}

	err := r.db.Model(&models.User{}).
		Where("id = ?", userID).
		Updates(fields).Error
	return false, err
}
