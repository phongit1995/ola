package adminrelationship

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
	relationships := admin.Group("/relationships", r.authMiddleware.RequireAdmin())
	{
		relationships.GET("", r.controller.ListRelationships)
		relationships.GET("/stats", r.controller.GetStats)
		relationships.GET("/follows", r.controller.ListFollows)
		relationships.GET("/users", r.controller.UserStats)
	}
}
