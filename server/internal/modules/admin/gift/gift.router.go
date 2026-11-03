package admingift

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
	gifts := admin.Group("/gifts", r.authMiddleware.RequireAdmin())
	{
		gifts.GET("", r.controller.List)
		gifts.POST("", r.controller.Create)
		gifts.GET("/transactions", r.controller.ListTransactions)
		gifts.PATCH("/:id", r.controller.Update)
		gifts.DELETE("/:id", r.controller.Delete)
	}
}
