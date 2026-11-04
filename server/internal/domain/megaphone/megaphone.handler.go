package megaphone

import (
	"context"
	"encoding/json"
	"errors"
	"time"

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
		logger:   logger.Named("[megaphone_events]"),
	}
}

func (h *EventHandler) OnCreated(ctx context.Context, message []byte) error {
	var event CreatedEvent
	if err := json.Unmarshal(message, &event); err != nil {
		h.logger.Errorw("Failed to unmarshal MegaphoneCreated", "error", err)
		return err
	}
	if event.Megaphone.ID == "" {
		return errors.New("megaphone id is required")
	}
	now := time.Now().UTC()
	if !now.Before(event.Megaphone.EndsAt()) {
		h.logger.Infow("Skip finished megaphone", "megaphone_id", event.Megaphone.ID, "show_at", event.Megaphone.ShowAt)
		return nil
	}

	h.wsServer.BroadcastToAll(constants.WebSocketEventMegaphoneNew, map[string]any{
		"megaphone":  utils.MustToJSONMap(event.Megaphone),
		"serverTime": now.Format(time.RFC3339Nano),
	})
	h.logger.Infow("✅ MEGAPHONE_NEW broadcast", "megaphone_id", event.Megaphone.ID)
	return nil
}

func (h *EventHandler) OnRemoved(ctx context.Context, message []byte) error {
	var event RemovedEvent
	if err := json.Unmarshal(message, &event); err != nil {
		h.logger.Errorw("Failed to unmarshal MegaphoneRemoved", "error", err)
		return err
	}
	if event.ID == "" {
		return errors.New("megaphone id is required")
	}

	h.wsServer.BroadcastToAll(constants.WebSocketEventMegaphoneRemoved, map[string]any{"id": event.ID})
	h.logger.Infow("✅ MEGAPHONE_REMOVED broadcast", "megaphone_id", event.ID)
	return nil
}
