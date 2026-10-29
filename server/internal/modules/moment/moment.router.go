package moment

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
	moments := api.Group("/moments", r.authMiddleware.RequireAuth())
	{
		moments.POST("", r.rateLimit.LimitPolicy(middleware.PolicyMomentCreate), r.controller.Create)
		moments.GET("/tray", r.controller.Tray)
		moments.GET("/mine", r.controller.Mine)
		moments.GET("/history", r.controller.History)
		moments.POST("/seen", r.rateLimit.LimitPolicy(middleware.PolicyMomentSeen), r.controller.MarkSeen)
		moments.POST("/:id/reactions", r.rateLimit.LimitPolicy(middleware.PolicyMomentReact), r.controller.React)
		moments.GET("/:id/reactions", r.controller.Reactors)
		moments.POST("/:id/comments", r.rateLimit.LimitPolicy(middleware.PolicyMomentComment), r.controller.Comment)
		moments.GET("/:id/comments", r.controller.Comments)
		moments.GET("/:id/viewers", r.controller.Viewers)
		moments.PATCH("/:id/hidden", r.controller.SetHidden)
		moments.GET("/:id", r.controller.Get)
		moments.DELETE("/:id", r.controller.Delete)
	}
}
