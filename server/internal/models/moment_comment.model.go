package models

import (
	"time"

	"github.com/google/uuid"
)

type MomentComment struct {
	ID        uuid.UUID `gorm:"type:uuid;primaryKey;default:gen_random_uuid()"`
	MomentID  uuid.UUID `gorm:"type:uuid;not null"`
	AuthorID  uuid.UUID `gorm:"type:uuid;not null"`
	Content   string    `gorm:"type:text;not null"`
	CreatedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP"`
	Author    *User     `gorm:"foreignKey:AuthorID;constraint:OnDelete:CASCADE"`
}

func (MomentComment) TableName() string {
	return "moment_comments"
}
