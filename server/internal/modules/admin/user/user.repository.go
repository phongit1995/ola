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

func (r *Repository) List(f ListFilter) ([]*models.User, int64, error) {
	db := r.db.Model(&models.User{})
	if f.Query != "" {
		like := "%" + f.Query + "%"
		db = db.Where("username ILIKE ? OR full_name ILIKE ? OR email ILIKE ?", like, like, like)
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

func (r *Repository) SetActive(id uuid.UUID, active bool) error {
	return r.db.Model(&models.User{}).
		Where("id = ?", id).
		Update("is_active", active).Error
}

func (r *Repository) SoftDelete(id uuid.UUID) error {
	return r.db.Delete(&models.User{}, "id = ?", id).Error
}
