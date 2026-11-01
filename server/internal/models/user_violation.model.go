package models

import (
	"time"

	"github.com/google/uuid"
)

type UserViolation struct {
	ID             uuid.UUID  `gorm:"type:uuid;primaryKey;default:gen_random_uuid()"`
	UserID         uuid.UUID  `gorm:"type:uuid;not null"`
	Source         string     `gorm:"type:varchar(20);not null"`
	TargetType     string     `gorm:"type:varchar(20);not null"`
	TargetID       string     `gorm:"type:varchar(64);not null"`
	ReportID       *uuid.UUID `gorm:"type:uuid"`
	Reason         string     `gorm:"type:varchar(20);not null"`
	Severity       string     `gorm:"type:varchar(20);not null"`
	Points         int        `gorm:"type:smallint;not null;default:0"`
	ContentRemoved bool       `gorm:"not null;default:false"`
	Note           string     `gorm:"type:text;not null;default:''"`
	AdminID        *uuid.UUID `gorm:"type:uuid"`
	RevokedAt      *time.Time
	RevokedBy      *uuid.UUID `gorm:"type:uuid"`
	CreatedAt      time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP"`
	Admin          *AdminUser `gorm:"foreignKey:AdminID"`
	Revoker        *AdminUser `gorm:"foreignKey:RevokedBy"`
}

func (UserViolation) TableName() string {
	return "user_violations"
}
