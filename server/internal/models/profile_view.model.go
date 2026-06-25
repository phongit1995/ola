package models

import (
	"time"

	"github.com/google/uuid"
)

type ProfileView struct {
	ID       uuid.UUID `gorm:"type:uuid;primary_key;default:gen_random_uuid()"`
	ViewerID uuid.UUID `gorm:"type:uuid;not null;uniqueIndex:uq_profile_views_owner_viewer,priority:2"`
	OwnerID  uuid.UUID `gorm:"type:uuid;not null;uniqueIndex:uq_profile_views_owner_viewer,priority:1;index:idx_profile_views_owner_time,priority:1"`
	ViewedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP;index:idx_profile_views_owner_time,priority:2,sort:desc"`

	Viewer *User `gorm:"foreignKey:ViewerID;constraint:OnDelete:CASCADE"`
	Owner  *User `gorm:"foreignKey:OwnerID;constraint:OnDelete:CASCADE"`
}

func (ProfileView) TableName() string {
	return "profile_views"
}
