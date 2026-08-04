package wheel

import (
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
)

type OptionInput struct {
	Label     string  `json:"label" binding:"required,max=100"`
	Weight    float64 `json:"weight" binding:"gte=0"`
	VipTypeID *int16  `json:"vipTypeId"`
	VipDays   *int    `json:"vipDays"`
	KenAmount *int    `json:"kenAmount"`
	IsActive  bool    `json:"isActive"`
	SortOrder int     `json:"sortOrder"`
}

type SegmentInput struct {
	Kind         models.WheelSegmentKind `json:"kind" binding:"required,oneof=miss ken_fixed ken_random vip_days vip_item vip_random"`
	Label        string                  `json:"label" binding:"required,max=100"`
	Weight       float64                 `json:"weight" binding:"gte=0"`
	KenAmount    *int                    `json:"kenAmount"`
	KenMin       *int                    `json:"kenMin"`
	KenMax       *int                    `json:"kenMax"`
	VipDays      *int                    `json:"vipDays"`
	VipTypeID    *int16                  `json:"vipTypeId"`
	IsSuperLucky bool                    `json:"isSuperLucky"`
	IsActive     bool                    `json:"isActive"`
	SortOrder    int                     `json:"sortOrder"`
	Options      []OptionInput           `json:"options"`
}

type SaveConfigRequest struct {
	Segments []SegmentInput `json:"segments"`
}

type CreateWheelRequest struct {
	Name             string         `json:"name" binding:"required,max=100"`
	KenCost          int            `json:"kenCost" binding:"gte=0"`
	FreeDailyEnabled bool           `json:"freeDailyEnabled"`
	IsEnabled        bool           `json:"isEnabled"`
	SortOrder        int            `json:"sortOrder"`
	Segments         []SegmentInput `json:"segments"`
}

type UpdateWheelRequest struct {
	Name             *string `json:"name"`
	KenCost          *int    `json:"kenCost"`
	FreeDailyEnabled *bool   `json:"freeDailyEnabled"`
	IsEnabled        *bool   `json:"isEnabled"`
	SortOrder        *int    `json:"sortOrder"`
}

type SpinRequest struct {
	IdempotencyKey string `json:"idempotencyKey"`
}

type OptionView struct {
	ID        uuid.UUID `json:"id"`
	Label     string    `json:"label"`
	Weight    float64   `json:"weight"`
	VipTypeID *int16    `json:"vipTypeId,omitempty"`
	VipDays   *int      `json:"vipDays,omitempty"`
	KenAmount *int      `json:"kenAmount,omitempty"`
	IsActive  bool      `json:"isActive"`
	SortOrder int       `json:"sortOrder"`
}

type SegmentView struct {
	ID           uuid.UUID               `json:"id"`
	Kind         models.WheelSegmentKind `json:"kind"`
	Label        string                  `json:"label"`
	Weight       float64                 `json:"weight"`
	KenAmount    *int                    `json:"kenAmount,omitempty"`
	KenMin       *int                    `json:"kenMin,omitempty"`
	KenMax       *int                    `json:"kenMax,omitempty"`
	VipDays      *int                    `json:"vipDays,omitempty"`
	VipTypeID    *int16                  `json:"vipTypeId,omitempty"`
	IsSuperLucky bool                    `json:"isSuperLucky"`
	IsActive     bool                    `json:"isActive"`
	SortOrder    int                     `json:"sortOrder"`
	Options      []OptionView            `json:"options"`
}

type WheelView struct {
	ID               uuid.UUID     `json:"id"`
	Name             string        `json:"name"`
	KenCost          int           `json:"kenCost"`
	FreeDailyEnabled bool          `json:"freeDailyEnabled"`
	IsEnabled        bool          `json:"isEnabled"`
	SortOrder        int           `json:"sortOrder"`
	Segments         []SegmentView `json:"segments"`
}

type WheelListResponse struct {
	Items []WheelView `json:"items"`
}

type PlayerOptionView struct {
	Label     string `json:"label"`
	VipTypeID *int16 `json:"vipTypeId,omitempty"`
	VipDays   *int   `json:"vipDays,omitempty"`
	KenAmount *int   `json:"kenAmount,omitempty"`
}

type PlayerSegmentView struct {
	ID        uuid.UUID               `json:"id"`
	Kind      models.WheelSegmentKind `json:"kind"`
	Label     string                  `json:"label"`
	KenAmount *int                    `json:"kenAmount,omitempty"`
	KenMin    *int                    `json:"kenMin,omitempty"`
	KenMax    *int                    `json:"kenMax,omitempty"`
	VipDays   *int                    `json:"vipDays,omitempty"`
	VipTypeID *int16                  `json:"vipTypeId,omitempty"`
	SortOrder int                     `json:"sortOrder"`
	Options   []PlayerOptionView      `json:"options,omitempty"`
}

type PlayerConfigResponse struct {
	ID               uuid.UUID           `json:"id"`
	Name             string              `json:"name"`
	KenCost          int                 `json:"kenCost"`
	FreeDailyEnabled bool                `json:"freeDailyEnabled"`
	FreeAvailable    bool                `json:"freeAvailable"`
	Segments         []PlayerSegmentView `json:"segments"`
}

type SpinResult struct {
	SpinID              uuid.UUID               `json:"spinId"`
	WheelID             uuid.UUID               `json:"wheelId"`
	SegmentIndex        int                     `json:"segmentIndex"`
	SegmentID           uuid.UUID               `json:"segmentId"`
	SegmentKind         models.WheelSegmentKind `json:"segmentKind"`
	IsWin               bool                    `json:"isWin"`
	IsSuperLucky        bool                    `json:"isSuperLucky"`
	KenCost             int                     `json:"kenCost"`
	IsFree              bool                    `json:"isFree"`
	KenBalance          int                     `json:"kenBalance"`
	KenBalanceAfterCost int                     `json:"kenBalanceAfterCost"`
	FreeAvailable       bool                    `json:"freeAvailable"`
	RewardLabel         *string                 `json:"rewardLabel,omitempty"`
	KenAmount           *int                    `json:"kenAmount,omitempty"`
	VipDays             *int                    `json:"vipDays,omitempty"`
	VipTypeID           *int16                  `json:"vipTypeId,omitempty"`
}

type SpinView struct {
	ID           uuid.UUID               `json:"id"`
	WheelID      uuid.UUID               `json:"wheelId"`
	WheelName    string                  `json:"wheelName"`
	KenCost      int                     `json:"kenCost"`
	IsFree       bool                    `json:"isFree"`
	SegmentKind  models.WheelSegmentKind `json:"segmentKind"`
	RewardLabel  *string                 `json:"rewardLabel,omitempty"`
	KenAmount    *int                    `json:"kenAmount,omitempty"`
	VipDays      *int                    `json:"vipDays,omitempty"`
	VipTypeID    *int16                  `json:"vipTypeId,omitempty"`
	IsSuperLucky bool                    `json:"isSuperLucky"`
	CreatedAt    time.Time               `json:"createdAt"`
}

type SpinListResponse struct {
	Items  []SpinView `json:"items"`
	Total  int64      `json:"total"`
	Limit  int        `json:"limit"`
	Offset int        `json:"offset"`
}

type SpinUserView struct {
	ID       uuid.UUID `json:"id"`
	Username string    `json:"username"`
	FullName string    `json:"fullName"`
	Avatar   string    `json:"avatar"`
}

type AdminSpinView struct {
	SpinView
	User SpinUserView `json:"user"`
}

type AdminSpinListResponse struct {
	Items  []AdminSpinView `json:"items"`
	Total  int64           `json:"total"`
	Limit  int             `json:"limit"`
	Offset int             `json:"offset"`
}

type StatsOverview struct {
	TotalSpins    int64   `json:"totalSpins"`
	UniquePlayers int64   `json:"uniquePlayers"`
	KenIn         int64   `json:"kenIn"`
	KenOut        int64   `json:"kenOut"`
	VipDaysOut    int64   `json:"vipDaysOut"`
	VipItemsOut   int64   `json:"vipItemsOut"`
	FreeSpins     int64   `json:"freeSpins"`
	WinSpins      int64   `json:"winSpins"`
	WinRate       float64 `json:"winRate"`
	NetKen        int64   `json:"netKen"`
}

type StatsKind struct {
	SegmentKind models.WheelSegmentKind `json:"segmentKind"`
	Spins       int64                   `json:"spins"`
	Percent     float64                 `json:"percent"`
}

type StatsReward struct {
	SegmentKind models.WheelSegmentKind `json:"segmentKind"`
	RewardLabel string                  `json:"rewardLabel"`
	Count       int64                   `json:"count"`
}

type StatsWheel struct {
	WheelID   uuid.UUID `json:"wheelId"`
	WheelName string    `json:"wheelName"`
	Spins     int64     `json:"spins"`
	KenIn     int64     `json:"kenIn"`
	KenOut    int64     `json:"kenOut"`
	Rtp       float64   `json:"rtp"`
}

type StatsTimePoint struct {
	Date   string `json:"date"`
	Spins  int64  `json:"spins"`
	KenIn  int64  `json:"kenIn"`
	KenOut int64  `json:"kenOut"`
}

type StatsPlayer struct {
	User     SpinUserView `json:"user"`
	Spins    int64        `json:"spins"`
	KenSpent int64        `json:"kenSpent"`
}

type StatsResponse struct {
	Overview   StatsOverview    `json:"overview"`
	ByKind     []StatsKind      `json:"byKind"`
	TopRewards []StatsReward    `json:"topRewards"`
	ByWheel    []StatsWheel     `json:"byWheel"`
	Timeseries []StatsTimePoint `json:"timeseries"`
	TopPlayers []StatsPlayer    `json:"topPlayers"`
	Bucket     string           `json:"bucket"`
}
