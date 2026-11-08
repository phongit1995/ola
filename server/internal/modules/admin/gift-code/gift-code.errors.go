package admingiftcode

import (
	"net/http"

	"ola-chat-server/internal/utils"
)

var (
	ErrCampaignNotFound = utils.NewHTTPErrorWithCode(http.StatusNotFound, "Không tìm thấy đợt mã quà tặng", ErrorCodeGiftCodeCampaignAbsent)
	ErrCodeNotFound     = utils.NewHTTPErrorWithCode(http.StatusNotFound, "Không tìm thấy mã", ErrorCodeGiftCodeAbsent)
	ErrCodeTaken        = utils.NewHTTPErrorWithCode(http.StatusConflict, "Mã này đã có, chọn mã khác", ErrorCodeGiftCodeTaken)
	ErrFieldsLocked     = utils.NewHTTPErrorWithCode(http.StatusConflict, "Đã có người nhận nên không đổi được loại mã, dạng mã và quà", ErrorCodeGiftCodeFieldsLocked)
	ErrNotUniqueKind    = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "Chỉ đợt mã riêng mới sinh thêm mã được", ErrorCodeGiftCodeNotUnique)
	ErrCodeLimit        = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "Mỗi đợt tối đa 100.000 mã, mỗi lần sinh tối đa 50.000 mã", ErrorCodeGiftCodeLimit)
	ErrCodeAlreadyUsed  = utils.NewHTTPErrorWithCode(http.StatusConflict, "Mã đã dùng thì không khoá được vì quà đã phát", ErrorCodeGiftCodeAlreadyUsed)
	ErrLockReason       = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "Nhập lý do khoá mã", ErrorCodeGiftCodeLockReason)
)

func invalidInput(msg string) error {
	return utils.NewHTTPErrorWithCode(http.StatusBadRequest, msg, ErrorCodeGiftCodeInvalidInput)
}
