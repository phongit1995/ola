package adminwordchain

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
	wordChain := admin.Group("/word-chain", r.authMiddleware.RequireAdmin())
	{
		wordChain.GET("", r.controller.Overview)
		wordChain.GET("/messages", r.controller.Messages)
		wordChain.GET("/wins", r.controller.Wins)
	}
}
