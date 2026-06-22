package egg

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
	egg := api.Group("/egg", r.authMiddleware.RequireAuth())
	{
		egg.GET("/packs", r.controller.ListPacks)
		egg.POST("/packs/:id/draws", r.controller.Draw)
		egg.GET("/draws", r.controller.ListDraws)
	}
}
