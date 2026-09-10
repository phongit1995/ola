package adminsetting

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
	settings := admin.Group("/settings", r.authMiddleware.RequireAdmin())
	{
		settings.GET("", r.controller.List)
		settings.PUT("", r.controller.PutMany)
		settings.PUT("/:key", r.controller.Put)
	}
}
