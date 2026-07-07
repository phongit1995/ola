package models

import (
	"time"

	"github.com/google/uuid"
)

type WheelSegmentKind string

const (
	WheelSegmentMiss      WheelSegmentKind = "miss"
	WheelSegmentKenFixed  WheelSegmentKind = "ken_fixed"
	WheelSegmentKenRandom WheelSegmentKind = "ken_random"
	WheelSegmentVipDays   WheelSegmentKind = "vip_days"
	WheelSegmentVipItem   WheelSegmentKind = "vip_item"
	WheelSegmentVipRandom WheelSegmentKind = "vip_random"
)

type Wheel struct {
	BaseModel
	Name             string `gorm:"type:varchar(100);not null" json:"name"`
	KenCost          int    `gorm:"not null;default:0" json:"kenCost"`
	FreeDailyEnabled bool   `gorm:"not null;default:false" json:"freeDailyEnabled"`
	IsEnabled        bool   `gorm:"not null;default:true" json:"isEnabled"`
	SortOrder        int    `gorm:"not null;default:0" json:"sortOrder"`
}

func (Wheel) TableName() string {
	return "wheels"
}

type WheelSegment struct {
	ID           uuid.UUID        `gorm:"type:uuid;primary_key;default:gen_random_uuid()" json:"id"`
	WheelID      uuid.UUID        `gorm:"type:uuid;not null;index" json:"wheelId"`
	Kind         WheelSegmentKind `gorm:"type:varchar(20);not null" json:"kind"`
	Label        string           `gorm:"type:varchar(100);not null" json:"label"`
	Color        string           `gorm:"type:varchar(9);not null;default:''" json:"color"`
	Weight       float64          `gorm:"type:numeric(10,4);not null;default:0" json:"weight"`
	KenAmount    *int             `gorm:"column:ken_amount" json:"kenAmount,omitempty"`
	KenMin       *int             `gorm:"column:ken_min" json:"kenMin,omitempty"`
	KenMax       *int             `gorm:"column:ken_max" json:"kenMax,omitempty"`
	VipDays      *int             `gorm:"column:vip_days" json:"vipDays,omitempty"`
	VipTypeID    *int16           `gorm:"column:vip_type_id" json:"vipTypeId,omitempty"`
	IsSuperLucky bool             `gorm:"not null;default:false" json:"isSuperLucky"`
	IsActive     bool             `gorm:"not null;default:true" json:"isActive"`
	SortOrder    int              `gorm:"not null;default:0" json:"sortOrder"`
	CreatedAt    time.Time        `gorm:"not null;default:CURRENT_TIMESTAMP" json:"createdAt"`
	UpdatedAt    time.Time        `gorm:"not null;default:CURRENT_TIMESTAMP" json:"updatedAt"`
}

func (WheelSegment) TableName() string {
	return "wheel_segments"
}

type WheelSegmentOption struct {
	ID        uuid.UUID `gorm:"type:uuid;primary_key;default:gen_random_uuid()" json:"id"`
	SegmentID uuid.UUID `gorm:"type:uuid;not null;index" json:"segmentId"`
	Label     string    `gorm:"type:varchar(100);not null" json:"label"`
	Weight    float64   `gorm:"type:numeric(10,4);not null;default:0" json:"weight"`
	VipTypeID *int16    `gorm:"column:vip_type_id" json:"vipTypeId,omitempty"`
	VipDays   *int      `gorm:"column:vip_days" json:"vipDays,omitempty"`
	KenAmount *int      `gorm:"column:ken_amount" json:"kenAmount,omitempty"`
	IsActive  bool      `gorm:"not null;default:true" json:"isActive"`
	SortOrder int       `gorm:"not null;default:0" json:"sortOrder"`
	CreatedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP" json:"createdAt"`
	UpdatedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP" json:"updatedAt"`
}

func (WheelSegmentOption) TableName() string {
	return "wheel_segment_options"
}

type WheelSpin struct {
	ID           uuid.UUID        `gorm:"type:uuid;primary_key;default:gen_random_uuid()" json:"id"`
	UserID       uuid.UUID        `gorm:"type:uuid;not null;index" json:"userId"`
	WheelID      uuid.UUID        `gorm:"type:uuid;not null" json:"wheelId"`
	WheelName    string           `gorm:"type:varchar(100);not null" json:"wheelName"`
	KenCost      int              `gorm:"not null;default:0" json:"kenCost"`
	IsFree       bool             `gorm:"not null;default:false" json:"isFree"`
	SegmentID    *uuid.UUID       `gorm:"column:segment_id" json:"segmentId,omitempty"`
	SegmentKind  WheelSegmentKind `gorm:"type:varchar(20);not null" json:"segmentKind"`
	RewardLabel  *string          `gorm:"type:varchar(100)" json:"rewardLabel,omitempty"`
	KenAmount    *int             `gorm:"column:ken_amount" json:"kenAmount,omitempty"`
	VipDays      *int             `gorm:"column:vip_days" json:"vipDays,omitempty"`
	VipTypeID    *int16           `gorm:"column:vip_type_id" json:"vipTypeId,omitempty"`
	IsSuperLucky bool             `gorm:"not null;default:false" json:"isSuperLucky"`
	Metadata     JSONB            `gorm:"type:jsonb" json:"metadata,omitempty"`
	CreatedAt    time.Time        `gorm:"not null;default:CURRENT_TIMESTAMP" json:"createdAt"`
}

func (WheelSpin) TableName() string {
	return "wheel_spins"
}

type WheelFreeClaim struct {
	UserID    uuid.UUID `gorm:"type:uuid;primary_key" json:"userId"`
	WheelID   uuid.UUID `gorm:"type:uuid;primary_key" json:"wheelId"`
	ClaimDate time.Time `gorm:"type:date;primary_key" json:"claimDate"`
	CreatedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP" json:"createdAt"`
}

func (WheelFreeClaim) TableName() string {
	return "wheel_free_claims"
}
