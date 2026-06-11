package models

import (
	"time"

	"github.com/google/uuid"
)

type PostReactionType string

const (
	PostReactionLike    PostReactionType = "like"
	PostReactionDislike PostReactionType = "dislike"
)

type PostReaction struct {
	PostID    uuid.UUID        `gorm:"type:uuid;primaryKey"`
	UserID    uuid.UUID        `gorm:"type:uuid;primaryKey"`
	Type      PostReactionType `gorm:"type:varchar(10);not null"`
	CreatedAt time.Time        `gorm:"not null;default:CURRENT_TIMESTAMP"`
	UpdatedAt time.Time        `gorm:"not null;default:CURRENT_TIMESTAMP"`
}

func (PostReaction) TableName() string {
	return "me_reactions"
}
