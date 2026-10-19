package adminvip

import "time"

const (
	PurchaseKindPackage = "package"
	PurchaseKindIcon    = "icon"

	PurchaseModeSelf = "self"
	PurchaseModeGift = "gift"
)

type PurchaseFilter struct {
	Kind   string
	Mode   string
	Search string
	From   *time.Time
	To     *time.Time
}

type UserInfo struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	FullName string `json:"fullName,omitempty"`
	Avatar   string `json:"avatar,omitempty"`
}

type PurchaseItem struct {
	ID         string    `json:"id" example:"550e8400-e29b-41d4-a716-446655440000"`
	Kind       string    `json:"kind" example:"package"`
	Source     string    `json:"source" example:"gift"`
	Name       string    `json:"name" example:"Gói 30 ngày"`
	VipIconID  int       `json:"vipIconId,omitempty" example:"4"`
	Days       int       `json:"days" example:"30"`
	KenPaid    int64     `json:"kenPaid" example:"250"`
	VipEndTime string    `json:"vipEndTime,omitempty" example:"2026-12-31T00:00:00Z"`
	User       *UserInfo `json:"user,omitempty"`
	Giver      *UserInfo `json:"giver,omitempty"`
	CreatedAt  string    `json:"createdAt" example:"2026-10-19T10:00:00Z"`
}

type PurchaseListResponse struct {
	Total  int64          `json:"total" example:"1"`
	Limit  int            `json:"limit" example:"20"`
	Offset int            `json:"offset" example:"0"`
	Items  []PurchaseItem `json:"items"`
}

type PurchaseTotals struct {
	Count        int64 `json:"count"`
	Ken          int64 `json:"ken"`
	PackageCount int64 `json:"packageCount"`
	PackageKen   int64 `json:"packageKen"`
	IconCount    int64 `json:"iconCount"`
	IconKen      int64 `json:"iconKen"`
	GiftCount    int64 `json:"giftCount"`
	Buyers       int64 `json:"buyers"`
}

type PurchaseSeriesItem struct {
	Date       string `json:"date"`
	PackageKen int64  `json:"packageKen"`
	IconKen    int64  `json:"iconKen"`
	Count      int64  `json:"count"`
}

type PurchaseBreakdownItem struct {
	Kind      string `json:"kind"`
	Name      string `json:"name"`
	VipIconID int    `json:"vipIconId,omitempty"`
	Count     int64  `json:"count"`
	GiftCount int64  `json:"giftCount"`
	Ken       int64  `json:"ken"`
}

type PurchaseStatsResponse struct {
	Bucket         string                  `json:"bucket"`
	Today          PurchaseTotals          `json:"today"`
	ThisMonth      PurchaseTotals          `json:"thisMonth"`
	Range          PurchaseTotals          `json:"range"`
	ActiveVipUsers int64                   `json:"activeVipUsers"`
	Series         []PurchaseSeriesItem    `json:"series"`
	Breakdown      []PurchaseBreakdownItem `json:"breakdown"`
}

type PurchaseListSuccessResponse struct {
	Success bool                 `json:"success"`
	Data    PurchaseListResponse `json:"data"`
}

type PurchaseStatsSuccessResponse struct {
	Success bool                  `json:"success"`
	Data    PurchaseStatsResponse `json:"data"`
}
