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
	ShopItemID string `json:"shopItemId" binding:"required,uuid" example:"550e8400-e29b-41d4-a716-446655440000"`
}

type TransferRequest struct {
	ToUserID string `json:"toUserId" binding:"required,uuid" example:"550e8400-e29b-41d4-a716-446655440000"`
	Password string `json:"password" binding:"required"`
}

type PrivacyRequest struct {
	Privacy int16 `json:"privacy" binding:"min=0,max=2" example:"0"`
}

type BatchDeleteRequest struct {
	IDs []string `json:"ids" binding:"required,min=1,max=100,dive,uuid" example:"550e8400-e29b-41d4-a716-446655440000"`
}

type BatchDeleteResponse struct {
	Deleted int `json:"deleted" example:"3"`
}

type MessageResponse struct {
	Message string `json:"message" example:"ok"`
}

type PackageItem struct {
	ID        string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Name      string `json:"name" example:"Gói 30 ngày"`
	Days      int    `json:"days" example:"30"`
	KenPrice  int    `json:"kenPrice" example:"250"`
	IsActive  bool   `json:"isActive" example:"true"`
	SortOrder int    `json:"sortOrder" example:"2"`
}

type PackageListResponse struct {
	Total  int           `json:"total" example:"4"`
	Limit  int           `json:"limit" example:"50"`
	Offset int           `json:"offset" example:"0"`
	Items  []PackageItem `json:"items"`
}

type BuyPackageResponse struct {
	PurchaseID  string `json:"purchaseId" example:"550e8400-e29b-41d4-a716-446655440000"`
	PackageName string `json:"packageName" example:"Gói 30 ngày"`
	Days        int    `json:"days" example:"30"`
	KenSpent    int    `json:"kenSpent" example:"250"`
	KenBalance  int    `json:"kenBalance" example:"1750"`
	VipEndTime  string `json:"vipEndTime" example:"2026-12-31T00:00:00Z"`
}

type GiftPackageRequest struct {
	ToUsername string `json:"toUsername" binding:"required" example:"minhanh"`
	Password   string `json:"password" binding:"required" example:"password123"`
}

type GiftPackageResponse struct {
	ReceiverUsername string `json:"receiverUsername" example:"minhanh"`
	Days             int    `json:"days" example:"30"`
	KenSpent         int    `json:"kenSpent" example:"250"`
	KenBalance       int    `json:"kenBalance" example:"1750"`
	VipEndTime       string `json:"vipEndTime" example:"2026-12-31T00:00:00Z"`
}

type GiftIconRequest struct {
	ShopItemID string `json:"shopItemId" binding:"required,uuid" example:"550e8400-e29b-41d4-a716-446655440000"`
	ToUsername string `json:"toUsername" binding:"required" example:"minhanh"`
	Password   string `json:"password" binding:"required" example:"password123"`
}

type GiftIconResponse struct {
	ReceiverUsername string `json:"receiverUsername" example:"minhanh"`
	KenSpent         int    `json:"kenSpent" example:"250"`
	KenBalance       int    `json:"kenBalance" example:"1750"`
}

type PurchaseHistoryItem struct {
	ID              string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	PackageName     string `json:"packageName" example:"Gói 30 ngày"`
	Days            int    `json:"days" example:"30"`
	KenPrice        int    `json:"kenPrice" example:"250"`
	KenBalanceAfter int    `json:"kenBalanceAfter" example:"1750"`
	VipEndTime      string `json:"vipEndTime" example:"2026-12-31T00:00:00Z"`
	Source          string `json:"source" example:"package"`
	CreatedAt       string `json:"createdAt" example:"2026-06-19T10:00:00Z"`
}

type HistoryListResponse struct {
	Total  int                   `json:"total" example:"1"`
	Limit  int                   `json:"limit" example:"50"`
	Offset int                   `json:"offset" example:"0"`
	Items  []PurchaseHistoryItem `json:"items"`
}

type TransferHistoryItem struct {
	ID           string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	FromUserID   string `json:"fromUserId" example:"550e8400-e29b-41d4-a716-446655440000"`
	FromUsername string `json:"fromUsername" example:"phong"`
	FromFullName string `json:"fromFullName" example:"Phong Phan"`
	ToUserID     string `json:"toUserId" example:"660e8400-e29b-41d4-a716-446655440000"`
	ToUsername   string `json:"toUsername" example:"minhanh"`
	ToFullName   string `json:"toFullName" example:"Minh Anh"`
	VipIconID    int16  `json:"vipIconId" example:"4"`
	CreatedAt    string `json:"createdAt" example:"2026-06-19T10:00:00Z"`
}

type TransferHistoryListResponse struct {
	Total  int                   `json:"total" example:"1"`
	Limit  int                   `json:"limit" example:"50"`
	Offset int                   `json:"offset" example:"0"`
	Items  []TransferHistoryItem `json:"items"`
}

type CreatePackageRequest struct {
	Name      string `json:"name" binding:"required,max=100" example:"Gói 30 ngày"`
	Days      int    `json:"days" binding:"required,min=1,max=3650" example:"30"`
	KenPrice  int    `json:"kenPrice" binding:"min=0" example:"250"`
	IsActive  *bool  `json:"isActive" example:"true"`
	SortOrder int    `json:"sortOrder" example:"2"`
}

type UpdatePackageRequest struct {
	Name      *string `json:"name" binding:"omitempty,max=100" example:"Gói 30 ngày"`
	Days      *int    `json:"days" binding:"omitempty,min=1,max=3650" example:"30"`
	KenPrice  *int    `json:"kenPrice" binding:"omitempty,min=0" example:"250"`
	IsActive  *bool   `json:"isActive" example:"true"`
	SortOrder *int    `json:"sortOrder" example:"2"`
}

type ShopCatalogItem struct {
	ID        string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	VipTypeID int16  `json:"vipTypeId" example:"4"`
	KenPrice  int    `json:"kenPrice" example:"100"`
}

type ShopCatalogResponse struct {
	Total int               `json:"total" example:"5"`
	Items []ShopCatalogItem `json:"items"`
}

type BuyIconResponse struct {
	Item       VipItem `json:"item"`
	KenBalance int     `json:"kenBalance" example:"900"`
}

type ShopItem struct {
	ID        string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	VipTypeID int16  `json:"vipTypeId" example:"4"`
	KenPrice  int    `json:"kenPrice" example:"100"`
	IsActive  bool   `json:"isActive" example:"true"`
	SortOrder int    `json:"sortOrder" example:"0"`
}

type ShopListResponse struct {
	Total int        `json:"total" example:"5"`
	Items []ShopItem `json:"items"`
}

type CreateShopItemRequest struct {
	VipTypeID int16 `json:"vipTypeId" binding:"required,min=1,max=136" example:"4"`
	KenPrice  int   `json:"kenPrice" binding:"min=0" example:"100"`
	IsActive  *bool `json:"isActive" example:"true"`
	SortOrder int   `json:"sortOrder" example:"0"`
}

type UpdateShopItemRequest struct {
	KenPrice  *int  `json:"kenPrice" binding:"omitempty,min=0" example:"150"`
	IsActive  *bool `json:"isActive" example:"true"`
	SortOrder *int  `json:"sortOrder" example:"0"`
}

type StoreSuccessResponse = utils.BaseResponse[StoreResponse]
type VipItemSuccessResponse = utils.BaseResponse[VipItem]
type MessageSuccessResponse = utils.BaseResponse[MessageResponse]
type BatchDeleteSuccessResponse = utils.BaseResponse[BatchDeleteResponse]
type PackageListSuccessResponse = utils.BaseResponse[PackageListResponse]
type PackageItemSuccessResponse = utils.BaseResponse[PackageItem]
type BuyPackageSuccessResponse = utils.BaseResponse[BuyPackageResponse]
type GiftPackageSuccessResponse = utils.BaseResponse[GiftPackageResponse]
type GiftIconSuccessResponse = utils.BaseResponse[GiftIconResponse]
type HistoryListSuccessResponse = utils.BaseResponse[HistoryListResponse]
type TransferHistoryListSuccessResponse = utils.BaseResponse[TransferHistoryListResponse]
type ShopCatalogSuccessResponse = utils.BaseResponse[ShopCatalogResponse]
type BuyIconSuccessResponse = utils.BaseResponse[BuyIconResponse]
type ShopListSuccessResponse = utils.BaseResponse[ShopListResponse]
type ShopItemSuccessResponse = utils.BaseResponse[ShopItem]
