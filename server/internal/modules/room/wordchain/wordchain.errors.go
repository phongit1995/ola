package wordchain

import (
	"fmt"
	"net/http"
	"ola-chat-server/internal/utils"
)

var (
	ErrVerifyFailed  = utils.NewHTTPErrorWithCode(http.StatusServiceUnavailable, "Không thể kiểm tra từ lúc này, vui lòng thử lại sau.", ErrorCodeVerifyFailed)
	ErrBusy          = utils.NewHTTPError(http.StatusConflict, "Phòng nối từ đang xử lý, vui lòng thử lại.")
	ErrNoGuessesLeft = utils.NewHTTPErrorWithCode(http.StatusForbidden, "Bạn đã hết lượt đoán cho từ này, chờ người khác nối đúng nhé.", ErrorCodeNoGuesses)
	ErrWaitTurn      = utils.NewHTTPErrorWithCode(http.StatusForbidden, "Bạn vừa nối đúng, chờ người khác nối tiếp nhé.", ErrorCodeWaitTurn)
	ErrNoHint        = utils.NewHTTPErrorWithCode(http.StatusConflict, "Chưa tìm được gợi ý cho từ này, bạn chưa bị trừ KEN.", ErrorCodeNoHint)
	ErrKenShort      = utils.NewHTTPErrorWithCode(http.StatusBadRequest, fmt.Sprintf("Bạn cần %d KEN để dùng gợi ý.", HintPriceKen), ErrorCodeKenShort)
	ErrLookupEmpty   = utils.NewHTTPError(http.StatusBadRequest, "Từ không được để trống")
	ErrLookupTooLong = utils.NewHTTPError(http.StatusBadRequest, fmt.Sprintf("Từ tra cứu không được vượt quá %d ký tự.", LookupMaxWordRunes))
	ErrLookupFailed  = utils.NewHTTPError(http.StatusBadGateway, "Không thể tra từ lúc này, vui lòng thử lại sau.")
)

func cooldownError(template string, seconds int) error {
	return utils.NewHTTPErrorWithCode(http.StatusTooManyRequests, fmt.Sprintf(template, seconds), ErrorCodeCooldown)
}
