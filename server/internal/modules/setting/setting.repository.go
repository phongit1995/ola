package setting

import (
	"errors"
	"time"

	"ola-chat-server/internal/constants"
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

func (r *Repository) UpsertMany(items []models.AppSetting) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		for _, item := range items {
			entry := models.AppSetting{Key: item.Key, Value: item.Value}
			err := tx.Clauses(clause.OnConflict{
				Columns:   []clause.Column{{Name: "key"}},
				DoUpdates: clause.Assignments(map[string]interface{}{"value": item.Value, "updated_at": gorm.Expr("CURRENT_TIMESTAMP")}),
			}).Create(&entry).Error
			if err != nil {
				return err
			}
		}
		return nil
	})
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

func (r *Repository) UpdateIfUnchanged(key string, value models.JSONB, expected time.Time) (bool, error) {
	result := r.db.Model(&models.AppSetting{}).
		Where("key = ? AND updated_at = ?", key, expected).
		Updates(map[string]interface{}{"value": value, "updated_at": gorm.Expr("CURRENT_TIMESTAMP")})
	return result.RowsAffected > 0, result.Error
}

const markCookieDeadSQL = `
UPDATE app_settings
SET value = jsonb_set(value, '{cookies}', (
		SELECT jsonb_agg(CASE
			WHEN entry->>'cookie' = @cookie AND entry->>'status' = @active
			THEN entry || jsonb_build_object('status', CAST(@dead AS text), 'deadAt', CAST(@at AS text))
			ELSE entry END ORDER BY position)
		FROM jsonb_array_elements(value->'cookies') WITH ORDINALITY AS entries(entry, position)
	)),
	updated_at = CURRENT_TIMESTAMP
WHERE key = @key
	AND jsonb_typeof(value->'cookies') = 'array'
	AND EXISTS (
		SELECT 1 FROM jsonb_array_elements(value->'cookies') AS entries(entry)
		WHERE entry->>'cookie' = @cookie AND entry->>'status' = @active
	)`

func (r *Repository) MarkCookieDead(key, cookie string, at time.Time) (bool, error) {
	result := r.db.Exec(markCookieDeadSQL, map[string]interface{}{
		"key":    key,
		"cookie": cookie,
		"active": constants.StoryCookieStatusActive,
		"dead":   constants.StoryCookieStatusDead,
		"at":     at.UTC().Format(time.RFC3339),
	})
	return result.RowsAffected > 0, result.Error
}
