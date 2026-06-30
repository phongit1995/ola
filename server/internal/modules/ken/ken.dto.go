package ken

import "ola-chat-server/internal/utils"

type TransferRequest struct {
	ToUserID string `json:"toUserId" binding:"required,uuid" example:"550e8400-e29b-41d4-a716-446655440000"`
	Amount   int    `json:"amount" binding:"required,min=1000,max=10000000" example:"1000"`
}

type TransferResponse struct {
	ToUserID   string `json:"toUserId" example:"550e8400-e29b-41d4-a716-446655440000"`
	Amount     int    `json:"amount" example:"1000"`
	KenBalance int    `json:"kenBalance" example:"8000"`
}

type TransferSuccessResponse = utils.BaseResponse[TransferResponse]
