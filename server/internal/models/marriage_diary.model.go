package models

import "github.com/google/uuid"

type MarriageDiaryEntry struct {
	BaseModel
	MarriageID uuid.UUID `gorm:"type:uuid;not null;index"`
	AuthorID   uuid.UUID `gorm:"type:uuid;not null;index"`
	Content    string    `gorm:"type:text;not null"`

	Author *User `gorm:"foreignKey:AuthorID;constraint:OnDelete:CASCADE"`
}

func (MarriageDiaryEntry) TableName() string {
	return "marriage_diary_entries"
}
