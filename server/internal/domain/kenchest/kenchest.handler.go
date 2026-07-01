package kenchest

import (
	"context"
	"encoding/json"
	"errors"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/transport/websocket"

	"go.uber.org/zap"
)

type EventHandler struct {
	wsServer *websocket.Server
	logger   *zap.SugaredLogger
}

func NewEventHandler(wsServer *websocket.Server, logger *zap.SugaredLogger) *EventHandler {
	return &EventHandler{
		wsServer: wsServer,
		logger:   logger.Named("[ken_chest_events]"),
	}
}

func (h *EventHandler) OnAvailable(ctx context.Context, message []byte) error {
	var event ChestAvailableEvent
	if err := json.Unmarshal(message, &event); err != nil {
		h.logger.Errorw("Failed to unmarshal KenChestAvailable", "error", err)
		return err
	}
	if event.ID == "" {
		return errors.New("ken chest id is required")
	}
	if !time.Now().Before(event.ExpiresAt) {
		h.logger.Infow("Skip expired ken chest available event", "chest_id", event.ID, "expires_at", event.ExpiresAt)
		return nil
	}

	h.wsServer.BroadcastToAll(constants.WebSocketEventKenChestAvailable, map[string]any{
		"id":              event.ID,
		"expiresAt":       event.ExpiresAt,
		"durationSeconds": event.DurationSeconds,
	})
	h.logger.Infow("✅ KEN_CHEST_AVAILABLE broadcast", "chest_id", event.ID)
	return nil
}

func (h *EventHandler) OnClosed(ctx context.Context, message []byte) error {
	var event ChestClosedEvent
	if err := json.Unmarshal(message, &event); err != nil {
		h.logger.Errorw("Failed to unmarshal KenChestClosed", "error", err)
		return err
	}
	if event.ID == "" {
		return errors.New("ken chest id is required")
	}

	h.wsServer.BroadcastToAll(constants.WebSocketEventKenChestClosed, map[string]any{"id": event.ID})
	h.logger.Infow("✅ KEN_CHEST_CLOSED broadcast", "chest_id", event.ID)
	return nil
}
