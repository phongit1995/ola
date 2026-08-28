package admingamematch

import (
	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/utils"
)

type Router struct {
	controller     *Controller
	authMiddleware *middleware.AuthMiddleware
}

func NewRouter(controller *Controller, authMiddleware *middleware.AuthMiddleware) *Router {
	return &Router{controller: controller, authMiddleware: authMiddleware}
}

func (r *Router) Setup(admin *utils.AppGroup) {
	matches := admin.Group("/game-matches", r.authMiddleware.RequireAdmin())
	{
		matches.GET("", r.controller.ListMatches)
		matches.GET("/stats", r.controller.GetStats)
		matches.GET("/suspects", r.controller.GetSuspects)
		matches.GET("/levels", r.controller.ListLevels)
	}
}
