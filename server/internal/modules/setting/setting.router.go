package setting

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
	api.GET("/settings/app-update", r.controller.AppUpdate)

	settings := api.Group("/settings", r.authMiddleware.RequireAuth())
	{
		settings.GET("/topup", r.controller.TopupConfig)
		settings.GET("/username-change", r.controller.UsernameChangeConfig)
		settings.GET("/word-chain", r.controller.WordChainConfig)
		settings.GET("/story", r.controller.StoryConfig)
		settings.GET("/chat-bot", r.controller.ChatBotConfig)
		settings.GET("/app", r.controller.AppConfig)
	}
}
