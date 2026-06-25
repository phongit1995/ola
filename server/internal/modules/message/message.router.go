package message

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
	return &Router{
		controller:     controller,
		authMiddleware: authMiddleware,
		rateLimit:      rateLimit,
	}
}

func (r *Router) Setup(router *utils.AppGroup) {
	messages := router.Group("/messages")
	messages.Use(r.authMiddleware.RequireAuth())
	send := r.rateLimit.LimitPolicy(middleware.PolicyChatMessage)
	{
		messages.POST("", send, r.controller.SendMessage)
		messages.POST("/direct", send, r.controller.SendDirectMessage)
		messages.POST("/images", send, r.controller.SendImageMessage)
		messages.POST("/audio", send, r.controller.SendAudioMessage)
		messages.GET("/:conversationId", r.controller.GetMessages)
		messages.PATCH("/:conversationId/:messageId", r.controller.UpdateMessage)
		messages.DELETE("/:conversationId/:messageId", r.controller.DeleteMessage)
		messages.POST("/:conversationId/:messageId/reactions", r.controller.ToggleReaction)
	}
}
