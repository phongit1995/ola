package message

import (
	"context"
	"fmt"
	"time"

	"ola-chat-server/internal/constants"
	messageEvents "ola-chat-server/internal/domain/message"
	"ola-chat-server/internal/modules/conversation"
	"ola-chat-server/internal/utils"

	"github.com/gocql/gocql"
	"github.com/google/uuid"
)

func (s *Service) UpdateMessage(userID uuid.UUID, conversationIDStr, messageIDStr, newContent string) (*MessageResponse, error) {
	conversationID, err := uuid.Parse(conversationIDStr)
	if err != nil {
		return nil, fmt.Errorf("invalid conversation ID: %w", err)
	}

	messageID, err := gocql.ParseUUID(messageIDStr)
	if err != nil {
		return nil, fmt.Errorf("invalid message ID: %w", err)
	}

	// Get existing message
	msg, err := s.repo.GetMessageByID(conversationID, messageID)
	if err != nil {
		return nil, fmt.Errorf("message not found: %w", err)
	}

	// Validate ownership
	if msg.SenderID != userID {
		return nil, fmt.Errorf("you can only update your own messages")
	}

	// Validate message is not deleted
	if msg.DeletedAt != nil {
		return nil, fmt.Errorf("cannot update deleted message")
	}

	if msg.MessageType == constants.MessageTypeGift {
		return nil, fmt.Errorf("cannot update gift message")
	}

	// Validate content
	if newContent == "" {
		return nil, fmt.Errorf("content cannot be empty")
	}

	conv, err := s.getConversationByIDCached(conversationID)
	if err != nil {
		return nil, fmt.Errorf("conversation not found: %w", err)
	}
	members, err := s.getMembersCached(conversationID)
	if err != nil {
		return nil, fmt.Errorf("failed to check conversation membership: %w", err)
	}
	if !isMember(members, userID) {
		return nil, ErrNotMember
	}
	if err := conversation.EnsureDirectInteractionAllowed(s.relSvc, conv, members, userID); err != nil {
		return nil, err
	}

	// Update message in ScyllaDB
	if err := s.repo.UpdateMessage(conversationID, messageID, newContent); err != nil {
		return nil, fmt.Errorf("failed to update message: %w", err)
	}

	senderName := ""
	senderAvatar := ""
	if u, err := s.userCache.GetUserCache(userID, true); err == nil && u != nil {
		senderName = u.Username
		senderAvatar = u.Avatar
	}

	// Update inbox preview if this is the last message
	utils.SafeGo(s.logger, func() {
		s.updateInboxPreviewIfLastMessage(conversationID, messageID, newContent, members)
	})

	// Build response
	now := time.Now()
	response := &MessageResponse{
		ID:             messageID.String(),
		ConversationID: conversationID.String(),
		SenderID:       userID.String(),
		SenderName:     senderName,
		SenderAvatar:   senderAvatar,
		Type:           msg.MessageType,
		Content:        newContent,
		Metadata:       msg.Metadata,
		Status:         "sent",
		CreatedAt:      msg.CreatedAt.Format(time.RFC3339),
		UpdatedAt:      now.Format(time.RFC3339),
		EditedAt:       now.Format(time.RFC3339),
		Reactions:      parseReactions(msg.Reactions),
	}

	if msg.ReplyToID != nil {
		response.ReplyToID = msg.ReplyToID.String()
		response.ReplyTo = parseReplySnapshot(msg.ReplySnapshot)
	}

	s.invalidateMessageCachesAsync(conversationID, messageID)
	s.publishMessageUpdatedAsync(*response, conversationID)

	s.logger.Infow("Message updated successfully",
		"conversation_id", conversationID,
		"message_id", messageID,
		"user_id", userID,
	)

	return response, nil
}

func (s *Service) invalidateMessageCachesAsync(conversationID uuid.UUID, messageID gocql.UUID) {
	utils.SafeGo(s.logger, func() {
		if err := s.cache.DeleteMessage(conversationID, messageID); err != nil {
			s.logger.Warnw("Failed to invalidate message cache after update",
				"conversation_id", conversationID, "message_id", messageID, "error", err)
		}
		if err := s.cache.DeleteConversationMessages(conversationID); err != nil {
			s.logger.Warnw("Failed to invalidate conversation messages cache after update",
				"conversation_id", conversationID, "error", err)
		}
	})
}

func (s *Service) DeleteMessage(userID uuid.UUID, conversationIDStr, messageIDStr string) error {
	conversationID, err := uuid.Parse(conversationIDStr)
	if err != nil {
		return fmt.Errorf("invalid conversation ID: %w", err)
	}

	messageID, err := gocql.ParseUUID(messageIDStr)
	if err != nil {
		return fmt.Errorf("invalid message ID: %w", err)
	}

	msg, err := s.repo.GetMessageByID(conversationID, messageID)
	if err != nil {
		return fmt.Errorf("message not found: %w", err)
	}

	if msg.SenderID != userID {
		return fmt.Errorf("you can only delete your own messages")
	}

	if window := s.cfg.MessageDeleteWindowSeconds; window > 0 {
		age := time.Since(msg.CreatedAt)
		if age > time.Duration(window)*time.Second {
			return ErrMessageDeleteExpired
		}
	}

	members, err := s.getMembersCached(conversationID)
	if err != nil {
		return fmt.Errorf("failed to check conversation membership: %w", err)
	}
	if !isMember(members, userID) {
		return ErrNotMember
	}

	if err := s.repo.DeleteMessage(conversationID, messageID); err != nil {
		return fmt.Errorf("failed to delete message: %w", err)
	}

	// Update inbox preview if this is the last message
	utils.SafeGo(s.logger, func() { s.updateInboxPreviewAfterDelete(conversationID, messageID, members) })

	utils.SafeGo(s.logger, func() { s.invalidateCachesAfterDelete(conversationID, messageID) })

	s.publishAsync("message deleted event", func(ctx context.Context) error {
		return s.kafkaProducer.PublishMessageDeleted(ctx, &messageEvents.MessageDeletedEvent{
			Conversation: s.conversationEventData(conversationID),
			MessageID:    messageIDStr,
		})
	})

	return nil
}

func (s *Service) invalidateCachesAfterDelete(conversationID uuid.UUID, messageID gocql.UUID) {
	if err := s.cache.InvalidateConversationMessages(conversationID); err != nil {
		s.logger.Warnw("Failed to invalidate conversation messages cache", "conversation_id", conversationID, "error", err)
	}

	if err := s.cache.DeleteMessage(conversationID, messageID); err != nil {
		s.logger.Warnw("Failed to invalidate message cache", "message_id", messageID, "error", err)
	}

	s.logger.Debugw("Cache invalidated after delete", "conversation_id", conversationID, "message_id", messageID)
}

func (s *Service) updateInboxPreviewAfterDelete(conversationID uuid.UUID, deletedMessageID gocql.UUID, members []conversation.ConversationMember) {
	for _, m := range members {
		inboxEntry, _, err := s.repo.GetConversationInboxEntry(m.UserID, conversationID)
		if err != nil || inboxEntry == nil || inboxEntry.LastMessageID == nil {
			continue
		}

		if *inboxEntry.LastMessageID == deletedMessageID {
			if err := s.repo.UpdateConversationPreview(m.UserID, conversationID, MessageDeletedPreview); err != nil {
				s.logger.Errorw("Failed to update inbox preview after delete",
					"user_id", m.UserID,
					"conversation_id", conversationID,
					"error", err,
				)
			} else {
				s.convCache.DeleteUserConversations(m.UserID)
			}
		}
	}
}

func (s *Service) updateInboxPreviewIfLastMessage(conversationID uuid.UUID, messageID gocql.UUID, newContent string, members []conversation.ConversationMember) {
	shortContent := truncatePreview(newContent, 100)

	for _, m := range members {
		inboxEntry, _, err := s.repo.GetConversationInboxEntry(m.UserID, conversationID)
		if err != nil || inboxEntry == nil || inboxEntry.LastMessageID == nil {
			continue
		}

		if *inboxEntry.LastMessageID == messageID {
			if err := s.repo.UpdateConversationPreview(m.UserID, conversationID, shortContent); err != nil {
				s.logger.Errorw("Failed to update inbox preview",
					"user_id", m.UserID,
					"conversation_id", conversationID,
					"error", err,
				)
			} else {
				s.convCache.DeleteUserConversations(m.UserID)
			}
		}
	}
}

func (s *Service) recreateInboxEntry(userID, conversationID uuid.UUID, messageID gocql.UUID, messageBody string, senderID uuid.UUID, incrementUnread bool) error {
	conv, err := s.getConversationByIDCached(conversationID)
	if err != nil {
		return fmt.Errorf("failed to get conversation: %w", err)
	}

	gocqlUserID, err := utils.ToGocqlUUID(userID)
	if err != nil {
		return fmt.Errorf("failed to convert userID: %w", err)
	}
	gocqlConvID, err := utils.ToGocqlUUID(conversationID)
	if err != nil {
		return fmt.Errorf("failed to convert conversationID: %w", err)
	}
	gocqlSenderID, err := utils.ToGocqlUUID(senderID)
	if err != nil {
		return fmt.Errorf("failed to convert senderID: %w", err)
	}

	initialUnread := 0
	if incrementUnread {
		initialUnread = 1
	}
	now := time.Now()

	inboxEntry := &conversation.ConversationByUser{
		UserID:             gocqlUserID,
		ConversationID:     gocqlConvID,
		LastMessageAt:      messageID,
		LastMessageID:      &messageID,
		LastMessagePreview: messageBody,
		LastMessageSender:  &gocqlSenderID,
		UnreadCount:        initialUnread,
		UpdatedAt:          &now,
	}

	if conv.Type == constants.ConversationTypeDirect {
		otherUser, gocqlOtherUserID, err := s.resolveDirectOther(conversationID, userID)
		if err != nil {
			return err
		}
		name := directDisplayName(otherUser)
		inboxEntry.ConversationType = constants.ConversationTypeDirect
		inboxEntry.DisplayName = name
		inboxEntry.DisplayAvatar = otherUser.Avatar
		inboxEntry.OtherUserID = &gocqlOtherUserID
		inboxEntry.OtherUserName = name
		inboxEntry.OtherUserAvatar = otherUser.Avatar
	} else {
		inboxEntry.ConversationType = constants.ConversationTypeGroupDB
		inboxEntry.DisplayName = conv.Name
		inboxEntry.DisplayAvatar = conv.Avatar
	}

	if err := s.convRepo.AddConversationToUserInbox(inboxEntry); err != nil {
		return fmt.Errorf("failed to add conversation to inbox: %w", err)
	}

	utils.SafeGo(s.logger, func() {
		s.convCache.SetUnreadCount(conversationID, userID, initialUnread)
		s.convCache.DeleteUserConversations(userID)
	})

	return nil
}
