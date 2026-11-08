package admingiftcode

import (
	"time"

	admincommon "ola-chat-server/internal/modules/admin/common"
)

type RewardInput struct {
	Type      string `json:"type" binding:"required,oneof=vip_days vip_icon avatar_frame" example:"vip_days"`
	Days      int    `json:"days" binding:"omitempty,min=1,max=3650" example:"7"`
	VipIconID int16  `json:"vipIconId" binding:"omitempty,min=1,max=138" example:"15"`
	FrameID   string `json:"frameId" binding:"omitempty,len=3,numeric" example:"001"`
}

type CampaignRequest struct {
	Name              string        `json:"name" binding:"required,max=100" example:"Tết 2027"`
	Kind              string        `json:"kind" binding:"required,oneof=shared unique" example:"shared"`
	Code              string        `json:"code" binding:"max=20" example:"TET2027"`
	CodePrefix        string        `json:"codePrefix" binding:"max=8" example:"TET27-"`
	CodeLength        int           `json:"codeLength" binding:"omitempty,min=6,max=16" example:"8"`
	TotalUses         int           `json:"totalUses" binding:"required,min=1" example:"500"`
	Rewards           []RewardInput `json:"rewards" binding:"required,min=1,max=5,dive"`
	SuccessMessage    string        `json:"successMessage" binding:"max=150" example:"Chúc mừng năm mới! Bạn nhận được {quà}."`
	SendNotification  bool          `json:"sendNotification"`
	MinAccountAgeDays int           `json:"minAccountAgeDays" binding:"min=0,max=365" example:"1"`
	AllowWeb          bool          `json:"allowWeb"`
	AllowAndroid      bool          `json:"allowAndroid"`
	AllowIOS          bool          `json:"allowIos"`
	OnePerDevice      bool          `json:"onePerDevice"`
	StartsAt          *time.Time    `json:"startsAt"`
	EndsAt            time.Time     `json:"endsAt" binding:"required"`
	Enabled           bool          `json:"enabled"`
}

type EnabledRequest struct {
	Enabled bool `json:"enabled"`
}

type GenerateCodesRequest struct {
	Count int `json:"count" binding:"required,min=1,max=50000" example:"20"`
}

type LockCodeRequest struct {
	Locked bool   `json:"locked"`
	Reason string `json:"reason" binding:"max=200" example:"Lộ trên group Facebook"`
}

type AdminBrief struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	FullName string `json:"fullName,omitempty"`
}

type RewardItem struct {
	Type      string `json:"type"`
	Days      int    `json:"days,omitempty"`
	VipIconID int16  `json:"vipIconId,omitempty"`
	FrameID   string `json:"frameId,omitempty"`
}

type CampaignItem struct {
	ID                string       `json:"id"`
	Name              string       `json:"name"`
	Kind              string       `json:"kind"`
	Code              string       `json:"code,omitempty"`
	CodePrefix        string       `json:"codePrefix"`
	CodeLength        int          `json:"codeLength"`
	TotalUses         int          `json:"totalUses"`
	UsedCount         int          `json:"usedCount"`
	LockedCodes       int64        `json:"lockedCodes"`
	Rewards           []RewardItem `json:"rewards"`
	SuccessMessage    string       `json:"successMessage"`
	SendNotification  bool         `json:"sendNotification"`
	MinAccountAgeDays int          `json:"minAccountAgeDays"`
	AllowWeb          bool         `json:"allowWeb"`
	AllowAndroid      bool         `json:"allowAndroid"`
	AllowIOS          bool         `json:"allowIos"`
	OnePerDevice      bool         `json:"onePerDevice"`
	StartsAt          *string      `json:"startsAt"`
	EndsAt            string       `json:"endsAt"`
	Enabled           bool         `json:"enabled"`
	Status            string       `json:"status"`
	CreatedBy         *AdminBrief  `json:"createdBy,omitempty"`
	UpdatedBy         *AdminBrief  `json:"updatedBy,omitempty"`
	CreatedAt         string       `json:"createdAt"`
	UpdatedAt         string       `json:"updatedAt"`
}

type CampaignStats struct {
	Running       int64 `json:"running"`
	RedeemedToday int64 `json:"redeemedToday"`
	RedeemedTotal int64 `json:"redeemedTotal"`
	VipDaysGiven  int64 `json:"vipDaysGiven"`
}

type CampaignListResponse struct {
	Items  []CampaignItem `json:"items"`
	Total  int64          `json:"total"`
	Limit  int            `json:"limit"`
	Offset int            `json:"offset"`
	Stats  CampaignStats  `json:"stats"`
}

type CodeItem struct {
	ID         string                 `json:"id"`
	Code       string                 `json:"code"`
	Status     string                 `json:"status"`
	User       *admincommon.UserBrief `json:"user,omitempty"`
	UsedAt     *string                `json:"usedAt,omitempty"`
	LockedAt   *string                `json:"lockedAt,omitempty"`
	LockedBy   *AdminBrief            `json:"lockedBy,omitempty"`
	LockReason string                 `json:"lockReason,omitempty"`
}

type CodeCounts struct {
	Unused int64 `json:"unused"`
	Used   int64 `json:"used"`
	Locked int64 `json:"locked"`
}

type CodeListResponse struct {
	Items  []CodeItem `json:"items"`
	Total  int64      `json:"total"`
	Limit  int        `json:"limit"`
	Offset int        `json:"offset"`
	Counts CodeCounts `json:"counts"`
}

type GenerateCodesResponse struct {
	Generated int `json:"generated"`
	TotalUses int `json:"totalUses"`
}

type RedemptionItem struct {
	ID         string                `json:"id"`
	User       admincommon.UserBrief `json:"user"`
	Code       string                `json:"code"`
	Platform   string                `json:"platform"`
	DeviceName string                `json:"deviceName"`
	IPAddress  string                `json:"ipAddress"`
	Rewards    []RewardItem          `json:"rewards"`
	CreatedAt  string                `json:"createdAt"`
}

type RedemptionListResponse struct {
	Items  []RedemptionItem `json:"items"`
	Total  int64            `json:"total"`
	Limit  int              `json:"limit"`
	Offset int              `json:"offset"`
}

type AttemptSummary struct {
	Failures            int64 `json:"failures"`
	WrongCodes          int64 `json:"wrongCodes"`
	BlockedUsers        int64 `json:"blockedUsers"`
	MultiAccountDevices int64 `json:"multiAccountDevices"`
}

type AttemptUserItem struct {
	User         admincommon.UserBrief `json:"user"`
	DeviceName   string                `json:"deviceName"`
	Platform     string                `json:"platform"`
	Failures     int64                 `json:"failures"`
	TopReason    string                `json:"topReason"`
	RecentCodes  []string              `json:"recentCodes"`
	LastAt       string                `json:"lastAt"`
	BlockedUntil *string               `json:"blockedUntil,omitempty"`
}

type AttemptUserListResponse struct {
	Items  []AttemptUserItem `json:"items"`
	Total  int64             `json:"total"`
	Limit  int               `json:"limit"`
	Offset int               `json:"offset"`
}

type AttemptDeviceItem struct {
	DeviceID   string                  `json:"deviceId"`
	DeviceName string                  `json:"deviceName"`
	Platform   string                  `json:"platform"`
	Accounts   []admincommon.UserBrief `json:"accounts"`
	Failures   int64                   `json:"failures"`
	Successes  int64                   `json:"successes"`
	LastAt     string                  `json:"lastAt"`
}

type AttemptDeviceListResponse struct {
	Items  []AttemptDeviceItem `json:"items"`
	Total  int64               `json:"total"`
	Limit  int                 `json:"limit"`
	Offset int                 `json:"offset"`
}

type AttemptItem struct {
	ID         string                `json:"id"`
	User       admincommon.UserBrief `json:"user"`
	CodeInput  string                `json:"codeInput"`
	Reason     string                `json:"reason"`
	Platform   string                `json:"platform"`
	DeviceName string                `json:"deviceName"`
	IPAddress  string                `json:"ipAddress"`
	CreatedAt  string                `json:"createdAt"`
}

type AttemptListResponse struct {
	Items  []AttemptItem `json:"items"`
	Total  int64         `json:"total"`
	Limit  int           `json:"limit"`
	Offset int           `json:"offset"`
}

type CampaignFilter struct {
	Search string
	Status string
	Kind   string
	Limit  int
	Offset int
}

type AttemptFilter struct {
	Since  time.Time
	Search string
	Reason string
	Limit  int
	Offset int
}
