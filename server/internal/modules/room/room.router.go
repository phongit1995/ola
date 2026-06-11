package room

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
	admin := api.Group("/admin/rooms", r.authMiddleware.RequireAdmin())
	{
		admin.POST("", r.controller.CreateRoom)
		admin.GET("", r.controller.ListRoomsAdmin)
		admin.PATCH("/:id", r.controller.UpdateRoom)
		admin.DELETE("/:id", r.controller.DeleteRoom)
	}

	rooms := api.Group("/rooms", r.authMiddleware.RequireAuth())
	{
		rooms.GET("", r.controller.BrowseRooms)
		rooms.GET("/:id", r.controller.GetRoom)
		rooms.POST("/:id/join", r.controller.JoinRoom)
		rooms.POST("/:id/leave", r.controller.LeaveRoom)
		rooms.GET("/:id/members", r.controller.RoomMembers)
		rooms.POST("/:id/messages", r.controller.SendRoomMessage)
		rooms.GET("/:id/messages", r.controller.RoomMessages)
	}
}
