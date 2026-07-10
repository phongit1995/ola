package models

import (
	"github.com/google/uuid"
)

type VipTransfer struct {
	BaseModel
	FromUserID uuid.UUID `gorm:"type:uuid;not null;index"`
	ToUserID   uuid.UUID `gorm:"type:uuid;not null;index"`
	VipIconID  int16     `gorm:"not null"`
	InstanceID uuid.UUID `gorm:"type:uuid;not null"`
}

func (VipTransfer) TableName() string {
	return "vip_transfers"
}
