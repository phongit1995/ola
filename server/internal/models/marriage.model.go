package models

import (
	"time"

	"github.com/google/uuid"
)

const (
	MarriageProposalPending   = "pending"
	MarriageProposalAccepted  = "accepted"
	MarriageProposalRejected  = "rejected"
	MarriageProposalCancelled = "cancelled"
)

type MarriageProposal struct {
	BaseModel
	ProposerID  uuid.UUID `gorm:"type:uuid;not null;index"`
	AddresseeID uuid.UUID `gorm:"type:uuid;not null;index"`
	Message     string    `gorm:"type:varchar(500)"`
	Status      string    `gorm:"type:varchar(20);not null;default:'pending'"`
	RespondedAt *time.Time

	Proposer  *User `gorm:"foreignKey:ProposerID;constraint:OnDelete:CASCADE"`
	Addressee *User `gorm:"foreignKey:AddresseeID;constraint:OnDelete:CASCADE"`
}

func (MarriageProposal) TableName() string {
	return "marriage_proposals"
}

const (
	MarriageStatusActive   = "active"
	MarriageStatusDivorced = "divorced"
)

type Marriage struct {
	BaseModel
	UserLowID  uuid.UUID  `gorm:"type:uuid;not null;index"`
	UserHighID uuid.UUID  `gorm:"type:uuid;not null;index"`
	Status     string     `gorm:"type:varchar(20);not null;default:'active'"`
	ProposalID *uuid.UUID `gorm:"type:uuid"`
	MarriedAt  time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP"`
	DivorcedAt *time.Time
	DivorcedBy *uuid.UUID `gorm:"type:uuid"`
}

func (Marriage) TableName() string {
	return "marriages"
}
