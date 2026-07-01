package kenchest

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
	chests := api.Group("/ken/chests", r.authMiddleware.RequireAuth())
	{
		chests.GET("/active", r.controller.ListActive)
		chests.POST("/:id/open", r.controller.Open)
	}
}
