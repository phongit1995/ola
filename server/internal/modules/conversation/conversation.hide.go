package conversation

import (
	"fmt"

	"ola-chat-server/internal/utils"

	"github.com/gocql/gocql"
	"github.com/google/uuid"
)

func (s *Service) SetConversationMuted(userID, conversationID uuid.UUID, muted bool) error {
	members, err := s.GetMembersCached(conversationID)
	if err != nil {
		return fmt.Errorf("failed to get members: %w", err)
	}
	if !requireActiveMember(members, userID) {
		return fmt.Errorf("user is not a member of this conversation")
	}

	applied, err := s.repo.SetMuted(userID, conversationID, muted)
	if err != nil {
		return fmt.Errorf("failed to set mute state: %w", err)
	}
	if !applied {
		return fmt.Errorf("conversation not found in inbox")
	}

	utils.SafeGo(s.logger, func() { s.InvalidateUserConversationsCache([]uuid.UUID{userID}) })
	return nil
}

func (s *Service) HideConversation(userID, conversationID uuid.UUID, clearMessages bool) error {
	members, err := s.GetMembersCached(conversationID)
	if err != nil {
		return fmt.Errorf("failed to get members: %w", err)
	}
	if !requireActiveMember(members, userID) {
		return fmt.Errorf("user is not a member of this conversation")
	}

	if clearMessages {
		marker := gocql.TimeUUID()
		if err := s.repo.SetClearedMarker(userID, conversationID, marker); err != nil {
			return fmt.Errorf("failed to set cleared marker: %w", err)
		}
		if err := s.cache.SetClearedMarkerCache(userID, conversationID, marker.String()); err != nil {
			s.logger.Warnw("Failed to cache cleared marker", "user_id", userID, "conversation_id", conversationID, "error", err)
		}
	}

	if err := s.repo.HideConversation(userID, conversationID); err != nil {
		return fmt.Errorf("failed to hide conversation: %w", err)
	}

	utils.SafeGo(s.logger, func() {
		if err := s.cache.AddHiddenConversation(userID, conversationID); err != nil {
			s.logger.Warnw("Failed to update hidden cache", "user_id", userID, "conversation_id", conversationID, "error", err)
		}
		s.cache.ResetUnreadCount(conversationID, userID)
		s.InvalidateUserConversationsCache([]uuid.UUID{userID})
	})

	return nil
}

func (s *Service) UnhideConversation(userID, conversationID uuid.UUID) error {
	hidden, err := s.repo.GetHiddenConversation(userID, conversationID)
	if err != nil {
		return fmt.Errorf("failed to check hidden status: %w", err)
	}
	if hidden == nil {
		return fmt.Errorf("conversation is not hidden")
	}

	conv, err := s.repo.GetConversationByID(conversationID)
	if err != nil {
		return fmt.Errorf("failed to get conversation: %w", err)
	}

	members, membersErr := s.GetMembersCached(conversationID)
	if membersErr != nil {
		s.logger.Warnw("Failed to get members, resolving display without them",
			"conversation_id", conversationID, "error", membersErr)
	}
	d := s.resolveConversationDisplay(conv, userID, members)

	newLastMessageAt := gocql.TimeUUID()
	if err := s.repo.UnhideConversation(userID, conversationID, newLastMessageAt, nil, "", nil,
		d.ConversationType, d.DisplayName, d.DisplayAvatar, d.OtherUserID, d.OtherUserName, d.OtherUserAvatar, 0); err != nil {
		return fmt.Errorf("failed to unhide conversation: %w", err)
	}

	utils.SafeGo(s.logger, func() {
		if err := s.cache.RemoveHiddenConversation(userID, conversationID); err != nil {
			s.logger.Warnw("Failed to update hidden cache", "user_id", userID, "conversation_id", conversationID, "error", err)
		}
		s.cache.ResetUnreadCount(conversationID, userID)
		s.InvalidateUserConversationsCache([]uuid.UUID{userID})
	})

	return nil
}

func (s *Service) CheckIfHidden(userID, conversationID uuid.UUID) (bool, error) {
	return s.cache.CheckIfHiddenCached(userID, conversationID)
}

func (s *Service) AutoUnhideOnNewMessage(userID, conversationID uuid.UUID, messageID gocql.UUID,
	messageBody string, senderID uuid.UUID) error {

	isHidden, err := s.CheckIfHidden(userID, conversationID)
	if err != nil {
		return fmt.Errorf("failed to check hidden status: %w", err)
	}

	if !isHidden {
		return nil
	}

	s.logger.Infow("Auto-unhiding conversation due to new message",
		"user_id", userID, "conversation_id", conversationID, "message_id", messageID)

	conv, err := s.repo.GetConversationByID(conversationID)
	if err != nil {
		return fmt.Errorf("failed to get conversation: %w", err)
	}

	members, membersErr := s.GetMembersCached(conversationID)
	if membersErr != nil {
		s.logger.Warnw("Failed to get members, resolving display without them",
			"conversation_id", conversationID, "error", membersErr)
	}
	d := s.resolveConversationDisplay(conv, userID, members)

	unreadAfter := 0
	if userID != senderID {
		unreadAfter = 1
	}

	if err := s.repo.UnhideConversation(userID, conversationID, messageID, &messageID, messageBody, &senderID,
		d.ConversationType, d.DisplayName, d.DisplayAvatar, d.OtherUserID, d.OtherUserName, d.OtherUserAvatar, unreadAfter); err != nil {
		return fmt.Errorf("failed to auto-unhide conversation: %w", err)
	}

	utils.SafeGo(s.logger, func() {
		if err := s.cache.RemoveHiddenConversation(userID, conversationID); err != nil {
			s.logger.Warnw("Failed to update hidden cache", "user_id", userID, "conversation_id", conversationID, "error", err)
		}
		s.InvalidateUserConversationsCache([]uuid.UUID{userID})
	})

	return nil
}
