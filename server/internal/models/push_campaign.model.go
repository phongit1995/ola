package models

import (
	"time"

	"github.com/google/uuid"
)

type PushCampaign struct {
	BaseModel
	CreatedBy    *uuid.UUID `gorm:"type:uuid"`
	Audience     string     `gorm:"type:varchar(20);not null"`
	TargetUserID *uuid.UUID `gorm:"type:uuid"`
	Title        string     `gorm:"type:varchar(100);not null"`
	Body         string     `gorm:"type:varchar(500);not null"`
	Status       string     `gorm:"type:varchar(20);not null;default:'queued'"`
	TotalDevices int        `gorm:"not null;default:0"`
	SuccessCount int        `gorm:"not null;default:0"`
	FailureCount int        `gorm:"not null;default:0"`
	Error        string     `gorm:"type:text;not null;default:''"`
	StartedAt    *time.Time
	FinishedAt   *time.Time
	Creator      *AdminUser `gorm:"foreignKey:CreatedBy"`
	TargetUser   *User      `gorm:"foreignKey:TargetUserID"`
}

func (PushCampaign) TableName() string {
	return "push_campaigns"
}
