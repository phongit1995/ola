package models

import "time"

type AppSetting struct {
	Key       string    `gorm:"type:varchar(100);primaryKey" json:"key"`
	Value     JSONB     `gorm:"type:jsonb;not null" json:"value"`
	UpdatedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP" json:"updatedAt"`
}

func (AppSetting) TableName() string {
	return "app_settings"
}
