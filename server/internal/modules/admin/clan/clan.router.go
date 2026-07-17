package adminclan

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
	clans := admin.Group("/clans", r.authMiddleware.RequireAdmin())
	{
		clans.GET("", r.controller.ListClans)
		clans.GET("/:id/members", r.controller.Members)
		clans.DELETE("/:id", r.controller.DeleteClan)
	}
}
