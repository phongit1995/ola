package message

import (
	"errors"
	"fmt"

	"github.com/gocql/gocql"
	"github.com/google/uuid"
)

var (
	ErrNotConversationMember = errors.New("not a conversation member")
	ErrMessageNotFound       = errors.New("message not found")
)

func (s *Service) FindMessageForMember(userID uuid.UUID, conversationIDStr, messageIDStr string) (*Message, error) {
	conversationID, err := uuid.Parse(conversationIDStr)
	if err != nil {
		return nil, fmt.Errorf("invalid conversation ID: %w", err)
	}
	messageID, err := gocql.ParseUUID(messageIDStr)
	if err != nil {
		return nil, fmt.Errorf("invalid message ID: %w", err)
	}

	members, err := s.getMembersCached(conversationID)
	if err != nil {
		return nil, err
	}
	if !isMember(members, userID) {
		return nil, ErrNotConversationMember
	}

	msg, err := s.repo.GetMessageByID(conversationID, messageID)
	if err != nil {
		if errors.Is(err, gocql.ErrNotFound) {
			return nil, ErrMessageNotFound
		}
		return nil, err
	}
	return msg, nil
}
