package vip

import "ola-chat-server/internal/utils"

type VipItem struct {
	InstanceID string `json:"instanceId" example:"550e8400-e29b-41d4-a716-446655440000"`
	TypeID     int16  `json:"typeId" example:"4"`
	IsLocked   bool   `json:"isLocked" example:"false"`
	IsUsing    bool   `json:"isUsing" example:"true"`
	Source     string `json:"source" example:"purchase"`
	AcquiredAt string `json:"acquiredAt" example:"2026-06-19T10:00:00Z"`
}

type StoreQuery struct {
	Limit  int `form:"limit" binding:"omitempty,min=1,max=100"`
	Offset int `form:"offset" binding:"omitempty,min=0"`
}

type StoreResponse struct {
	UserID       string    `json:"userId" example:"550e8400-e29b-41d4-a716-446655440000"`
	ActiveTypeID *int16    `json:"activeTypeId" example:"4"`
	VipEndTime   *string   `json:"vipEndTime" example:"2026-12-31T00:00:00Z"`
	Days         *int      `json:"days" example:"30"`
	Privacy      int16     `json:"privacy" example:"0"`
	Total        int       `json:"total" example:"3"`
	Limit        int       `json:"limit" example:"50"`
	Offset       int       `json:"offset" example:"0"`
	Items        []VipItem `json:"items"`
}

type BuyRequest struct {
	TypeID int16 `json:"typeId" binding:"required,min=1,max=120" example:"4"`
}

type ExtendRequest struct {
	Days int `json:"days" binding:"required,min=1,max=3650" example:"30"`
}

type TransferRequest struct {
	ToUserID string `json:"toUserId" binding:"required,uuid" example:"550e8400-e29b-41d4-a716-446655440000"`
}

type PrivacyRequest struct {
	Privacy int16 `json:"privacy" binding:"min=0,max=2" example:"0"`
}

type MessageResponse struct {
	Message string `json:"message" example:"ok"`
}

type StoreSuccessResponse = utils.BaseResponse[StoreResponse]
type VipItemSuccessResponse = utils.BaseResponse[VipItem]
type MessageSuccessResponse = utils.BaseResponse[MessageResponse]
