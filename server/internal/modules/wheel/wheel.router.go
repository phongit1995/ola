package wheel

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
	wheel := api.Group("/wheel", r.authMiddleware.RequireAuth())
	{
		wheel.GET("", r.controller.GetConfig)
		wheel.POST("/spins", r.controller.Spin)
		wheel.GET("/spins", r.controller.ListSpins)
	}
}
