package admintopup

import (
	"time"

	userModule "ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/utils"
)

type ListFilter struct {
	Status string
	Type   string
	Search string
	From   *time.Time
	To     *time.Time
}

type UserInfo = userModule.UserBrief

type TransactionItem struct {
	ID              string    `json:"id"`
	ProviderTxID    string    `json:"providerTxId"`
	Description     string    `json:"description"`
	Amount          int64     `json:"amount"`
	Type            string    `json:"type"`
	Status          string    `json:"status"`
	MatchedUsername string    `json:"matchedUsername,omitempty"`
	KenAmount       int64     `json:"kenAmount"`
	BonusKen        int64     `json:"bonusKen"`
	BonusPercent    int       `json:"bonusPercent"`
	KenTxID         string    `json:"kenTxId,omitempty"`
	Note            string    `json:"note,omitempty"`
	User            *UserInfo `json:"user,omitempty"`
	CreatedAt       string    `json:"createdAt"`
	UpdatedAt       string    `json:"updatedAt"`
}

type TransactionListResponse = utils.Page[TransactionItem]

type ManualCreditRequest struct {
	Username string `json:"username" binding:"required"`
}

type ManualCreditResponse struct {
	ID           string   `json:"id"`
	Status       string   `json:"status"`
	KenAmount    int64    `json:"kenAmount"`
	BonusKen     int64    `json:"bonusKen"`
	BonusPercent int      `json:"bonusPercent"`
	BalanceAfter int      `json:"balanceAfter"`
	User         UserInfo `json:"user"`
}

type StatsTotals struct {
	Count  int64 `json:"count"`
	Amount int64 `json:"amount"`
	Ken    int64 `json:"ken"`
}

type StatsSeriesItem struct {
	Date   string `json:"date"`
	Amount int64  `json:"amount"`
	Ken    int64  `json:"ken"`
	Count  int64  `json:"count"`
}

type StatsResponse struct {
	Bucket    string            `json:"bucket"`
	Today     StatsTotals       `json:"today"`
	ThisMonth StatsTotals       `json:"thisMonth"`
	Range     StatsTotals       `json:"range"`
	Pending   StatsTotals       `json:"pending"`
	Series    []StatsSeriesItem `json:"series"`
}

type StatsSuccessResponse struct {
	Success bool          `json:"success"`
	Data    StatsResponse `json:"data"`
}

type TransactionListSuccessResponse struct {
	Success bool                    `json:"success"`
	Data    TransactionListResponse `json:"data"`
}

type ManualCreditSuccessResponse struct {
	Success bool                 `json:"success"`
	Data    ManualCreditResponse `json:"data"`
}
