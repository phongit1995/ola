package admincheckin

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
	group := admin.Group("/checkin", r.authMiddleware.RequireAdmin())
	{
		group.GET("/months", r.controller.ListMonths)
		group.POST("/months", r.controller.CreateMonth)
		group.GET("/months/:month", r.controller.GetMonth)
		group.PATCH("/months/:month", r.controller.UpdateMonth)
		group.DELETE("/months/:month", r.controller.DeleteMonth)
		group.POST("/months/:month/publish", r.controller.PublishMonth)
		group.PUT("/months/:month/slots", r.controller.SaveSlots)
		group.POST("/months/:month/slots/swap", r.controller.SwapSlots)
		group.GET("/stats", r.controller.Stats)
		group.GET("/history", r.controller.History)
		group.GET("/users/:userId", r.controller.UserMonth)
	}
}
