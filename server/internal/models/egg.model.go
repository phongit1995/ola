package models

import (
	"time"

	"github.com/google/uuid"
)

type EggCategoryType string

const (
	EggCategoryNothing EggCategoryType = "nothing"
	EggCategoryVipIcon EggCategoryType = "vip_icon"
	EggCategoryKen     EggCategoryType = "ken"
	EggCategoryVipDays EggCategoryType = "vip_days"
)

type EggPack struct {
	BaseModel
	Name      string `gorm:"type:varchar(100);not null" json:"name"`
	KenCost   int    `gorm:"not null;default:0" json:"kenCost"`
	IsEnabled bool   `gorm:"not null;default:true" json:"isEnabled"`
	SortOrder int    `gorm:"not null;default:0" json:"sortOrder"`
}

func (EggPack) TableName() string {
	return "egg_packs"
}

type EggCategory struct {
	ID        uuid.UUID       `gorm:"type:uuid;primary_key;default:gen_random_uuid()" json:"id"`
	PackID    uuid.UUID       `gorm:"type:uuid;not null;index" json:"packId"`
	Type      EggCategoryType `gorm:"type:varchar(20);not null" json:"type"`
	Label     string          `gorm:"type:varchar(100);not null" json:"label"`
	Weight    float64         `gorm:"type:numeric(10,4);not null;default:0" json:"weight"`
	IsActive  bool            `gorm:"not null;default:true" json:"isActive"`
	SortOrder int             `gorm:"not null;default:0" json:"sortOrder"`
	CreatedAt time.Time       `gorm:"not null;default:CURRENT_TIMESTAMP" json:"createdAt"`
	UpdatedAt time.Time       `gorm:"not null;default:CURRENT_TIMESTAMP" json:"updatedAt"`
}

func (EggCategory) TableName() string {
	return "egg_categories"
}

type EggReward struct {
	ID           uuid.UUID `gorm:"type:uuid;primary_key;default:gen_random_uuid()" json:"id"`
	CategoryID   uuid.UUID `gorm:"type:uuid;not null;index" json:"categoryId"`
	Label        string    `gorm:"type:varchar(100);not null" json:"label"`
	Weight       float64   `gorm:"type:numeric(10,4);not null;default:0" json:"weight"`
	VipTypeID    *int16    `gorm:"column:vip_type_id" json:"vipTypeId,omitempty"`
	KenAmount    *int      `gorm:"column:ken_amount" json:"kenAmount,omitempty"`
	VipDays      *int      `gorm:"column:vip_days" json:"vipDays,omitempty"`
	IsSuperLucky bool      `gorm:"not null;default:false" json:"isSuperLucky"`
	IsActive     bool      `gorm:"not null;default:true" json:"isActive"`
	SortOrder    int       `gorm:"not null;default:0" json:"sortOrder"`
	CreatedAt    time.Time `gorm:"not null;default:CURRENT_TIMESTAMP" json:"createdAt"`
	UpdatedAt    time.Time `gorm:"not null;default:CURRENT_TIMESTAMP" json:"updatedAt"`
}

func (EggReward) TableName() string {
	return "egg_rewards"
}

type EggDraw struct {
	ID           uuid.UUID       `gorm:"type:uuid;primary_key;default:gen_random_uuid()" json:"id"`
	UserID       uuid.UUID       `gorm:"type:uuid;not null;index" json:"userId"`
	PackID       uuid.UUID       `gorm:"type:uuid;not null" json:"packId"`
	PackName     string          `gorm:"type:varchar(100);not null" json:"packName"`
	KenCost      int             `gorm:"not null" json:"kenCost"`
	CategoryType EggCategoryType `gorm:"type:varchar(20);not null" json:"categoryType"`
	RewardType   *string         `gorm:"type:varchar(20)" json:"rewardType,omitempty"`
	RewardLabel  *string         `gorm:"type:varchar(100)" json:"rewardLabel,omitempty"`
	VipTypeID    *int16          `gorm:"column:vip_type_id" json:"vipTypeId,omitempty"`
	KenAmount    *int            `gorm:"column:ken_amount" json:"kenAmount,omitempty"`
	VipDays      *int            `gorm:"column:vip_days" json:"vipDays,omitempty"`
	IsSuperLucky bool            `gorm:"not null;default:false" json:"isSuperLucky"`
	KenTxID      *uuid.UUID      `gorm:"column:ken_tx_id" json:"kenTxId,omitempty"`
	Metadata     JSONB           `gorm:"type:jsonb" json:"metadata,omitempty"`
	CreatedAt    time.Time       `gorm:"not null;default:CURRENT_TIMESTAMP" json:"createdAt"`
}

func (EggDraw) TableName() string {
	return "egg_draws"
}
