package adminmarriage

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
	marriages := admin.Group("/marriages", r.authMiddleware.RequireAdmin())
	{
		marriages.GET("", r.controller.ListMarriages)
		marriages.GET("/stats", r.controller.GetStats)
		marriages.GET("/proposals", r.controller.ListProposals)
	}
}
