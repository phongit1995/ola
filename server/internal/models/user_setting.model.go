package models

import (
	"time"

	"github.com/google/uuid"
)

const (
	SettingMessagePrivacyAll     = "all"
	SettingMessagePrivacyFriends = "friends"

	SettingMeVisibilityAll     = "all"
	SettingMeVisibilityFriends = "friends"

	SettingCommentPrivacyAll     = "all"
	SettingCommentPrivacyFriends = "friends"

	SettingFontSizeSmall  = "small"
	SettingFontSizeMedium = "medium"
	SettingFontSizeLarge  = "large"
)

type UserSetting struct {
	UserID         uuid.UUID `gorm:"type:uuid;primaryKey"`
	MessagePrivacy string    `gorm:"type:varchar(20);not null"`
	MeVisibility   string    `gorm:"type:varchar(20);not null"`
	CommentPrivacy string    `gorm:"type:varchar(20);not null"`
	ShowBirthday   bool      `gorm:"not null"`
	ShowInterested bool      `gorm:"not null"`
	NotifMessage   bool      `gorm:"not null"`
	NotifSound     bool      `gorm:"not null"`
	SoundGame      bool      `gorm:"not null"`
	SoundKen       bool      `gorm:"not null"`
	FontSize       string    `gorm:"type:varchar(20);not null"`
	WallpaperURL   string    `gorm:"type:text;not null"`
	CreatedAt      time.Time `gorm:"not null;default:CURRENT_TIMESTAMP"`
	UpdatedAt      time.Time `gorm:"not null;default:CURRENT_TIMESTAMP"`
}

func (UserSetting) TableName() string {
	return "user_settings"
}
