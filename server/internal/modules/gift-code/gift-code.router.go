package giftcode

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
	codes := api.Group("/gift-codes", r.authMiddleware.RequireAuth())
	{
		codes.POST("/redeem", r.rateLimit.LimitPolicy(middleware.PolicyGiftCodeRedeem), r.controller.Redeem)
	}
}
