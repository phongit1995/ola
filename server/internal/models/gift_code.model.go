package models

import (
	"database/sql/driver"
	"encoding/json"
	"errors"
	"time"

	"github.com/google/uuid"
)

const (
	GiftCodeKindShared = "shared"
	GiftCodeKindUnique = "unique"

	GiftCodeRewardVipDays     = "vip_days"
	GiftCodeRewardVipIcon     = "vip_icon"
	GiftCodeRewardAvatarFrame = "avatar_frame"
)

type GiftCodeReward struct {
	Type      string `json:"type"`
	Days      int    `json:"days,omitempty"`
	VipIconID int16  `json:"vipIconId,omitempty"`
	FrameID   string `json:"frameId,omitempty"`
}

type GiftCodeRewards []GiftCodeReward

func (r GiftCodeRewards) Value() (driver.Value, error) {
	if r == nil {
		return []byte("[]"), nil
	}
	return json.Marshal(r)
}

func (r *GiftCodeRewards) Scan(value interface{}) error {
	if value == nil {
		*r = GiftCodeRewards{}
		return nil
	}
	var raw []byte
	switch v := value.(type) {
	case []byte:
		raw = v
	case string:
		raw = []byte(v)
	default:
		return errors.New("gift code rewards: unsupported type")
	}
	return json.Unmarshal(raw, r)
}

type GiftCodeCampaign struct {
	BaseModel
	Name              string          `gorm:"type:varchar(100);not null"`
	Kind              string          `gorm:"type:varchar(10);not null"`
	CodePrefix        string          `gorm:"type:varchar(8);not null;default:''"`
	CodeLength        int16           `gorm:"not null;default:0"`
	TotalUses         int             `gorm:"not null"`
	UsedCount         int             `gorm:"not null;default:0"`
	Rewards           GiftCodeRewards `gorm:"type:jsonb;not null"`
	SuccessMessage    string          `gorm:"type:varchar(150);not null;default:''"`
	SendNotification  bool            `gorm:"not null"`
	MinAccountAgeDays int16           `gorm:"not null;default:0"`
	AllowWeb          bool            `gorm:"not null"`
	AllowAndroid      bool            `gorm:"not null"`
	AllowIOS          bool            `gorm:"column:allow_ios;not null"`
	OnePerDevice      bool            `gorm:"not null"`
	StartsAt          *time.Time
	EndsAt            time.Time  `gorm:"not null"`
	Enabled           bool       `gorm:"not null"`
	CreatedBy         *uuid.UUID `gorm:"type:uuid"`
	UpdatedBy         *uuid.UUID `gorm:"type:uuid"`
	Creator           *AdminUser `gorm:"foreignKey:CreatedBy"`
	Updater           *AdminUser `gorm:"foreignKey:UpdatedBy"`
}

func (GiftCodeCampaign) TableName() string {
	return "gift_code_campaigns"
}

type GiftCode struct {
	ID         uuid.UUID  `gorm:"type:uuid;primary_key;default:gen_random_uuid()"`
	CampaignID uuid.UUID  `gorm:"type:uuid;not null"`
	Code       string     `gorm:"type:varchar(32);not null"`
	UsedBy     *uuid.UUID `gorm:"type:uuid"`
	UsedAt     *time.Time
	LockedAt   *time.Time
	LockedBy   *uuid.UUID `gorm:"type:uuid"`
	LockReason string     `gorm:"type:varchar(200);not null;default:''"`
	CreatedAt  time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP"`
	User       *User      `gorm:"foreignKey:UsedBy"`
	Locker     *AdminUser `gorm:"foreignKey:LockedBy"`
}

func (GiftCode) TableName() string {
	return "gift_codes"
}

type GiftCodeRedemption struct {
	ID         uuid.UUID       `gorm:"type:uuid;primary_key;default:gen_random_uuid()"`
	CampaignID uuid.UUID       `gorm:"type:uuid;not null"`
	CodeID     uuid.UUID       `gorm:"type:uuid;not null"`
	UserID     uuid.UUID       `gorm:"type:uuid;not null"`
	DeviceKey  *string         `gorm:"type:varchar(128)"`
	DeviceID   string          `gorm:"type:varchar(128);not null;default:''"`
	DeviceName string          `gorm:"type:varchar(255);not null;default:''"`
	Platform   string          `gorm:"type:varchar(10);not null"`
	IPAddress  string          `gorm:"type:varchar(45);not null;default:''"`
	Rewards    GiftCodeRewards `gorm:"type:jsonb;not null"`
	CreatedAt  time.Time       `gorm:"not null;default:CURRENT_TIMESTAMP"`
	User       *User           `gorm:"foreignKey:UserID"`
	Code       *GiftCode       `gorm:"foreignKey:CodeID"`
}

func (GiftCodeRedemption) TableName() string {
	return "gift_code_redemptions"
}

type GiftCodeAttempt struct {
	ID         uuid.UUID  `gorm:"type:uuid;primary_key;default:gen_random_uuid()"`
	UserID     uuid.UUID  `gorm:"type:uuid;not null"`
	CampaignID *uuid.UUID `gorm:"type:uuid"`
	CodeInput  string     `gorm:"type:varchar(40);not null"`
	Reason     string     `gorm:"type:varchar(20);not null"`
	DeviceID   string     `gorm:"type:varchar(128);not null;default:''"`
	DeviceName string     `gorm:"type:varchar(255);not null;default:''"`
	Platform   string     `gorm:"type:varchar(10);not null"`
	IPAddress  string     `gorm:"type:varchar(45);not null;default:''"`
	CreatedAt  time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP"`
	User       *User      `gorm:"foreignKey:UserID"`
}

func (GiftCodeAttempt) TableName() string {
	return "gift_code_attempts"
}
