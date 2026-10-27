package adminmoment

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
	moments := admin.Group("/moments", r.authMiddleware.RequireAdmin())
	{
		moments.GET("", r.controller.ListMoments)
		moments.GET("/:id", r.controller.GetMoment)
		moments.PATCH("/:id/status", r.controller.UpdateStatus)
		moments.POST("/:id/purge-media", r.controller.PurgeMedia)
		moments.GET("/:id/viewers", r.controller.ListViewers)
	}
	purge := admin.Group("/moment-media-purge", r.authMiddleware.RequireAdmin())
	{
		purge.GET("/logs", r.controller.MediaPurgeLogs)
		purge.POST("/run", r.controller.RunMediaPurge)
	}
}
