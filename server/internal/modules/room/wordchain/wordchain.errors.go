package wordchain

import (
	"fmt"
	"net/http"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/utils"
)

var (
	ErrVerifyFailed  = utils.NewHTTPErrorWithCode(http.StatusServiceUnavailable, "Không thể kiểm tra từ lúc này, vui lòng thử lại sau.", constants.ErrorCodeWordChainVerifyFailed)
	ErrBusy          = utils.NewHTTPError(http.StatusConflict, "Phòng nối từ đang xử lý, vui lòng thử lại.")
	ErrNoGuessesLeft = utils.NewHTTPErrorWithCode(http.StatusForbidden, "Bạn đã hết lượt đoán cho từ này, chờ người khác nối đúng nhé.", constants.ErrorCodeWordChainNoGuesses)
	ErrWaitTurn      = utils.NewHTTPErrorWithCode(http.StatusForbidden, "Bạn vừa nối đúng, chờ người khác nối tiếp nhé.", constants.ErrorCodeWordChainWaitTurn)
	ErrGuessesLeft   = utils.NewHTTPErrorWithCode(http.StatusConflict, "Bạn vẫn còn lượt đoán cho từ này, chưa cần mua thêm.", constants.ErrorCodeWordChainGuessesLeft)
	ErrPriceChanged  = utils.NewHTTPErrorWithCode(http.StatusConflict, "Giá mua thêm lượt đã thay đổi, vui lòng tải lại trang.", constants.ErrorCodeWordChainPriceChanged)
	ErrNoHint        = utils.NewHTTPErrorWithCode(http.StatusConflict, "Chưa tìm được gợi ý cho từ này, bạn chưa bị trừ KEN.", constants.ErrorCodeWordChainNoHint)
	ErrDisabled      = utils.NewHTTPErrorWithCode(http.StatusForbidden, "Phòng nối từ đang tạm đóng.", constants.ErrorCodeWordChainDisabled)
	ErrUnavailable   = utils.NewHTTPErrorWithCode(http.StatusServiceUnavailable, "Phòng nối từ tạm thời không khả dụng, vui lòng thử lại sau.", constants.ErrorCodeWordChainUnavailable)
	ErrWordChanged   = utils.NewHTTPErrorWithCode(http.StatusConflict, "Từ hiện tại vừa đổi, bạn chưa bị trừ lượt. Xem từ mới rồi thử lại nhé.", constants.ErrorCodeWordChainWordChanged)
	ErrBadCursor     = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "Mốc phân trang không hợp lệ.", constants.ErrorCodeWordChainBadCursor)
	ErrLookupEmpty   = utils.NewHTTPError(http.StatusBadRequest, "Từ không được để trống")
	ErrLookupTooLong = utils.NewHTTPError(http.StatusBadRequest, fmt.Sprintf("Từ tra cứu không được vượt quá %d ký tự.", constants.WordChainLookupMaxWordRunes))
	ErrLookupFailed  = utils.NewHTTPError(http.StatusBadGateway, "Không thể tra từ lúc này, vui lòng thử lại sau.")
)

func kenShortError(price int) error {
	return utils.NewHTTPErrorWithCode(http.StatusBadRequest, fmt.Sprintf("Bạn cần %d KEN để dùng gợi ý.", price), constants.ErrorCodeWordChainKenShort)
}

func guessKenShortError(price int) error {
	return utils.NewHTTPErrorWithCode(http.StatusBadRequest, fmt.Sprintf("Bạn cần %d KEN để mua thêm lượt.", price), constants.ErrorCodeWordChainKenShort)
}

func cooldownError(seconds int) error {
	return utils.NewHTTPErrorWithCode(http.StatusTooManyRequests, fmt.Sprintf("⏳ Vui lòng chờ %ds trước khi tra tiếp.", seconds), constants.ErrorCodeWordChainCooldown)
}
