package message

import (
	"context"
	"encoding/json"
	"fmt"
	"strings"
	"sync"
	"time"

	"ola-chat-server/internal/constants"
	messageEvents "ola-chat-server/internal/domain/message"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/conversation"
	"ola-chat-server/internal/utils"

	"github.com/gocql/gocql"
	"github.com/google/uuid"
)

func truncatePreview(content string, maxRunes int) string {
	runes := []rune(content)
	if len(runes) <= maxRunes {
		return content
	}
	return string(runes[:maxRunes]) + "…"
}

func imagePreviewText(content string) string {
	c := strings.TrimSpace(content)
	if c == "" {
		return "📷 Photo"
	}
	return "📷 " + truncatePreview(c, 50)
}

func audioPreviewText() string {
	return "🎵 Audio"
}

func callPreviewText(metadata string) string {
	var meta CallMetadata
	if err := json.Unmarshal([]byte(metadata), &meta); err != nil {
		return "📞 Call"
	}
	switch meta.CallStatus {
	case string(models.CallStatusMissed):
		return "📞 Missed call"
	case string(models.CallStatusDeclined):
		return "📞 Call declined"
	}
	if meta.CallType == string(models.CallTypeVideo) {
		return "📹 Video call"
	}
	return "📞 Voice call"
}

func giftPreviewText(metadata string) string {
	var meta GiftPreviewMetadata
	if err := json.Unmarshal([]byte(metadata), &meta); err != nil || meta.GiftName == "" {
		return "🎁 Gift"
	}
	return fmt.Sprintf("🎁 %s ×%d", meta.GiftName, meta.Quantity)
}

func (s *Service) validateMessageContent(messageType, content, metadata string) error {
	isManagedURL := func(rawURL string) bool {
		return s.s3 != nil && s.s3.IsManagedURL(rawURL)
	}
	switch messageType {
	case constants.MessageTypeImage:
		return validateImageMetadata(metadata, isManagedURL)
	case constants.MessageTypeAudio:
		return validateAudioMetadata(metadata, isManagedURL)
	case constants.MessageTypeText:
		if strings.TrimSpace(content) == "" {
			return fmt.Errorf("content required for text message")
		}
	}
	return nil
}

func previewForType(messageType, content, metadata string) string {
	switch messageType {
	case constants.MessageTypeImage:
		return imagePreviewText(content)
	case constants.MessageTypeAudio:
		return audioPreviewText()
	case constants.MessageTypeCall:
		return callPreviewText(metadata)
	case constants.MessageTypeGift:
		return giftPreviewText(metadata)
	default:
		return truncatePreview(content, 100)
	}
}

func (s *Service) SendMessage(senderID, conversationID uuid.UUID, messageType, content, metadata string, replyToID *uuid.UUID, clientMsgID string) (*MessageResponse, error) {
	conv, err := s.getConversationByIDCached(conversationID)
	if err != nil {
		return nil, fmt.Errorf("conversation not found: %w", err)
	}

	members, err := s.getMembersCached(conversationID)
	if err != nil {
		return nil, fmt.Errorf("failed to get members: %w", err)
	}

	if !isActiveMember(members, senderID) {
		return nil, ErrNotMember
	}
	if err := conversation.EnsureDirectInteractionAllowed(s.relSvc, conv, members, senderID); err != nil {
		return nil, err
	}

	if clientMsgID != "" {
		if existing, err := s.cachedIdempotentMessage(senderID, conversationID, messageType, clientMsgID); err != nil {
			return nil, err
		} else if existing != nil {
			s.logger.Infow("Idempotent send: returning existing message",
				"client_msg_id", clientMsgID, "message_id", existing.ID)
			return existing, nil
		}
	}

	if err := s.validateMessageContent(messageType, content, metadata); err != nil {
		return nil, err
	}

	var replySnapshot *ReplySnapshot
	if replyToID != nil {
		replySnapshot, err = s.resolveReplySnapshot(conversationID, *replyToID)
		if err != nil {
			return nil, err
		}
	}

	now := time.Now()
	messageID := gocql.TimeUUID()

	senderInfo, err := s.userCache.GetUserCache(senderID, true)
	if err != nil {
		return nil, fmt.Errorf("failed to get sender info: %w", err)
	}

	msg := &Message{
		ConversationID: conversationID,
		MessageID:      messageID,
		SenderID:       senderID,
		SenderName:     senderInfo.Username,
		SenderAvatar:   senderInfo.Avatar,
		MessageType:    messageType,
		Content:        content,
		Metadata:       metadata,
		CreatedAt:      now,
		UpdatedAt:      now,
		ReplyToID:      replyToID,
	}

	if replySnapshot != nil {
		if raw, marshalErr := json.Marshal(replySnapshot); marshalErr == nil {
			msg.ReplySnapshot = string(raw)
		}
	}

	if err := s.repo.CreateMessage(msg); err != nil {
		return nil, fmt.Errorf("failed to create message: %w", err)
	}

	shortContent := previewForType(messageType, content, metadata)

	memberIDs := conversation.ActiveMemberIDs(members)

	response := &MessageResponse{
		ID:             messageID.String(),
		ConversationID: conversationID.String(),
		SenderID:       senderID.String(),
		SenderName:     senderInfo.Username,
		SenderAvatar:   senderInfo.Avatar,
		Type:           messageType,
		Content:        content,
		Metadata:       metadata,
		Status:         "sent",
		CreatedAt:      now.Format(time.RFC3339),
		UpdatedAt:      now.Format(time.RFC3339),
		ClientMsgID:    clientMsgID,
	}

	if replyToID != nil {
		response.ReplyToID = replyToID.String()
		response.ReplyTo = replySnapshot
	}

	if clientMsgID != "" {
		if err := s.cache.SetMessageByClientMsgID(senderID, clientMsgID, response); err != nil {
			s.logger.Warnw("Failed to set client_msg_id dedup cache", "client_msg_id", clientMsgID, "error", err)
		}
	}

	utils.SafeGo(s.logger, func() {
		s.postSendMessageTasks(conversationID, memberIDs, members, msg, response, shortContent, senderID, messageID, now)
	})

	return response, nil
}

func (s *Service) resolveReplySnapshot(conversationID, replyToID uuid.UUID) (*ReplySnapshot, error) {
	messageID, err := gocql.ParseUUID(replyToID.String())
	if err != nil {
		return nil, fmt.Errorf("invalid reply to ID: %w", err)
	}

	orig, cacheErr := s.cache.GetMessage(conversationID, messageID)
	if cacheErr != nil || orig == nil {
		orig, err = s.repo.GetMessageByID(conversationID, messageID)
		if err != nil {
			return nil, ErrReplyNotFound
		}
	}
	if orig.DeletedAt != nil {
		return nil, ErrReplyNotFound
	}

	snapshot := &ReplySnapshot{
		MessageID:  orig.MessageID.String(),
		SenderID:   orig.SenderID.String(),
		SenderName: orig.SenderName,
		Excerpt:    utils.TruncateRunes(orig.Content, MessageReplyExcerptMaxRunes),
		Type:       orig.MessageType,
	}
	if u, userErr := s.userCache.GetUserCache(orig.SenderID, true); userErr == nil && u != nil {
		snapshot.SenderName = u.Username
	}
	if orig.MessageType == constants.MessageTypeImage {
		var meta ImageMetadata
		if unmarshalErr := json.Unmarshal([]byte(orig.Metadata), &meta); unmarshalErr == nil {
			snapshot.ImageURL = meta.URL
		}
	}
	return snapshot, nil
}

func parseReplySnapshot(raw string) *ReplySnapshot {
	if raw == "" {
		return nil
	}
	var snapshot ReplySnapshot
	if err := json.Unmarshal([]byte(raw), &snapshot); err != nil {
		return nil
	}
	return &snapshot
}

func toEventReplySnapshot(snapshot *ReplySnapshot) *messageEvents.ReplySnapshot {
	if snapshot == nil {
		return nil
	}
	return &messageEvents.ReplySnapshot{
		MessageID:  snapshot.MessageID,
		SenderID:   snapshot.SenderID,
		SenderName: snapshot.SenderName,
		Excerpt:    snapshot.Excerpt,
		Type:       snapshot.Type,
		ImageURL:   snapshot.ImageURL,
	}
}

func (s *Service) applyInboxFanout(conversationID uuid.UUID, members []conversation.ConversationMember,
	messageID gocql.UUID, shortContent string, senderID uuid.UUID, now time.Time) map[string]int {

	activeIDs := conversation.ActiveMemberIDs(members)

	currentUnread, err := s.repo.GetUnreadCounts(activeIDs, conversationID)
	if err != nil {
		s.logger.Errorw("Failed to batch read unread counts", "conversation_id", conversationID, "error", err)
		currentUnread = map[uuid.UUID]int{}
	}

	inboxUpdates := make([]*ConversationInboxUpdate, 0, len(activeIDs))
	unreadByUser := make(map[string]int, len(activeIDs))
	var hiddenMembers []conversation.ConversationMember

	for _, member := range members {
		if !member.IsActive {
			continue
		}

		_, hasInbox := currentUnread[member.UserID]
		if !hasInbox {
			isHidden, hiddenErr := s.convRepo.CheckIfHidden(member.UserID, conversationID)
			if hiddenErr != nil {
				s.logger.Warnw("Failed to check hidden status, treating as not hidden",
					"user_id", member.UserID, "conversation_id", conversationID, "error", hiddenErr)
			}
			if isHidden {
				hiddenMembers = append(hiddenMembers, member)
			} else {
				s.logger.Warnw("Inbox entry missing, will recreate", "user_id", member.UserID)
				memberID := member.UserID
				utils.SafeGo(s.logger, func() {
					s.recreateInboxEntry(memberID, conversationID, messageID, shortContent, senderID, memberID != senderID)
				})
			}
			continue
		}

		newUnread := currentUnread[member.UserID]
		if member.UserID != senderID {
			if counted, incErr := s.convCache.IncrementUnreadSeeded(conversationID, member.UserID, newUnread); incErr == nil {
				newUnread = counted
			} else {
				s.logger.Warnw("Redis unread increment failed, falling back to read-modify-write",
					"user_id", member.UserID, "conversation_id", conversationID, "error", incErr)
				newUnread++
			}
			unreadByUser[member.UserID.String()] = newUnread
		}

		inboxUpdates = append(inboxUpdates, &ConversationInboxUpdate{
			UserID:             member.UserID,
			ConversationID:     conversationID,
			LastMessageAt:      messageID,
			LastMessageID:      &messageID,
			LastMessagePreview: shortContent,
			LastMessageSender:  &senderID,
			UnreadCount:        newUnread,
			UpdatedAt:          &now,
		})
	}

	if len(inboxUpdates) > 0 {
		if err := s.repo.BatchUpdateInbox(inboxUpdates); err != nil {
			s.logger.Errorw("Failed to batch update inbox", "error", err)
		}
	}

	if len(hiddenMembers) > 0 {
		conv, err := s.getConversationByIDCached(conversationID)
		if err != nil || conv == nil {
			conv, err = s.convRepo.GetConversationByID(conversationID)
		}
		if err != nil || conv == nil {
			s.logger.Errorw("Failed to fetch conversation for hidden-member unhide, recipients will not see this message in their inbox until the next one",
				"conversation_id", conversationID, "hidden_member_count", len(hiddenMembers), "error", err)
			return unreadByUser
		}
		s.processHiddenMembers(hiddenMembers, conv, members, conversationID, messageID, shortContent, senderID, unreadByUser)
	}
	return unreadByUser
}

func (s *Service) processHiddenMembers(hiddenMembers []conversation.ConversationMember, conv *conversation.Conversation,
	allMembers []conversation.ConversationMember, conversationID uuid.UUID, messageID gocql.UUID, shortContent string, senderID uuid.UUID,
	unreadByUser map[string]int) {

	for _, m := range hiddenMembers {
		s.logger.Infow("Auto-unhiding conversation", "user_id", m.UserID, "conversation_id", conversationID)

		d := conversation.ResolveConversationDisplay(conv, m.UserID, allMembers, s.userCache)

		unreadAfterUnhide := 0
		if m.UserID != senderID {
			unreadAfterUnhide = 1
		}

		if err := s.convRepo.UnhideConversation(m.UserID, conversationID, messageID,
			&messageID, shortContent, &senderID,
			d.ConversationType, d.DisplayName, d.DisplayAvatar, d.OtherUserID, d.OtherUserName, d.OtherUserAvatar,
			unreadAfterUnhide); err != nil {
			s.logger.Errorw("Failed to auto-unhide", "user_id", m.UserID, "error", err)
			continue
		}

		s.convCache.RemoveHiddenConversation(m.UserID, conversationID)
		s.convCache.SetUnreadCount(conversationID, m.UserID, unreadAfterUnhide)
		if unreadAfterUnhide > 0 {
			unreadByUser[m.UserID.String()] = unreadAfterUnhide
		}
	}
}

func (s *Service) postSendMessageTasks(conversationID uuid.UUID, memberIDs []uuid.UUID,
	members []conversation.ConversationMember, msg *Message, response *MessageResponse,
	shortContent string, senderID uuid.UUID, messageID gocql.UUID, now time.Time) {

	unreadCounts := s.applyInboxFanout(conversationID, members, messageID, shortContent, senderID, now)

	if err := s.cache.SetMessage(msg); err != nil {
		s.logger.Warnw("Failed to cache message", "message_id", msg.MessageID, "error", err)
	}

	s.invalidateCachesAfterSend(conversationID, memberIDs)

	s.publishWithTimeout("message created event", func(ctx context.Context) error {
		return s.kafkaProducer.PublishMessageCreated(ctx, &messageEvents.MessageCreatedEvent{
			Conversation: s.conversationEventData(conversationID),
			Message:      messageDataFromResponse(*response),
			UnreadCounts: unreadCounts,
		})
	})
}

func (s *Service) invalidateCachesAfterSend(conversationID uuid.UUID, memberIDs []uuid.UUID) {
	if err := s.cache.InvalidateConversationMessages(conversationID); err != nil {
		s.logger.Warnw("Failed to invalidate conversation messages cache", "conversation_id", conversationID, "error", err)
	}

	var wg sync.WaitGroup
	for _, userID := range memberIDs {
		wg.Add(1)
		uid := userID
		utils.SafeGo(s.logger, func() {
			defer wg.Done()
			if err := s.convCache.DeleteUserConversations(uid); err != nil {
				s.logger.Warnw("Failed to invalidate user conversations cache", "user_id", uid, "error", err)
			}
		})
	}
	wg.Wait()

	s.logger.Debugw("Cache invalidated after send", "conversation_id", conversationID, "member_count", len(memberIDs))
}
