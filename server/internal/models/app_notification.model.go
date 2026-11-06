package models

import (
	"encoding/json"

	"github.com/google/uuid"
)

const (
	AppNotificationFriendRequest    = "friend_request"
	AppNotificationMarriageProposal = "marriage_proposal"
	AppNotificationClanRoleAssigned = "clan_role_assigned"
	AppNotificationClanRoleRevoked  = "clan_role_revoked"
	AppNotificationClanVerified     = "clan_verified"
	AppNotificationClanUnverified   = "clan_unverified"
	AppNotificationClanBanned       = "clan_banned"
	AppNotificationContentViolation = "content_violation"
	AppNotificationReportResolved   = "report_resolved"
	AppNotificationGiftReceived     = "gift_received"
	AppNotificationKenReceived      = "ken_received"
	AppNotificationVipReceived      = "vip_received"
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

type AppNotificationTransfer struct {
	Amount    int   `json:"amount,omitempty"`
	VipTypeID int16 `json:"vipTypeId,omitempty"`
	Days      int   `json:"days,omitempty"`
}

func (t AppNotificationTransfer) Preview() string {
	raw, err := json.Marshal(t)
	if err != nil {
		return ""
	}
	return string(raw)
}

func ParseAppNotificationTransfer(preview string) (AppNotificationTransfer, bool) {
	var t AppNotificationTransfer
	if preview == "" || json.Unmarshal([]byte(preview), &t) != nil {
		return AppNotificationTransfer{}, false
	}
	return t, true
}
