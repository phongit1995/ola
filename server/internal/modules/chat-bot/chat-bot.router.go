package chatbot

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
	bot := api.Group("/chat-bot", r.authMiddleware.RequireAuth())
	{
		bot.RawPOST("", r.rateLimit.LimitPolicy(middleware.PolicyChatBot), r.controller.Chat)
	}
}
