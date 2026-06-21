package me

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

func (r *Router) Setup(api *utils.AppGroup) {
	me := api.Group("/me", r.authMiddleware.RequireAuth())
	{
		me.POST("/images", r.controller.UploadImages)
		me.POST("", r.controller.Create)
		me.GET("", r.controller.Feed)
		me.GET("/mine", r.controller.ListMine)
		me.GET("/users/:userId", r.controller.ListByUser)
		me.GET("/:id", r.controller.GetPost)
		me.PUT("/:id", r.controller.UpdatePost)
		me.DELETE("/:id", r.controller.DeletePost)
		me.POST("/:id/pin", r.controller.Pin)
		me.DELETE("/:id/pin", r.controller.Unpin)
		me.POST("/:id/react", r.controller.React)
		me.DELETE("/:id/react", r.controller.RemoveReaction)
		me.GET("/:id/likers", r.controller.Likers)
		me.POST("/:id/comments", r.controller.AddComment)
		me.GET("/:id/comments", r.controller.ListComments)
		me.DELETE("/:id/comments/:commentId", r.controller.DeleteComment)
	}
}
