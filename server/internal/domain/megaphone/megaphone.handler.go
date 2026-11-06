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

func (h *EventHandler) OnPlay(ctx context.Context, message []byte) error {
	var event PlayEvent
	if err := json.Unmarshal(message, &event); err != nil {
		h.logger.Errorw("Failed to unmarshal MegaphonePlay", "error", err)
		return err
	}
	if event.Megaphone.ID == "" {
		return errors.New("megaphone id is required")
	}
	if event.Stale(time.Now().UTC()) {
		h.logger.Infow("Skip stale megaphone play", "megaphone_id", event.Megaphone.ID, "played_at", event.PlayedAt)
		return nil
	}

	h.wsServer.BroadcastToAll(constants.WebSocketEventMegaphonePlay, map[string]any{
		"megaphone": utils.MustToJSONMap(event.Megaphone),
	})
	h.logger.Infow("✅ MEGAPHONE_PLAY broadcast", "megaphone_id", event.Megaphone.ID)
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
