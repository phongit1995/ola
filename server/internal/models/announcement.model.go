package models

import "time"

type Announcement struct {
	BaseModel
	Title    string     `gorm:"type:varchar(200);not null" json:"title"`
	Content  string     `gorm:"type:text;default:''" json:"content"`
	Link     string     `gorm:"type:varchar(500)" json:"link"`
	IsActive bool       `gorm:"not null;default:false" json:"isActive"`
	StartsAt *time.Time `gorm:"type:timestamptz" json:"startsAt"`
	EndsAt   *time.Time `gorm:"type:timestamptz" json:"endsAt"`
}

func (Announcement) TableName() string {
	return "announcements"
}
