package conversation

import (
	"errors"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/relationships"
	usersetting "ola-chat-server/internal/modules/user-setting"

	"github.com/google/uuid"
)

var (
	ErrNotAllowedToMessage        = errors.New("recipient only accepts messages from friends")
	ErrBlocked                    = errors.New("cannot send messages while either user has blocked the other")
	ErrDirectRecipientUnavailable = errors.New("direct conversation recipient unavailable")
)

const (
	ErrorCodeMessageBlocked             = "MESSAGE_BLOCKED"
	ErrorCodeMessageFriendsOnly         = "MESSAGE_FRIENDS_ONLY"
	ErrorCodeDirectRecipientUnavailable = "DIRECT_RECIPIENT_UNAVAILABLE"
)

type BlockChecker interface {
	IsBlockedEither(userID1, userID2 uuid.UUID) (bool, error)
}

func BlockIfUsersBlocked(checker BlockChecker, userID1, userID2 uuid.UUID) error {
	blocked, err := checker.IsBlockedEither(userID1, userID2)
	if err != nil {
		return err
	}
	if blocked {
		return ErrBlocked
	}
	return nil
}

func EnsureDirectInteractionAllowed(checker BlockChecker, conv *Conversation, members []ConversationMember, userID uuid.UUID) error {
	if conv.Type != constants.ConversationTypeDirect {
		return nil
	}
	for _, member := range members {
		if member.IsActive && member.UserID != userID {
			return BlockIfUsersBlocked(checker, userID, member.UserID)
		}
	}
	return ErrDirectRecipientUnavailable
}

func BlockIfPrivateFromStranger(userSettingSvc *usersetting.Service, relRepo *relationships.Repository, senderID, recipientID uuid.UUID) error {
	settings, err := userSettingSvc.GetSettings(recipientID)
	if err != nil {
		return err
	}
	if settings.MessagePrivacy != models.SettingMessagePrivacyFriends {
		return nil
	}
	friends, err := relRepo.AreFriends(senderID, recipientID)
	if err != nil {
		return err
	}
	if !friends {
		return ErrNotAllowedToMessage
	}
	return nil
}
