package models

import "github.com/google/uuid"

type PostComment struct {
	BaseModel
	PostID   uuid.UUID `gorm:"type:uuid;not null;index"`
	AuthorID uuid.UUID `gorm:"type:uuid;not null;index"`
	Content  string    `gorm:"type:text;not null"`
	Author   *User     `gorm:"foreignKey:AuthorID;constraint:OnDelete:CASCADE"`
}

func (PostComment) TableName() string {
	return "me_comments"
}
