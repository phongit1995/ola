package setting

import (
	"errors"

	"ola-chat-server/internal/models"

	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func (r *Repository) List() ([]models.AppSetting, error) {
	var items []models.AppSetting
	err := r.db.Order("key ASC").Find(&items).Error
	return items, err
}

func (r *Repository) Get(key string) (*models.AppSetting, error) {
	var item models.AppSetting
	err := r.db.First(&item, "key = ?", key).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &item, nil
}

func (r *Repository) Upsert(key string, value models.JSONB) (*models.AppSetting, error) {
	item := models.AppSetting{Key: key, Value: value}
	err := r.db.Clauses(clause.OnConflict{
		Columns:   []clause.Column{{Name: "key"}},
		DoUpdates: clause.Assignments(map[string]interface{}{"value": value, "updated_at": gorm.Expr("CURRENT_TIMESTAMP")}),
	}).Create(&item).Error
	if err != nil {
		return nil, err
	}
	return r.Get(key)
}
