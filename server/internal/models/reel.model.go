package models

import (
	"database/sql/driver"
	"encoding/json"
	"errors"
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type ReelOverlay struct {
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
	Align    string  `json:"align"`
}

type ReelOverlays []ReelOverlay

func (o ReelOverlays) Value() (driver.Value, error) {
	if o == nil {
		return []byte("[]"), nil
	}
	return json.Marshal(o)
}

func (o *ReelOverlays) Scan(value interface{}) error {
	if value == nil {
		*o = ReelOverlays{}
		return nil
	}
	bytes, ok := value.([]byte)
	if !ok {
		return errors.New("failed to unmarshal ReelOverlays value")
	}
	return json.Unmarshal(bytes, o)
}

type Reel struct {
	ID           uuid.UUID      `gorm:"type:uuid;primaryKey;default:gen_random_uuid()"`
	AuthorID     uuid.UUID      `gorm:"type:uuid;not null"`
	Type         string         `gorm:"type:varchar(10);not null"`
	Position     int            `gorm:"type:smallint;not null;default:0"`
	Background   string         `gorm:"type:varchar(32);not null;default:''"`
	Overlays     ReelOverlays   `gorm:"type:jsonb;not null;default:'[]'"`
	MediaURL     string         `gorm:"type:text;not null;default:''"`
	MediaObject  string         `gorm:"type:varchar(500);not null;default:''"`
	SourceObject string         `gorm:"type:varchar(500);not null;default:''"`
	ThumbURL     string         `gorm:"type:text;not null;default:''"`
	ThumbObject  string         `gorm:"type:varchar(500);not null;default:''"`
	Width        int            `gorm:"not null;default:0"`
	Height       int            `gorm:"not null;default:0"`
	Duration     float64        `gorm:"not null;default:0"`
	Size         int64          `gorm:"not null;default:0"`
	MimeType     string         `gorm:"type:varchar(50);not null;default:''"`
	Visibility   string         `gorm:"type:varchar(20);not null;default:'friend'"`
	Status       string         `gorm:"type:varchar(20);not null;default:'ready'"`
	Enabled      bool           `gorm:"not null;default:true"`
	Attempts     int            `gorm:"column:processing_attempts;type:smallint;not null;default:0"`
	Failures     int            `gorm:"column:processing_failures;type:smallint;not null;default:0"`
	ClaimedAt    *time.Time     `gorm:"column:processing_started_at"`
	RetryAt      *time.Time     `gorm:"column:processing_retry_at"`
	PurgedAt     *time.Time     `gorm:"column:purged_at"`
	ExpiresAt    time.Time      `gorm:"not null"`
	CreatedAt    time.Time      `gorm:"not null;default:CURRENT_TIMESTAMP"`
	DeletedAt    gorm.DeletedAt `gorm:"index"`
	Author       *User          `gorm:"foreignKey:AuthorID;constraint:OnDelete:CASCADE"`
}

func (Reel) TableName() string {
	return "reels"
}

func (r *Reel) BeforeCreate(tx *gorm.DB) error {
	if r.ID == uuid.Nil {
		r.ID = uuid.New()
	}
	return nil
}
