package adminreel

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
	reels := admin.Group("/reels", r.authMiddleware.RequireAdmin())
	{
		reels.GET("", r.controller.ListReels)
		reels.GET("/:id", r.controller.GetReel)
		reels.PATCH("/:id/status", r.controller.UpdateStatus)
		reels.GET("/:id/viewers", r.controller.ListViewers)
	}
}
