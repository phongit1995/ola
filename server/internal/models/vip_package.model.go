package models

type VipPackage struct {
	BaseModel
	Name      string `gorm:"type:varchar(100);not null"`
	Days      int    `gorm:"not null"`
	KenPrice  int    `gorm:"not null"`
	IsActive  bool   `gorm:"not null;default:true"`
	SortOrder int    `gorm:"not null;default:0"`
}

func (VipPackage) TableName() string {
	return "vip_packages"
}
