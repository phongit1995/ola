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

func (s *Service) CheckDirectConversation(user1ID, user2ID uuid.UUID) (*ConversationResponse, error) {
	if user1ID == user2ID {
		return nil, fmt.Errorf("cannot check conversation with yourself")
	}

	otherUser, err := s.userCache.GetUserCache(user2ID, true)
	if err != nil {
		return nil, fmt.Errorf("user not found: %w", err)
	}

	userA, userB := user1ID, user2ID
	if user1ID.String() > user2ID.String() {
		userA, userB = user2ID, user1ID
	}

	existingConvID, err := s.repo.GetDirectConversationID(userA, userB)
	if err != nil {
		return nil, fmt.Errorf("failed to check existing conversation: %w", err)
	}

	displayName := userDisplayName(otherUser)

	if existingConvID == nil {
		return &ConversationResponse{
			ID:               "",
			Type:             constants.ConversationTypeDirect,
			Name:             displayName,
			Avatar:           otherUser.Avatar,
			ParticipantCount: 0,
			IsNew:            true,
		}, nil
	}

	conv, err := s.repo.GetConversationByID(*existingConvID)
	if err != nil {
		return nil, fmt.Errorf("failed to load conversation metadata: %w", err)
	}

	return &ConversationResponse{
		ID:               existingConvID.String(),
		Type:             constants.ConversationTypeDirect,
		Name:             displayName,
		Avatar:           otherUser.Avatar,
		CreatedAt:        conv.CreatedAt.Format(time.RFC3339),
		UpdatedAt:        conv.UpdatedAt.Format(time.RFC3339),
		ParticipantCount: 2,
		IsNew:            false,
	}, nil
}

func userDisplayName(u *models.User) string {
	if u.FullName != "" {
		return u.FullName
	}
	return u.Username
}

func (s *Service) CreateDirectConversation(user1ID, user2ID uuid.UUID) (*ConversationResponse, error) {
	if user1ID == user2ID {
		return nil, fmt.Errorf("cannot create conversation with yourself")
	}
	if err := BlockIfUsersBlocked(s.relSvc, user1ID, user2ID); err != nil {
		return nil, err
	}

	user1, err := s.userCache.GetUserCache(user1ID, true)
	if err != nil {
		return nil, fmt.Errorf("user1 not found: %w", err)
	}
	otherUser, err := s.userCache.GetUserCache(user2ID, true)
	if err != nil {
		return nil, fmt.Errorf("user2 not found: %w", err)
	}

	userA, userB := user1ID, user2ID
	if user1ID.String() > user2ID.String() {
		userA, userB = user2ID, user1ID
	}

	existingID, err := s.repo.GetDirectConversationID(userA, userB)
	if err != nil {
		return nil, err
	}
	if existingID == nil {
		if err := BlockIfPrivateFromStranger(s.userSettingSvc, s.relRepo, user1ID, user2ID); err != nil {
			return nil, err
		}
	}

	now := time.Now()
	conversationID := uuid.New()

	applied, existingConvID, err := s.repo.TryInsertDirectConversationPair(userA, userB, conversationID)
	if err != nil {
		return nil, fmt.Errorf("failed to insert direct conversation pair: %w", err)
	}

	if !applied {
		s.logger.Infow("Direct conversation already exists (race condition prevented)",
			"user1", user1ID, "user2", user2ID, "existing_conv_id", existingConvID)
		otherUserDisplayName := userDisplayName(otherUser)
		return &ConversationResponse{
			ID:               existingConvID.String(),
			Type:             constants.ConversationTypeDirect,
			Name:             otherUserDisplayName,
			Avatar:           otherUser.Avatar,
			CreatedAt:        now.Format(time.RFC3339),
			UpdatedAt:        now.Format(time.RFC3339),
			ParticipantCount: 2,
			IsNew:            false,
		}, nil
	}

	lastMessageAt := gocql.TimeUUID()

	batch := s.repo.NewBatch()

	conv := &Conversation{
		ConversationID:   conversationID,
		Type:             constants.ConversationTypeDirect,
		Name:             "",
		Avatar:           "",
		CreatedBy:        user1ID,
		CreatedAt:        now,
		UpdatedAt:        now,
		ParticipantCount: 2,
	}
	s.repo.AddConversationToBatch(batch, conv)

	member1 := &ConversationMember{
		ConversationID: conversationID,
		UserID:         user1ID,
		JoinedAt:       now,
		IsActive:       true,
		Role:           constants.MemberRoleDefault,
	}
	member2 := &ConversationMember{
		ConversationID: conversationID,
		UserID:         user2ID,
		JoinedAt:       now,
		IsActive:       true,
		Role:           constants.MemberRoleDefault,
	}
	s.repo.AddMemberToBatch(batch, member1)
	s.repo.AddMemberToBatch(batch, member2)

	gocqlUser1ID, err := utils.ToGocqlUUID(user1ID)
	if err != nil {
		return nil, fmt.Errorf("failed to convert user1ID: %w", err)
	}
	gocqlUser2ID, err := utils.ToGocqlUUID(user2ID)
	if err != nil {
		return nil, fmt.Errorf("failed to convert user2ID: %w", err)
	}
	gocqlConvID, err := utils.ToGocqlUUID(conversationID)
	if err != nil {
		return nil, fmt.Errorf("failed to convert conversationID: %w", err)
	}

	otherUserDisplayName := userDisplayName(otherUser)
	user1DisplayName := userDisplayName(user1)

	inbox1 := newDirectInboxEntry(gocqlUser1ID, gocqlUser2ID, gocqlConvID, otherUserDisplayName, otherUser.Avatar, lastMessageAt, now)
	inbox2 := newDirectInboxEntry(gocqlUser2ID, gocqlUser1ID, gocqlConvID, user1DisplayName, user1.Avatar, lastMessageAt, now)
	s.repo.AddConversationToUserInboxBatch(batch, inbox1)
	s.repo.AddConversationToUserInboxBatch(batch, inbox2)

	if err := s.repo.ExecuteBatch(batch); err != nil {
		return nil, fmt.Errorf("failed to create direct conversation: %w", err)
	}

	members := []ConversationMember{*member1, *member2}
	s.cacheAndPublishDirectCreated(conversationID, user1ID, user2ID, user1, otherUser, members, now)

	return &ConversationResponse{
		ID:               conversationID.String(),
		Type:             constants.ConversationTypeDirect,
		Name:             userDisplayName(otherUser),
		Avatar:           otherUser.Avatar,
		CreatedAt:        now.Format(time.RFC3339),
		UpdatedAt:        now.Format(time.RFC3339),
		ParticipantCount: 2,
		IsNew:            true,
	}, nil
}

func newDirectInboxEntry(owner, other, convID gocql.UUID, otherName, otherAvatar string, lastMessageAt gocql.UUID, now time.Time) *ConversationByUser {
	otherID := other
	updatedAt := now
	return &ConversationByUser{
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

func (s *Service) cacheAndPublishDirectCreated(conversationID, user1ID, user2ID uuid.UUID, user1, otherUser *models.User, members []ConversationMember, now time.Time) {
	utils.SafeGo(s.logger, func() {
		s.InvalidateUserConversationsCache([]uuid.UUID{user1ID, user2ID})
		if err := s.cache.SetConversationMembers(conversationID, members); err != nil {
			s.logger.Warnw("Failed to cache conversation members after creation",
				"conversation_id", conversationID, "error", err)
		}
		s.publishDirectConversationCreated(conversationID, user1ID, user2ID, user1, otherUser, now)
	})
}

func (s *Service) publishDirectConversationCreated(convID, user1ID, user2ID uuid.UUID, user1, user2 *models.User, createdAt time.Time) {
	user1Name := userDisplayName(user1)
	user2Name := userDisplayName(user2)

	participants := []map[string]interface{}{
		{"userId": user1ID.String(), "username": user1.Username, "avatar": user1.Avatar},
		{"userId": user2ID.String(), "username": user2.Username, "avatar": user2.Avatar},
	}

	createdAtStr := createdAt.Format(time.RFC3339)

	user1Event := &conversationEvents.CreatedEvent{
		ConversationID: convID.String(),
		Data: map[string]interface{}{
			"id":               convID.String(),
			"type":             constants.ConversationTypeDirect,
			"name":             user2Name,
			"avatar":           user2.Avatar,
			"createdAt":        createdAtStr,
			"updatedAt":        createdAtStr,
			"participantCount": 2,
			"unreadCount":      0,
			"participants":     participants,
		},
	}
	user2Event := &conversationEvents.CreatedEvent{
		ConversationID: convID.String(),
		Data: map[string]interface{}{
			"id":               convID.String(),
			"type":             constants.ConversationTypeDirect,
			"name":             user1Name,
			"avatar":           user1.Avatar,
			"createdAt":        createdAtStr,
			"updatedAt":        createdAtStr,
			"participantCount": 2,
			"unreadCount":      0,
			"participants":     participants,
		},
	}

	utils.PublishWithTimeout(s.logger, "CONVERSATION_CREATED for user1", func(ctx context.Context) error {
		return s.kafkaProducer.PublishConversationCreated(ctx, user1Event)
	})
	utils.PublishWithTimeout(s.logger, "CONVERSATION_CREATED for user2", func(ctx context.Context) error {
		return s.kafkaProducer.PublishConversationCreated(ctx, user2Event)
	})
}

func (s *Service) CreateGroupConversation(creatorID uuid.UUID, name string, participantIDs []uuid.UUID) (*ConversationResponse, error) {
	if len(participantIDs) < 2 {
		return nil, fmt.Errorf("group conversation must have at least 2 participants")
	}
	if name == "" {
		return nil, fmt.Errorf("group name is required")
	}

	participants, err := s.resolveGroupParticipants(creatorID, participantIDs)
	if err != nil {
		return nil, err
	}
	participantCount := len(participants)

	now := time.Now()
	conversationID := uuid.New()
	lastMessageAt := gocql.TimeUUID()

	batch := s.repo.NewBatch()

	conv := &Conversation{
		ConversationID:   conversationID,
		Type:             constants.ConversationTypeGroupDB,
		Name:             name,
		Avatar:           "",
		CreatedBy:        creatorID,
		CreatedAt:        now,
		UpdatedAt:        now,
		ParticipantCount: participantCount,
	}
	s.repo.AddConversationToBatch(batch, conv)

	members := make([]ConversationMember, 0, participantCount)
	for _, participantID := range participants {
		role := constants.MemberRoleDefault
		if participantID == creatorID {
			role = "admin"
		}

		member := &ConversationMember{
			ConversationID: conversationID,
			UserID:         participantID,
			JoinedAt:       now,
			IsActive:       true,
			Role:           role,
		}
		s.repo.AddMemberToBatch(batch, member)
		members = append(members, *member)

		gocqlParticipantID, err := utils.ToGocqlUUID(participantID)
		if err != nil {
			return nil, fmt.Errorf("failed to convert participantID: %w", err)
		}
		gocqlConvID, err := utils.ToGocqlUUID(conversationID)
		if err != nil {
			return nil, fmt.Errorf("failed to convert conversationID: %w", err)
		}

		inbox := &ConversationByUser{
			UserID:           gocqlParticipantID,
			ConversationID:   gocqlConvID,
			ConversationType: constants.ConversationTypeGroupDB,
			DisplayName:      name,
			DisplayAvatar:    "",
			LastMessageAt:    lastMessageAt,
			UnreadCount:      0,
			UpdatedAt:        &now,
		}
		s.repo.AddConversationToUserInboxBatch(batch, inbox)
	}

	if err := s.repo.ExecuteBatch(batch); err != nil {
		return nil, fmt.Errorf("failed to create group conversation: %w", err)
	}

	s.cacheAndPublishGroupCreated(conversationID, name, participants, members, now)

	return &ConversationResponse{
		ID:               conversationID.String(),
		Type:             constants.ConversationTypeGroupDB,
		Name:             name,
		CreatedAt:        now.Format(time.RFC3339),
		UpdatedAt:        now.Format(time.RFC3339),
		ParticipantCount: participantCount,
		IsNew:            true,
	}, nil
}

func (s *Service) resolveGroupParticipants(creatorID uuid.UUID, participantIDs []uuid.UUID) ([]uuid.UUID, error) {
	all := append(participantIDs, creatorID)
	seen := make(map[uuid.UUID]bool, len(all))
	unique := make([]uuid.UUID, 0, len(all))
	for _, id := range all {
		if seen[id] {
			continue
		}
		seen[id] = true
		unique = append(unique, id)
	}

	usersFound := s.userCache.GetUsersBatch(unique, true)
	for _, id := range unique {
		if u, ok := usersFound[id]; !ok || u == nil {
			return nil, fmt.Errorf("participant %s not found", id)
		}
	}
	return unique, nil
}

func (s *Service) cacheAndPublishGroupCreated(conversationID uuid.UUID, name string, participantIDs []uuid.UUID, members []ConversationMember, now time.Time) {
	utils.SafeGo(s.logger, func() {
		s.InvalidateUserConversationsCache(participantIDs)
		if err := s.cache.SetConversationMembers(conversationID, members); err != nil {
			s.logger.Warnw("Failed to cache conversation members after creation",
				"conversation_id", conversationID, "error", err)
		}
		s.publishGroupConversationCreated(conversationID, name, participantIDs, now)
	})
}

func (s *Service) publishGroupConversationCreated(convID uuid.UUID, name string, participantIDs []uuid.UUID, createdAt time.Time) {
	usersMap := s.userCache.GetUsersBatch(participantIDs, true)
	participants := make([]map[string]interface{}, 0, len(participantIDs))
	for _, pid := range participantIDs {
		u, ok := usersMap[pid]
		if !ok || u == nil {
			continue
		}
		participants = append(participants, map[string]interface{}{
			"userId":   pid.String(),
			"username": u.Username,
			"avatar":   u.Avatar,
		})
	}

	createdAtStr := createdAt.Format(time.RFC3339)

	for _, pid := range participantIDs {
		event := &conversationEvents.CreatedEvent{
			ConversationID: convID.String(),
			Data: map[string]interface{}{
				"id":               convID.String(),
				"type":             constants.ConversationTypeGroupDB,
				"name":             name,
				"createdAt":        createdAtStr,
				"updatedAt":        createdAtStr,
				"participantCount": len(participantIDs),
				"unreadCount":      0,
				"participants":     participants,
			},
		}
		utils.PublishWithTimeout(s.logger, fmt.Sprintf("CONVERSATION_CREATED for group participant %s", pid), func(ctx context.Context) error {
			return s.kafkaProducer.PublishConversationCreated(ctx, event)
		})
	}
}
