package models

import (
	"time"

	"github.com/google/uuid"
)

const (
	AvatarFrameSourcePurchase = "purchase"
	AvatarFrameSourceGift     = "gift"
	AvatarFrameSourceTransfer = "transfer"
	AvatarFrameSourceGiftCode = "gift_code"
)

type AvatarFrameShopItem struct {
	BaseModel
	FrameID   string `gorm:"type:varchar(8);not null"`
	KenPrice  int    `gorm:"not null"`
	IsActive  bool   `gorm:"not null"`
	SortOrder int    `gorm:"not null"`
}

func (AvatarFrameShopItem) TableName() string {
	return "avatar_frame_shop_items"
}

type UserAvatarFrame struct {
	BaseModel
	UserID     uuid.UUID `gorm:"type:uuid;not null"`
	FrameID    string    `gorm:"type:varchar(8);not null"`
	Source     string    `gorm:"type:varchar(20);not null"`
	AcquiredAt time.Time `gorm:"not null"`
}

func (UserAvatarFrame) TableName() string {
	return "user_avatar_frames"
}

type AvatarFramePurchase struct {
	BaseModel
	UserID          uuid.UUID  `gorm:"type:uuid;not null"`
	RecipientUserID *uuid.UUID `gorm:"type:uuid"`
	ShopItemID      *uuid.UUID `gorm:"type:uuid"`
	FrameID         string     `gorm:"type:varchar(8);not null"`
	KenPrice        int        `gorm:"not null"`
	KenBalanceAfter int        `gorm:"not null"`
	Source          string     `gorm:"type:varchar(20);not null"`
}

func (AvatarFramePurchase) TableName() string {
	return "avatar_frame_purchases"
}

type AvatarFrameTransfer struct {
	BaseModel
	FromUserID uuid.UUID `gorm:"type:uuid;not null"`
	ToUserID   uuid.UUID `gorm:"type:uuid;not null"`
	FrameID    string    `gorm:"type:varchar(8);not null"`
}

func (AvatarFrameTransfer) TableName() string {
	return "avatar_frame_transfers"
}
