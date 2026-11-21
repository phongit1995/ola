package checkin

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
	group := api.Group("/checkin", r.authMiddleware.RequireAuth())
	{
		group.GET("", r.controller.Status)
		group.POST("", r.rateLimit.LimitPolicy(middleware.PolicyCheckin), r.controller.CheckIn)
		group.POST("/open", r.rateLimit.LimitPolicy(middleware.PolicyCheckin), r.controller.Open)
	}
}
