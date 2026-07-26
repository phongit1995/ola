package adminkenchest

import (
	"time"

	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

type StatsFilter struct {
	Source string
	UserID *uuid.UUID
	From   *time.Time
	To     *time.Time
}

type StatsOverview struct {
	TotalChests   int64   `json:"totalChests"`
	ManualChests  int64   `json:"manualChests"`
	AutoChests    int64   `json:"autoChests"`
	ActiveChests  int64   `json:"activeChests"`
	ExpiredChests int64   `json:"expiredChests"`
	TotalClaims   int64   `json:"totalClaims"`
	EmptyClaims   int64   `json:"emptyClaims"`
	EmptyRate     float64 `json:"emptyRate"`
	TotalKenGiven int64   `json:"totalKenGiven"`
	UniqueUsers   int64   `json:"uniqueUsers"`
}

type StatsSourceRow struct {
	Source   string `json:"source"`
	Chests   int64  `json:"chests"`
	Claims   int64  `json:"claims"`
	KenGiven int64  `json:"kenGiven"`
}

type StatsTimePoint struct {
	Date     string `json:"date"`
	Claims   int64  `json:"claims"`
	Empty    int64  `json:"empty"`
	KenGiven int64  `json:"kenGiven"`
}

type StatsResponse struct {
	Overview   StatsOverview    `json:"overview"`
	BySource   []StatsSourceRow `json:"bySource"`
	Timeseries []StatsTimePoint `json:"timeseries"`
	Bucket     string           `json:"bucket"`
}

type UserBrief struct {
	ID       string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Username string `json:"username" example:"john_doe"`
	FullName string `json:"fullName" example:"John Doe"`
	Avatar   string `json:"avatar" example:"https://example.com/avatar.jpg"`
}

type UserStatsItem struct {
	User        UserBrief `json:"user"`
	Claims      int64     `json:"claims" example:"25"`
	Chests      int64     `json:"chests" example:"20"`
	EmptyClaims int64     `json:"emptyClaims" example:"4"`
	EmptyRate   float64   `json:"emptyRate" example:"16"`
	KenTotal    int64     `json:"kenTotal" example:"52000"`
	LastClaimAt string    `json:"lastClaimAt" example:"2026-07-25T15:12:33Z"`
}

type UserStatsResponse struct {
	Total  int64           `json:"total" example:"1"`
	Limit  int             `json:"limit" example:"20"`
	Offset int             `json:"offset" example:"0"`
	Items  []UserStatsItem `json:"items"`
}

type StatsSuccessResponse = utils.BaseResponse[StatsResponse]
type UserStatsSuccessResponse = utils.BaseResponse[UserStatsResponse]
