package models

type Gift struct {
	BaseModel
	Name        string `gorm:"type:varchar(60);not null"`
	NameEn      string `gorm:"type:varchar(60);not null;default:''"`
	ImageURL    string `gorm:"type:varchar(500);not null"`
	KenPrice    int    `gorm:"not null"`
	CharmPoints int    `gorm:"not null"`
	IsActive    bool   `gorm:"not null"`
	SortOrder   int    `gorm:"not null;default:0"`
}

func (Gift) TableName() string {
	return "gifts"
}
