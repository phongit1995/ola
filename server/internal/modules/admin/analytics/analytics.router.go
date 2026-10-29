package adminanalytics

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
	analytics := admin.Group("/analytics", r.authMiddleware.RequireAdmin())
	{
		analytics.GET("/overview", r.controller.GetOverview)
		analytics.GET("/realtime", r.controller.GetRealtime)
	}
}
