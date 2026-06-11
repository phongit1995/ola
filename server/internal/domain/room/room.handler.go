package room

import (
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"
	"context"
	"encoding/json"
	"errors"

	"go.uber.org/zap"
)

type EventHandler struct {
	wsServer *websocket.Server
	logger   *zap.SugaredLogger
}

func NewEventHandler(wsServer *websocket.Server, logger *zap.SugaredLogger) *EventHandler {
	return &EventHandler{
		wsServer: wsServer,
		logger:   logger.Named("[room_events]"),
	}
}

func (h *EventHandler) OnMessageCreated(ctx context.Context, message []byte) error {
	var event RoomMessageCreatedEvent
	if err := json.Unmarshal(message, &event); err != nil {
		h.logger.Errorw("Failed to unmarshal RoomMessageCreated", "error", err)
		return err
	}

	if event.Message == nil || event.Room == nil {
		return errors.New("room and message are required")
	}

	if len(event.MemberIDs) == 0 {
		h.logger.Warnw("No members to emit room message", "room_id", event.Room.ID)
		return nil
	}

	payload := map[string]interface{}{
		"room":    utils.MustToJSONMap(event.Room),
		"message": utils.MustToJSONMap(event.Message),
	}
	wrapped := utils.WrapWebSocketMessage(constants.WebSocketEventNewRoomMessage, payload)
	h.wsServer.EmitToUsers(event.MemberIDs, constants.WebSocketMessageEvent, wrapped)

	h.logger.Infow("Room message emitted",
		"room_id", event.Room.ID,
		"message_id", event.Message.ID,
		"recipients", len(event.MemberIDs),
	)
	return nil
}
