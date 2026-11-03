package models

import (
	"time"

	"github.com/google/uuid"
)

const (
	GiftSourceChat    = "chat"
	GiftSourceProfile = "profile"
)

type GiftTransaction struct {
	ID              uuid.UUID  `gorm:"type:uuid;primary_key;default:gen_random_uuid()"`
	SenderID        uuid.UUID  `gorm:"type:uuid;not null"`
	ReceiverID      uuid.UUID  `gorm:"type:uuid;not null"`
	GiftID          uuid.UUID  `gorm:"type:uuid;not null"`
	GiftName        string     `gorm:"type:varchar(60);not null"`
	GiftImageURL    string     `gorm:"type:varchar(500);not null"`
	Quantity        int        `gorm:"not null"`
	UnitPrice       int        `gorm:"not null"`
	TotalKen        int        `gorm:"not null"`
	CharmPoints     int        `gorm:"not null"`
	Source          string     `gorm:"type:varchar(20);not null"`
	ConversationID  *uuid.UUID `gorm:"type:uuid"`
	MessageID       string     `gorm:"type:varchar(64);not null;default:''"`
	Note            string     `gorm:"type:varchar(100);not null;default:''"`
	ClientRequestID string     `gorm:"type:varchar(64);not null"`
	CreatedAt       time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP"`
}

func (GiftTransaction) TableName() string {
	return "gift_transactions"
}
