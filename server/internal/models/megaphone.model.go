package models

import (
	"time"

	"github.com/google/uuid"
)

const (
	MegaphoneStatusActive  = "active"
	MegaphoneStatusRemoved = "removed"

	MegaphoneTypeMessage = "message"
	MegaphoneTypeGift    = "gift"
	MegaphoneTypeLucky   = "lucky"
)

type Megaphone struct {
	ID                uuid.UUID `gorm:"type:uuid;primary_key;default:gen_random_uuid()"`
	SenderID          uuid.UUID `gorm:"type:uuid;not null"`
	Type              string    `gorm:"type:varchar(20);not null"`
	Content           string    `gorm:"type:varchar(200);not null"`
	KenPrice          int       `gorm:"not null"`
	Weight            int       `gorm:"type:smallint;not null"`
	ShowAt            time.Time `gorm:"not null"`
	DisplaySeconds    int       `gorm:"not null"`
	ExpiresAt         time.Time `gorm:"not null"`
	FirstPlayedAt     *time.Time
	Status            string     `gorm:"type:varchar(20);not null"`
	RemovedBy         *uuid.UUID `gorm:"type:uuid"`
	RemovedReason     string     `gorm:"type:varchar(200);not null;default:''"`
	RemovedAt         *time.Time
	ClientRequestID   string     `gorm:"type:varchar(64);not null"`
	GiftTransactionID *uuid.UUID `gorm:"type:uuid"`
	LuckyReward       JSONB      `gorm:"type:jsonb"`
	CreatedAt         time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP"`
}

func (Megaphone) TableName() string {
	return "megaphones"
}
