package adminannouncement

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
	announcements := admin.Group("/announcements", r.authMiddleware.RequireAdmin())
	{
		announcements.GET("", r.controller.List)
		announcements.POST("", r.controller.Create)
		announcements.PATCH("/:id", r.controller.Update)
		announcements.DELETE("/:id", r.controller.Delete)
	}
}
