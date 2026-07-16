package models

import "github.com/google/uuid"

type ClanRole string

const (
	ClanRoleOwner      ClanRole = "owner"
	ClanRoleDeputy     ClanRole = "deputy"
	ClanRoleAmbassador ClanRole = "ambassador"
	ClanRoleMember     ClanRole = "member"
)

type ClanMember struct {
	BaseModel
	ClanID   uuid.UUID `gorm:"type:uuid;not null;index"`
	UserID   uuid.UUID `gorm:"type:uuid;not null;index"`
	Role     ClanRole  `gorm:"type:varchar(12);not null;default:'member'"`
	Verified bool      `gorm:"not null;default:false"`
	User     *User     `gorm:"foreignKey:UserID;constraint:OnDelete:CASCADE"`
}

func (ClanMember) TableName() string {
	return "clan_members"
}
