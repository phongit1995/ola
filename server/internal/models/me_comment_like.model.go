package models

import (
	"time"

	"github.com/google/uuid"
)

type MeCommentLike struct {
	CommentID uuid.UUID `gorm:"type:uuid;primaryKey"`
	UserID    uuid.UUID `gorm:"type:uuid;primaryKey"`
	CreatedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP"`
}

func (MeCommentLike) TableName() string {
	return "me_comment_likes"
}
