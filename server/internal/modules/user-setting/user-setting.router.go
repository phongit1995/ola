package usersetting

import (
	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/utils"
)

type Router struct {
	controller     *Controller
	authMiddleware *middleware.AuthMiddleware
}

func NewRouter(controller *Controller, authMiddleware *middleware.AuthMiddleware) *Router {
	return &Router{
		controller:     controller,
		authMiddleware: authMiddleware,
	}
}

func (r *Router) Setup(api *utils.AppGroup) {
	settings := api.Group("/user-settings", r.authMiddleware.RequireAuth())
	{
		settings.GET("", r.controller.GetSettings)
		settings.PUT("", r.controller.UpdateSettings)
	}
}
