package adminme

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
	posts := admin.Group("/me", r.authMiddleware.RequireAdmin())
	{
		posts.GET("", r.controller.ListPosts)
		posts.GET("/:id", r.controller.GetPost)
		posts.PATCH("/:id/status", r.controller.UpdateStatus)
		posts.GET("/:id/comments", r.controller.ListComments)
		posts.DELETE("/:id/comments/:commentId", r.controller.DeleteComment)
	}
}
