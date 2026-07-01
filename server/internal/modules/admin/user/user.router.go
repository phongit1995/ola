package adminuser

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
	users := admin.Group("/users",
		r.authMiddleware.RequireAdmin(),
	)
	{
		users.GET("", r.controller.ListUsers)
		users.GET("/:id", r.controller.GetUser)
		users.GET("/:id/vips", r.controller.ListUserVips)
		users.PATCH("/:id/status", r.controller.UpdateStatus)
		users.DELETE("/:id", r.controller.DeleteUser)
	}
}
