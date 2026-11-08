package avatarframe

import (
	"net/http"

	"ola-chat-server/internal/utils"
)

var (
	ErrShopItemNotFound = utils.NewHTTPErrorWithCode(http.StatusNotFound, "avatar frame shop item not found", ErrorCodeShopItemNotFound)
	ErrInvalidFrameID   = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "invalid avatar frame id", ErrorCodeInvalidFrameID)
	ErrPriceChanged     = utils.NewHTTPErrorWithCode(http.StatusConflict, "avatar frame price changed", ErrorCodePriceChanged)
	ErrAlreadyOwned     = utils.NewHTTPErrorWithCode(http.StatusConflict, "avatar frame already owned", ErrorCodeAlreadyOwned)
	ErrReceiverOwns     = utils.NewHTTPErrorWithCode(http.StatusConflict, "receiver already owns this avatar frame", ErrorCodeReceiverOwns)
	ErrNotOwned         = utils.NewHTTPErrorWithCode(http.StatusNotFound, "avatar frame not owned", ErrorCodeNotOwned)
	ErrInUse            = utils.NewHTTPErrorWithCode(http.StatusConflict, "avatar frame is equipped", ErrorCodeInUse)
	ErrVipRequired      = utils.NewHTTPErrorWithCode(http.StatusForbidden, "vip required to equip avatar frame", ErrorCodeVipRequired)
	ErrInsufficientKen  = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "insufficient ken balance", ErrorCodeInsufficientKen)
	ErrWrongPassword    = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "invalid password", ErrorCodeWrongPassword)
	ErrReceiverNotFound = utils.NewHTTPErrorWithCode(http.StatusNotFound, "receiver not found", ErrorCodeReceiverNotFound)
	ErrSelfTarget       = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "cannot send avatar frame to yourself", ErrorCodeSelfTarget)
	ErrBlocked          = utils.NewHTTPErrorWithCode(http.StatusForbidden, "cannot send avatar frame to a blocked user", ErrorCodeBlocked)
	ErrPrivateStore     = utils.NewHTTPErrorWithCode(http.StatusForbidden, "avatar frame store is private", ErrorCodePrivateStore)
)
