package models

import "time"

type AdminUser struct {
	BaseModel
	Username     string     `gorm:"unique;not null"`
	Password     string     `gorm:"not null"`
	FullName     string     `gorm:"type:varchar(100)"`
	Email        string     `gorm:"type:varchar(255)"`
	Avatar       string     `gorm:"type:varchar(500)"`
	Role         string     `gorm:"type:varchar(20);not null;default:'ADMIN'"`
	IsActive     bool       `gorm:"not null;default:true"`
	RefreshToken string     `gorm:"type:text"`
	LastLoginIP  string     `gorm:"type:varchar(45)"`
	LastLoginAt  *time.Time
}

func (AdminUser) TableName() string {
	return "admin_users"
}
