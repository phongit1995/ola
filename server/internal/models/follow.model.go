package models

import (
	"time"

	"github.com/google/uuid"
)

type Follow struct {
	ID         uuid.UUID `gorm:"type:uuid;default:gen_random_uuid();primaryKey"`
	FollowerID uuid.UUID `gorm:"type:uuid;not null;uniqueIndex:idx_unique_follow,priority:1;index:idx_follows_follower"`
	FolloweeID uuid.UUID `gorm:"type:uuid;not null;uniqueIndex:idx_unique_follow,priority:2;index:idx_follows_followee"`
	CreatedAt  time.Time `gorm:"not null;default:CURRENT_TIMESTAMP"`

	Follower *User `gorm:"foreignKey:FollowerID;constraint:OnDelete:CASCADE"`
	Followee *User `gorm:"foreignKey:FolloweeID;constraint:OnDelete:CASCADE"`
}

func (Follow) TableName() string {
	return "follows"
}
