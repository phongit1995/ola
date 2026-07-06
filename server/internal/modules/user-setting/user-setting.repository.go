package usersetting

import (
	"errors"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func (r *Repository) GetSettings(userID uuid.UUID) (*models.UserSetting, error) {
	var settings models.UserSetting
	if err := r.db.First(&settings, "user_id = ?", userID).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, nil
		}
		return nil, err
	}
	return &settings, nil
}

func (r *Repository) UpsertSettings(settings *models.UserSetting) error {
	return r.db.Clauses(clause.OnConflict{
		Columns: []clause.Column{{Name: "user_id"}},
		DoUpdates: clause.AssignmentColumns([]string{
			"message_privacy", "me_visibility", "comment_privacy",
			"show_birthday", "show_interested",
			"notif_message", "notif_sound", "sound_game", "sound_ken",
			"font_size", "wallpaper_url", "updated_at",
		}),
	}).Create(settings).Error
}
