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
		vip.POST("/gift", r.controller.GiftIcon)
		vip.GET("/icons/catalog", r.controller.IconCatalog)
		vip.GET("/packages", r.controller.ListPackages)
		vip.POST("/packages/:id/buy", r.controller.BuyPackage)
		vip.POST("/packages/:id/gift", r.controller.GiftPackage)
		vip.GET("/history", r.controller.GetHistory)
		vip.GET("/transfers", r.controller.GetTransfers)
		vip.POST("/icons/:id/use", r.controller.Use)
		vip.POST("/icons/:id/lock", r.controller.Lock)
		vip.POST("/icons/:id/unlock", r.controller.Unlock)
		vip.POST("/icons/:id/transfer", r.controller.Transfer)
		vip.POST("/icons/batch-delete", r.controller.BatchDelete)
		vip.DELETE("/icons/:id", r.controller.Delete)
	}
}
