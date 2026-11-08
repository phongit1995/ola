package avatarframe

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
	frames := api.Group("/avatar-frames", r.authMiddleware.RequireAuth())
	{
		frames.GET("/shop", r.controller.ListShop)
		frames.POST("/buy", r.controller.Buy)
		frames.POST("/gift", r.controller.Gift)
		frames.GET("/mine", r.controller.GetMyStore)
		frames.PUT("/equip", r.controller.Equip)
		frames.POST("/mine/:frameId/transfer", r.controller.Transfer)
		frames.GET("/users/:userId/store", r.controller.GetUserStore)
		frames.PUT("/store/privacy", r.controller.SetPrivacy)
		frames.GET("/history", r.controller.GetHistory)
		frames.GET("/transfers", r.controller.GetTransfers)
	}
}
