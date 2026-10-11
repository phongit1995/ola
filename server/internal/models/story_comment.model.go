package models

import (
	"time"

	"github.com/google/uuid"
)

type StoryComment struct {
	BaseModel
	StoryID   uuid.UUID  `gorm:"type:uuid;not null"`
	AuthorID  uuid.UUID  `gorm:"type:uuid;not null"`
	ParentID  *uuid.UUID `gorm:"type:uuid"`
	Content   string     `gorm:"type:text;not null"`
	LikeCount int        `gorm:"not null;default:0"`
}

func (StoryComment) TableName() string {
	return "story_comments"
}

type StoryCommentLike struct {
	CommentID uuid.UUID `gorm:"type:uuid;primaryKey"`
	UserID    uuid.UUID `gorm:"type:uuid;primaryKey"`
	CreatedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP"`
}

func (StoryCommentLike) TableName() string {
	return "story_comment_likes"
}

type StoryUnlock struct {
	UserID    uuid.UUID  `gorm:"type:uuid;primaryKey"`
	StoryID   uuid.UUID  `gorm:"type:uuid;primaryKey"`
	Source    string     `gorm:"type:varchar(20);not null"`
	CommentID *uuid.UUID `gorm:"type:uuid"`
	CreatedAt time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP"`
}

func (StoryUnlock) TableName() string {
	return "story_unlocks"
}
