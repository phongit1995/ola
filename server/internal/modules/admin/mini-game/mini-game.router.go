package adminminigame

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
	games := admin.Group("/mini-games", r.authMiddleware.RequireAdmin())
	{
		games.GET("", r.controller.List)
		games.POST("", r.controller.Create)
		games.PATCH("/:id", r.controller.Update)
		games.DELETE("/:id", r.controller.Delete)
	}
}
