package models

import (
	"database/sql/driver"
	"encoding/json"
	"errors"

	"github.com/google/uuid"
)

type PostVisibility string

const (
	PostVisibilityPublic  PostVisibility = "public"
	PostVisibilityPrivate PostVisibility = "private"
)

type PostImage struct {
	URL      string `json:"url"`
	Width    int    `json:"width"`
	Height   int    `json:"height"`
	MimeType string `json:"mimeType"`
}

type PostImages []PostImage

func (p PostImages) Value() (driver.Value, error) {
	if p == nil {
		return nil, nil
	}
	return json.Marshal(p)
}

func (p *PostImages) Scan(value interface{}) error {
	if value == nil {
		*p = nil
		return nil
	}
	bytes, ok := value.([]byte)
	if !ok {
		return errors.New("failed to unmarshal PostImages value")
	}
	return json.Unmarshal(bytes, p)
}

type Post struct {
	BaseModel
	AuthorID     uuid.UUID      `gorm:"type:uuid;not null;index"`
	Content      string         `gorm:"type:text"`
	Images       PostImages     `gorm:"type:jsonb"`
	Visibility   PostVisibility `gorm:"type:varchar(20);not null;default:'public'"`
	LikeCount    int            `gorm:"not null;default:0"`
	DislikeCount int            `gorm:"not null;default:0"`
	CommentCount int            `gorm:"not null;default:0"`
	Author       *User          `gorm:"foreignKey:AuthorID;constraint:OnDelete:CASCADE"`
}

func (Post) TableName() string {
	return "me"
}
