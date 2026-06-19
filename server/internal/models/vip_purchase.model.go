package models

import (
	"time"

	"github.com/google/uuid"
)

type VipPurchase struct {
	BaseModel
	UserID          uuid.UUID  `gorm:"type:uuid;not null;index"`
	PackageID       *uuid.UUID `gorm:"type:uuid"`
	PackageName     string     `gorm:"type:varchar(100);not null"`
	Days            int        `gorm:"not null"`
	KenPrice        int        `gorm:"not null"`
	KenBalanceAfter int        `gorm:"not null"`
	VipEndTimeAfter time.Time  `gorm:"not null"`
	Source          string     `gorm:"type:varchar(20);not null;default:'package'"`
}

func (VipPurchase) TableName() string {
	return "vip_purchases"
}
