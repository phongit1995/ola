package models

import (
	"time"

	"github.com/google/uuid"
)

type UsernameChangeLog struct {
	ID          uuid.UUID  `gorm:"type:uuid;primary_key;default:gen_random_uuid()"`
	UserID      uuid.UUID  `gorm:"type:uuid;not null;index"`
	OldUsername string     `gorm:"type:varchar(50);not null"`
	NewUsername string     `gorm:"type:varchar(50);not null"`
	Cost        int        `gorm:"not null;default:0"`
	ActorType   string     `gorm:"type:varchar(10);not null;default:'user'"`
	ActorID     *uuid.UUID `gorm:"type:uuid"`
	CreatedAt   time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP;index"`
}

func (UsernameChangeLog) TableName() string {
	return "username_change_logs"
}
