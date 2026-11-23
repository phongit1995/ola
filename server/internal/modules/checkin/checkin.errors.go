package checkin

import (
	"net/http"

	"ola-chat-server/internal/utils"
)

var (
	ErrCheckinDisabled         = utils.NewHTTPErrorWithCode(http.StatusForbidden, "check-in is not available right now", ErrorCodeCheckinDisabled)
	ErrCheckinCompleted        = utils.NewHTTPErrorWithCode(http.StatusConflict, "you already checked in every slot this month", ErrorCodeCheckinCompleted)
	ErrCheckinEmailNotVerified = utils.NewHTTPErrorWithCode(http.StatusForbidden, "verify your email to check in", ErrorCodeCheckinEmailNotVerified)
	ErrCheckinTaskNotDone      = utils.NewHTTPErrorWithCode(http.StatusConflict, "finish today's task to open the box", ErrorCodeCheckinTaskNotDone)
	ErrCheckinVipRequired      = utils.NewHTTPErrorWithCode(http.StatusForbidden, "this box is for VIP members", ErrorCodeCheckinVipRequired)
	ErrCheckinNothingToOpen    = utils.NewHTTPErrorWithCode(http.StatusConflict, "there is no box to open today", ErrorCodeCheckinNothingToOpen)
	ErrCheckinRequestID        = utils.NewHTTPError(http.StatusBadRequest, "clientRequestId is required")
)
