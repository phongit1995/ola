package vip

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
	vip := api.Group("/vip", r.authMiddleware.RequireAuth())
	{
		vip.GET("/store", r.controller.GetMyStore)
		vip.PUT("/store/privacy", r.controller.SetPrivacy)
		vip.GET("/users/:userId/store", r.controller.GetUserStore)
		vip.POST("/buy", r.controller.Buy)
		vip.GET("/icons/catalog", r.controller.IconCatalog)
		vip.GET("/packages", r.controller.ListPackages)
		vip.POST("/packages/:id/buy", r.controller.BuyPackage)
		vip.GET("/history", r.controller.GetHistory)
		vip.POST("/icons/:id/use", r.controller.Use)
		vip.POST("/icons/:id/lock", r.controller.Lock)
		vip.POST("/icons/:id/unlock", r.controller.Unlock)
		vip.POST("/icons/:id/transfer", r.controller.Transfer)
		vip.DELETE("/icons/:id", r.controller.Delete)
	}
}
