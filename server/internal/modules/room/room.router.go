package room

import (
	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/utils"
)

type Router struct {
	controller     *Controller
	authMiddleware *middleware.AuthMiddleware
	rateLimit      *middleware.RateLimitMiddleware
}

func NewRouter(controller *Controller, authMiddleware *middleware.AuthMiddleware, rateLimit *middleware.RateLimitMiddleware) *Router {
	return &Router{controller: controller, authMiddleware: authMiddleware, rateLimit: rateLimit}
}

func (r *Router) Setup(api *utils.AppGroup) {
	rooms := api.Group("/rooms", r.authMiddleware.RequireAuth())
	{
		rooms.GET("", r.controller.BrowseRooms)
		rooms.GET("/blocked", r.controller.ListBlockedUsers)
		rooms.POST("/blocked", r.controller.BlockUser)
		rooms.DELETE("/blocked/:userId", r.controller.UnblockUser)
		rooms.GET("/:id", r.controller.GetRoom)
		rooms.POST("/:id/join", r.controller.JoinRoom)
		rooms.GET("/:id/members", r.controller.RoomMembers)
		rooms.GET("/:id/messages", r.controller.RoomMessages)
		rooms.POST("/:id/messages", r.rateLimit.LimitPolicy(middleware.PolicyRoomMessage), r.controller.SendRoomMessage)
		rooms.POST("/:id/messages/images", r.rateLimit.LimitPolicy(middleware.PolicyRoomMessage), r.controller.SendRoomImageMessage)
		rooms.POST("/:id/messages/audio", r.rateLimit.LimitPolicy(middleware.PolicyRoomMessage), r.controller.SendRoomAudioMessage)
		rooms.DELETE("/:id/messages/:messageId", r.controller.DeleteRoomMessage)
		rooms.POST("/:id/messages/:messageId/reactions", r.controller.ToggleRoomMessageReaction)
	}
}
