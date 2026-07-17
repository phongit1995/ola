package models

type MiniGame struct {
	BaseModel
	Slug        string `gorm:"type:varchar(50);not null" json:"slug"`
	Name        string `gorm:"type:varchar(100);not null" json:"name"`
	Description string `gorm:"type:varchar(300)" json:"description"`
	IconURL     string `gorm:"type:varchar(500)" json:"iconUrl"`
	GameURL     string `gorm:"type:varchar(500);not null" json:"gameUrl"`
	IsEnabled   bool   `gorm:"not null;default:true" json:"isEnabled"`
	SortOrder   int    `gorm:"not null;default:0" json:"sortOrder"`
}

func (MiniGame) TableName() string {
	return "mini_games"
}
