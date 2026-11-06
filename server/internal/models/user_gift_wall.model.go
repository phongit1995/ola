package models

import (
	"time"

	"github.com/google/uuid"
)

type UserGiftWall struct {
	ReceiverID     uuid.UUID `gorm:"type:uuid;primaryKey"`
	GiftID         uuid.UUID `gorm:"type:uuid;primaryKey"`
	Quantity       int       `gorm:"not null;default:0"`
	LastReceivedAt time.Time `gorm:"not null"`
}

func (UserGiftWall) TableName() string {
	return "user_gift_wall"
}
