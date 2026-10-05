package story

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
	stories := api.Group("/stories", r.authMiddleware.RequireAuth())
	{
		stories.GET("", r.controller.List)
		stories.GET("/genres", r.controller.Genres)
		stories.GET("/:id", r.controller.Detail)
		stories.GET("/:id/chapters", r.controller.Chapters)
		stories.GET("/:id/chapters/:position", r.controller.Chapter)
	}
}
