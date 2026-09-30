package wordchain

import (
	"fmt"
	"net/http"
	"ola-chat-server/internal/utils"
)

var (
	ErrVerifyFailed  = utils.NewHTTPErrorWithCode(http.StatusServiceUnavailable, "Không thể kiểm tra từ lúc này, vui lòng thử lại sau.", ErrorCodeVerifyFailed)
	ErrBusy          = utils.NewHTTPError(http.StatusConflict, "Phòng nối từ đang xử lý, vui lòng thử lại.")
	ErrLookupEmpty   = utils.NewHTTPError(http.StatusBadRequest, "Từ không được để trống")
	ErrLookupTooLong = utils.NewHTTPError(http.StatusBadRequest, fmt.Sprintf("Từ tra cứu không được vượt quá %d ký tự.", LookupMaxWordRunes))
	ErrLookupFailed  = utils.NewHTTPError(http.StatusBadGateway, "Không thể tra từ lúc này, vui lòng thử lại sau.")
)

func cooldownError(template string, seconds int) error {
	return utils.NewHTTPErrorWithCode(http.StatusTooManyRequests, fmt.Sprintf(template, seconds), ErrorCodeCooldown)
}
