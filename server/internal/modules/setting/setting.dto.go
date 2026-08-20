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
	Enabled       bool           `json:"enabled" example:"true"`
	MinAmount     int            `json:"minAmount" example:"10000"`
	StepAmount    int            `json:"stepAmount" example:"1000"`
	PresetAmounts []int          `json:"presetAmounts"`
	KenPerVnd     int            `json:"kenPerVnd" example:"1"`
	Bank          *TopupBankInfo `json:"bank,omitempty"`
}

type TopupConfigSuccessResponse = utils.BaseResponse[TopupConfigResponse]

type UsernameChangeConfigSuccessResponse = utils.BaseResponse[UsernameChangeConfig]
