package adminken

import (
	"time"

	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

type AdjustRequest struct {
	Action      string `json:"action" binding:"required,oneof=grant deduct" example:"grant"`
	Amount      int    `json:"amount" binding:"required,min=1" example:"500"`
	Description string `json:"description" binding:"omitempty,max=255" example:"Đền bù sự kiện"`
}

type AdjustResponse struct {
	TransactionID string `json:"transactionId" example:"550e8400-e29b-41d4-a716-446655440000"`
	UserID        string `json:"userId" example:"550e8400-e29b-41d4-a716-446655440000"`
	Action        string `json:"action" example:"grant"`
	Direction     string `json:"direction" example:"credit"`
	Type          string `json:"type" example:"ADMIN_GRANT"`
	Amount        int    `json:"amount" example:"500"`
	BalanceBefore int    `json:"balanceBefore" example:"1000"`
	BalanceAfter  int    `json:"balanceAfter" example:"1500"`
}

type CounterpartyInfo struct {
	ID       string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Username string `json:"username" example:"john_doe"`
	FullName string `json:"fullName,omitempty" example:"John Doe"`
	Avatar   string `json:"avatar,omitempty" example:"https://cdn.ola.vn/a.png"`
}

type TransactionItem struct {
	ID            string            `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Direction     string            `json:"direction" example:"credit"`
	Type          string            `json:"type" example:"ADMIN_GRANT"`
	Amount        int               `json:"amount" example:"500"`
	BalanceBefore int               `json:"balanceBefore" example:"1000"`
	BalanceAfter  int               `json:"balanceAfter" example:"1500"`
	Description   string            `json:"description" example:"Đền bù sự kiện"`
	RefType       string            `json:"refType,omitempty" example:"vip_purchase"`
	RefID         string            `json:"refId,omitempty" example:"550e8400-e29b-41d4-a716-446655440000"`
	ActorType     string            `json:"actorType,omitempty" example:"admin"`
	ActorID       string            `json:"actorId,omitempty" example:"550e8400-e29b-41d4-a716-446655440000"`
	Counterparty  *CounterpartyInfo `json:"counterparty,omitempty"`
	CreatedAt     string            `json:"createdAt" example:"2026-06-22T10:00:00Z"`
}

type TransactionListResponse struct {
	Total  int               `json:"total" example:"2"`
	Limit  int               `json:"limit" example:"20"`
	Offset int               `json:"offset" example:"0"`
	Items  []TransactionItem `json:"items"`
}

type TransferFilter struct {
	SenderID   *uuid.UUID
	ReceiverID *uuid.UUID
	UserID     *uuid.UUID
	MinAmount  *int
	MaxAmount  *int
	From       *time.Time
	To         *time.Time
}

type TransferItem struct {
	ID          string           `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	From        CounterpartyInfo `json:"from"`
	To          CounterpartyInfo `json:"to"`
	Amount      int              `json:"amount" example:"5000"`
	Description string           `json:"description,omitempty" example:"Chuyển ken"`
	CreatedAt   string           `json:"createdAt" example:"2026-07-26T10:00:00Z"`
}

type TransferListResponse struct {
	Total  int64          `json:"total" example:"1"`
	Limit  int            `json:"limit" example:"20"`
	Offset int            `json:"offset" example:"0"`
	Items  []TransferItem `json:"items"`
}

type TransferUserStatsItem struct {
	User           CounterpartyInfo `json:"user"`
	SentCount      int64            `json:"sentCount" example:"12"`
	SentTotal      int64            `json:"sentTotal" example:"60000"`
	ReceivedCount  int64            `json:"receivedCount" example:"8"`
	ReceivedTotal  int64            `json:"receivedTotal" example:"32000"`
	NetKen         int64            `json:"netKen" example:"-28000"`
	Partners       int64            `json:"partners" example:"5"`
	LastTransferAt string           `json:"lastTransferAt" example:"2026-07-26T10:00:00Z"`
}

type TransferUserStatsResponse struct {
	Total  int64                   `json:"total" example:"1"`
	Limit  int                     `json:"limit" example:"20"`
	Offset int                     `json:"offset" example:"0"`
	Items  []TransferUserStatsItem `json:"items"`
}

type AdjustSuccessResponse = utils.BaseResponse[AdjustResponse]
type TransactionListSuccessResponse = utils.BaseResponse[TransactionListResponse]
type TransferListSuccessResponse = utils.BaseResponse[TransferListResponse]
type TransferUserStatsSuccessResponse = utils.BaseResponse[TransferUserStatsResponse]
