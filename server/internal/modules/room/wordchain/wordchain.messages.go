package wordchain

import (
	"fmt"
	"ola-chat-server/internal/models"
	"time"

	"github.com/google/uuid"
)

func newMessage(sessionID string, now time.Time) Message {
	return Message{
		ID:        uuid.NewString(),
		SessionID: sessionID,
		CreatedAt: now.UTC().Format(time.RFC3339Nano),
	}
}

func botMessage(sessionID, messageType, content, word string, now time.Time) Message {
	msg := newMessage(sessionID, now)
	msg.Type = messageType
	msg.SenderType = SenderTypeBot
	msg.Content = content
	msg.Word = word
	return msg
}

func moveMessage(sessionID, senderID string, sender *models.User, content string, res MoveResult, now time.Time) Message {
	msg := newMessage(sessionID, now)
	msg.Type = MessageTypeMove
	msg.SenderType = SenderTypeUser
	msg.SenderID = senderID
	msg.Content = content
	msg.Word = res.Normalized
	msg.Code = res.Code
	msg.Reaction = reactionFor(res.Code)
	msg.RequiredSyllable = res.RequiredSyllable
	return msg.withSender(sender)
}

func winMessage(sessionID string, move Message, now time.Time) Message {
	content := fmt.Sprintf("🏆 **THẮNG!** Từ \"%s\" không còn từ nào để nối tiếp!", lastWord(move.Word))
	return botMessage(sessionID, MessageTypeWin, content, move.Word, now)
}

func gameStartedMessage(sessionID, word string, now time.Time) Message {
	content := fmt.Sprintf("**Game mới bắt đầu!**\nTừ hiện tại: **%s**", word)
	return botMessage(sessionID, MessageTypeGameStarted, content, word, now)
}

func sessionStartedMessage(state GameState) Message {
	content := fmt.Sprintf("**Phiên mới bắt đầu!**\nTừ bắt đầu: **%s**", state.Word)
	return botMessage(state.SessionID, MessageTypeSessionStarted, content, state.Word, state.SessionStartedAt)
}

func (m Message) withSender(u *models.User) Message {
	if u == nil {
		return m
	}
	m.SenderName = u.Username
	m.SenderAvatar = u.Avatar
	m.SenderGender = u.Gender
	m.SenderVip = u.VipUsed
	if u.VipEndTime != nil {
		vipEnd := u.VipEndTime.Format(time.RFC3339)
		m.SenderVipEnd = &vipEnd
	}
	return m
}

func (m Message) stored() storedMessage {
	return storedMessage{
		ID:               m.ID,
		Seq:              m.Seq,
		SessionID:        m.SessionID,
		Type:             m.Type,
		SenderType:       m.SenderType,
		SenderID:         m.SenderID,
		Content:          m.Content,
		Word:             m.Word,
		Code:             m.Code,
		Reaction:         m.Reaction,
		RequiredSyllable: m.RequiredSyllable,
		CreatedAt:        m.CreatedAt,
	}
}

func (m storedMessage) toMessage(sender *models.User) Message {
	return Message{
		ID:               m.ID,
		Seq:              m.Seq,
		SessionID:        m.SessionID,
		Type:             m.Type,
		SenderType:       m.SenderType,
		SenderID:         m.SenderID,
		Content:          m.Content,
		Word:             m.Word,
		Code:             m.Code,
		Reaction:         m.Reaction,
		RequiredSyllable: m.RequiredSyllable,
		CreatedAt:        m.CreatedAt,
	}.withSender(sender)
}
