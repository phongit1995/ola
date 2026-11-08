package admingiftcode

import "time"

const (
	ErrorCodeGiftCodeTaken          = "GIFT_CODE_TAKEN"
	ErrorCodeGiftCodeFieldsLocked   = "GIFT_CODE_FIELDS_LOCKED"
	ErrorCodeGiftCodeInvalidInput   = "GIFT_CODE_INVALID_INPUT"
	ErrorCodeGiftCodeNotUnique      = "GIFT_CODE_NOT_UNIQUE_KIND"
	ErrorCodeGiftCodeLimit          = "GIFT_CODE_LIMIT"
	ErrorCodeGiftCodeAlreadyUsed    = "GIFT_CODE_ALREADY_USED"
	ErrorCodeGiftCodeLockReason     = "GIFT_CODE_LOCK_REASON_REQUIRED"
	ErrorCodeGiftCodeCampaignAbsent = "GIFT_CODE_CAMPAIGN_NOT_FOUND"
	ErrorCodeGiftCodeAbsent         = "GIFT_CODE_NOT_FOUND"

	CodeStatusUnused = "unused"
	CodeStatusUsed   = "used"
	CodeStatusLocked = "locked"

	MaxCodesPerBatch    = 50000
	MaxCodesPerCampaign = 100000
	MaxSharedUses       = 1000000
	GenerateInsertBatch = 1000
	GenerateMaxRounds   = 20
	ExportMaxRows       = 100000
	RecentCodesShown    = 3
	MultiAccountDevice  = 3

	DefaultAttemptRange = 24 * time.Hour
	VietnamTimezone     = "Asia/Ho_Chi_Minh"
)

var attemptRanges = map[string]time.Duration{
	"1h":  time.Hour,
	"24h": 24 * time.Hour,
	"7d":  7 * 24 * time.Hour,
	"30d": 30 * 24 * time.Hour,
}
