package websocket

import (
	"ola-chat-server/internal/constants"

	socket "github.com/zishang520/socket.io/servers/socket/v3"
)

type ConversationMembersGetter interface {
	GetConversationMembers(conversationID string) ([]string, error)
}

type EventHandler struct {
	server          *Server
	presenceService *PresenceService
	convMembers     ConversationMembersGetter
}

func NewEventHandler(server *Server, presenceService *PresenceService, convMembers ConversationMembersGetter) *EventHandler {
	return &EventHandler{
		server:          server,
		presenceService: presenceService,
		convMembers:     convMembers,
	}
}

func (h *EventHandler) RegisterEvents() {
	h.server.io.On("connection", func(clients ...any) {
		client := clients[0].(*socket.Socket)
		data := client.Data().(*SocketData)
		userID := data.UserID

		h.handleConnection(client, userID)
	})
}

func (h *EventHandler) handleConnection(client *socket.Socket, userID string) {
	client.Join(socket.Room("user:" + userID))

	isFirstConnection, err := h.presenceService.AddConnection(userID)
	if err != nil {
		h.server.logger.Errorw("Failed to add presence", "user_id", userID, "error", err)
	}

	h.server.logger.Infow("WebSocket connected",
		"user_id", userID,
		"socket_id", client.Id(),
		"is_first_connection", isFirstConnection)

	h.registerClientEvents(client, userID)
}

func (h *EventHandler) registerClientEvents(client *socket.Socket, userID string) {
	// Disconnect event
	client.On("disconnect", func(args ...any) {
		h.handleDisconnect(client, userID)
	})

	// Heartbeat ping to refresh presence TTL
	client.On("ping", func(args ...any) {
		if err := h.presenceService.RefreshPresence(userID); err != nil {
			h.server.logger.Warnw("Failed to refresh presence on ping", "user_id", userID, "error", err)
		}
		if h.server.roomPresence != nil {
			data := client.Data().(*SocketData)
			for roomID := range data.JoinedRooms {
				h.server.roomPresence.Refresh(roomID, userID)
			}
		}
	})

	if h.server.roomSvc != nil {
		h.registerRoomEvents(client, userID)
	}
}

func (h *EventHandler) registerRoomEvents(client *socket.Socket, userID string) {
	client.On(constants.SocketEventRoomJoin, func(args ...any) {
		ack, rest := extractAck(args)
		roomID := stringField(argMap(rest), "roomId")
		if roomID == "" {
			replyAck(ack, nil, "roomId is required")
			return
		}

		enabled, err := h.server.roomSvc.RoomEnabled(roomID)
		if err != nil {
			replyAck(ack, nil, "room not found")
			return
		}
		if !enabled {
			replyAck(ack, nil, "room is disabled")
			return
		}

		data := client.Data().(*SocketData)
		client.Join(roomChannel(roomID))
		if !data.JoinedRooms[roomID] {
			data.JoinedRooms[roomID] = true
			if _, err := h.server.roomPresence.Join(roomID, userID); err != nil {
				h.server.logger.Warnw("Failed to add room presence", "room_id", roomID, "user_id", userID, "error", err)
			}
		}

		count, _ := h.server.roomPresence.MemberCount(roomID)
		h.server.EmitToRoom(roomID, constants.WebSocketEventRoomMemberJoined, map[string]any{
			"roomId":      roomID,
			"userId":      userID,
			"memberCount": count,
		})
		replyAck(ack, map[string]any{"roomId": roomID, "memberCount": count}, "")
	})

	client.On(constants.SocketEventRoomLeave, func(args ...any) {
		ack, rest := extractAck(args)
		roomID := stringField(argMap(rest), "roomId")
		if roomID == "" {
			replyAck(ack, nil, "roomId is required")
			return
		}
		h.leaveRoom(client, userID, roomID)
		count, _ := h.server.roomPresence.MemberCount(roomID)
		h.server.EmitToRoom(roomID, constants.WebSocketEventRoomMemberLeft, map[string]any{
			"roomId":      roomID,
			"userId":      userID,
			"memberCount": count,
		})
		replyAck(ack, map[string]any{"roomId": roomID}, "")
	})

}

func (h *EventHandler) leaveRoom(client *socket.Socket, userID, roomID string) {
	data := client.Data().(*SocketData)
	client.Leave(roomChannel(roomID))
	if data.JoinedRooms[roomID] {
		delete(data.JoinedRooms, roomID)
		if _, err := h.server.roomPresence.Leave(roomID, userID); err != nil {
			h.server.logger.Warnw("Failed to remove room presence", "room_id", roomID, "user_id", userID, "error", err)
		}
	}
}

func argMap(args []any) map[string]any {
	if len(args) > 0 {
		if m, ok := args[0].(map[string]any); ok {
			return m
		}
	}
	return nil
}

func stringField(m map[string]any, key string) string {
	if m == nil {
		return ""
	}
	if v, ok := m[key].(string); ok {
		return v
	}
	return ""
}

func extractAck(args []any) (socket.Ack, []any) {
	if len(args) == 0 {
		return nil, args
	}
	if ack, ok := args[len(args)-1].(socket.Ack); ok {
		return ack, args[:len(args)-1]
	}
	return nil, args
}

func replyAck(ack socket.Ack, data any, errMsg string) {
	if ack == nil {
		return
	}
	resp := map[string]any{"ok": errMsg == ""}
	if errMsg != "" {
		resp["error"] = errMsg
	}
	if data != nil {
		resp["data"] = data
	}
	ack([]any{resp}, nil)
}

func (h *EventHandler) handleDisconnect(client *socket.Socket, userID string) {
	if h.server.roomPresence != nil {
		data := client.Data().(*SocketData)
		for roomID := range data.JoinedRooms {
			if _, err := h.server.roomPresence.Leave(roomID, userID); err != nil {
				h.server.logger.Warnw("Failed to leave room on disconnect", "room_id", roomID, "user_id", userID, "error", err)
			}
			count, _ := h.server.roomPresence.MemberCount(roomID)
			h.server.EmitToRoom(roomID, constants.WebSocketEventRoomMemberLeft, map[string]any{
				"roomId":      roomID,
				"userId":      userID,
				"memberCount": count,
			})
		}
	}

	isLastConnection, err := h.presenceService.RemoveConnection(userID)
	if err != nil {
		h.server.logger.Errorw("Failed to remove presence", "user_id", userID, "error", err)
	}

	h.server.logger.Infow("WebSocket disconnected",
		"user_id", userID,
		"socket_id", client.Id(),
		"is_last_connection", isLastConnection)
}

