package adminpushcampaign

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
	campaigns := admin.Group("/push-campaigns", r.authMiddleware.RequireAdmin())
	{
		campaigns.GET("", r.controller.ListCampaigns)
		campaigns.GET("/audience", r.controller.Audience)
		campaigns.POST("", r.controller.CreateCampaign)
	}
}
