package models

import (
	"time"

	"github.com/google/uuid"
)

type MeReactionType string

const (
	MeReactionLike    MeReactionType = "like"
	MeReactionDislike MeReactionType = "dislike"
)

type MeReaction struct {
	PostID    uuid.UUID      `gorm:"type:uuid;primaryKey"`
	UserID    uuid.UUID      `gorm:"type:uuid;primaryKey"`
	Type      MeReactionType `gorm:"type:varchar(10);not null"`
	CreatedAt time.Time      `gorm:"not null;default:CURRENT_TIMESTAMP"`
	UpdatedAt time.Time      `gorm:"not null;default:CURRENT_TIMESTAMP"`
}

func (MeReaction) TableName() string {
	return "me_reactions"
}
