package adminwheel

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
	wheel := admin.Group("/wheel", r.authMiddleware.RequireAdmin())
	{
		wheel.GET("/wheels", r.controller.ListWheels)
		wheel.POST("/wheels", r.controller.CreateWheel)
		wheel.PATCH("/wheels/:id", r.controller.UpdateWheel)
		wheel.DELETE("/wheels/:id", r.controller.DeleteWheel)
		wheel.PUT("/wheels/:id/config", r.controller.SaveConfig)
		wheel.GET("/spins", r.controller.ListSpins)
		wheel.GET("/stats", r.controller.GetStats)
		wheel.GET("/stats/users", r.controller.GetUserStats)
		wheel.GET("/stats/vip", r.controller.GetVipStats)
	}
}
