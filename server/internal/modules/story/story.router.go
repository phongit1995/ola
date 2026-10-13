package story

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
	stories := api.Group("/stories", r.authMiddleware.RequireAuth())
	{
		stories.GET("", r.controller.List)
		stories.GET("/genres", r.controller.Genres)
		stories.GET("/comments", r.controller.RecentComments)
		stories.GET("/:id", r.controller.Detail)
		stories.GET("/:id/chapters", r.controller.Chapters)
		stories.GET("/:id/chapters/:position", r.rateLimit.LimitPolicy(middleware.PolicyStoryChapter), r.controller.Chapter)
		stories.GET("/:id/comments", r.controller.Comments)
		stories.POST("/:id/comments", r.rateLimit.LimitPolicy(middleware.PolicyStoryComment), r.controller.CreateComment)
		stories.DELETE("/:id/comments/:commentId", r.controller.DeleteComment)
		stories.POST("/:id/comments/:commentId/like", r.rateLimit.LimitPolicy(middleware.PolicyStoryCommentLike), r.controller.LikeComment)
	}
}
