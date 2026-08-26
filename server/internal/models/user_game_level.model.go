package models

import (
	"time"

	"github.com/google/uuid"
)

type UserGameLevel struct {
	UserID    uuid.UUID `gorm:"type:uuid;primaryKey" json:"userId"`
	GameID    string    `gorm:"type:varchar(50);primaryKey" json:"gameId"`
	Exp       int64     `gorm:"not null;default:0" json:"exp"`
	Level     int       `gorm:"not null;default:1" json:"level"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`
}

func (UserGameLevel) TableName() string {
	return "user_game_levels"
}
