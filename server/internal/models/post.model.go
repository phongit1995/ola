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
	PostVisibilityFriend  PostVisibility = "friend"
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

type CheckIn struct {
	Name       string  `json:"name"`
	Address    string  `json:"address,omitempty"`
	Lat        float64 `json:"lat,omitempty"`
	Lng        float64 `json:"lng,omitempty"`
	Action     string  `json:"action,omitempty"`
	ActionIcon string  `json:"actionIcon,omitempty"`
}

func (c *CheckIn) Value() (driver.Value, error) {
	if c == nil {
		return nil, nil
	}
	return json.Marshal(c)
}

func (c *CheckIn) Scan(value interface{}) error {
	if value == nil {
		return nil
	}
	bytes, ok := value.([]byte)
	if !ok {
		return errors.New("failed to unmarshal CheckIn value")
	}
	return json.Unmarshal(bytes, c)
}

type MentionIDs []string

func (m MentionIDs) Value() (driver.Value, error) {
	if m == nil {
		return nil, nil
	}
	return json.Marshal(m)
}

func (m *MentionIDs) Scan(value interface{}) error {
	if value == nil {
		*m = nil
		return nil
	}
	bytes, ok := value.([]byte)
	if !ok {
		return errors.New("failed to unmarshal MentionIDs value")
	}
	return json.Unmarshal(bytes, m)
}

type Post struct {
	BaseModel
	AuthorID     uuid.UUID      `gorm:"type:uuid;not null;index"`
	Content      string         `gorm:"type:text"`
	Images       PostImages     `gorm:"type:jsonb"`
	Mentions     MentionIDs     `gorm:"type:jsonb"`
	CheckIn      *CheckIn       `gorm:"type:jsonb"`
	Sticker      string         `gorm:"type:varchar(500)"`
	Visibility   PostVisibility `gorm:"type:varchar(20);not null;default:'public'"`
	Enabled      bool           `gorm:"not null;default:true"`
	LikeCount    int            `gorm:"not null;default:0"`
	DislikeCount int            `gorm:"not null;default:0"`
	CommentCount int            `gorm:"not null;default:0"`
	Author       *User          `gorm:"foreignKey:AuthorID;constraint:OnDelete:CASCADE"`
}

func (Post) TableName() string {
	return "me"
}
