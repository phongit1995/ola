package models

import (
	"time"

	"github.com/google/uuid"
	"github.com/lib/pq"
)

type WordChainHintPurchase struct {
	UserID           uuid.UUID      `gorm:"type:uuid;primaryKey" json:"userId"`
	SessionID        uuid.UUID      `gorm:"type:uuid;primaryKey" json:"sessionId"`
	Turn             int64          `gorm:"primaryKey;autoIncrement:false" json:"turn"`
	Word             string         `json:"word"`
	Hints            pq.StringArray `gorm:"type:text[]" json:"hints"`
	Price            int            `json:"price"`
	KenTransactionID uuid.UUID      `gorm:"type:uuid" json:"kenTransactionId"`
	CreatedAt        time.Time      `json:"createdAt"`
}

func (WordChainHintPurchase) TableName() string {
	return "word_chain_hint_purchases"
}
