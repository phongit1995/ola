package adminkenchest

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
	ken := admin.Group("/ken", r.authMiddleware.RequireAdmin())
	{
		ken.POST("/chests", r.controller.Create)
		ken.GET("/chests", r.controller.List)
		ken.GET("/chests/:id", r.controller.Detail)
		ken.GET("/chests/:id/claims", r.controller.ListClaims)
		ken.DELETE("/chests/:id", r.controller.Delete)

		ken.GET("/claims", r.controller.ListAllClaims)

		ken.GET("/chest-stats", r.controller.GetStats)
		ken.GET("/chest-stats/users", r.controller.GetUserStats)

		ken.GET("/auto-jobs", r.controller.ListAutoJobs)
		ken.POST("/auto-jobs", r.controller.CreateAutoJob)
		ken.PUT("/auto-jobs/:id", r.controller.UpdateAutoJob)
		ken.DELETE("/auto-jobs/:id", r.controller.DeleteAutoJob)

		ken.GET("/auto-settings", r.controller.GetAutoSettings)
		ken.PUT("/auto-settings", r.controller.UpdateAutoSettings)
	}
}
