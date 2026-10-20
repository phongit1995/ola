package models

import (
	"time"

	"github.com/google/uuid"
)

type Report struct {
	BaseModel
	ReporterID     uuid.UUID  `gorm:"type:uuid;not null"`
	TargetType     string     `gorm:"type:varchar(20);not null"`
	TargetID       string     `gorm:"type:varchar(64);not null"`
	ContextID      *string    `gorm:"type:varchar(64)"`
	ReportedUserID *uuid.UUID `gorm:"type:uuid"`
	Reason         string     `gorm:"type:varchar(20);not null"`
	Note           string     `gorm:"type:text;not null;default:''"`
	Snapshot       JSONB      `gorm:"type:jsonb"`
	Status         string     `gorm:"type:varchar(20);not null;default:'pending'"`
	HandledBy      *uuid.UUID `gorm:"type:uuid"`
	HandledAt      *time.Time
	HandlerNote    string     `gorm:"type:text;not null;default:''"`
	Reporter       *User      `gorm:"foreignKey:ReporterID"`
	ReportedUser   *User      `gorm:"foreignKey:ReportedUserID"`
	Handler        *AdminUser `gorm:"foreignKey:HandledBy"`
}

func (Report) TableName() string {
	return "reports"
}
