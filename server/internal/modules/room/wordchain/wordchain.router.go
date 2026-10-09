package wordchain

import (
	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/utils"
)

type Router struct {
	controller *Controller
	rateLimit  *middleware.RateLimitMiddleware
}

func NewRouter(controller *Controller, rateLimit *middleware.RateLimitMiddleware) *Router {
	return &Router{controller: controller, rateLimit: rateLimit}
}

func (r *Router) Setup(rooms *utils.AppGroup) {
	wordChain := rooms.Group("/word-chain")
	{
		wordChain.GET("", r.controller.Overview)
		wordChain.GET("/messages", r.controller.Messages)
		wordChain.POST("/moves", r.rateLimit.LimitPolicy(middleware.PolicyRoomMessage), r.controller.Move)
		wordChain.POST("/hints", r.rateLimit.LimitPolicy(middleware.PolicyRoomMessage), r.controller.Hint)
		wordChain.POST("/guesses", r.rateLimit.LimitPolicy(middleware.PolicyRoomMessage), r.controller.BuyGuesses)
		wordChain.GET("/leaderboard", r.controller.Leaderboard)
		wordChain.GET("/wins", r.controller.Wins)
		wordChain.GET("/lookup", r.controller.Lookup)
	}
}
