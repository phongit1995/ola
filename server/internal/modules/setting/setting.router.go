package setting

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
	settings := api.Group("/settings", r.authMiddleware.RequireAuth())
	{
		settings.GET("/topup", r.controller.TopupConfig)
		settings.GET("/username-change", r.controller.UsernameChangeConfig)
	}
}
