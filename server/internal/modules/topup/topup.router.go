package topup

import (
	"ola-chat-server/internal/utils"
)

type Router struct {
	controller *Controller
}

func NewRouter(controller *Controller) *Router {
	return &Router{controller: controller}
}

func (r *Router) Setup(router *utils.AppGroup) {
	router.RawPOST("/topup/webhook/sieuthicode", r.controller.BankWebhook)
}
