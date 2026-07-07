package pen

import "ola-chat-server/internal/utils"

type CreateShotRequest struct {
	BetAmount int    `json:"betAmount" binding:"required" example:"1000"`
	Side      string `json:"side" binding:"required,oneof=left right" example:"left"`
}

type CatchRequest struct {
	Side string `json:"side" binding:"required,oneof=left right" example:"right"`
}

type UserBrief struct {
	ID         string  `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Username   string  `json:"username" example:"john_doe"`
	FullName   string  `json:"fullName,omitempty" example:"John Doe"`
	Avatar     string  `json:"avatar,omitempty" example:"https://example.com/avatar.jpg"`
	VipUsed    *string `json:"vipUsed,omitempty" example:"12"`
	VipEndTime *string `json:"vipEndTime,omitempty" example:"2026-12-31T00:00:00Z"`
}

type ShotView struct {
	ID          string     `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Shooter     *UserBrief `json:"shooter,omitempty"`
	Keeper      *UserBrief `json:"keeper,omitempty"`
	BetAmount   int        `json:"betAmount" example:"1000"`
	Status      string     `json:"status" example:"open"`
	ShooterSide string     `json:"shooterSide,omitempty" example:"left"`
	KeeperSide  string     `json:"keeperSide,omitempty" example:"right"`
	Result      string     `json:"result,omitempty" example:"goal"`
	WinnerID    string     `json:"winnerId,omitempty"`
	Pot         *int       `json:"pot,omitempty"`
	Commission  *int       `json:"commission,omitempty"`
	Payout      *int       `json:"payout,omitempty"`
	CreatedAt   string     `json:"createdAt" example:"2026-06-24T10:00:00Z"`
	SettledAt   string     `json:"settledAt,omitempty"`
	CancelledAt string     `json:"cancelledAt,omitempty"`
}

type ShotListResponse struct {
	Total  int64      `json:"total" example:"1"`
	Limit  int        `json:"limit" example:"20"`
	Offset int        `json:"offset" example:"0"`
	Items  []ShotView `json:"items"`
}

type CreateShotResponse struct {
	Shot       ShotView `json:"shot"`
	KenBalance int      `json:"kenBalance" example:"11345"`
}

type CatchResult struct {
	ShotID      string `json:"shotId"`
	Result      string `json:"result" example:"saved"`
	Win         bool   `json:"win" example:"true"`
	WinnerID    string `json:"winnerId"`
	BetAmount   int    `json:"betAmount" example:"1000"`
	Pot         int    `json:"pot" example:"2000"`
	Commission  int    `json:"commission" example:"100"`
	Payout      int    `json:"payout" example:"1900"`
	ShooterSide string `json:"shooterSide" example:"left"`
	KeeperSide  string `json:"keeperSide" example:"left"`
	KenBalance  int    `json:"kenBalance" example:"12245"`
}

type CancelResponse struct {
	ShotID     string `json:"shotId"`
	Status     string `json:"status" example:"cancelled"`
	Refunded   int    `json:"refunded" example:"1000"`
	KenBalance int    `json:"kenBalance" example:"12345"`
}

type CreateShotSuccessResponse = utils.BaseResponse[CreateShotResponse]
type ShotListSuccessResponse = utils.BaseResponse[ShotListResponse]
type CatchSuccessResponse = utils.BaseResponse[CatchResult]
type CancelSuccessResponse = utils.BaseResponse[CancelResponse]

type StatsOverview struct {
	TotalShots     int64   `json:"totalShots"`
	SettledShots   int64   `json:"settledShots"`
	OpenShots      int64   `json:"openShots"`
	CancelledShots int64   `json:"cancelledShots"`
	UniqueShooters int64   `json:"uniqueShooters"`
	UniqueKeepers  int64   `json:"uniqueKeepers"`
	TotalVolume    int64   `json:"totalVolume"`
	HouseTake      int64   `json:"houseTake"`
	TotalPayout    int64   `json:"totalPayout"`
	SavedCount     int64   `json:"savedCount"`
	GoalCount      int64   `json:"goalCount"`
	KeeperWinRate  float64 `json:"keeperWinRate"`
}

type StatsResult struct {
	Result  string  `json:"result"`
	Count   int64   `json:"count"`
	Percent float64 `json:"percent"`
}

type StatsStatus struct {
	Status  string  `json:"status"`
	Count   int64   `json:"count"`
	Percent float64 `json:"percent"`
}

type StatsTimePoint struct {
	Date      string `json:"date"`
	Shots     int64  `json:"shots"`
	Settled   int64  `json:"settled"`
	Volume    int64  `json:"volume"`
	HouseTake int64  `json:"houseTake"`
}

type StatsPlayer struct {
	User   UserBrief `json:"user"`
	Shots  int64     `json:"shots"`
	Staked int64     `json:"staked"`
	Won    int64     `json:"won"`
}

type PenStatsResponse struct {
	Overview   StatsOverview    `json:"overview"`
	ByResult   []StatsResult    `json:"byResult"`
	ByStatus   []StatsStatus    `json:"byStatus"`
	Timeseries []StatsTimePoint `json:"timeseries"`
	TopPlayers []StatsPlayer    `json:"topPlayers"`
	Bucket     string           `json:"bucket"`
}

type AdminShotListSuccessResponse = utils.BaseResponse[ShotListResponse]
type PenStatsSuccessResponse = utils.BaseResponse[PenStatsResponse]

type LeaderboardEntry struct {
	Rank   int       `json:"rank" example:"1"`
	User   UserBrief `json:"user"`
	Profit int64     `json:"profit" example:"19000"`
}

type LeaderboardResponse struct {
	Period string             `json:"period" example:"day"`
	From   string             `json:"from" example:"2026-07-06T17:00:00Z"`
	To     string             `json:"to" example:"2026-07-07T09:00:00Z"`
	Items  []LeaderboardEntry `json:"items"`
}

type LeaderboardSuccessResponse = utils.BaseResponse[LeaderboardResponse]
