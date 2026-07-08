package auth

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
	auth := api.Group("/auth")
	{
		auth.POST("/register", r.rateLimit.LimitPolicy(middleware.PolicyRegister), r.controller.Register)
		auth.POST("/login", r.rateLimit.LimitPolicy(middleware.PolicyLogin), r.controller.Login)
		auth.POST("/refresh", r.controller.Refresh)
		auth.POST("/logout", r.authMiddleware.RequireAuth(), r.controller.Logout)
		auth.POST("/change-password", r.authMiddleware.RequireAuth(), r.controller.ChangePassword)
	}
}
