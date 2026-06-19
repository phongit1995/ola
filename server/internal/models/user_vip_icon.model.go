package models

import (
	"time"

	"github.com/google/uuid"
)

type UserVipIcon struct {
	BaseModel
	UserID     uuid.UUID `gorm:"type:uuid;not null;index" json:"userId"`
	VipIconID  int16     `gorm:"not null" json:"vipIconId"`
	IsLocked   bool      `gorm:"not null;default:false" json:"isLocked"`
	Source     string    `gorm:"type:varchar(20);not null;default:'purchase'" json:"source"`
	AcquiredAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP" json:"acquiredAt"`
}

func (UserVipIcon) TableName() string {
	return "user_vip_icons"
}
