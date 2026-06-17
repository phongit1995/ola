package models

import (
	"time"

	"github.com/google/uuid"
)

type UserSession struct {
	BaseModel
	UserID       uuid.UUID  `gorm:"type:uuid;not null;index" json:"userId"`
	RefreshToken string     `gorm:"type:text;not null" json:"-"`
	DeviceName   string     `gorm:"type:varchar(255)" json:"deviceName"`
	Platform     string     `gorm:"type:varchar(20)" json:"platform"`
	DeviceID     string     `gorm:"type:varchar(128)" json:"deviceId"`
	AppVersion   string     `gorm:"type:varchar(40)" json:"appVersion"`
	UserAgent    string     `gorm:"type:text" json:"userAgent"`
	IPAddress    string     `gorm:"type:varchar(45)" json:"ipAddress"`
	LastActiveAt time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP" json:"lastActiveAt"`
	RevokedAt    *time.Time `json:"revokedAt,omitempty"`
}
