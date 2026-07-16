package notification

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

func (r *Router) Setup(api *utils.AppGroup) {
	notifications := api.Group("/notifications", r.authMiddleware.RequireAuth())
	{
		notifications.GET("", r.controller.List)
		notifications.GET("/unread-count", r.controller.UnreadCount)
		notifications.POST("/read-all", r.controller.ReadAll)
	}
}
