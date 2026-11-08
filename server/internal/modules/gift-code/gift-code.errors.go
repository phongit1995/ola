package giftcode

import (
	"net/http"

	"ola-chat-server/internal/utils"
)

var (
	ErrGiftCodeInvalid            = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "gift code is invalid or expired", ErrorCodeGiftCodeInvalid)
	ErrGiftCodeNotStarted         = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "gift code is not active yet", ErrorCodeGiftCodeNotStarted)
	ErrGiftCodeExpired            = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "gift code has expired", ErrorCodeGiftCodeExpired)
	ErrGiftCodeSoldOut            = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "gift code has no uses left", ErrorCodeGiftCodeSoldOut)
	ErrGiftCodeUsed               = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "gift code was already used", ErrorCodeGiftCodeUsed)
	ErrGiftCodeAlreadyRedeemed    = utils.NewHTTPErrorWithCode(http.StatusConflict, "you already received this gift", ErrorCodeGiftCodeAlreadyRedeemed)
	ErrGiftCodeDeviceRedeemed     = utils.NewHTTPErrorWithCode(http.StatusConflict, "this device already received this gift", ErrorCodeGiftCodeDeviceRedeemed)
	ErrGiftCodeAccountTooNew      = utils.NewHTTPErrorWithCode(http.StatusForbidden, "account is too new for this gift code", ErrorCodeGiftCodeAccountTooNew)
	ErrGiftCodePlatformNotAllowed = utils.NewHTTPErrorWithCode(http.StatusForbidden, "gift code is not available on this platform", ErrorCodeGiftCodePlatformNotAllowed)
	ErrGiftCodeTooManyAttempts    = utils.NewHTTPErrorWithCode(http.StatusTooManyRequests, "too many wrong gift codes, try again later", ErrorCodeGiftCodeTooManyAttempts)
	ErrGiftCodeEmailNotVerified   = utils.NewHTTPErrorWithCode(http.StatusForbidden, "verify your email to redeem gift codes", ErrorCodeGiftCodeEmailNotVerified)
	ErrGiftCodeDeviceUnknown      = utils.NewHTTPErrorWithCode(http.StatusForbidden, "cannot identify this device, sign in again to redeem", ErrorCodeGiftCodeDeviceUnknown)
)

var reasonErrors = map[string]error{
	ReasonWrong:      ErrGiftCodeInvalid,
	ReasonDisabled:   ErrGiftCodeInvalid,
	ReasonLocked:     ErrGiftCodeInvalid,
	ReasonNotStarted: ErrGiftCodeNotStarted,
	ReasonExpired:    ErrGiftCodeExpired,
	ReasonSoldOut:    ErrGiftCodeSoldOut,
	ReasonUsed:       ErrGiftCodeUsed,
	ReasonRedeemed:   ErrGiftCodeAlreadyRedeemed,
	ReasonDevice:     ErrGiftCodeDeviceRedeemed,
	ReasonYoung:      ErrGiftCodeAccountTooNew,
	ReasonPlatform:   ErrGiftCodePlatformNotAllowed,
	ReasonUnverified: ErrGiftCodeEmailNotVerified,
	ReasonNoDevice:   ErrGiftCodeDeviceUnknown,
}

var guessReasons = map[string]bool{
	ReasonWrong:    true,
	ReasonDisabled: true,
	ReasonLocked:   true,
}
