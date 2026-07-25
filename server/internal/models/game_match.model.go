package models

import (
	"time"

	"github.com/google/uuid"
)

type GameMatch struct {
	BaseModel
	GameID     string     `gorm:"type:varchar(50);not null" json:"gameId"`
	MatchID    string     `gorm:"type:varchar(64);not null" json:"matchId"`
	Player0ID  uuid.UUID  `gorm:"type:uuid;not null" json:"player0Id"`
	Player1ID  uuid.UUID  `gorm:"type:uuid;not null" json:"player1Id"`
	WinnerID   *uuid.UUID `gorm:"type:uuid" json:"winnerId,omitempty"`
	LoserID    *uuid.UUID `gorm:"type:uuid" json:"loserId,omitempty"`
	Status     string     `gorm:"type:varchar(10);not null;default:playing" json:"status"`
	Reason     string     `gorm:"type:varchar(20);not null;default:''" json:"reason"`
	Mode       string     `gorm:"type:varchar(10);not null" json:"mode"`
	Bet        int        `gorm:"not null;default:0" json:"bet"`
	KenDelta   int        `gorm:"not null;default:0" json:"kenDelta"`
	MoveCount  int        `gorm:"not null;default:0" json:"moveCount"`
	StartedAt  time.Time  `gorm:"not null" json:"startedAt"`
	EscrowedAt time.Time  `gorm:"not null" json:"escrowedAt"`
	FinishedAt *time.Time `json:"finishedAt,omitempty"`
}

func (GameMatch) TableName() string {
	return "game_matches"
}
