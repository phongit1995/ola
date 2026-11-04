package megaphone

import (
	"net/http"

	"ola-chat-server/internal/utils"
)

var (
	ErrMegaphoneDisabled        = utils.NewHTTPErrorWithCode(http.StatusForbidden, "megaphone is disabled", ErrorCodeMegaphoneDisabled)
	ErrMegaphoneContentEmpty    = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "megaphone content is empty", ErrorCodeMegaphoneContentEmpty)
	ErrMegaphoneContentTooLong  = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "megaphone content is too long", ErrorCodeMegaphoneContentTooLong)
	ErrMegaphoneLinkNotAllowed  = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "links are not allowed in megaphones", ErrorCodeMegaphoneLinkNotAllowed)
	ErrMegaphoneContentBlocked  = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "megaphone content is not allowed", ErrorCodeMegaphoneContentBlocked)
	ErrMegaphoneCooldown        = utils.NewHTTPErrorWithCode(http.StatusTooManyRequests, "please wait before sending another megaphone", ErrorCodeMegaphoneCooldown)
	ErrMegaphoneDailyLimit      = utils.NewHTTPErrorWithCode(http.StatusTooManyRequests, "daily megaphone limit reached", ErrorCodeMegaphoneDailyLimit)
	ErrMegaphoneQueueFull       = utils.NewHTTPErrorWithCode(http.StatusConflict, "megaphone queue is full", ErrorCodeMegaphoneQueueFull)
	ErrMegaphoneInsufficientKen = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "insufficient ken balance", ErrorCodeMegaphoneInsufficientKen)
	ErrMegaphoneRequestConflict = utils.NewHTTPErrorWithCode(http.StatusConflict, "megaphone request id was used for another megaphone", ErrorCodeMegaphoneRequestConflict)
	ErrMegaphoneNotFound        = utils.NewHTTPErrorWithCode(http.StatusNotFound, "megaphone not found", ErrorCodeMegaphoneNotFound)
)
