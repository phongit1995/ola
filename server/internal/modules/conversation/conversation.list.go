package conversation

import (
	"context"
	"fmt"
	"time"

	"ola-chat-server/internal/constants"
	conversationEvents "ola-chat-server/internal/domain/conversation"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/gocql/gocql"
	"github.com/google/uuid"
)

func (s *Service) GetUserConversations(userID uuid.UUID, limit int) (*ConversationsListResponse, error) {
	conversations, err := s.cache.GetUserConversationsCached(userID, limit)
	if err != nil {
		return nil, fmt.Errorf("failed to get user conversations: %w", err)
	}

	otherReads := s.resolveOtherReadStates(conversations, userID)
	users := s.batchConversationUsers(conversations)

	responses := make([]ConversationResponse, 0, len(conversations))
	for _, conv := range conversations {
		var otherLastRead *gocql.UUID
		if conv.ConversationType == constants.ConversationTypeDirect && conv.OtherUserID != nil {
			if otherUUID, err := uuid.Parse(conv.OtherUserID.String()); err == nil {
				if convUUID, err := uuid.Parse(conv.ConversationID.String()); err == nil {
					otherLastRead = otherReads[otherUUID.String()+":"+convUUID.String()]
				}
			}
		}
		responses = append(responses, s.buildConversationResponse(conv, userID, otherLastRead, users))
	}

	s.enrichPresence(responses)

	return &ConversationsListResponse{
		Conversations: responses,
		Total:         len(responses),
	}, nil
}

func (s *Service) batchConversationUsers(conversations []ConversationByUser) map[uuid.UUID]*models.User {
	idSet := make(map[uuid.UUID]struct{}, len(conversations)*2)
	for _, conv := range conversations {
		if conv.ConversationType == constants.ConversationTypeDirect && conv.OtherUserID != nil {
			if id, err := uuid.Parse(conv.OtherUserID.String()); err == nil {
				idSet[id] = struct{}{}
			}
		}
		if conv.LastMessageSender != nil {
			if id, err := uuid.Parse(conv.LastMessageSender.String()); err == nil {
				idSet[id] = struct{}{}
			}
		}
	}
	ids := make([]uuid.UUID, 0, len(idSet))
	for id := range idSet {
		ids = append(ids, id)
	}
	return s.userCache.GetUsersBatch(ids, true)
}

func (s *Service) resolveOtherReadStates(conversations []ConversationByUser, userID uuid.UUID) map[string]*gocql.UUID {
	otherReadPairs := make([]OtherUserReadState, 0)
	otherReads := make(map[string]*gocql.UUID)
	for _, conv := range conversations {
		if conv.ConversationType != constants.ConversationTypeDirect ||
			conv.OtherUserID == nil ||
			conv.LastMessageSender == nil ||
			conv.LastMessageSender.String() != userID.String() {
			continue
		}
		otherUUID, err := uuid.Parse(conv.OtherUserID.String())
		if err != nil {
			continue
		}
		convUUID, err := uuid.Parse(conv.ConversationID.String())
		if err != nil {
			continue
		}
		key := otherUUID.String() + ":" + convUUID.String()
		if cachedMsgID, cacheErr := s.cache.GetLastRead(convUUID, otherUUID); cacheErr == nil && cachedMsgID != "" {
			if gocqlMsgID, parseErr := gocql.ParseUUID(cachedMsgID); parseErr == nil {
				otherReads[key] = &gocqlMsgID
				continue
			}
		}
		otherReadPairs = append(otherReadPairs, OtherUserReadState{
			UserID:         otherUUID,
			ConversationID: convUUID,
		})
	}

	if len(otherReadPairs) == 0 {
		return otherReads
	}

	dbReads, err := s.repo.GetOtherUsersLastRead(otherReadPairs)
	if err != nil {
		s.logger.Warnw("Failed to fetch other users last read", "error", err)
		return otherReads
	}
	for k, v := range dbReads {
		otherReads[k] = v
	}
	utils.SafeGo(s.logger, func() {
		for _, p := range otherReadPairs {
			key := p.UserID.String() + ":" + p.ConversationID.String()
			if msgID, ok := dbReads[key]; ok && msgID != nil {
				s.cache.SetLastRead(p.ConversationID, p.UserID, msgID.String())
			}
		}
	})
	return otherReads
}

func (s *Service) enrichPresence(responses []ConversationResponse) {
	if s.presence == nil {
		return
	}
	otherIDs := make([]string, 0, len(responses))
	seen := make(map[string]bool, len(responses))
	for _, r := range responses {
		if r.OtherUser != nil && !seen[r.OtherUser.ID] {
			otherIDs = append(otherIDs, r.OtherUser.ID)
			seen[r.OtherUser.ID] = true
		}
	}
	if len(otherIDs) == 0 {
		return
	}
	presenceMap := s.presence.GetPresenceBatch(otherIDs)
	for i := range responses {
		if responses[i].OtherUser == nil {
			continue
		}
		info := presenceMap[responses[i].OtherUser.ID]
		responses[i].OtherUser.IsOnline = info.IsOnline
		responses[i].OtherUser.LastActiveAt = info.LastActiveAt
	}
}

func (s *Service) MarkConversationAsRead(userID, conversationID uuid.UUID) error {
	members, err := s.GetMembersCached(conversationID)
	if err != nil {
		return fmt.Errorf("failed to get members: %w", err)
	}
	if !requireActiveMember(members, userID) {
		return fmt.Errorf("user is not a member of this conversation")
	}

	userConv, err := s.repo.GetUserConversationByID(userID, conversationID)
	if err != nil {
		return fmt.Errorf("failed to get user conversation: %w", err)
	}
	if userConv == nil {
		return fmt.Errorf("conversation not found in user inbox")
	}

	lastReadMessageID := userConv.LastMessageID

	upToDate := lastReadMessageID == nil ||
		(userConv.LastReadMessageID != nil && *userConv.LastReadMessageID == *lastReadMessageID)
	if userConv.UnreadCount == 0 && upToDate {
		return nil
	}

	now := time.Now()

	applied, err := s.repo.MarkAsRead(conversationID, userID, lastReadMessageID, now)
	if err != nil {
		return fmt.Errorf("failed to mark as read: %w", err)
	}
	if !applied {
		s.logger.Infow("markRead skipped, inbox row no longer exists",
			"user_id", userID, "conversation_id", conversationID)
		return nil
	}

	utils.SafeGo(s.logger, func() {
		s.cache.ResetUnreadCount(conversationID, userID)
		if err := s.cache.ClearPendingPush(conversationID, userID); err != nil {
			s.logger.Warnw("Failed to clear pending dm push", "user_id", userID, "conversation_id", conversationID, "error", err)
		}
		if lastReadMessageID != nil {
			s.cache.SetLastRead(conversationID, userID, lastReadMessageID.String())
		}
		s.InvalidateUserConversationsCache([]uuid.UUID{userID})
	})

	if userConv.LastMessageSender != nil && userConv.OtherUserID != nil {
		senderID := *userConv.LastMessageSender
		otherUserID := *userConv.OtherUserID
		if senderID != gocql.UUID(userID) && senderID == otherUserID {
			event := &conversationEvents.UpdatedEvent{
				ConversationID: conversationID.String(),
				Data: map[string]interface{}{
					"id":   conversationID.String(),
					"seen": true,
				},
			}
			utils.PublishAsync(s.logger, "conversation updated event for seen", func(ctx context.Context) error {
				return s.kafkaProducer.PublishConversationUpdated(ctx, event)
			})
		}
	}

	return nil
}
