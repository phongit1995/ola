package models

import (
	"database/sql/driver"
	"encoding/json"
	"errors"
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type MomentOverlay struct {
	ID       string  `json:"id"`
	Text     string  `json:"text"`
	X        float64 `json:"x"`
	Y        float64 `json:"y"`
	W        float64 `json:"w"`
	Scale    float64 `json:"scale"`
	Rotation float64 `json:"rotation"`
	Color    string  `json:"color"`
	Style    string  `json:"style"`
	Font     string  `json:"font"`
	Bold     bool    `json:"bold,omitempty"`
	Italic   bool    `json:"italic,omitempty"`
	Align    string  `json:"align"`
}

type MomentOverlays []MomentOverlay

func (o MomentOverlays) Value() (driver.Value, error) {
	if o == nil {
		return []byte("[]"), nil
	}
	return json.Marshal(o)
}

func (o *MomentOverlays) Scan(value interface{}) error {
	if value == nil {
		*o = MomentOverlays{}
		return nil
	}
	bytes, ok := value.([]byte)
	if !ok {
		return errors.New("failed to unmarshal MomentOverlays value")
	}
	return json.Unmarshal(bytes, o)
}

type MomentReactionCounts map[string]int64

func (c MomentReactionCounts) Value() (driver.Value, error) {
	if c == nil {
		return []byte("{}"), nil
	}
	return json.Marshal(c)
}

func (c *MomentReactionCounts) Scan(value interface{}) error {
	if value == nil {
		*c = MomentReactionCounts{}
		return nil
	}
	bytes, ok := value.([]byte)
	if !ok {
		return errors.New("failed to unmarshal MomentReactionCounts value")
	}
	return json.Unmarshal(bytes, c)
}

type Moment struct {
	ID             uuid.UUID      `gorm:"type:uuid;primaryKey;default:gen_random_uuid()"`
	AuthorID       uuid.UUID      `gorm:"type:uuid;not null"`
	Type           string         `gorm:"type:varchar(10);not null"`
	Position       int            `gorm:"type:smallint;not null;default:0"`
	Background     string         `gorm:"type:varchar(32);not null;default:''"`
	Overlays       MomentOverlays `gorm:"type:jsonb;not null;default:'[]'"`
	MediaURL       string         `gorm:"type:text;not null;default:''"`
	MediaObject    string         `gorm:"type:varchar(500);not null;default:''"`
	SourceObject   string         `gorm:"type:varchar(500);not null;default:''"`
	ThumbURL       string         `gorm:"type:text;not null;default:''"`
	ThumbObject    string         `gorm:"type:varchar(500);not null;default:''"`
	Width          int            `gorm:"not null;default:0"`
	Height         int            `gorm:"not null;default:0"`
	Duration       float64        `gorm:"not null;default:0"`
	Size           int64          `gorm:"not null;default:0"`
	MimeType       string         `gorm:"type:varchar(50);not null;default:''"`
	Visibility     string         `gorm:"type:varchar(20);not null;default:'friend'"`
	Status         string         `gorm:"type:varchar(20);not null;default:'ready'"`
	Enabled        bool           `gorm:"not null;default:true"`
	HiddenBy       *string        `gorm:"type:varchar(10)"`
	HiddenAt       *time.Time
	ViewerCount    int64                `gorm:"type:integer;not null;default:0"`
	ReactionCounts MomentReactionCounts `gorm:"type:jsonb;not null;default:'{}'"`
	Attempts       int                  `gorm:"column:processing_attempts;type:smallint;not null;default:0"`
	Failures       int                  `gorm:"column:processing_failures;type:smallint;not null;default:0"`
	ClaimedAt      *time.Time           `gorm:"column:processing_started_at"`
	RetryAt        *time.Time           `gorm:"column:processing_retry_at"`
	PurgedAt       *time.Time           `gorm:"column:purged_at"`
	ExpiresAt      time.Time            `gorm:"not null"`
	CreatedAt      time.Time            `gorm:"not null;default:CURRENT_TIMESTAMP"`
	DeletedAt      gorm.DeletedAt       `gorm:"index"`
	Author         *User                `gorm:"foreignKey:AuthorID;constraint:OnDelete:CASCADE"`
}

func (Moment) TableName() string {
	return "moments"
}

func (r *Moment) BeforeCreate(tx *gorm.DB) error {
	if r.ID == uuid.Nil {
		r.ID = uuid.New()
	}
	return nil
}
