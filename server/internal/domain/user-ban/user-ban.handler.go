package userban

import (
	"context"
	"encoding/json"
	"errors"

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
		logger:   logger.Named("[user_ban_events]"),
	}
}

func (h *EventHandler) OnBanned(ctx context.Context, message []byte) error {
	var event Event
	if err := json.Unmarshal(message, &event); err != nil {
		h.logger.Errorw("Failed to unmarshal UserBanned", "error", err)
		return err
	}
	if event.UserID == "" {
		return errors.New("user id is required")
	}

	h.wsServer.DisconnectUser(event.UserID)
	h.logger.Infow("✅ USER_BANNED disconnected", "user_id", event.UserID)
	return nil
}
