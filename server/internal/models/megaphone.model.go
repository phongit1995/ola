package models

import (
	"time"

	"github.com/google/uuid"
)

const (
	MegaphoneStatusActive  = "active"
	MegaphoneStatusRemoved = "removed"
)

type Megaphone struct {
	ID              uuid.UUID  `gorm:"type:uuid;primary_key;default:gen_random_uuid()"`
	SenderID        uuid.UUID  `gorm:"type:uuid;not null"`
	Content         string     `gorm:"type:varchar(200);not null"`
	KenPrice        int        `gorm:"not null"`
	ShowAt          time.Time  `gorm:"not null"`
	DisplaySeconds  int        `gorm:"not null"`
	Status          string     `gorm:"type:varchar(20);not null"`
	RemovedBy       *uuid.UUID `gorm:"type:uuid"`
	RemovedReason   string     `gorm:"type:varchar(200);not null;default:''"`
	RemovedAt       *time.Time
	ClientRequestID string    `gorm:"type:varchar(64);not null"`
	CreatedAt       time.Time `gorm:"not null;default:CURRENT_TIMESTAMP"`
}

func (Megaphone) TableName() string {
	return "megaphones"
}

func (m *Megaphone) EndsAt() time.Time {
	return m.ShowAt.Add(time.Duration(m.DisplaySeconds) * time.Second)
}
