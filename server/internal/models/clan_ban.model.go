package models

import "github.com/google/uuid"

type ClanBan struct {
	BaseModel
	ClanID   uuid.UUID `gorm:"type:uuid;not null;index"`
	UserID   uuid.UUID `gorm:"type:uuid;not null;index"`
	BannedBy uuid.UUID `gorm:"type:uuid;not null"`
	User     *User     `gorm:"foreignKey:UserID;constraint:OnDelete:CASCADE"`
}

func (ClanBan) TableName() string {
	return "clan_bans"
}
