package adminconversation

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
	conversations := admin.Group("/conversations", r.authMiddleware.RequireAdmin())
	{
		conversations.GET("", r.controller.ListByUser)
		conversations.GET("/:id", r.controller.Detail)
		conversations.GET("/:id/messages", r.controller.Messages)
	}
}
