package gift

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
	gifts := api.Group("/gifts", r.authMiddleware.RequireAuth())
	{
		gifts.GET("", r.controller.Catalog)
		gifts.POST("/send", r.rateLimit.LimitPolicy(middleware.PolicyGiftSend), r.controller.Send)
		gifts.GET("/received", r.controller.Received)
		gifts.GET("/sent", r.controller.Sent)
		gifts.GET("/leaderboard", r.controller.Leaderboard)
		gifts.GET("/users/:id/wall", r.controller.Wall)
	}
}
