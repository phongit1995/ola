package models

const (
	GiftAnimationRandom           = "random"
	GiftSenderCharmPercentDefault = 50
)

type Gift struct {
	BaseModel
	Name               string `gorm:"type:varchar(60);not null"`
	NameEn             string `gorm:"type:varchar(60);not null;default:''"`
	ImageURL           string `gorm:"type:varchar(500);not null"`
	KenPrice           int    `gorm:"not null"`
	CharmPoints        int    `gorm:"not null"`
	IsActive           bool   `gorm:"not null"`
	SortOrder          int    `gorm:"not null;default:0"`
	Animation          string `gorm:"type:varchar(20);not null;default:'random'"`
	SenderCharmPercent int    `gorm:"type:smallint;not null"`
}

func (Gift) TableName() string {
	return "gifts"
}
