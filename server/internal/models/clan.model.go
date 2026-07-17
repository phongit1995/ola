package models

import "github.com/google/uuid"

type ClanPolicy int16

const (
	ClanPolicyFreePost            ClanPolicy = 0
	ClanPolicyFreeJoin            ClanPolicy = 1
	ClanPolicyVerifiedPost        ClanPolicy = 2
	ClanPolicyClosed              ClanPolicy = 3
	ClanPolicyVerifiedViewAndPost ClanPolicy = 4
)

func (p ClanPolicy) Valid() bool {
	return p >= ClanPolicyFreePost && p <= ClanPolicyVerifiedViewAndPost
}

type Clan struct {
	BaseModel
	Handle           string     `gorm:"type:varchar(32);not null"`
	OwnerID          uuid.UUID  `gorm:"type:uuid;not null;index"`
	Description      string     `gorm:"type:text"`
	Avatar           string     `gorm:"type:varchar(500);not null;default:''"`
	Cover            string     `gorm:"type:varchar(500);not null;default:''"`
	Policy           ClanPolicy `gorm:"type:smallint;not null;default:0"`
	MemberPublicPost bool       `gorm:"not null;default:false"`
	MemberCount      int        `gorm:"not null;default:1"`
	VisitCount       int64      `gorm:"not null;default:0"`
	MeTopPostID      *uuid.UUID `gorm:"type:uuid"`
	RoomID           *uuid.UUID `gorm:"type:uuid"`
	Owner            *User      `gorm:"foreignKey:OwnerID;constraint:OnDelete:CASCADE"`
}

func (Clan) TableName() string {
	return "clans"
}
