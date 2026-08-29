package admintopup

import (
	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/utils"
)

type Router struct {
	controller     *Controller
	authMiddleware *middleware.AuthMiddleware
}

func NewRouter(controller *Controller, authMiddleware *middleware.AuthMiddleware) *Router {
	return &Router{controller: controller, authMiddleware: authMiddleware}
}

func (r *Router) Setup(admin *utils.AppGroup) {
	topup := admin.Group("/topup", r.authMiddleware.RequireAdmin())
	{
		topup.GET("/stats", r.controller.Stats)
		topup.GET("/transactions", r.controller.List)
		topup.POST("/transactions/:id/credit", r.controller.ManualCredit)
	}
}
