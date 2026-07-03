package models

import "github.com/google/uuid"

const (
	MeNotificationLike    = "like"
	MeNotificationComment = "comment"
	MeNotificationMention = "mention"
)

type MeNotification struct {
	BaseModel
	RecipientID uuid.UUID  `gorm:"type:uuid;not null;index"`
	ActorID     uuid.UUID  `gorm:"type:uuid;not null"`
	Type        string     `gorm:"type:varchar(20);not null"`
	PostID      uuid.UUID  `gorm:"type:uuid;not null"`
	CommentID   *uuid.UUID `gorm:"type:uuid"`
	Preview     string     `gorm:"type:text"`
	IsRead      bool       `gorm:"not null;default:false"`
	Actor       *User      `gorm:"foreignKey:ActorID;constraint:OnDelete:CASCADE"`
}

func (MeNotification) TableName() string {
	return "me_notifications"
}
