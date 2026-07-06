package conversation

import (
	"errors"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/relationships"
	usersetting "ola-chat-server/internal/modules/user-setting"

	"github.com/google/uuid"
)

var ErrNotAllowedToMessage = errors.New("recipient only accepts messages from friends")

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
