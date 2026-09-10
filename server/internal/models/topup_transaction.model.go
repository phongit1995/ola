package models

import (
	"time"

	"github.com/google/uuid"
)

type TopupTxStatus string

const (
	TopupTxStatusProcessing      TopupTxStatus = "PROCESSING"
	TopupTxStatusCredited        TopupTxStatus = "CREDITED"
	TopupTxStatusNoMatch         TopupTxStatus = "NO_MATCH"
	TopupTxStatusBelowMin        TopupTxStatus = "BELOW_MIN"
	TopupTxStatusSkippedOut      TopupTxStatus = "SKIPPED_OUT"
	TopupTxStatusSkippedDisabled TopupTxStatus = "SKIPPED_DISABLED"
	TopupTxStatusFailed          TopupTxStatus = "FAILED"
)

type TopupTransaction struct {
	ID              uuid.UUID     `gorm:"type:uuid;primary_key;default:gen_random_uuid()"`
	ProviderTxID    string        `gorm:"type:varchar(120);not null;uniqueIndex"`
	Description     string        `gorm:"type:varchar(500);not null;default:''"`
	Amount          int64         `gorm:"not null"`
	Type            string        `gorm:"type:varchar(10);not null"`
	Status          TopupTxStatus `gorm:"type:varchar(30);not null"`
	MatchedUsername *string       `gorm:"type:varchar(50)"`
	UserID          *uuid.UUID    `gorm:"type:uuid"`
	KenAmount       int64         `gorm:"not null;default:0"`
	BonusKen        int64         `gorm:"not null;default:0"`
	BonusPercent    int           `gorm:"not null;default:0"`
	KenTxID         *uuid.UUID    `gorm:"type:uuid"`
	Note            *string       `gorm:"type:varchar(255)"`
	Raw             JSONB         `gorm:"type:jsonb"`
	CreatedAt       time.Time     `gorm:"not null;default:CURRENT_TIMESTAMP"`
	UpdatedAt       time.Time     `gorm:"not null;default:CURRENT_TIMESTAMP"`
}

func (TopupTransaction) TableName() string {
	return "topup_transactions"
}
