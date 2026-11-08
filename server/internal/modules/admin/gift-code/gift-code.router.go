package admingiftcode

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
	codes := admin.Group("/gift-codes", r.authMiddleware.RequireAdmin())
	{
		codes.GET("", r.controller.List)
		codes.POST("", r.controller.Create)
		codes.GET("/attempts", r.controller.ListAttempts)
		codes.GET("/attempts/summary", r.controller.AttemptSummary)
		codes.GET("/attempts/users", r.controller.AttemptUsers)
		codes.GET("/attempts/devices", r.controller.AttemptDevices)
		codes.GET("/:id", r.controller.Get)
		codes.PUT("/:id", r.controller.Update)
		codes.PATCH("/:id/enabled", r.controller.SetEnabled)
		codes.GET("/:id/codes", r.controller.ListCodes)
		codes.POST("/:id/codes", r.controller.GenerateCodes)
		codes.GET("/:id/codes/export", r.controller.ExportCodes)
		codes.PATCH("/:id/codes/:codeId/lock", r.controller.SetCodeLock)
		codes.GET("/:id/redemptions", r.controller.ListRedemptions)
		codes.GET("/:id/redemptions/export", r.controller.ExportRedemptions)
	}
}
