package egg

import (
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
)

type RewardInput struct {
	Label        string  `json:"label" binding:"required,max=100"`
	Weight       float64 `json:"weight" binding:"gte=0"`
	VipTypeID    *int16  `json:"vipTypeId"`
	KenAmount    *int    `json:"kenAmount"`
	VipDays      *int    `json:"vipDays"`
	IsSuperLucky bool    `json:"isSuperLucky"`
	IsActive     bool    `json:"isActive"`
	SortOrder    int     `json:"sortOrder"`
}

type CategoryInput struct {
	Type      models.EggCategoryType `json:"type" binding:"required,oneof=nothing vip_icon ken vip_days"`
	Label     string                 `json:"label" binding:"required,max=100"`
	Weight    float64                `json:"weight" binding:"gte=0"`
	IsActive  bool                   `json:"isActive"`
	SortOrder int                    `json:"sortOrder"`
	Rewards   []RewardInput          `json:"rewards"`
}

type SaveConfigRequest struct {
	Categories []CategoryInput `json:"categories"`
}

type CreatePackRequest struct {
	Name       string          `json:"name" binding:"required,max=100"`
	KenCost    int             `json:"kenCost" binding:"gte=0"`
	IsEnabled  bool            `json:"isEnabled"`
	SortOrder  int             `json:"sortOrder"`
	Categories []CategoryInput `json:"categories"`
}

type UpdatePackRequest struct {
	Name      *string `json:"name"`
	KenCost   *int    `json:"kenCost"`
	IsEnabled *bool   `json:"isEnabled"`
	SortOrder *int    `json:"sortOrder"`
}

type OpenPackRequest struct {
	IdempotencyKey string `json:"idempotencyKey"`
}

type RewardView struct {
	ID           uuid.UUID `json:"id"`
	Label        string    `json:"label"`
	Weight       float64   `json:"weight"`
	VipTypeID    *int16    `json:"vipTypeId,omitempty"`
	KenAmount    *int      `json:"kenAmount,omitempty"`
	VipDays      *int      `json:"vipDays,omitempty"`
	IsSuperLucky bool      `json:"isSuperLucky"`
	IsActive     bool      `json:"isActive"`
	SortOrder    int       `json:"sortOrder"`
}

type CategoryView struct {
	ID        uuid.UUID              `json:"id"`
	Type      models.EggCategoryType `json:"type"`
	Label     string                 `json:"label"`
	Weight    float64                `json:"weight"`
	IsActive  bool                   `json:"isActive"`
	SortOrder int                    `json:"sortOrder"`
	Rewards   []RewardView           `json:"rewards"`
}

type PackView struct {
	ID         uuid.UUID      `json:"id"`
	Name       string         `json:"name"`
	KenCost    int            `json:"kenCost"`
	IsEnabled  bool           `json:"isEnabled"`
	SortOrder  int            `json:"sortOrder"`
	Categories []CategoryView `json:"categories,omitempty"`
}

type PackListResponse struct {
	Items []PackView `json:"items"`
}

type GiftRewardView struct {
	Label        string `json:"label"`
	VipTypeID    *int16 `json:"vipTypeId,omitempty"`
	KenAmount    *int   `json:"kenAmount,omitempty"`
	VipDays      *int   `json:"vipDays,omitempty"`
	IsSuperLucky bool   `json:"isSuperLucky"`
}

type GiftSectionView struct {
	Type    models.EggCategoryType `json:"type"`
	Rewards []GiftRewardView       `json:"rewards"`
}

type GiftListResponse struct {
	Items []GiftSectionView `json:"items"`
}

type OpenResult struct {
	DrawID       uuid.UUID              `json:"drawId"`
	PackID       uuid.UUID              `json:"packId"`
	KenCost      int                    `json:"kenCost"`
	KenBalance   int                    `json:"kenBalance"`
	CategoryType models.EggCategoryType `json:"categoryType"`
	IsWin        bool                   `json:"isWin"`
	IsSuperLucky bool                   `json:"isSuperLucky"`
	RewardType   *string                `json:"rewardType,omitempty"`
	RewardLabel  *string                `json:"rewardLabel,omitempty"`
	VipTypeID    *int16                 `json:"vipTypeId,omitempty"`
	KenAmount    *int                   `json:"kenAmount,omitempty"`
	VipDays      *int                   `json:"vipDays,omitempty"`
}

type DrawView struct {
	ID           uuid.UUID              `json:"id"`
	PackID       uuid.UUID              `json:"packId"`
	PackName     string                 `json:"packName"`
	KenCost      int                    `json:"kenCost"`
	CategoryType models.EggCategoryType `json:"categoryType"`
	RewardType   *string                `json:"rewardType,omitempty"`
	RewardLabel  *string                `json:"rewardLabel,omitempty"`
	VipTypeID    *int16                 `json:"vipTypeId,omitempty"`
	KenAmount    *int                   `json:"kenAmount,omitempty"`
	VipDays      *int                   `json:"vipDays,omitempty"`
	IsSuperLucky bool                   `json:"isSuperLucky"`
	CreatedAt    time.Time              `json:"createdAt"`
}

type DrawListResponse struct {
	Items  []DrawView `json:"items"`
	Total  int64      `json:"total"`
	Limit  int        `json:"limit"`
	Offset int        `json:"offset"`
}

type DrawUserView struct {
	ID       uuid.UUID `json:"id"`
	Username string    `json:"username"`
	FullName string    `json:"fullName"`
	Avatar   string    `json:"avatar"`
}

type AdminDrawView struct {
	DrawView
	User DrawUserView `json:"user"`
}

type AdminDrawListResponse struct {
	Items  []AdminDrawView `json:"items"`
	Total  int64           `json:"total"`
	Limit  int             `json:"limit"`
	Offset int             `json:"offset"`
}

type StatsOverview struct {
	TotalDraws    int64   `json:"totalDraws"`
	UniquePlayers int64   `json:"uniquePlayers"`
	KenIn         int64   `json:"kenIn"`
	KenOut        int64   `json:"kenOut"`
	VipDaysOut    int64   `json:"vipDaysOut"`
	VipIconsOut   int64   `json:"vipIconsOut"`
	WinDraws      int64   `json:"winDraws"`
	WinRate       float64 `json:"winRate"`
	NetKen        int64   `json:"netKen"`
}

type StatsCategory struct {
	CategoryType models.EggCategoryType `json:"categoryType"`
	Draws        int64                  `json:"draws"`
	Percent      float64                `json:"percent"`
}

type StatsReward struct {
	CategoryType models.EggCategoryType `json:"categoryType"`
	RewardLabel  string                 `json:"rewardLabel"`
	Count        int64                  `json:"count"`
}

type StatsPack struct {
	PackID   uuid.UUID `json:"packId"`
	PackName string    `json:"packName"`
	Draws    int64     `json:"draws"`
	KenIn    int64     `json:"kenIn"`
	KenOut   int64     `json:"kenOut"`
	Rtp      float64   `json:"rtp"`
}

type StatsTimePoint struct {
	Date   string `json:"date"`
	Draws  int64  `json:"draws"`
	KenIn  int64  `json:"kenIn"`
	KenOut int64  `json:"kenOut"`
}

type StatsPlayer struct {
	User     DrawUserView `json:"user"`
	Draws    int64        `json:"draws"`
	KenSpent int64        `json:"kenSpent"`
}

type StatsResponse struct {
	Overview   StatsOverview    `json:"overview"`
	ByCategory []StatsCategory  `json:"byCategory"`
	TopRewards []StatsReward    `json:"topRewards"`
	ByPack     []StatsPack      `json:"byPack"`
	Timeseries []StatsTimePoint `json:"timeseries"`
	TopPlayers []StatsPlayer    `json:"topPlayers"`
	Bucket     string           `json:"bucket"`
}
