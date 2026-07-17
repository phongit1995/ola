package clan

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
	clans := api.Group("/clans", r.authMiddleware.RequireAuth())
	{
		clans.GET("/check-name", r.controller.CheckName)
		clans.GET("/mine", r.controller.Mine)
		clans.POST("", r.controller.Create)
		clans.GET("/by-handle/:handle", r.controller.GetByHandle)
		clans.GET("/:id", r.controller.GetByID)
		clans.PATCH("/:id", r.controller.Update)
		clans.POST("/:id/avatar", r.controller.UploadAvatar)
		clans.POST("/:id/cover", r.controller.UploadCover)
		clans.POST("/:id/join", r.controller.Join)
		clans.DELETE("/:id/join", r.controller.Leave)
		clans.GET("/:id/members", r.controller.Members)
		clans.PUT("/:id/roles", r.controller.AssignRole)
		clans.DELETE("/:id/roles/:role", r.controller.RevokeRole)
		clans.POST("/:id/verify", r.controller.Verify)
		clans.DELETE("/:id/verify", r.controller.Unverify)
		clans.GET("/:id/bans", r.controller.Bans)
		clans.POST("/:id/bans", r.controller.Ban)
		clans.DELETE("/:id/bans/:userId", r.controller.Unban)
		clans.GET("/:id/me", r.controller.Posts)
		clans.POST("/:id/me", r.controller.CreatePost)
		clans.POST("/:id/pin", r.controller.Pin)
		clans.DELETE("/:id/pin", r.controller.Unpin)
		clans.DELETE("/:id/me/:postId", r.controller.DeletePost)
		clans.DELETE("/:id/me/by-user/:userId", r.controller.DeletePostsByUser)
	}
}
