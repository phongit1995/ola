package room

import (
	"context"
	"encoding/json"
	"errors"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

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
	if event.Room == nil || event.Message == nil || event.Message.RoomID == "" {
		return errors.New("room and message are required")
	}

	envelope := map[string]any{
		"room":    utils.MustToJSONMap(event.Room),
		"message": utils.MustToJSONMap(event.Message),
	}
	h.wsServer.EmitToRoom(event.Message.RoomID, constants.WebSocketEventNewRoomMessage, envelope)
	h.logger.Infow("✅ ROOM_MESSAGE_CREATED broadcast", "room_id", event.Message.RoomID, "message_id", event.Message.ID)
	return nil
}

func (h *EventHandler) OnReactionUpdated(ctx context.Context, message []byte) error {
	var event RoomMessageReactionUpdatedEvent
	if err := json.Unmarshal(message, &event); err != nil {
		h.logger.Errorw("Failed to unmarshal RoomMessageReactionUpdated", "error", err)
		return err
	}
	if event.RoomID == "" || event.MessageID == "" {
		return errors.New("roomId and messageId are required")
	}

	reactions := event.Reactions
	if reactions == nil {
		reactions = map[string][]RoomReactor{}
	}
	h.wsServer.EmitToRoom(event.RoomID, constants.WebSocketEventRoomMessageReactionUpdated, map[string]any{
		"roomId":        event.RoomID,
		"messageId":     event.MessageID,
		"reactions":     utils.MustToJSONMap(reactions),
		"actorUserId":   event.ActorUserID,
		"actorUsername": event.ActorUsername,
		"type":          event.Type,
		"action":        event.Action,
	})
	h.logger.Infow("✅ ROOM_MESSAGE_REACTION_UPDATED broadcast", "room_id", event.RoomID, "message_id", event.MessageID)
	return nil
}

func (h *EventHandler) OnMessageDeleted(ctx context.Context, message []byte) error {
	var event RoomMessageDeletedEvent
	if err := json.Unmarshal(message, &event); err != nil {
		h.logger.Errorw("Failed to unmarshal RoomMessageDeleted", "error", err)
		return err
	}
	if event.RoomID == "" || event.MessageID == "" {
		return errors.New("roomId and messageId are required")
	}

	h.wsServer.EmitToRoom(event.RoomID, constants.WebSocketEventRoomMessageDeleted, map[string]any{
		"roomId":    event.RoomID,
		"messageId": event.MessageID,
	})
	h.logger.Infow("✅ ROOM_MESSAGE_DELETED broadcast", "room_id", event.RoomID, "message_id", event.MessageID)
	return nil
}
