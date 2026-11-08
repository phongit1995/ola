package giftcode

import (
	"ola-chat-server/internal/modules/setting"

	"github.com/google/uuid"
)

type RedeemRequest struct {
	Code string `json:"code" binding:"required,max=40" example:"TET2027"`
}

type RewardItem struct {
	Type      string `json:"type" example:"vip_days"`
	Days      int    `json:"days,omitempty" example:"7"`
	VipIconID int16  `json:"vipIconId,omitempty" example:"15"`
}

type RedeemResponse struct {
	Message string       `json:"message" example:"Bạn nhận được 7 ngày VIP."`
	Rewards []RewardItem `json:"rewards"`
}

type RedeemInput struct {
	UserID    uuid.UUID
	SessionID uuid.UUID
	Code      string
	Client    setting.Client
	IP        string
}
