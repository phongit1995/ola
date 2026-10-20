package adminreport

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
	reports := admin.Group("/reports", r.authMiddleware.RequireAdmin())
	{
		reports.GET("", r.controller.ListReports)
		reports.GET("/summary", r.controller.Summary)
		reports.PATCH("/:id/status", r.controller.UpdateStatus)
	}
}
