package gift

import (
	"net/http"

	"ola-chat-server/internal/utils"
)

var (
	ErrGiftDisabled            = utils.NewHTTPErrorWithCode(http.StatusForbidden, "gift is disabled", ErrorCodeGiftDisabled)
	ErrGiftNotFound            = utils.NewHTTPErrorWithCode(http.StatusNotFound, "gift not found", ErrorCodeGiftNotFound)
	ErrGiftSelf                = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "cannot send a gift to yourself", ErrorCodeGiftSelf)
	ErrGiftBlocked             = utils.NewHTTPErrorWithCode(http.StatusForbidden, "cannot send a gift to a blocked user", ErrorCodeGiftBlocked)
	ErrGiftReceiverUnavailable = utils.NewHTTPErrorWithCode(http.StatusNotFound, "gift receiver is unavailable", ErrorCodeGiftReceiverUnavailable)
	ErrGiftInsufficientKen     = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "insufficient ken balance", ErrorCodeGiftInsufficientKen)
	ErrGiftInvalidQuantity     = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "invalid gift quantity", ErrorCodeGiftInvalidQuantity)
	ErrGiftNoteTooLong         = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "gift note is too long", ErrorCodeGiftNoteTooLong)
	ErrGiftRequestConflict     = utils.NewHTTPErrorWithCode(http.StatusConflict, "gift request id was used for another gift", ErrorCodeGiftRequestConflict)
	ErrGiftWallPrivate         = utils.NewHTTPErrorWithCode(http.StatusForbidden, "gift wall is private", ErrorCodeGiftWallPrivate)
)
