package models

type VipShopItem struct {
	BaseModel
	VipTypeID int16 `gorm:"not null"`
	KenPrice  int   `gorm:"not null"`
	IsActive  bool  `gorm:"not null;default:true"`
	SortOrder int   `gorm:"not null;default:0"`
}

func (VipShopItem) TableName() string {
	return "vip_shop_items"
}
