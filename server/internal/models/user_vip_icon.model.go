package models

import (
	"time"

	"github.com/google/uuid"
)

type UserVipIcon struct {
	BaseModel
	UserID     uuid.UUID  `gorm:"type:uuid;not null;index" json:"userId"`
	VipIconID  int16      `gorm:"not null" json:"vipIconId"`
	IsLocked   bool       `gorm:"not null;default:false" json:"isLocked"`
	Source     string     `gorm:"type:varchar(20);not null;default:'purchase'" json:"source"`
	AcquiredAt time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP" json:"acquiredAt"`
	Locked     bool       `gorm:"column:locked;not null;default:false" json:"locked"`
	ExpiresAt  *time.Time `json:"expiresAt"`
}

func (UserVipIcon) TableName() string {
	return "user_vip_icons"
}

func (i *UserVipIcon) Expired(now time.Time) bool {
	return ItemExpired(i.ExpiresAt, now)
}
