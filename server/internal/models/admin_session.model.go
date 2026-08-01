package models

import (
	"time"

	"github.com/google/uuid"
)

type AdminSession struct {
	BaseModel
	AdminID                  uuid.UUID  `gorm:"type:uuid;not null;index" json:"adminId"`
	RefreshTokenHash         string     `gorm:"type:char(64);not null" json:"-"`
	PreviousRefreshTokenHash *string    `gorm:"type:char(64)" json:"-"`
	LastRotatedAt            *time.Time `json:"-"`
	// RefreshRetryResponse is an AES-GCM ciphertext, never a plaintext token pair.
	RefreshRetryResponse []byte     `gorm:"type:bytea" json:"-"`
	UserAgent            string     `gorm:"type:text" json:"userAgent"`
	IPAddress            string     `gorm:"type:varchar(45)" json:"ipAddress"`
	LastActiveAt         time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP" json:"lastActiveAt"`
	ExpiresAt            time.Time  `gorm:"not null;index" json:"expiresAt"`
	RevokedAt            *time.Time `json:"revokedAt,omitempty"`
}

func (AdminSession) TableName() string {
	return "admin_sessions"
}
