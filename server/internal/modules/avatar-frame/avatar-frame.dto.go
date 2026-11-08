package avatarframe

type ShopItem struct {
	ID        string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	FrameID   string `json:"frameId" example:"001"`
	KenPrice  int    `json:"kenPrice" example:"5000"`
	IsActive  bool   `json:"isActive" example:"true"`
	SortOrder int    `json:"sortOrder" example:"0"`
	Owned     bool   `json:"owned" example:"false"`
}

type ShopResponse struct {
	Total int        `json:"total" example:"1"`
	Items []ShopItem `json:"items"`
}

type BuyRequest struct {
	ShopItemID       string `json:"shopItemId" binding:"required,uuid" example:"550e8400-e29b-41d4-a716-446655440000"`
	ExpectedKenPrice *int   `json:"expectedKenPrice" binding:"required,min=0" example:"5000"`
}

type BuyResponse struct {
	FrameID    string `json:"frameId" example:"001"`
	KenSpent   int    `json:"kenSpent" example:"5000"`
	KenBalance int    `json:"kenBalance" example:"15000"`
}

type GiftRequest struct {
	ShopItemID       string `json:"shopItemId" binding:"required,uuid" example:"550e8400-e29b-41d4-a716-446655440000"`
	ExpectedKenPrice *int   `json:"expectedKenPrice" binding:"required,min=0" example:"5000"`
	ToUsername       string `json:"toUsername" binding:"required" example:"minhanh"`
	Password         string `json:"password" binding:"required" example:"password123"`
}

type GiftResponse struct {
	ReceiverUsername string `json:"receiverUsername" example:"minhanh"`
	FrameID          string `json:"frameId" example:"001"`
	KenSpent         int    `json:"kenSpent" example:"5000"`
	KenBalance       int    `json:"kenBalance" example:"15000"`
}

type OwnedFrame struct {
	FrameID    string `json:"frameId" example:"001"`
	Source     string `json:"source" example:"purchase"`
	AcquiredAt string `json:"acquiredAt" example:"2026-11-09T10:00:00Z"`
	IsEquipped bool   `json:"isEquipped" example:"true"`
}

type StoreResponse struct {
	UserID          string       `json:"userId" example:"550e8400-e29b-41d4-a716-446655440000"`
	EquippedFrameID *string      `json:"equippedFrameId" example:"001"`
	VipActive       bool         `json:"vipActive" example:"true"`
	Privacy         int16        `json:"privacy" example:"0"`
	Total           int          `json:"total" example:"3"`
	Limit           int          `json:"limit" example:"50"`
	Offset          int          `json:"offset" example:"0"`
	Items           []OwnedFrame `json:"items"`
}

type EquipRequest struct {
	FrameID string `json:"frameId" binding:"omitempty,len=3,numeric" example:"001"`
}

type EquipResponse struct {
	EquippedFrameID *string `json:"equippedFrameId" example:"001"`
}

type TransferRequest struct {
	ToUserID string `json:"toUserId" binding:"required,uuid" example:"550e8400-e29b-41d4-a716-446655440000"`
	Password string `json:"password" binding:"required" example:"password123"`
}

type PrivacyRequest struct {
	Privacy int16 `json:"privacy" binding:"min=0,max=2" example:"0"`
}

type MessageResponse struct {
	Message string `json:"message" example:"ok"`
}

type UserBrief struct {
	ID       string `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Username string `json:"username" example:"minhanh"`
	FullName string `json:"fullName,omitempty" example:"Minh Anh"`
}

type PurchaseHistoryItem struct {
	ID        string     `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	FrameID   string     `json:"frameId" example:"001"`
	KenPrice  int        `json:"kenPrice" example:"5000"`
	Source    string     `json:"source" example:"gift"`
	Buyer     UserBrief  `json:"buyer"`
	Recipient *UserBrief `json:"recipient,omitempty"`
	CreatedAt string     `json:"createdAt" example:"2026-11-09T10:00:00Z"`
}

type PurchaseHistoryResponse struct {
	Total  int64                 `json:"total" example:"1"`
	Limit  int                   `json:"limit" example:"20"`
	Offset int                   `json:"offset" example:"0"`
	Items  []PurchaseHistoryItem `json:"items"`
}

type TransferHistoryItem struct {
	ID        string    `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	FrameID   string    `json:"frameId" example:"001"`
	From      UserBrief `json:"from"`
	To        UserBrief `json:"to"`
	CreatedAt string    `json:"createdAt" example:"2026-11-09T10:00:00Z"`
}

type TransferHistoryResponse struct {
	Total  int64                 `json:"total" example:"1"`
	Limit  int                   `json:"limit" example:"20"`
	Offset int                   `json:"offset" example:"0"`
	Items  []TransferHistoryItem `json:"items"`
}

type CreateShopItemsRequest struct {
	FrameIDs  []string `json:"frameIds" binding:"required,min=1,max=200,dive,len=3,numeric" example:"001"`
	KenPrice  int      `json:"kenPrice" binding:"min=0" example:"5000"`
	IsActive  *bool    `json:"isActive" example:"true"`
	SortOrder int      `json:"sortOrder" example:"0"`
}

type CreateShopItemsResponse struct {
	Created []ShopItem `json:"created"`
	Skipped []string   `json:"skipped"`
}

type UpdateShopItemRequest struct {
	KenPrice  *int  `json:"kenPrice" binding:"omitempty,min=0" example:"5000"`
	IsActive  *bool `json:"isActive" example:"true"`
	SortOrder *int  `json:"sortOrder" example:"0"`
}
