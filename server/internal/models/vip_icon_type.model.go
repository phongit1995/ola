package models

import "time"

type VipIconType struct {
	TypeID    int16     `gorm:"primaryKey;column:type_id"`
	Name      string    `gorm:"type:varchar(100);not null"`
	KenPrice  int       `gorm:"not null;default:0"`
	IsActive  bool      `gorm:"not null;default:true"`
	CreatedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP"`
	UpdatedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP"`
}

func (VipIconType) TableName() string {
	return "vip_icon_types"
}
