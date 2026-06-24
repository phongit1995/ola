package pen

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
	p := api.Group("/pen", r.authMiddleware.RequireAuth())
	{
		p.POST("/shots", r.controller.CreateShot)
		p.GET("/shots", r.controller.ListOpenShots)
		p.GET("/mine", r.controller.ListMyOpenShots)
		p.POST("/shots/:id/catch", r.controller.Catch)
		p.POST("/shots/:id/cancel", r.controller.Cancel)
		p.GET("/history", r.controller.History)
	}
}
