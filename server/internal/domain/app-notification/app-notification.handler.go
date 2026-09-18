package appnotification

import (
	"context"
	"encoding/json"
	"errors"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/push"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"go.uber.org/zap"
)

type EventHandler struct {
	wsServer   *websocket.Server
	pushSender *push.Sender
	logger     *zap.SugaredLogger
}

func NewEventHandler(wsServer *websocket.Server, pushSender *push.Sender, logger *zap.SugaredLogger) *EventHandler {
	return &EventHandler{
		wsServer:   wsServer,
		pushSender: pushSender,
		logger:     logger.Named("[app_notification_events]"),
	}
}

func (h *EventHandler) OnCreated(ctx context.Context, message []byte) error {
	var event Event
	if err := json.Unmarshal(message, &event); err != nil {
		h.logger.Errorw("Failed to unmarshal AppNotification", "error", err)
		return err
	}
	if event.RecipientID == "" {
		return errors.New("recipient id is required")
	}

	if len(event.Notification) == 0 || string(event.Notification) == "null" {
		if event.RemovedID == "" {
			return errors.New("notification or removed id is required")
		}
		wrapped := utils.WrapWebSocketMessage(constants.WebSocketEventAppNotification, map[string]interface{}{
			"removedId":   event.RemovedID,
			"unreadCount": event.UnreadCount,
		})
		h.wsServer.EmitToUser(event.RecipientID, constants.WebSocketMessageEvent, wrapped)
		h.logger.Infow("✅ APP_NOTIFICATION removal emitted", "recipient_id", event.RecipientID, "unread_count", event.UnreadCount)
		return nil
	}

	var notification map[string]interface{}
	if err := json.Unmarshal(event.Notification, &notification); err != nil {
		h.logger.Errorw("Failed to unmarshal AppNotification body", "error", err)
		return err
	}

	wrapped := utils.WrapWebSocketMessage(constants.WebSocketEventAppNotification, map[string]interface{}{
		"notification": notification,
		"unreadCount":  event.UnreadCount,
	})
	h.wsServer.EmitToUser(event.RecipientID, constants.WebSocketMessageEvent, wrapped)
	h.logger.Infow("✅ APP_NOTIFICATION emitted", "recipient_id", event.RecipientID, "unread_count", event.UnreadCount)

	if h.pushSender != nil {
		h.pushSender.SendAppNotification(event.RecipientID, notification, int(event.UnreadCount))
	}
	return nil
}
