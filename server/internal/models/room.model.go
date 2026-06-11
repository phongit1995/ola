package models

import (
	"time"

	"github.com/google/uuid"
)

type Room struct {
	BaseModel
	Name        string    `gorm:"type:varchar(150);not null"`
	Description string    `gorm:"type:text"`
	ImageURL    string    `gorm:"type:varchar(500)"`
	MaxMembers  int       `gorm:"not null;default:0"`
	MemberCount int       `gorm:"not null;default:0"`
	Enabled     bool      `gorm:"not null;default:true"`
	CreatedBy   uuid.UUID `gorm:"type:uuid;not null"`
}

func (Room) TableName() string {
	return "rooms"
}

type RoomMember struct {
	RoomID   uuid.UUID `gorm:"type:uuid;primaryKey"`
	UserID   uuid.UUID `gorm:"type:uuid;primaryKey"`
	JoinedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP"`
}

func (RoomMember) TableName() string {
	return "room_members"
}
