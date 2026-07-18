package adminuser

import (
	"fmt"
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

func (r *Repository) List(f ListFilter) ([]*models.User, int64, error) {
	db := r.db.Model(&models.User{})
	if f.IncludeDeleted {
		db = db.Unscoped()
	}
	if f.Query != "" {
		like := "%" + f.Query + "%"
		db = db.Where("username ILIKE ? OR full_name ILIKE ? OR email ILIKE ?", like, like, like)
	}
	if f.IP != "" {
		db = db.Where("last_login_ip ILIKE ?", f.IP+"%")
	}
	if f.IsActive != nil {
		db = db.Where("is_active = ?", *f.IsActive)
	}
	if f.Gender != "" {
		db = db.Where("gender = ?", f.Gender)
	}
	if f.Vip != nil {
		if *f.Vip {
			db = db.Where("vip_end_time > NOW()")
		} else {
			db = db.Where("vip_end_time IS NULL OR vip_end_time <= NOW()")
		}
	}
	if f.EmailVerified != nil {
		db = db.Where("email_verified = ?", *f.EmailVerified)
	}

	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var users []*models.User
	err := db.Order(orderClause(f.SortBy, f.SortDir)).Limit(f.Limit).Offset(f.Offset).Find(&users).Error
	if err != nil {
		return nil, 0, err
	}

	return users, total, nil
}

var sortColumns = map[string]string{
	"createdAt":     "created_at",
	"lastLoginAt":   "last_login_at",
	"followerCount": "follower_count",
	"username":      "username",
}

func orderClause(sortBy, sortDir string) string {
	col, ok := sortColumns[sortBy]
	if !ok {
		col = "created_at"
	}
	dir := "DESC"
	if sortDir == "asc" {
		dir = "ASC"
	}
	clause := col + " " + dir
	if col == "last_login_at" {
		clause += " NULLS LAST"
	}
	return clause + ", id DESC"
}

func (r *Repository) FindByID(id uuid.UUID) (*models.User, error) {
	var user models.User
	err := r.db.First(&user, "id = ?", id).Error
	if err != nil {
		return nil, err
	}
	return &user, nil
}

func (r *Repository) FindByIDUnscoped(id uuid.UUID) (*models.User, error) {
	var user models.User
	err := r.db.Unscoped().First(&user, "id = ?", id).Error
	if err != nil {
		return nil, err
	}
	return &user, nil
}

func (r *Repository) UsernameTaken(username string, exclude uuid.UUID) (bool, error) {
	var count int64
	err := r.db.Unscoped().Model(&models.User{}).
		Where("LOWER(username) = LOWER(?) AND id <> ?", username, exclude).
		Count(&count).Error
	return count > 0, err
}

func (r *Repository) SetUsername(id uuid.UUID, username string) error {
	return r.db.Unscoped().Model(&models.User{}).
		Where("id = ?", id).
		Update("username", username).Error
}

func (r *Repository) UpdatePassword(id uuid.UUID, hashedPassword string) error {
	return r.db.Model(&models.User{}).
		Where("id = ?", id).
		Update("password", hashedPassword).Error
}

func (r *Repository) SetActive(id uuid.UUID, active bool) error {
	return r.db.Model(&models.User{}).
		Where("id = ?", id).
		Update("is_active", active).Error
}

func (r *Repository) SoftDelete(id uuid.UUID) error {
	return r.db.Delete(&models.User{}, "id = ?", id).Error
}

func (r *Repository) CountVipIcons(userID uuid.UUID) (int64, error) {
	var count int64
	err := r.db.Model(&models.UserVipIcon{}).Where("user_id = ?", userID).Count(&count).Error
	return count, err
}

func (r *Repository) ListVipIcons(userID uuid.UUID, activeTypeID int16, limit, offset int) ([]models.UserVipIcon, error) {
	var items []models.UserVipIcon
	order := fmt.Sprintf("(vip_icon_id = %d) DESC, acquired_at DESC", activeTypeID)
	err := r.db.
		Where("user_id = ?", userID).
		Order(order).
		Limit(limit).
		Offset(offset).
		Find(&items).Error
	return items, err
}

func (r *Repository) CreateVipIcon(icon *models.UserVipIcon) error {
	return r.db.Create(icon).Error
}

func (r *Repository) CountSessions(userID uuid.UUID) (int64, error) {
	var count int64
	err := r.db.Model(&models.UserSession{}).Where("user_id = ?", userID).Count(&count).Error
	return count, err
}

func (r *Repository) ListSessions(userID uuid.UUID, limit, offset int) ([]models.UserSession, error) {
	var sessions []models.UserSession
	err := r.db.
		Where("user_id = ?", userID).
		Order("last_active_at DESC").
		Limit(limit).
		Offset(offset).
		Find(&sessions).Error
	return sessions, err
}
