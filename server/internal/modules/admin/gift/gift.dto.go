package admingift

import (
	admincommon "ola-chat-server/internal/modules/admin/common"
	"ola-chat-server/internal/utils"
)

type GiftItem struct {
	ID          string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Name        string `json:"name" example:"Hoa hồng"`
	NameEn      string `json:"nameEn" example:"Rose"`
	ImageURL    string `json:"imageUrl" example:"https://cdn.ola.vn/gifts/rose.png"`
	KenPrice    int    `json:"kenPrice" example:"10"`
	CharmPoints int    `json:"charmPoints" example:"10"`
	IsActive    bool   `json:"isActive" example:"true"`
	SortOrder   int    `json:"sortOrder" example:"0"`
	CreatedAt   string `json:"createdAt" example:"2026-11-05T10:00:00Z"`
	UpdatedAt   string `json:"updatedAt" example:"2026-11-05T10:00:00Z"`
}

type GiftListResponse struct {
	Items []GiftItem `json:"items"`
}

type CreateGiftRequest struct {
	Name        string `json:"name" binding:"required,max=60" example:"Hoa hồng"`
	NameEn      string `json:"nameEn" binding:"max=60" example:"Rose"`
	ImageURL    string `json:"imageUrl" binding:"required,url,max=500" example:"https://cdn.ola.vn/gifts/rose.png"`
	KenPrice    int    `json:"kenPrice" binding:"required,min=1,max=10000000" example:"10"`
	CharmPoints int    `json:"charmPoints" binding:"min=0,max=100000000" example:"10"`
	IsActive    *bool  `json:"isActive" example:"true"`
	SortOrder   int    `json:"sortOrder" example:"0"`
}

type UpdateGiftRequest struct {
	Name        *string `json:"name" binding:"omitempty,max=60" example:"Hoa hồng"`
	NameEn      *string `json:"nameEn" binding:"omitempty,max=60" example:"Rose"`
	ImageURL    *string `json:"imageUrl" binding:"omitempty,url,max=500" example:"https://cdn.ola.vn/gifts/rose.png"`
	KenPrice    *int    `json:"kenPrice" binding:"omitempty,min=1,max=10000000" example:"10"`
	CharmPoints *int    `json:"charmPoints" binding:"omitempty,min=0,max=100000000" example:"10"`
	IsActive    *bool   `json:"isActive" example:"true"`
	SortOrder   *int    `json:"sortOrder" example:"0"`
}

type TransactionItem struct {
	ID           string                `json:"id" example:"550e8400-e29b-41d4-a716-446655440002"`
	Sender       admincommon.UserBrief `json:"sender"`
	Receiver     admincommon.UserBrief `json:"receiver"`
	GiftID       string                `json:"giftId" example:"550e8400-e29b-41d4-a716-446655440000"`
	GiftName     string                `json:"giftName" example:"Hoa hồng"`
	GiftImageURL string                `json:"giftImageUrl" example:"https://cdn.ola.vn/gifts/rose.png"`
	Quantity     int                   `json:"quantity" example:"5"`
	UnitPrice    int                   `json:"unitPrice" example:"10"`
	TotalKen     int                   `json:"totalKen" example:"50"`
	CharmPoints  int                   `json:"charmPoints" example:"50"`
	Source       string                `json:"source" example:"chat"`
	Note         string                `json:"note,omitempty" example:"Chúc mừng sinh nhật"`
	CreatedAt    string                `json:"createdAt" example:"2026-11-05T10:00:00Z"`
}

type TransactionListResponse struct {
	Total      int64             `json:"total" example:"120"`
	TotalKen   int64             `json:"totalKen" example:"25000"`
	TotalCharm int64             `json:"totalCharm" example:"25000"`
	Limit      int               `json:"limit" example:"20"`
	Offset     int               `json:"offset" example:"0"`
	Items      []TransactionItem `json:"items"`
}

type GiftListSuccessResponse = utils.BaseResponse[GiftListResponse]
type GiftItemSuccessResponse = utils.BaseResponse[GiftItem]
type TransactionListSuccessResponse = utils.BaseResponse[TransactionListResponse]
