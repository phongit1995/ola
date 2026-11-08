package models

import (
	"encoding/json"
	"fmt"
	"strconv"

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
	AppNotificationAvatarFrame      = "avatar_frame_received"
	AppNotificationGiftCode         = "gift_code"
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
	Amount    int    `json:"amount,omitempty"`
	VipTypeID int16  `json:"vipTypeId,omitempty"`
	Days      int    `json:"days,omitempty"`
	FrameID   string `json:"frameId,omitempty"`
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

func IsAppNotificationTransfer(ntype string) bool {
	return ntype == AppNotificationKenReceived || ntype == AppNotificationVipReceived || ntype == AppNotificationAvatarFrame
}

func (t AppNotificationTransfer) Message(ntype string) string {
	if ntype == AppNotificationKenReceived {
		if t.Amount > 0 {
			return "Đã chuyển cho bạn " + groupThousands(t.Amount) + " Ken"
		}
		return "Đã chuyển Ken cho bạn"
	}
	if ntype == AppNotificationAvatarFrame {
		if t.FrameID != "" {
			return "Đã tặng bạn khung avatar #" + t.FrameID
		}
		return "Đã tặng bạn khung avatar"
	}
	if t.Days > 0 {
		return fmt.Sprintf("Đã tặng bạn %d ngày VIP", t.Days)
	}
	return "Đã tặng bạn VIP"
}

func groupThousands(n int) string {
	digits := strconv.Itoa(n)
	for i := len(digits) - 3; i > 0; i -= 3 {
		digits = digits[:i] + "," + digits[i:]
	}
	return digits
}
