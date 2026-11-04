package megaphone

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
	megaphones := api.Group("/megaphones", r.authMiddleware.RequireAuth())
	{
		megaphones.GET("", r.controller.History)
		megaphones.POST("", r.rateLimit.LimitPolicy(middleware.PolicyMegaphoneSend), r.controller.Send)
		megaphones.GET("/config", r.controller.Config)
		megaphones.GET("/active", r.controller.Active)
	}
}
