package adminwheel

import (
	"time"

	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

type StatsFilter struct {
	WheelID *uuid.UUID
	UserID  *uuid.UUID
	From    *time.Time
	To      *time.Time
}

type UserBrief struct {
	ID       string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Username string `json:"username" example:"john_doe"`
	FullName string `json:"fullName" example:"John Doe"`
	Avatar   string `json:"avatar" example:"https://example.com/avatar.jpg"`
}

type UserStatsItem struct {
	User       UserBrief `json:"user"`
	Spins      int64     `json:"spins" example:"120"`
	WinSpins   int64     `json:"winSpins" example:"30"`
	WinRate    float64   `json:"winRate" example:"25"`
	FreeSpins  int64     `json:"freeSpins" example:"12"`
	KenSpent   int64     `json:"kenSpent" example:"120000"`
	KenWon     int64     `json:"kenWon" example:"40000"`
	NetKen     int64     `json:"netKen" example:"-80000"`
	VipDays    int64     `json:"vipDays" example:"14"`
	VipItems   int64     `json:"vipItems" example:"2"`
	LastSpinAt string    `json:"lastSpinAt" example:"2026-07-25T15:12:33Z"`
}

type UserStatsResponse struct {
	Total  int64           `json:"total" example:"1"`
	Limit  int             `json:"limit" example:"20"`
	Offset int             `json:"offset" example:"0"`
	Items  []UserStatsItem `json:"items"`
}

type VipStatsRow struct {
	VipTypeID int16 `json:"vipTypeId" example:"12"`
	ItemWins  int64 `json:"itemWins" example:"5"`
	DayWins   int64 `json:"dayWins" example:"9"`
	VipDays   int64 `json:"vipDays" example:"27"`
}

type VipStatsResponse struct {
	Items []VipStatsRow `json:"items"`
}

type UserStatsSuccessResponse = utils.BaseResponse[UserStatsResponse]
type VipStatsSuccessResponse = utils.BaseResponse[VipStatsResponse]
