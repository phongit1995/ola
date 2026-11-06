package megaphone

import (
	megaphoneEvents "ola-chat-server/internal/domain/megaphone"
	"ola-chat-server/internal/utils"
)

type ConfigResponse struct {
	Enabled           bool `json:"enabled" example:"true"`
	KenPrice          int  `json:"kenPrice" example:"5000"`
	MaxLength         int  `json:"maxLength" example:"80"`
	DisplaySeconds    int  `json:"displaySeconds" example:"12"`
	LiveMinutes       int  `json:"liveMinutes" example:"30"`
	CooldownSeconds   int  `json:"cooldownSeconds" example:"60"`
	DailyLimit        int  `json:"dailyLimit" example:"20"`
	TodayCount        int  `json:"todayCount" example:"2"`
	CooldownRemaining int  `json:"cooldownRemaining" example:"0"`
	QueueWaitSeconds  int  `json:"queueWaitSeconds" example:"25"`
}

type SendRequest struct {
	Content         string `json:"content" binding:"required,max=1000" example:"Chúc cả nhà buổi tối vui vẻ 🎉"`
	ClientRequestID string `json:"clientRequestId" binding:"required,max=64" example:"7d0f3a8e-2f6b-4c1e-9a55-3a3e1c2b9f10"`
}

type SendResponse struct {
	Megaphone   megaphoneEvents.Megaphone `json:"megaphone"`
	KenBalance  int                       `json:"kenBalance" example:"8000"`
	WaitSeconds int                       `json:"waitSeconds" example:"25"`
}

type HistoryResponse struct {
	Items      []megaphoneEvents.Megaphone `json:"items"`
	NextCursor string                      `json:"nextCursor,omitempty"`
}

type ConfigSuccessResponse = utils.BaseResponse[ConfigResponse]
type SendSuccessResponse = utils.BaseResponse[SendResponse]
type HistorySuccessResponse = utils.BaseResponse[HistoryResponse]
