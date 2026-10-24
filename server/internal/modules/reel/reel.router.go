package reel

import (
	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/utils"
)

type Router struct {
	controller     *Controller
	authMiddleware *middleware.AuthMiddleware
	rateLimit      *middleware.RateLimitMiddleware
}

func NewRouter(controller *Controller, authMiddleware *middleware.AuthMiddleware, rateLimit *middleware.RateLimitMiddleware) *Router {
	return &Router{controller: controller, authMiddleware: authMiddleware, rateLimit: rateLimit}
}

func (r *Router) Setup(api *utils.AppGroup) {
	reels := api.Group("/reels", r.authMiddleware.RequireAuth())
	{
		reels.POST("", r.rateLimit.LimitPolicy(middleware.PolicyReelCreate), r.controller.Create)
		reels.GET("/tray", r.controller.Tray)
		reels.GET("/mine", r.controller.Mine)
		reels.POST("/seen", r.rateLimit.LimitPolicy(middleware.PolicyReelSeen), r.controller.MarkSeen)
		reels.GET("/:id/viewers", r.controller.Viewers)
		reels.DELETE("/:id", r.controller.Delete)
	}
}
