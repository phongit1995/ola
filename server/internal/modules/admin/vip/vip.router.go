package adminvip

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
	vip := admin.Group("/vip", r.authMiddleware.RequireAdmin())
	{
		vip.POST("/packages", r.controller.CreatePackage)
		vip.GET("/packages", r.controller.ListPackages)
		vip.PATCH("/packages/:id", r.controller.UpdatePackage)
		vip.DELETE("/packages/:id", r.controller.DeletePackage)
		vip.GET("/history", r.controller.ListHistory)
		vip.GET("/shop", r.controller.ListShopItems)
		vip.POST("/shop", r.controller.CreateShopItem)
		vip.PATCH("/shop/:id", r.controller.UpdateShopItem)
		vip.DELETE("/shop/:id", r.controller.DeleteShopItem)
	}
}
