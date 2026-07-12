package adminroom

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
	rooms := admin.Group("/rooms", r.authMiddleware.RequireAdmin())
	{
		rooms.POST("", r.controller.CreateRoom)
		rooms.GET("", r.controller.ListRooms)
		rooms.GET("/:id/messages", r.controller.Messages)
		rooms.DELETE("/:id/messages/:messageId", r.controller.DeleteMessage)
		rooms.PATCH("/:id", r.controller.UpdateRoom)
		rooms.DELETE("/:id", r.controller.DeleteRoom)
	}
}
