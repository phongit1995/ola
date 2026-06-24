package models

import (
	"time"

	"github.com/google/uuid"
)

type PenSide string

const (
	PenSideLeft  PenSide = "left"
	PenSideRight PenSide = "right"
)

type PenStatus string

const (
	PenStatusOpen      PenStatus = "open"
	PenStatusSettled   PenStatus = "settled"
	PenStatusCancelled PenStatus = "cancelled"
)

type PenResult string

const (
	PenResultSaved PenResult = "saved"
	PenResultGoal  PenResult = "goal"
)

type PenShot struct {
	BaseModel
	ShooterID   uuid.UUID  `gorm:"type:uuid;not null;index"`
	ShooterSide PenSide    `gorm:"type:varchar(8);not null"`
	BetAmount   int        `gorm:"not null"`
	Status      PenStatus  `gorm:"type:varchar(16);not null;default:'open'"`
	KeeperID    *uuid.UUID `gorm:"type:uuid"`
	KeeperSide  *PenSide   `gorm:"type:varchar(8)"`
	Result      *PenResult `gorm:"type:varchar(16)"`
	WinnerID    *uuid.UUID `gorm:"type:uuid"`
	Pot         *int
	Commission  *int
	Payout      *int
	ShootTxID   *uuid.UUID `gorm:"type:uuid"`
	CatchTxID   *uuid.UUID `gorm:"type:uuid"`
	PayoutTxID  *uuid.UUID `gorm:"type:uuid"`
	RefundTxID  *uuid.UUID `gorm:"type:uuid"`
	SettledAt   *time.Time
	CancelledAt *time.Time
	Shooter     *User `gorm:"foreignKey:ShooterID"`
	Keeper      *User `gorm:"foreignKey:KeeperID"`
}

func (PenShot) TableName() string {
	return "pen_shots"
}
