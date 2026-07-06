package models

import "github.com/google/uuid"

type MeComment struct {
	BaseModel
	PostID   uuid.UUID  `gorm:"type:uuid;not null;index"`
	AuthorID uuid.UUID  `gorm:"type:uuid;not null;index"`
	ParentID *uuid.UUID `gorm:"type:uuid;index"`
	Content  string     `gorm:"type:text;not null"`
	Author   *User      `gorm:"foreignKey:AuthorID;constraint:OnDelete:CASCADE"`
}

func (MeComment) TableName() string {
	return "me_comments"
}
