package adminavatarframe

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
	frames := admin.Group("/avatar-frames", r.authMiddleware.RequireAdmin())
	{
		frames.GET("/shop", r.controller.ListShopItems)
		frames.POST("/shop", r.controller.CreateShopItems)
		frames.PUT("/shop/order", r.controller.ReorderShopItems)
		frames.PATCH("/shop/:id", r.controller.UpdateShopItem)
		frames.DELETE("/shop/:id", r.controller.DeleteShopItem)
		frames.GET("/purchases", r.controller.ListPurchases)
		frames.GET("/purchases/stats", r.controller.PurchaseStats)
		frames.GET("/transfers", r.controller.ListTransfers)
	}

	users := admin.Group("/users", r.authMiddleware.RequireAdmin())
	{
		users.GET("/:id/avatar-frames", r.controller.ListUserFrames)
		users.POST("/:id/avatar-frames", r.controller.GrantUserFrame)
		users.DELETE("/:id/avatar-frames/:frameId", r.controller.RevokeUserFrame)
	}
}
