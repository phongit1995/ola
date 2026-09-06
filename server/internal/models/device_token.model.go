package models

import (
	"time"

	"github.com/google/uuid"
)

type DeviceToken struct {
	ID        uuid.UUID `gorm:"type:uuid;primaryKey;default:gen_random_uuid()" json:"id"`
	UserID    uuid.UUID `gorm:"type:uuid;not null" json:"userId"`
	SessionID uuid.UUID `gorm:"type:uuid;not null;index" json:"sessionId"`
	DeviceID  string    `gorm:"type:varchar(128);not null" json:"deviceId"`
	Platform  string    `gorm:"type:varchar(20);not null" json:"platform"`
	Token     string    `gorm:"type:text;not null" json:"-"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`
}
