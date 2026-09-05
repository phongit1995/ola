package models

import (
	"time"

	"github.com/google/uuid"
)

type RoomUserBlock struct {
	UserID        uuid.UUID `gorm:"type:uuid;primaryKey" json:"userId"`
	BlockedUserID uuid.UUID `gorm:"type:uuid;primaryKey" json:"blockedUserId"`
	CreatedAt     time.Time `json:"createdAt"`
}

func (RoomUserBlock) TableName() string {
	return "room_user_blocks"
}
