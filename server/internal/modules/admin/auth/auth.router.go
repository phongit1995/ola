package adminauth

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

func (r *Router) Setup(admin *utils.AppGroup) {
	auth := admin.Group("/auth")
	{
		auth.POST("/login", r.rateLimit.LimitPolicy(middleware.PolicyAdminLogin), r.controller.Login)
		auth.POST("/refresh", r.controller.Refresh)
		auth.GET("/me", r.authMiddleware.RequireAdmin(), r.controller.Me)
		auth.POST("/change-password", r.authMiddleware.RequireAdmin(), r.controller.ChangePassword)
	}
}
