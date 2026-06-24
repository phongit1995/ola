package adminpen

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
	p := admin.Group("/pen", r.authMiddleware.RequireAdmin())
	{
		p.GET("/shots", r.controller.ListShots)
		p.GET("/stats", r.controller.GetStats)
	}
}
