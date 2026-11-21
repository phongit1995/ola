package models

import (
	"database/sql/driver"
	"encoding/json"
	"errors"
	"time"

	"github.com/google/uuid"
)

const (
	CheckinRewardVipDays         = GiftCodeRewardVipDays
	CheckinRewardVipIcon         = GiftCodeRewardVipIcon
	CheckinRewardAvatarFrame     = GiftCodeRewardAvatarFrame
	CheckinRewardMegaphoneTicket = GiftCodeRewardMegaphoneTicket
	CheckinRewardKen             = "ken"

	CheckinRewardStatusNone    = "none"
	CheckinRewardStatusPending = "pending"
	CheckinRewardStatusClaimed = "claimed"

	CheckinTaskRandom = "random"
)

type CheckinReward struct {
	Type          string `json:"type"`
	Days          int    `json:"days,omitempty"`
	VipIconID     int16  `json:"vipIconId,omitempty"`
	FrameID       string `json:"frameId,omitempty"`
	Count         int    `json:"count,omitempty"`
	Amount        int    `json:"amount,omitempty"`
	AmountMin     int    `json:"amountMin,omitempty"`
	AmountMax     int    `json:"amountMax,omitempty"`
	ExpiresInDays int    `json:"expiresInDays,omitempty"`
}

func (r CheckinReward) IsRandomKen() bool {
	return r.Type == CheckinRewardKen && r.AmountMax > 0
}

type CheckinGiftOption struct {
	CheckinReward
	Weight int `json:"weight"`
}

type CheckinGift struct {
	Options []CheckinGiftOption `json:"options"`
}

type CheckinGifts []CheckinGift

func (g CheckinGifts) Value() (driver.Value, error) {
	if g == nil {
		return []byte("[]"), nil
	}
	return json.Marshal(g)
}

func (g *CheckinGifts) Scan(value interface{}) error {
	*g = CheckinGifts{}
	return scanCheckinJSON(value, g)
}

type CheckinSnapshot struct {
	Gifts      CheckinGifts `json:"gifts"`
	Featured   bool         `json:"featured"`
	RequireVip bool         `json:"requireVip"`
}

func (s CheckinSnapshot) Value() (driver.Value, error) {
	return json.Marshal(s)
}

func (s *CheckinSnapshot) Scan(value interface{}) error {
	*s = CheckinSnapshot{}
	return scanCheckinJSON(value, s)
}

type CheckinResultItem struct {
	Gift   int `json:"gift"`
	Option int `json:"option"`
	CheckinReward
}

type CheckinResult struct {
	Items []CheckinResultItem `json:"items"`
}

func (r CheckinResult) Value() (driver.Value, error) {
	return json.Marshal(r)
}

func (r *CheckinResult) Scan(value interface{}) error {
	*r = CheckinResult{}
	return scanCheckinJSON(value, r)
}

func scanCheckinJSON(value interface{}, out interface{}) error {
	switch v := value.(type) {
	case nil:
		return nil
	case []byte:
		return json.Unmarshal(v, out)
	case string:
		return json.Unmarshal([]byte(v), out)
	default:
		return errors.New("checkin json: unsupported type")
	}
}

type CheckinMonth struct {
	Month       time.Time `gorm:"type:date;primaryKey"`
	SlotCount   int16     `gorm:"not null"`
	PublishedAt *time.Time
	CreatedAt   time.Time `gorm:"not null"`
	UpdatedAt   time.Time `gorm:"not null"`
}

func (CheckinMonth) TableName() string {
	return "checkin_months"
}

type CheckinSlot struct {
	Month      time.Time    `gorm:"type:date;primaryKey"`
	Slot       int16        `gorm:"primaryKey"`
	Gifts      CheckinGifts `gorm:"type:jsonb;not null"`
	Featured   bool         `gorm:"not null"`
	RequireVip bool         `gorm:"not null"`
	Task       *string      `gorm:"type:varchar(32)"`
	UpdatedAt  time.Time    `gorm:"not null"`
}

func (CheckinSlot) TableName() string {
	return "checkin_slots"
}

type UserCheckin struct {
	ID              uuid.UUID       `gorm:"type:uuid;primaryKey;default:gen_random_uuid()"`
	UserID          uuid.UUID       `gorm:"type:uuid;not null"`
	Day             time.Time       `gorm:"type:date;not null"`
	Month           time.Time       `gorm:"type:date;not null"`
	Slot            int16           `gorm:"not null"`
	Task            *string         `gorm:"type:varchar(32)"`
	RewardStatus    string          `gorm:"type:varchar(12);not null"`
	RewardSnapshot  CheckinSnapshot `gorm:"type:jsonb;not null"`
	RewardResult    *CheckinResult  `gorm:"type:jsonb"`
	VipAtCheckin    bool            `gorm:"not null"`
	ClientRequestID string          `gorm:"type:varchar(64);not null"`
	TaskDoneAt      *time.Time
	ClaimedAt       *time.Time
	CreatedAt       time.Time `gorm:"not null"`
}

func (UserCheckin) TableName() string {
	return "user_checkins"
}
