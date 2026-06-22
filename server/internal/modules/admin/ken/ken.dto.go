package adminken

import "ola-chat-server/internal/utils"

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

type TransactionItem struct {
	ID            string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Direction     string `json:"direction" example:"credit"`
	Type          string `json:"type" example:"ADMIN_GRANT"`
	Amount        int    `json:"amount" example:"500"`
	BalanceBefore int    `json:"balanceBefore" example:"1000"`
	BalanceAfter  int    `json:"balanceAfter" example:"1500"`
	Description   string `json:"description" example:"Đền bù sự kiện"`
	RefType       string `json:"refType,omitempty" example:"vip_purchase"`
	RefID         string `json:"refId,omitempty" example:"550e8400-e29b-41d4-a716-446655440000"`
	ActorType     string `json:"actorType,omitempty" example:"admin"`
	ActorID       string `json:"actorId,omitempty" example:"550e8400-e29b-41d4-a716-446655440000"`
	CreatedAt     string `json:"createdAt" example:"2026-06-22T10:00:00Z"`
}

type TransactionListResponse struct {
	Total  int               `json:"total" example:"2"`
	Limit  int               `json:"limit" example:"20"`
	Offset int               `json:"offset" example:"0"`
	Items  []TransactionItem `json:"items"`
}

type AdjustSuccessResponse = utils.BaseResponse[AdjustResponse]
type TransactionListSuccessResponse = utils.BaseResponse[TransactionListResponse]
