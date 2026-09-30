package models

import (
	"time"

	"github.com/google/uuid"
)

type WordChainScore struct {
	MessageID    uuid.UUID `gorm:"type:uuid;primaryKey" json:"messageId"`
	SessionID    uuid.UUID `gorm:"type:uuid" json:"sessionId"`
	UserID       uuid.UUID `gorm:"type:uuid" json:"userId"`
	Word         string    `json:"word"`
	PreviousWord string    `json:"previousWord"`
	Points       int16     `json:"points"`
	IsWin        bool      `json:"isWin"`
	CreatedAt    time.Time `json:"createdAt"`
}

func (WordChainScore) TableName() string {
	return "word_chain_scores"
}
