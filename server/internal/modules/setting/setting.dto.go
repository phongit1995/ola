package setting

import "ola-chat-server/internal/utils"

type TopupBankInfo struct {
	BankName      string `json:"bankName" example:"Vietcombank"`
	BankBin       string `json:"bankBin" example:"970436"`
	AccountNumber string `json:"accountNumber" example:"0123456789"`
	AccountName   string `json:"accountName" example:"NGUYEN VAN A"`
	MemoTemplate  string `json:"memoTemplate" example:"@{username}"`
}

type TopupConfigResponse struct {
	Enabled       bool             `json:"enabled" example:"true"`
	EnabledMobile bool             `json:"enabledMobile" example:"true"`
	MinAmount     int              `json:"minAmount" example:"10000"`
	StepAmount    int              `json:"stepAmount" example:"1000"`
	PresetAmounts []int            `json:"presetAmounts"`
	BonusTiers    []TopupBonusTier `json:"bonusTiers"`
	Bank          *TopupBankInfo   `json:"bank,omitempty"`
}

type TopupConfigSuccessResponse = utils.BaseResponse[TopupConfigResponse]

type UsernameChangeConfigResponse struct {
	Enabled       bool                 `json:"enabled" example:"true"`
	EnabledMobile bool                 `json:"enabledMobile" example:"true"`
	Tiers         []UsernameChangeTier `json:"tiers"`
}

type UsernameChangeConfigSuccessResponse = utils.BaseResponse[UsernameChangeConfigResponse]

type WordChainConfigSuccessResponse = utils.BaseResponse[WordChainConfig]

type ChatBotAvailability struct {
	Type    string `json:"type" example:"OLALA"`
	Enabled bool   `json:"enabled" example:"true"`
}

type ChatBotPublicConfig struct {
	DailyLimit int                   `json:"dailyLimit" example:"50"`
	Bots       []ChatBotAvailability `json:"bots"`
}

type ChatBotPublicConfigSuccessResponse = utils.BaseResponse[ChatBotPublicConfig]

type FeatureEnabledResponse struct {
	Enabled bool `json:"enabled" example:"true"`
}

type FeatureEnabledSuccessResponse = utils.BaseResponse[FeatureEnabledResponse]
