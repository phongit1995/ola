package marriagediary

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
	d := api.Group("/marriage/diary", r.authMiddleware.RequireAuth())
	{
		d.GET("", r.controller.List)
		d.POST("", r.controller.Create)
		d.DELETE("/:id", r.controller.Delete)
	}
}
