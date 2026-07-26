package admingamematch

import (
	"time"

	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

type AdminMatchFilter struct {
	GameID   string
	UserID   *uuid.UUID
	WinnerID *uuid.UUID
	Status   string
	Reason   string
	Mode     string
	MinBet   *int
	MaxBet   *int
	From     *time.Time
	To       *time.Time
}

type UserBrief struct {
	ID       string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Username string `json:"username" example:"john_doe"`
	FullName string `json:"fullName,omitempty" example:"John Doe"`
	Avatar   string `json:"avatar,omitempty" example:"https://example.com/avatar.jpg"`
}

type MatchView struct {
	ID         string     `json:"id"`
	MatchID    string     `json:"matchId"`
	GameID     string     `json:"gameId" example:"caro"`
	Player0    *UserBrief `json:"player0,omitempty"`
	Player1    *UserBrief `json:"player1,omitempty"`
	WinnerID   string     `json:"winnerId,omitempty"`
	Status     string     `json:"status" example:"finished"`
	Reason     string     `json:"reason,omitempty" example:"win"`
	Mode       string     `json:"mode" example:"queue"`
	Bet        int        `json:"bet" example:"1000"`
	KenDelta   int        `json:"kenDelta" example:"900"`
	HouseTake  int        `json:"houseTake" example:"100"`
	MoveCount  int        `json:"moveCount" example:"24"`
	StartedAt  string     `json:"startedAt" example:"2026-07-24T10:00:00Z"`
	FinishedAt string     `json:"finishedAt,omitempty"`
}

type MatchListResponse struct {
	Total  int64       `json:"total" example:"1"`
	Limit  int         `json:"limit" example:"20"`
	Offset int         `json:"offset" example:"0"`
	Items  []MatchView `json:"items"`
}

type StatsOverview struct {
	TotalMatches    int64 `json:"totalMatches"`
	PlayingMatches  int64 `json:"playingMatches"`
	FinishedMatches int64 `json:"finishedMatches"`
	DecidedMatches  int64 `json:"decidedMatches"`
	DrawMatches     int64 `json:"drawMatches"`
	VoidMatches     int64 `json:"voidMatches"`
	UniquePlayers   int64 `json:"uniquePlayers"`
	TotalVolume     int64 `json:"totalVolume"`
	TotalPayout     int64 `json:"totalPayout"`
	HouseTake       int64 `json:"houseTake"`
}

type StatsGameRow struct {
	GameID    string `json:"gameId"`
	Matches   int64  `json:"matches"`
	Finished  int64  `json:"finished"`
	Volume    int64  `json:"volume"`
	HouseTake int64  `json:"houseTake"`
}

type StatsReasonRow struct {
	Reason  string  `json:"reason"`
	Count   int64   `json:"count"`
	Percent float64 `json:"percent"`
}

type StatsTimePoint struct {
	Date      string `json:"date"`
	Matches   int64  `json:"matches"`
	Finished  int64  `json:"finished"`
	Volume    int64  `json:"volume"`
	HouseTake int64  `json:"houseTake"`
}

type StatsPlayer struct {
	User    UserBrief `json:"user"`
	Matches int64     `json:"matches"`
	Wins    int64     `json:"wins"`
	Losses  int64     `json:"losses"`
	WinRate float64   `json:"winRate"`
	Staked  int64     `json:"staked"`
	NetKen  int64     `json:"netKen"`
}

type MatchStatsResponse struct {
	Overview   StatsOverview    `json:"overview"`
	ByGame     []StatsGameRow   `json:"byGame"`
	ByReason   []StatsReasonRow `json:"byReason"`
	Timeseries []StatsTimePoint `json:"timeseries"`
	TopPlayers []StatsPlayer    `json:"topPlayers"`
	Bucket     string           `json:"bucket"`
}

type SuspectPair struct {
	UserA        UserBrief `json:"userA"`
	UserB        UserBrief `json:"userB"`
	Matches      int64     `json:"matches"`
	Decided      int64     `json:"decided"`
	AWins        int64     `json:"aWins"`
	BWins        int64     `json:"bWins"`
	OneSidedRate float64   `json:"oneSidedRate"`
	TotalBet     int64     `json:"totalBet"`
	NetA         int64     `json:"netA"`
}

type SuspectsResponse struct {
	MinMatches     int           `json:"minMatches"`
	MinPairMatches int           `json:"minPairMatches"`
	Players        []StatsPlayer `json:"players"`
	Pairs          []SuspectPair `json:"pairs"`
}

type MatchListSuccessResponse = utils.BaseResponse[MatchListResponse]
type MatchStatsSuccessResponse = utils.BaseResponse[MatchStatsResponse]
type SuspectsSuccessResponse = utils.BaseResponse[SuspectsResponse]
