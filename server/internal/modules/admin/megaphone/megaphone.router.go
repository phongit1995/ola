package adminmegaphone

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
	megaphones := admin.Group("/megaphones", r.authMiddleware.RequireAdmin())
	{
		megaphones.GET("", r.controller.List)
		megaphones.POST("/:id/remove", r.controller.Remove)
	}
	admin.POST("/content-filter/check", r.authMiddleware.RequireAdmin(), r.controller.CheckContent)
}
