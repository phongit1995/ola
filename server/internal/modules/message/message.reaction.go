package message

import (
	"context"
	"encoding/json"
	"fmt"
	"slices"
	"strings"
	"time"

	"ola-chat-server/internal/constants"
	messageEvents "ola-chat-server/internal/domain/message"
	"ola-chat-server/internal/modules/conversation"

	"github.com/gocql/gocql"
	"github.com/google/uuid"
)

func parseReactions(raw string) map[string][]string {
	if strings.TrimSpace(raw) == "" {
		return map[string][]string{}
	}
	var m map[string][]string
	if err := json.Unmarshal([]byte(raw), &m); err != nil {
		return map[string][]string{}
	}
	if m == nil {
		return map[string][]string{}
	}
	return m
}

func applyReactionToggle(reactions map[string][]string, reactionType, userIDStr string) (string, error) {
	users := reactions[reactionType]

	filtered := make([]string, 0, len(users))
	hasReacted := false
	for _, u := range users {
		if u == userIDStr {
			hasReacted = true
			continue
		}
		filtered = append(filtered, u)
	}

	if hasReacted {
		if len(filtered) == 0 {
			delete(reactions, reactionType)
		} else {
			reactions[reactionType] = filtered
		}
		return constants.ReactionActionRemoved, nil
	}

	typesByUser := 0
	for _, ulist := range reactions {
		for _, u := range ulist {
			if u == userIDStr {
				typesByUser++
				break
			}
		}
	}
	if typesByUser >= MaxReactionTypesPerUserPerMessage {
		return "", fmt.Errorf("%w: max %d", ErrMaxReactions, MaxReactionTypesPerUserPerMessage)
	}

	newUsers := make([]string, len(users)+1)
	copy(newUsers, users)
	newUsers[len(users)] = userIDStr
	reactions[reactionType] = newUsers
	return constants.ReactionActionAdded, nil
}

func (s *Service) ToggleReaction(ctx context.Context, userID, conversationID uuid.UUID, messageIDStr, reactionType string) (*MessageResponse, error) {
	if !slices.Contains(constants.AllowedReactionTypes, reactionType) {
		return nil, fmt.Errorf("%w: %s", ErrInvalidMetadata, reactionType)
	}

	messageID, err := gocql.ParseUUID(messageIDStr)
	if err != nil {
		return nil, fmt.Errorf("invalid message ID: %w", err)
	}

	conv, err := s.getConversationByIDCached(conversationID)
	if err != nil {
		return nil, fmt.Errorf("conversation not found: %w", err)
	}
	members, err := s.getMembersCached(conversationID)
	if err != nil {
		return nil, fmt.Errorf("failed to get members: %w", err)
	}
	if !isActiveMember(members, userID) {
		return nil, ErrNotMember
	}
	if err := conversation.EnsureDirectInteractionAllowed(s.relSvc, conv, members, userID); err != nil {
		return nil, err
	}

	sender := s.mediaSender()
	if !sender.AllowReaction(userID) {
		return nil, ErrRateLimit
	}

	lockKey, err := sender.LockReaction(messageIDStr, "1")
	if err != nil {
		return nil, err
	}
	defer s.redis.Delete(lockKey)

	msg, err := s.repo.GetMessageByID(conversationID, messageID)
	if err != nil {
		return nil, fmt.Errorf("message not found: %w", err)
	}
	if msg.DeletedAt != nil {
		return nil, fmt.Errorf("message deleted")
	}

	reactions := parseReactions(msg.Reactions)
	userIDStr := userID.String()
	action, err := applyReactionToggle(reactions, reactionType, userIDStr)
	if err != nil {
		return nil, err
	}

	var newRaw string
	if len(reactions) == 0 {
		newRaw = ""
	} else {
		b, err := json.Marshal(reactions)
		if err != nil {
			return nil, fmt.Errorf("failed to marshal reactions: %w", err)
		}
		newRaw = string(b)
	}

	if err := s.repo.UpdateReactions(conversationID, messageID, newRaw); err != nil {
		return nil, fmt.Errorf("failed to persist reactions: %w", err)
	}

	s.cache.InvalidateConversationMessages(conversationID)
	s.cache.DeleteMessage(conversationID, messageID)

	s.publishAsync("reaction event", func(ctx context.Context) error {
		return s.kafkaProducer.PublishMessageReactionUpdated(ctx, &messageEvents.MessageReactionUpdatedEvent{
			ConversationID: conversationID.String(),
			MessageID:      messageIDStr,
			Reactions:      reactions,
			ActorUserID:    userIDStr,
			Type:           reactionType,
			Action:         action,
		})
	})

	senderUUID, _ := uuid.Parse(msg.SenderID.String())
	resp := &MessageResponse{
		ID:             messageID.String(),
		ConversationID: conversationID.String(),
		SenderID:       senderUUID.String(),
		SenderName:     msg.SenderName,
		SenderAvatar:   msg.SenderAvatar,
		Type:           msg.MessageType,
		Content:        msg.Content,
		Metadata:       msg.Metadata,
		Status:         "sent",
		CreatedAt:      msg.CreatedAt.Format(time.RFC3339),
		UpdatedAt:      time.Now().Format(time.RFC3339),
		Reactions:      reactions,
	}
	if msg.ReplyToID != nil {
		resp.ReplyToID = msg.ReplyToID.String()
		resp.ReplyTo = parseReplySnapshot(msg.ReplySnapshot)
	}
	return resp, nil
}
