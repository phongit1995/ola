package call

import (
	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/utils"
)

type Router struct {
	controller     *Controller
	authMiddleware *middleware.AuthMiddleware
	rateLimit      *middleware.RateLimitMiddleware
}

func NewRouter(
	controller *Controller,
	authMiddleware *middleware.AuthMiddleware,
	rateLimit *middleware.RateLimitMiddleware,
) *Router {
	return &Router{
		controller:     controller,
		authMiddleware: authMiddleware,
		rateLimit:      rateLimit,
	}
}

func (r *Router) Setup(router *utils.AppGroup) {
	calls := router.Group("/calls")
	calls.Use(r.authMiddleware.RequireAuth())
	{
		calls.GET("/active", r.controller.GetOngoingCall)
		calls.POST("/start", r.rateLimit.LimitPolicy(middleware.PolicyCallStart), r.controller.StartCall)
		calls.POST("/:id/answer", r.controller.AnswerCall)
		calls.POST("/:id/decline", r.controller.DeclineCall)
		calls.POST("/:id/end", r.controller.EndCall)
	}

	router.POST("/calls/webhook", r.controller.LiveKitWebhook)
}
