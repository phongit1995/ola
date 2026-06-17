package session

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
	sessions := api.Group("/sessions", r.authMiddleware.RequireAuth())
	{
		sessions.GET("", r.controller.List)
		sessions.DELETE("/others", r.controller.RevokeOthers)
		sessions.DELETE("/:id", r.controller.Revoke)
	}
}
