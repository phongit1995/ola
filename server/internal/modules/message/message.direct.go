package message

import (
	"context"
	"fmt"
	"sync"
	"time"

	"ola-chat-server/internal/constants"
	conversationEvents "ola-chat-server/internal/domain/conversation"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/conversation"
	"ola-chat-server/internal/utils"

	"github.com/gocql/gocql"
	"github.com/google/uuid"
)

func (s *Service) SendDirectMessage(senderID, recipientID uuid.UUID, messageType, content, metadata, clientMsgID string) (*MessageResponse, error) {
	if senderID == recipientID {
		return nil, fmt.Errorf("cannot send direct message to yourself")
	}
	if err := conversation.BlockIfUsersBlocked(s.relSvc, senderID, recipientID); err != nil {
		return nil, err
	}

	userA, userB := senderID, recipientID
	if senderID.String() > recipientID.String() {
		userA, userB = recipientID, senderID
	}

	existingID, err := s.convRepo.GetDirectConversationID(userA, userB)
	if err != nil {
		return nil, err
	}
	if existingID == nil {
		if err := conversation.BlockIfPrivateFromStranger(s.userSettingSvc, s.relRepo, senderID, recipientID); err != nil {
			return nil, err
		}
	}

	conversationID, isNew, err := s.convRepo.GetOrCreateDirectConversation(userA, userB)
	if err != nil {
		return nil, fmt.Errorf("failed to get/create conversation: %w", err)
	}

	if isNew {
		if err := s.createFullDirectConversation(conversationID, userA, userB, senderID); err != nil {
			return nil, fmt.Errorf("failed to create full conversation structure: %w", err)
		}
		s.logger.Infow("Created new direct conversation with full structure", "conversation_id", conversationID)
	}

	messageResponse, err := s.SendMessage(senderID, conversationID, messageType, content, metadata, nil, clientMsgID)
	if err != nil {
		return nil, err
	}

	if isNew {
		utils.SafeGo(s.logger, func() {
			s.publishConversationCreatedEvent(conversationID, senderID, recipientID, messageResponse)
		})
	}

	return messageResponse, nil
}

func directDisplayName(u *models.User) string {
	if u.FullName != "" {
		return u.FullName
	}
	return u.Username
}

func newDirectInbox(owner, other, convID gocql.UUID, otherName, otherAvatar string, lastMessageAt gocql.UUID, now time.Time) *conversation.ConversationByUser {
	otherID := other
	updatedAt := now
	return &conversation.ConversationByUser{
		UserID:           owner,
		ConversationID:   convID,
		ConversationType: constants.ConversationTypeDirect,
		DisplayName:      otherName,
		DisplayAvatar:    otherAvatar,
		OtherUserID:      &otherID,
		OtherUserName:    otherName,
		OtherUserAvatar:  otherAvatar,
		LastMessageAt:    lastMessageAt,
		UnreadCount:      0,
		UpdatedAt:        &updatedAt,
	}
}

func (s *Service) createFullDirectConversation(conversationID, userA, userB, createdBy uuid.UUID) error {
	user1Info, err := s.userCache.GetUserCache(userA, true)
	if err != nil {
		return fmt.Errorf("userA not found: %w", err)
	}
	user2Info, err := s.userCache.GetUserCache(userB, true)
	if err != nil {
		return fmt.Errorf("userB not found: %w", err)
	}

	now := time.Now()
	lastMessageAt := gocql.TimeUUID()

	batch := s.convRepo.NewBatch()

	conv := &conversation.Conversation{
		ConversationID:   conversationID,
		Type:             constants.ConversationTypeDirect,
		Name:             "",
		Avatar:           "",
		CreatedBy:        createdBy,
		CreatedAt:        now,
		UpdatedAt:        now,
		ParticipantCount: 2,
	}
	s.convRepo.AddConversationToBatch(batch, conv)

	userAMember := &conversation.ConversationMember{
		ConversationID: conversationID,
		UserID:         userA,
		JoinedAt:       now,
		IsActive:       true,
		Role:           constants.MemberRoleDefault,
	}
	userBMember := &conversation.ConversationMember{
		ConversationID: conversationID,
		UserID:         userB,
		JoinedAt:       now,
		IsActive:       true,
		Role:           constants.MemberRoleDefault,
	}
	s.convRepo.AddMemberToBatch(batch, userAMember)
	s.convRepo.AddMemberToBatch(batch, userBMember)

	gocqlUserAID, err := utils.ToGocqlUUID(userA)
	if err != nil {
		return fmt.Errorf("failed to convert userA: %w", err)
	}
	gocqlUserBID, err := utils.ToGocqlUUID(userB)
	if err != nil {
		return fmt.Errorf("failed to convert userB: %w", err)
	}
	gocqlConvID, err := utils.ToGocqlUUID(conversationID)
	if err != nil {
		return fmt.Errorf("failed to convert conversationID: %w", err)
	}

	user1DisplayName := directDisplayName(user1Info)
	user2DisplayName := directDisplayName(user2Info)

	userAInbox := newDirectInbox(gocqlUserAID, gocqlUserBID, gocqlConvID, user2DisplayName, user2Info.Avatar, lastMessageAt, now)
	userBInbox := newDirectInbox(gocqlUserBID, gocqlUserAID, gocqlConvID, user1DisplayName, user1Info.Avatar, lastMessageAt, now)

	if err := s.convRepo.ExecuteBatch(batch); err != nil {
		return fmt.Errorf("failed to execute batch: %w", err)
	}

	if err := s.convRepo.AddConversationToUserInbox(userAInbox); err != nil {
		return fmt.Errorf("failed to add userA inbox: %w", err)
	}

	if err := s.convRepo.AddConversationToUserInbox(userBInbox); err != nil {
		return fmt.Errorf("failed to add userB inbox: %w", err)
	}

	members := []conversation.ConversationMember{*userAMember, *userBMember}

	var wg sync.WaitGroup
	wg.Add(2)
	utils.SafeGo(s.logger, func() {
		defer wg.Done()
		s.convCache.InvalidateUserConversations([]uuid.UUID{userA, userB})
	})
	utils.SafeGo(s.logger, func() {
		defer wg.Done()
		if err := s.convCache.SetConversationMembers(conversationID, members); err != nil {
			s.logger.Warnw("Failed to cache conversation members after creation",
				"conversation_id", conversationID, "error", err)
		}
	})
	wg.Wait()

	return nil
}

func (s *Service) publishConversationCreatedEvent(convID, senderID, recipientID uuid.UUID, lastMessage *MessageResponse) {
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	conv, err := s.getConversationByIDCached(convID)
	if err != nil {
		s.logger.Errorw("Failed to get conversation for CREATED event", "conversation_id", convID, "error", err)
		return
	}

	senderUser, err := s.userCache.GetUserCache(senderID, true)
	if err != nil || senderUser == nil {
		s.logger.Errorw("Failed to get sender user", "user_id", senderID, "error", err)
		return
	}
	recipientUser, err := s.userCache.GetUserCache(recipientID, true)
	if err != nil || recipientUser == nil {
		s.logger.Errorw("Failed to get recipient user", "user_id", recipientID, "error", err)
		return
	}

	lastMessageText := ""
	lastMessageAt := conv.CreatedAt.Format(time.RFC3339)
	if lastMessage != nil {
		lastMessageText = lastMessage.Content
		lastMessageAt = lastMessage.CreatedAt
	}

	participants := []map[string]interface{}{
		{
			"userId":   senderID.String(),
			"username": senderUser.Username,
			"avatar":   senderUser.Avatar,
		},
		{
			"userId":   recipientID.String(),
			"username": recipientUser.Username,
			"avatar":   recipientUser.Avatar,
		},
	}

	senderEvent := &conversationEvents.CreatedEvent{
		ConversationID: convID.String(),
		Data: map[string]interface{}{
			"id":               conv.ConversationID.String(),
			"type":             conv.Type,
			"name":             recipientUser.Username,
			"avatar":           recipientUser.Avatar,
			"createdAt":        conv.CreatedAt.Format(time.RFC3339),
			"updatedAt":        conv.UpdatedAt.Format(time.RFC3339),
			"participantCount": conv.ParticipantCount,
			"lastMessageText":  lastMessageText,
			"lastMessageAt":    lastMessageAt,
			"unreadCount":      0,
			"participants":     participants,
		},
	}

	recipientEvent := &conversationEvents.CreatedEvent{
		ConversationID: convID.String(),
		Data: map[string]interface{}{
			"id":               conv.ConversationID.String(),
			"type":             conv.Type,
			"name":             senderUser.Username,
			"avatar":           senderUser.Avatar,
			"createdAt":        conv.CreatedAt.Format(time.RFC3339),
			"updatedAt":        conv.UpdatedAt.Format(time.RFC3339),
			"participantCount": conv.ParticipantCount,
			"lastMessageText":  lastMessageText,
			"lastMessageAt":    lastMessageAt,
			"unreadCount":      1,
			"participants":     participants,
		},
	}

	if err := s.kafkaProducer.PublishConversationCreated(ctx, senderEvent); err != nil {
		s.logger.Errorw("Failed to publish CONVERSATION_CREATED event for sender", "conversation_id", convID, "error", err)
	} else {
		s.logger.Infow("Published CONVERSATION_CREATED event for sender", "conversation_id", convID)
	}

	if err := s.kafkaProducer.PublishConversationCreated(ctx, recipientEvent); err != nil {
		s.logger.Errorw("Failed to publish CONVERSATION_CREATED event for recipient", "conversation_id", convID, "error", err)
	} else {
		s.logger.Infow("Published CONVERSATION_CREATED event for recipient", "conversation_id", convID)
	}
}

func (s *Service) resolveDirectOther(conversationID, selfID uuid.UUID) (*models.User, gocql.UUID, error) {
	members, err := s.getMembersCached(conversationID)
	if err != nil {
		return nil, gocql.UUID{}, fmt.Errorf("failed to get members: %w", err)
	}

	var otherUserID uuid.UUID
	for _, member := range members {
		if member.UserID != selfID && member.IsActive {
			otherUserID = member.UserID
			break
		}
	}
	if otherUserID == uuid.Nil {
		return nil, gocql.UUID{}, fmt.Errorf("failed to find other user in conversation")
	}

	otherUser, err := s.userCache.GetUserCache(otherUserID, true)
	if err != nil {
		return nil, gocql.UUID{}, fmt.Errorf("failed to get other user: %w", err)
	}
	gocqlOtherUserID, err := utils.ToGocqlUUID(otherUserID)
	if err != nil {
		return nil, gocql.UUID{}, fmt.Errorf("failed to convert otherUserID: %w", err)
	}
	return otherUser, gocqlOtherUserID, nil
}
