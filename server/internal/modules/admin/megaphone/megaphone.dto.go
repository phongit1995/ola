package adminmegaphone

import (
	admincommon "ola-chat-server/internal/modules/admin/common"
	contentfilter "ola-chat-server/internal/modules/content-filter"
	"ola-chat-server/internal/modules/moderation"
	"ola-chat-server/internal/utils"
)

type MegaphoneItem struct {
	ID             string                `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Type           string                `json:"type" example:"message"`
	Sender         admincommon.UserBrief `json:"sender"`
	Content        string                `json:"content" example:"Chúc cả nhà buổi tối vui vẻ"`
	KenPrice       int                   `json:"kenPrice" example:"2000"`
	ShowAt         string                `json:"showAt" example:"2026-11-06T10:00:00Z"`
	DisplaySeconds int                   `json:"displaySeconds" example:"12"`
	ExpiresAt      string                `json:"expiresAt" example:"2026-11-06T10:30:00Z"`
	Status         string                `json:"status" example:"active"`
	RemovedReason  string                `json:"removedReason,omitempty" example:"Quảng cáo"`
	RemovedAt      string                `json:"removedAt,omitempty" example:"2026-11-06T10:05:00Z"`
	CreatedAt      string                `json:"createdAt" example:"2026-11-06T09:59:50Z"`
}

type ListResponse struct {
	Items    []MegaphoneItem `json:"items"`
	Total    int64           `json:"total" example:"120"`
	TotalKen int64           `json:"totalKen" example:"240000"`
	Limit    int             `json:"limit" example:"20"`
	Offset   int             `json:"offset" example:"0"`
}

type PenaltyRequest struct {
	Reason   string `json:"reason" binding:"required,oneof=spam sensitive scam harassment copyright other" example:"scam"`
	Severity string `json:"severity" binding:"required,oneof=none violation deliberate" example:"violation"`
	Note     string `json:"note" binding:"omitempty,max=1000" example:"Rao bán KEN"`
}

type RemoveRequest struct {
	Reason  string          `json:"reason" binding:"omitempty,max=200" example:"Rao bán KEN"`
	Penalty *PenaltyRequest `json:"penalty"`
}

type RemoveResponse struct {
	Item    MegaphoneItem              `json:"item"`
	Penalty *moderation.PenaltyOutcome `json:"penalty,omitempty"`
}

type CheckContentRequest struct {
	Text string `json:"text" binding:"required,max=1000" example:"ai cần nạp ken giá rẻ ib"`
}

type ListSuccessResponse = utils.BaseResponse[ListResponse]
type RemoveSuccessResponse = utils.BaseResponse[RemoveResponse]
type CheckContentSuccessResponse = utils.BaseResponse[contentfilter.Result]
