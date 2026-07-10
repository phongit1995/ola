package websocket

import (
	"ola-chat-server/internal/constants"
	"context"

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
	userRoom := socket.Room("user:" + userID)
	client.Join(userRoom)
	client.Join(broadcastRoom)

	selfID := socket.Room(client.Id())
	h.server.io.To(userRoom).Except(selfID).Emit(constants.WebSocketEventSessionReplaced, map[string]any{
		"reason": "logged_in_elsewhere",
	})
	h.server.io.To(userRoom).Except(selfID).DisconnectSockets(true)

	isFirstConnection, err := h.presenceService.AddConnection(userID)
	if err != nil {
		h.server.logger.Errorw("Failed to add presence", "user_id", userID, "error", err)
	}

	if data, ok := client.Data().(*SocketData); ok {
		if err := h.presenceService.SetDevice(userID, data.Platform); err != nil {
			h.server.logger.Warnw("Failed to set device", "user_id", userID, "error", err)
		}
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
				h.server.roomPresence.Refresh(context.Background(), roomID, userID)
			}
		}
	})

	if h.server.roomPresence != nil {
		h.registerRoomEvents(client, userID)
	}
}

func (h *EventHandler) registerRoomEvents(client *socket.Socket, userID string) {
	client.On(constants.SocketEventRoomJoin, func(args ...any) {
		ack, rest := extractAck(args)
		m := argMap(rest)
		roomID := stringField(m, "roomId")
		ticket := stringField(m, "ticket")
		if roomID == "" {
			replyAck(ack, nil, "roomId is required")
			return
		}

		ctx := context.Background()
		data := client.Data().(*SocketData)

		if data.JoinedRooms[roomID] {
			count, _ := h.server.roomPresence.MemberCount(ctx, roomID)
			replyAck(ack, map[string]any{"roomId": roomID, "memberCount": count}, "")
			return
		}

		maxMembers, valid, err := h.server.roomPresence.ConsumeJoinTicket(ctx, ticket, roomID, userID)
		if err != nil {
			h.server.logger.Warnw("Failed to validate join ticket", "room_id", roomID, "user_id", userID, "error", err)
			replyAck(ack, nil, "failed to validate join ticket")
			return
		}
		if !valid {
			replyAck(ack, nil, "invalid or expired join ticket")
			return
		}

		added, full, err := h.server.roomPresence.Join(ctx, roomID, userID, maxMembers)
		if err != nil {
			h.server.logger.Warnw("Failed to add room presence", "room_id", roomID, "user_id", userID, "error", err)
			replyAck(ack, nil, "failed to join room")
			return
		}
		if full {
			replyAck(ack, nil, "room is full")
			return
		}

		data.JoinedRooms[roomID] = true
		client.Join(roomChannel(roomID))

		count, _ := h.server.roomPresence.MemberCount(ctx, roomID)
		if added {
			h.server.EmitToRoom(roomID, constants.WebSocketEventRoomMemberJoined, map[string]any{
				"roomId":      roomID,
				"userId":      userID,
				"memberCount": count,
			})
		}
		replyAck(ack, map[string]any{"roomId": roomID, "memberCount": count}, "")
	})

	client.On(constants.SocketEventRoomLeave, func(args ...any) {
		ack, rest := extractAck(args)
		roomID := stringField(argMap(rest), "roomId")
		if roomID == "" {
			replyAck(ack, nil, "roomId is required")
			return
		}
		count := h.leaveRoom(context.Background(), client, userID, roomID)
		replyAck(ack, map[string]any{"roomId": roomID, "memberCount": count}, "")
	})

}

func (h *EventHandler) leaveRoom(ctx context.Context, client *socket.Socket, userID, roomID string) int {
	data := client.Data().(*SocketData)
	client.Leave(roomChannel(roomID))
	if !data.JoinedRooms[roomID] {
		count, _ := h.server.roomPresence.MemberCount(ctx, roomID)
		return count
	}
	delete(data.JoinedRooms, roomID)
	removed, err := h.server.roomPresence.Leave(ctx, roomID, userID)
	if err != nil {
		h.server.logger.Warnw("Failed to remove room presence", "room_id", roomID, "user_id", userID, "error", err)
	}
	count, _ := h.server.roomPresence.MemberCount(ctx, roomID)
	if removed {
		h.server.EmitToRoom(roomID, constants.WebSocketEventRoomMemberLeft, map[string]any{
			"roomId":      roomID,
			"userId":      userID,
			"memberCount": count,
		})
	}
	return count
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
	// Giữ chỗ trong phòng ~1h khi disconnect (đăng xuất / mất kết nối): KHÔNG xoá presence
	// phòng lúc disconnect, để TTL RoomPresenceTTLSeconds tự dọn. Chỉ room:leave mới xoá ngay.
	// Mở lại đoạn dưới nếu muốn rời khỏi tất cả phòng ngay khi socket disconnect.
	// if h.server.roomPresence != nil {
	// 	ctx := context.Background()
	// 	data := client.Data().(*SocketData)
	// 	for roomID := range data.JoinedRooms {
	// 		h.leaveRoom(ctx, client, userID, roomID)
	// 	}
	// }

	isLastConnection, err := h.presenceService.RemoveConnection(userID)
	if err != nil {
		h.server.logger.Errorw("Failed to remove presence", "user_id", userID, "error", err)
	}

	h.server.logger.Infow("WebSocket disconnected",
		"user_id", userID,
		"socket_id", client.Id(),
		"is_last_connection", isLastConnection)
}

