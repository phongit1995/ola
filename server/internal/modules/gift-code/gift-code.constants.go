package giftcode

import "time"

const (
	ReasonWrong      = "wrong"
	ReasonDisabled   = "disabled"
	ReasonLocked     = "locked"
	ReasonNotStarted = "not_started"
	ReasonExpired    = "expired"
	ReasonSoldOut    = "sold_out"
	ReasonUsed       = "used"
	ReasonRedeemed   = "redeemed"
	ReasonDevice     = "device"
	ReasonYoung      = "young"
	ReasonPlatform   = "platform"
	ReasonUnverified = "unverified"
	ReasonNoDevice   = "no_device"

	StatusRunning   = "running"
	StatusScheduled = "scheduled"
	StatusSoldOut   = "soldout"
	StatusExpired   = "expired"
	StatusOff       = "off"

	ErrorCodeGiftCodeInvalid            = "GIFT_CODE_INVALID"
	ErrorCodeGiftCodeNotStarted         = "GIFT_CODE_NOT_STARTED"
	ErrorCodeGiftCodeExpired            = "GIFT_CODE_EXPIRED"
	ErrorCodeGiftCodeSoldOut            = "GIFT_CODE_SOLD_OUT"
	ErrorCodeGiftCodeUsed               = "GIFT_CODE_USED"
	ErrorCodeGiftCodeAlreadyRedeemed    = "GIFT_CODE_ALREADY_REDEEMED"
	ErrorCodeGiftCodeDeviceRedeemed     = "GIFT_CODE_DEVICE_REDEEMED"
	ErrorCodeGiftCodeAccountTooNew      = "GIFT_CODE_ACCOUNT_TOO_NEW"
	ErrorCodeGiftCodePlatformNotAllowed = "GIFT_CODE_PLATFORM_NOT_ALLOWED"
	ErrorCodeGiftCodeTooManyAttempts    = "GIFT_CODE_TOO_MANY_ATTEMPTS"
	ErrorCodeGiftCodeEmailNotVerified   = "GIFT_CODE_EMAIL_NOT_VERIFIED"
	ErrorCodeGiftCodeDeviceUnknown      = "GIFT_CODE_DEVICE_UNKNOWN"

	CacheKeyGiftCodeFailUser    = "GIFTCODE:FAIL:USER:%s"
	CacheKeyGiftCodeFailDevice  = "GIFTCODE:FAIL:DEVICE:%s"
	CacheKeyGiftCodeBlockUser   = "GIFTCODE:BLOCK:USER:%s"
	CacheKeyGiftCodeBlockDevice = "GIFTCODE:BLOCK:DEVICE:%s"
	CacheKeyGiftCodeStatus      = "GIFTCODE:RUNNING:%s"
	CacheKeyGiftCodeCleanupLock = "GIFTCODE:CLEANUP:LOCK"

	CacheTTLGiftCodeStatus = time.Minute

	FailWindow    = time.Minute
	FailLimit     = 5
	BlockDuration = 15 * time.Minute

	AttemptRetention     = 30 * 24 * time.Hour
	CleanupStartDelay    = 5 * time.Minute
	CleanupInterval      = 6 * time.Hour
	CleanupLockTTL       = 10 * time.Minute
	CleanupDeleteBatches = 50
	CleanupDeleteBatch   = 5000

	CodeAlphabet        = "ABCDEFGHJKMNPQRSTUVWXYZ23456789"
	CodeInputMaxLength  = 40
	CodeMaxLength       = 32
	SharedCodeMinLength = 4
	SharedCodeMaxLength = 20
	UniqueCodeMinLength = 6
	UniqueCodeMaxLength = 16
	CodePrefixMaxLength = 8

	RewardPlaceholder     = "{quà}"
	DefaultSuccessMessage = "Bạn nhận được {quà}."
	RewardTextJoiner      = " và "
	NotificationTitle     = "Mã quà tặng"

	PurchaseNameVipDays = "Mã quà tặng %s: %d ngày VIP"
)
