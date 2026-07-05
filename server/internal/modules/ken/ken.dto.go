package ken

import "ola-chat-server/internal/utils"

type TransferRequest struct {
	ToUserID string `json:"toUserId" binding:"required,uuid" example:"550e8400-e29b-41d4-a716-446655440000"`
	Amount   int    `json:"amount" binding:"required,min=1000,max=10000000" example:"1000"`
	Password string `json:"password" binding:"required" example:"password123"`
}

type TransferResponse struct {
	ToUserID   string `json:"toUserId" example:"550e8400-e29b-41d4-a716-446655440000"`
	Amount     int    `json:"amount" example:"1000"`
	KenBalance int    `json:"kenBalance" example:"8000"`
}

type TransferSuccessResponse = utils.BaseResponse[TransferResponse]

type KenTransactionItem struct {
	ID           string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Direction    string `json:"direction" example:"credit"`
	Type         string `json:"type" example:"TRANSFER_IN"`
	Amount       int    `json:"amount" example:"1000"`
	BalanceAfter int    `json:"balanceAfter" example:"9000"`
	Description  string `json:"description,omitempty"`
	CreatedAt    string `json:"createdAt" example:"2026-06-22T10:00:00Z"`

	CounterpartyID   string `json:"counterpartyId,omitempty" example:"550e8400-e29b-41d4-a716-446655440000"`
	CounterpartyName string `json:"counterpartyName,omitempty" example:"minh"`
}

type KenHistoryResponse struct {
	Total  int                  `json:"total" example:"2"`
	Limit  int                  `json:"limit" example:"20"`
	Offset int                  `json:"offset" example:"0"`
	Items  []KenTransactionItem `json:"items"`
}

type KenHistorySuccessResponse = utils.BaseResponse[KenHistoryResponse]
