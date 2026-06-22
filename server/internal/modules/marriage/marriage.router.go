package marriage

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
	m := api.Group("/marriage", r.authMiddleware.RequireAuth())
	{
		m.GET("", r.controller.GetStatus)
		m.POST("/divorce", r.controller.Divorce)
		m.POST("/proposals", r.controller.Propose)
		m.GET("/proposals", r.controller.ListProposals)
		m.POST("/proposals/:id/accept", r.controller.Accept)
		m.POST("/proposals/:id/reject", r.controller.Reject)
		m.DELETE("/proposals/:id", r.controller.Cancel)
	}
}
