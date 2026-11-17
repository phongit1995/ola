package friendcontent

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/push"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type EventHandler struct {
	repo       *Repository
	cache      *services.CacheService
	wsServer   *websocket.Server
	pushSender *push.Sender
	logger     *zap.SugaredLogger
	now        func() time.Time
}

func NewEventHandler(repo *Repository, cache *services.CacheService, wsServer *websocket.Server, pushSender *push.Sender, logger *zap.SugaredLogger) *EventHandler {
	return &EventHandler{
		repo:       repo,
		cache:      cache,
		wsServer:   wsServer,
		pushSender: pushSender,
		logger:     logger.Named(friendContentLogLabel),
		now:        time.Now,
	}
}

func (h *EventHandler) OnPublished(ctx context.Context, message []byte) error {
	var event Event
	if err := json.Unmarshal(message, &event); err != nil {
		h.logger.Errorw("Failed to unmarshal FriendContent", "error", err)
		return err
	}
	if event.Kind != constants.FriendContentPost && event.Kind != constants.FriendContentMoment {
		return fmt.Errorf("unsupported friend content kind %q", event.Kind)
	}
	authorID, err := uuid.Parse(event.AuthorID)
	if err != nil {
		return errors.New("invalid author id")
	}
	contentID, err := uuid.Parse(event.ContentID)
	if err != nil {
		return errors.New("invalid content id")
	}

	now := h.now()
	live, err := h.repo.ContentLive(ctx, event.Kind, authorID, contentID, now)
	if err != nil {
		return err
	}
	if !live {
		h.logger.Infow("Friend content no longer visible, skipping", "kind", event.Kind, "content_id", contentID)
		return nil
	}
	friends, err := h.repo.FriendIDs(ctx, authorID)
	if err != nil {
		return err
	}
	if len(friends) == 0 {
		return nil
	}
	author, err := h.repo.Author(ctx, authorID)
	if err != nil {
		return err
	}
	if !h.acquire(fmt.Sprintf(CacheKeyAuthorGuard, authorID.String()), AuthorGuardTTL) {
		h.logger.Infow("Author already notified friends recently, skipping", "author_id", authorID, "content_id", contentID)
		return nil
	}

	notice := noticePayload{
		Kind:      event.Kind,
		ContentID: contentID.String(),
		Author:    toAuthorPayload(author, now),
		Preview:   event.Preview,
	}
	wrapped := utils.WrapWebSocketMessage(constants.WebSocketEventFriendContent, notice)
	pushIn := push.FriendContentPush{
		Kind:       event.Kind,
		ContentID:  contentID.String(),
		AuthorID:   authorID.String(),
		AuthorName: firstNonEmpty(author.FullName, author.Username),
		Preview:    event.Preview,
	}

	notified := 0
	for _, friendID := range friends {
		if !h.acquire(fmt.Sprintf(CacheKeyRecipientGuard, friendID.String()), RecipientGuardTTL) {
			continue
		}
		recipientID := friendID.String()
		h.wsServer.EmitToUser(recipientID, constants.WebSocketMessageEvent, wrapped)
		if h.pushSender != nil {
			h.pushSender.SendFriendContent(recipientID, pushIn)
		}
		notified++
	}
	h.logger.Infow("✅ FRIEND_CONTENT delivered",
		"kind", event.Kind,
		"author_id", authorID,
		"content_id", contentID,
		"friends", len(friends),
		"notified", notified,
	)
	return nil
}

func (h *EventHandler) acquire(key string, ttl time.Duration) bool {
	if h.cache == nil {
		return true
	}
	acquired, err := h.cache.SetNX(key, "1", ttl)
	if err != nil {
		h.logger.Warnw("Friend content guard unavailable", "key", key, "error", err)
		return false
	}
	return acquired
}

func toAuthorPayload(u *models.User, now time.Time) *authorPayload {
	return &authorPayload{
		ID:            u.ID.String(),
		Username:      u.Username,
		FullName:      u.FullName,
		Avatar:        u.Avatar,
		AvatarFrameID: u.ActiveAvatarFrameID(now),
	}
}

func firstNonEmpty(values ...string) string {
	for _, v := range values {
		if v != "" {
			return v
		}
	}
	return ""
}
