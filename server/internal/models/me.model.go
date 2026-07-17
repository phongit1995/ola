package models

import (
	"database/sql/driver"
	"encoding/json"
	"errors"
	"time"

	"github.com/google/uuid"
)

type MeVisibility string

const (
	MeVisibilityPublic  MeVisibility = "public"
	MeVisibilityFriend  MeVisibility = "friend"
	MeVisibilityPrivate MeVisibility = "private"
)

type MeImage struct {
	URL      string `json:"url"`
	Width    int    `json:"width"`
	Height   int    `json:"height"`
	MimeType string `json:"mimeType"`
}

type MeImages []MeImage

func (p MeImages) Value() (driver.Value, error) {
	if p == nil {
		return nil, nil
	}
	return json.Marshal(p)
}

func (p *MeImages) Scan(value interface{}) error {
	if value == nil {
		*p = nil
		return nil
	}
	bytes, ok := value.([]byte)
	if !ok {
		return errors.New("failed to unmarshal MeImages value")
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

type Me struct {
	BaseModel
	AuthorID     uuid.UUID    `gorm:"type:uuid;not null;index"`
	ClanID       *uuid.UUID   `gorm:"type:uuid;index"`
	Content      string       `gorm:"type:text"`
	Images       MeImages     `gorm:"type:jsonb"`
	Mentions     MentionIDs   `gorm:"type:jsonb"`
	CheckIn      *CheckIn     `gorm:"type:jsonb"`
	Sticker      string       `gorm:"type:varchar(500)"`
	Visibility   MeVisibility `gorm:"type:varchar(20);not null;default:'public'"`
	Enabled      bool         `gorm:"not null;default:true"`
	LikeCount    int          `gorm:"not null;default:0"`
	DislikeCount int          `gorm:"not null;default:0"`
	CommentCount int          `gorm:"not null;default:0"`
	PinnedAt     *time.Time   `gorm:"index"`
	Author       *User        `gorm:"foreignKey:AuthorID;constraint:OnDelete:CASCADE"`
	Clan         *Clan        `gorm:"foreignKey:ClanID"`
}

func (Me) TableName() string {
	return "me"
}
