package gift

import "ola-chat-server/internal/utils"

type GiftItem struct {
	ID          string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Name        string `json:"name" example:"Hoa hồng"`
	NameEn      string `json:"nameEn,omitempty" example:"Rose"`
	ImageURL    string `json:"imageUrl" example:"https://cdn.ola.vn/gifts/rose.png"`
	KenPrice    int    `json:"kenPrice" example:"10"`
	CharmPoints int    `json:"charmPoints" example:"10"`
	Animation   string `json:"animation" example:"random"`
}

type GiftSettingsView struct {
	Enabled         bool  `json:"enabled" example:"true"`
	QuantityOptions []int `json:"quantityOptions"`
	QuantityMax     int   `json:"quantityMax" example:"99"`
	NoteMaxLength   int   `json:"noteMaxLength" example:"100"`
	ConfirmOverKen  int   `json:"confirmOverKen" example:"1000"`
}

type GiftCatalogResponse struct {
	Items    []GiftItem       `json:"items"`
	Settings GiftSettingsView `json:"settings"`
}

type SendGiftRequest struct {
	GiftID          string `json:"giftId" binding:"required,uuid" example:"550e8400-e29b-41d4-a716-446655440000"`
	ReceiverID      string `json:"receiverId" binding:"required,uuid" example:"550e8400-e29b-41d4-a716-446655440001"`
	Quantity        int    `json:"quantity" binding:"required,min=1" example:"5"`
	Note            string `json:"note" binding:"max=400" example:"Chúc mừng sinh nhật"`
	Source          string `json:"source" binding:"required,oneof=chat profile" example:"chat"`
	ClientRequestID string `json:"clientRequestId" binding:"required,max=64" example:"7d0f3a8e-2f6b-4c1e-9a55-3a3e1c2b9f10"`
}

type SendGiftResponse struct {
	TransactionID  string   `json:"transactionId" example:"550e8400-e29b-41d4-a716-446655440002"`
	Gift           GiftItem `json:"gift"`
	ReceiverID     string   `json:"receiverId" example:"550e8400-e29b-41d4-a716-446655440001"`
	Quantity       int      `json:"quantity" example:"5"`
	TotalKen       int      `json:"totalKen" example:"50"`
	CharmPoints    int      `json:"charmPoints" example:"50"`
	Note           string   `json:"note,omitempty" example:"Chúc mừng sinh nhật"`
	KenBalance     int      `json:"kenBalance" example:"950"`
	ReceiverCharm  int      `json:"receiverCharm" example:"1200"`
	ConversationID string   `json:"conversationId,omitempty" example:"550e8400-e29b-41d4-a716-446655440003"`
	MessageID      string   `json:"messageId,omitempty" example:"a1b2c3d4-0000-11ef-8000-000000000000"`
	CreatedAt      string   `json:"createdAt" example:"2026-11-05T10:00:00Z"`
}

type GiftMessageMetadata struct {
	TransactionID string `json:"transactionId"`
	GiftID        string `json:"giftId"`
	GiftName      string `json:"giftName"`
	GiftNameEn    string `json:"giftNameEn,omitempty"`
	ImageURL      string `json:"imageUrl"`
	Animation     string `json:"animation,omitempty"`
	Quantity      int    `json:"quantity"`
	CharmPoints   int    `json:"charmPoints"`
}

type GiftUserBrief struct {
	ID         string  `json:"id" example:"550e8400-e29b-41d4-a716-446655440001"`
	Username   string  `json:"username" example:"minh"`
	FullName   string  `json:"fullName,omitempty" example:"Minh"`
	Avatar     string  `json:"avatar,omitempty" example:"https://cdn.ola.vn/a.png"`
	Gender     string  `json:"gender,omitempty" example:"female"`
	VipUsed    *string `json:"vipUsed,omitempty"`
	VipEndTime *string `json:"vipEndTime,omitempty"`
}

type GiftWallItem struct {
	Gift     GiftItem `json:"gift"`
	Quantity int      `json:"quantity" example:"12"`
}

type GiftWallResponse struct {
	UserID     string         `json:"userId" example:"550e8400-e29b-41d4-a716-446655440001"`
	Charm      int            `json:"charm" example:"1200"`
	TotalGifts int            `json:"totalGifts" example:"34"`
	Items      []GiftWallItem `json:"items"`
}

type GiftHistoryItem struct {
	ID            string        `json:"id" example:"550e8400-e29b-41d4-a716-446655440002"`
	Counterparty  GiftUserBrief `json:"counterparty"`
	GiftID        string        `json:"giftId" example:"550e8400-e29b-41d4-a716-446655440000"`
	GiftName      string        `json:"giftName" example:"Hoa hồng"`
	GiftImageURL  string        `json:"giftImageUrl" example:"https://cdn.ola.vn/gifts/rose.png"`
	GiftAnimation string        `json:"giftAnimation" example:"random"`
	Quantity      int           `json:"quantity" example:"5"`
	TotalKen      int           `json:"totalKen" example:"50"`
	CharmPoints   int           `json:"charmPoints" example:"50"`
	Note          string        `json:"note,omitempty" example:"Chúc mừng sinh nhật"`
	Source        string        `json:"source" example:"chat"`
	CreatedAt     string        `json:"createdAt" example:"2026-11-05T10:00:00Z"`
}

type GiftHistoryResponse struct {
	Items      []GiftHistoryItem `json:"items"`
	NextCursor string            `json:"nextCursor,omitempty"`
}

type LeaderboardEntry struct {
	Rank  int           `json:"rank" example:"1"`
	User  GiftUserBrief `json:"user"`
	Value int64         `json:"value" example:"25000"`
}

type LeaderboardMe struct {
	Rank  int   `json:"rank" example:"12"`
	Value int64 `json:"value" example:"300"`
}

type LeaderboardResponse struct {
	Type   string             `json:"type" example:"receiver"`
	Period string             `json:"period" example:"week"`
	Items  []LeaderboardEntry `json:"items"`
	Me     LeaderboardMe      `json:"me"`
}

type GiftCatalogSuccessResponse = utils.BaseResponse[GiftCatalogResponse]
type SendGiftSuccessResponse = utils.BaseResponse[SendGiftResponse]
type GiftWallSuccessResponse = utils.BaseResponse[GiftWallResponse]
type GiftHistorySuccessResponse = utils.BaseResponse[GiftHistoryResponse]
type LeaderboardSuccessResponse = utils.BaseResponse[LeaderboardResponse]
