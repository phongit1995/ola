package models

import (
	"time"

	"github.com/google/uuid"
)

type AdminAuditLog struct {
	ID        uuid.UUID `gorm:"type:uuid;primary_key;default:gen_random_uuid()"`
	AdminID   uuid.UUID `gorm:"type:uuid;not null;index"`
	Method    string    `gorm:"type:varchar(10);not null"`
	Resource  string    `gorm:"type:varchar(60);not null"`
	Path      string    `gorm:"type:varchar(300);not null"`
	Route     string    `gorm:"type:varchar(300)"`
	Status    int       `gorm:"not null"`
	IP        string    `gorm:"type:varchar(45)"`
	Detail    JSONB     `gorm:"type:jsonb"`
	CreatedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP;index"`
}

func (AdminAuditLog) TableName() string {
	return "admin_audit_logs"
}
