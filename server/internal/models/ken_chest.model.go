package models

import (
	"time"

	"github.com/google/uuid"
)

type KenChestRewardMode string

const (
	KenChestRewardFixed  KenChestRewardMode = "fixed"
	KenChestRewardRandom KenChestRewardMode = "random"
)

type KenChestStatus string

const (
	KenChestStatusActive  KenChestStatus = "active"
	KenChestStatusExpired KenChestStatus = "expired"
	KenChestStatusDeleted KenChestStatus = "deleted"
)

type KenChest struct {
	BaseModel
	RewardMode        KenChestRewardMode `gorm:"type:varchar(10);not null" json:"rewardMode"`
	KenAmount         *int               `gorm:"column:ken_amount" json:"kenAmount,omitempty"`
	KenMin            *int               `gorm:"column:ken_min" json:"kenMin,omitempty"`
	KenMax            *int               `gorm:"column:ken_max" json:"kenMax,omitempty"`
	MaxRecipients     int                `gorm:"not null" json:"maxRecipients"`
	ClaimedRecipients int                `gorm:"not null;default:0" json:"claimedRecipients"`
	DurationSeconds   int                `gorm:"not null;default:90" json:"durationSeconds"`
	Status            KenChestStatus     `gorm:"type:varchar(12);not null;default:active" json:"status"`
	StartedAt         time.Time          `gorm:"not null;default:CURRENT_TIMESTAMP" json:"startedAt"`
	ExpiresAt         time.Time          `gorm:"not null" json:"expiresAt"`
	CreatedBy         *uuid.UUID         `gorm:"type:uuid" json:"createdBy,omitempty"`
	ClaimsCount       int                `gorm:"not null;default:0" json:"claimsCount"`
	TotalKenGiven     int64              `gorm:"not null;default:0" json:"totalKenGiven"`
}

func (KenChest) TableName() string {
	return "ken_chests"
}

type KenChestClaim struct {
	ID        uuid.UUID  `gorm:"type:uuid;primary_key;default:gen_random_uuid()" json:"id"`
	ChestID   uuid.UUID  `gorm:"type:uuid;not null;index" json:"chestId"`
	UserID    uuid.UUID  `gorm:"type:uuid;not null;index" json:"userId"`
	KenAmount int        `gorm:"not null;default:0" json:"kenAmount"`
	IsEmpty   bool       `gorm:"not null;default:false" json:"isEmpty"`
	KenTxID   *uuid.UUID `gorm:"column:ken_tx_id" json:"kenTxId,omitempty"`
	CreatedAt time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP" json:"createdAt"`
}

func (KenChestClaim) TableName() string {
	return "ken_chest_claims"
}
