package adminpen

import (
	"time"

	admincommon "ola-chat-server/internal/modules/admin/common"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

type StatsFilter struct {
	UserID *uuid.UUID
	From   *time.Time
	To     *time.Time
}

type UserBrief = admincommon.UserBrief

type UserStatsItem struct {
	User           UserBrief `json:"user"`
	Shots          int64     `json:"shots" example:"40"`
	ShooterSettled int64     `json:"shooterSettled" example:"30"`
	ShooterWins    int64     `json:"shooterWins" example:"12"`
	ShooterWinRate float64   `json:"shooterWinRate" example:"40"`
	Catches        int64     `json:"catches" example:"25"`
	KeeperWins     int64     `json:"keeperWins" example:"10"`
	KeeperSaveRate float64   `json:"keeperSaveRate" example:"40"`
	Cancelled      int64     `json:"cancelled" example:"3"`
	CancelRate     float64   `json:"cancelRate" example:"7.5"`
	Staked         int64     `json:"staked" example:"120000"`
	NetKen         int64     `json:"netKen" example:"-8000"`
	LastPlayAt     string    `json:"lastPlayAt" example:"2026-07-25T15:12:33Z"`
}

type UserStatsResponse struct {
	Total  int64           `json:"total" example:"1"`
	Limit  int             `json:"limit" example:"20"`
	Offset int             `json:"offset" example:"0"`
	Items  []UserStatsItem `json:"items"`
}

type SideStatsResponse struct {
	ShooterLeft  int64 `json:"shooterLeft" example:"120"`
	ShooterRight int64 `json:"shooterRight" example:"98"`
	KeeperLeft   int64 `json:"keeperLeft" example:"101"`
	KeeperRight  int64 `json:"keeperRight" example:"117"`
}

type UserStatsSuccessResponse = utils.BaseResponse[UserStatsResponse]
type SideStatsSuccessResponse = utils.BaseResponse[SideStatsResponse]
