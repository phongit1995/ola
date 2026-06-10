package adminauth

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
	auth := admin.Group("/auth")
	{
		auth.POST("/login", r.controller.Login)
		auth.POST("/refresh", r.controller.Refresh)
		auth.GET("/me", r.authMiddleware.RequireAdmin(), r.controller.Me)
	}
}
