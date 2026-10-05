package adminstory

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
	stories := admin.Group("/stories", r.authMiddleware.RequireAdmin())
	{
		stories.GET("", r.controller.List)
		stories.PATCH("", r.controller.UpdateMany)
		stories.GET("/summary", r.controller.Summary)
		stories.GET("/genres", r.controller.Genres)
		stories.GET("/sources", r.controller.Sources)
		stories.GET("/:id", r.controller.Detail)
		stories.PATCH("/:id", r.controller.Update)
		stories.DELETE("/:id", r.controller.Delete)
		stories.GET("/:id/chapters", r.controller.Chapters)
		stories.POST("/:id/fetch-content", r.controller.FetchContent)
		stories.GET("/:id/chapters/:position", r.controller.Chapter)
		stories.POST("/:id/chapters/:position/refetch", r.controller.Refetch)
	}
}
