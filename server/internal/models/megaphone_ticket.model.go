package models

import (
	"time"

	"github.com/google/uuid"
)

const (
	MegaphoneTicketSourceAdmin    = "admin"
	MegaphoneTicketSourceGiftCode = "gift_code"
	MegaphoneTicketSourceCheckin  = "checkin"

	MegaphoneTicketStatusUsable  = "usable"
	MegaphoneTicketStatusUsed    = "used"
	MegaphoneTicketStatusExpired = "expired"
	MegaphoneTicketStatusRevoked = "revoked"
)

type UserMegaphoneTicket struct {
	ID          uuid.UUID  `gorm:"type:uuid;primary_key;default:gen_random_uuid()"`
	UserID      uuid.UUID  `gorm:"type:uuid;not null"`
	Source      string     `gorm:"type:varchar(20);not null"`
	SourceRef   *uuid.UUID `gorm:"type:uuid"`
	ExpiresAt   *time.Time
	UsedAt      *time.Time
	MegaphoneID *uuid.UUID `gorm:"type:uuid"`
	RevokedAt   *time.Time
	RevokedBy   *uuid.UUID `gorm:"type:uuid"`
	CreatedAt   time.Time  `gorm:"not null"`
}

func (UserMegaphoneTicket) TableName() string {
	return "user_megaphone_tickets"
}

func (t UserMegaphoneTicket) Status(now time.Time) string {
	switch {
	case t.UsedAt != nil:
		return MegaphoneTicketStatusUsed
	case t.RevokedAt != nil:
		return MegaphoneTicketStatusRevoked
	case t.ExpiresAt != nil && !t.ExpiresAt.After(now):
		return MegaphoneTicketStatusExpired
	default:
		return MegaphoneTicketStatusUsable
	}
}
