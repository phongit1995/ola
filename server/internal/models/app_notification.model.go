package models

import "github.com/google/uuid"

const (
	AppNotificationFriendRequest    = "friend_request"
	AppNotificationMarriageProposal = "marriage_proposal"
	AppNotificationClanRoleAssigned = "clan_role_assigned"
	AppNotificationClanRoleRevoked  = "clan_role_revoked"
	AppNotificationClanVerified     = "clan_verified"
	AppNotificationClanUnverified   = "clan_unverified"
	AppNotificationClanBanned       = "clan_banned"
)

type AppNotification struct {
	BaseModel
	RecipientID uuid.UUID  `gorm:"type:uuid;not null;index"`
	ActorID     *uuid.UUID `gorm:"type:uuid"`
	Type        string     `gorm:"type:varchar(30);not null"`
	RefID       *uuid.UUID `gorm:"type:uuid"`
	Preview     string     `gorm:"type:text"`
	IsRead      bool       `gorm:"not null;default:false"`
	Actor       *User      `gorm:"foreignKey:ActorID;constraint:OnDelete:CASCADE"`
}

func (AppNotification) TableName() string {
	return "app_notifications"
}
