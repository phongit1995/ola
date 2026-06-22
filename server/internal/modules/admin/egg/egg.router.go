package adminegg

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
	egg := admin.Group("/egg", r.authMiddleware.RequireAdmin())
	{
		egg.GET("/packs", r.controller.ListPacks)
		egg.POST("/packs", r.controller.CreatePack)
		egg.PATCH("/packs/:id", r.controller.UpdatePack)
		egg.DELETE("/packs/:id", r.controller.DeletePack)
		egg.PUT("/packs/:id/config", r.controller.SaveConfig)
		egg.GET("/draws", r.controller.ListDraws)
	}
}
