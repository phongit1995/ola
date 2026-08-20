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
		auth.POST("/register", r.controller.Register)
		auth.POST("/login", r.rateLimit.LimitPolicy(middleware.PolicyLogin), r.controller.Login)
		auth.POST("/refresh", r.controller.Refresh)
		auth.POST("/logout", r.authMiddleware.RequireAuth(), r.controller.Logout)
		auth.POST("/change-password", r.authMiddleware.RequireAuth(), r.controller.ChangePassword)
		auth.POST("/forgot-password/send", r.rateLimit.LimitPolicy(middleware.PolicyForgotPasswordSend), r.controller.ForgotPasswordSend)
		auth.POST("/forgot-password/confirm", r.rateLimit.LimitPolicy(middleware.PolicyForgotPasswordConfirm), r.controller.ForgotPasswordConfirm)
		auth.POST("/verify-email/send", r.authMiddleware.RequireAuth(), r.rateLimit.LimitPolicy(middleware.PolicyEmailVerifySend), r.controller.SendEmailVerify)
		auth.POST("/verify-email/confirm", r.authMiddleware.RequireAuth(), r.controller.ConfirmEmailVerify)
	}
}
