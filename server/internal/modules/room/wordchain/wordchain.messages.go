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

func wrongAnswerMessage(sessionID string, state GameState, res MoveResult, now time.Time) Message {
	var reason string
	switch res.Code {
	case CodeInvalidFormat:
		reason = fmt.Sprintf("Từ bắt buộc phải gồm 2 âm tiết và bắt đầu bằng **\"%s\"**!", res.RequiredSyllable)
	case CodeMismatch:
		reason = fmt.Sprintf("Từ đầu của bạn phải là **\"%s\"**!", res.RequiredSyllable)
	case CodeRepeated:
		reason = "**Từ này đã được trả lời trước đó!**"
	default:
		reason = "**Từ không có trong bộ từ điển!**"
	}
	guesses := fmt.Sprintf("Bạn còn **%d** lần đoán.", res.RemainingGuesses)
	if res.RemainingGuesses == 0 {
		guesses = "Bạn đã hết lượt đoán cho từ này, chờ người khác nối đúng nhé."
	}
	content := fmt.Sprintf("%s %s\nTừ hiện tại: **%s**", reason, guesses, state.Word)
	msg := botMessage(sessionID, MessageTypeWrongAnswer, content, state.Word, now)
	msg.Code = res.Code
	msg.RequiredSyllable = res.RequiredSyllable
	remaining := res.RemainingGuesses
	msg.RemainingGuesses = &remaining
	return msg
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
		RemainingGuesses: m.RemainingGuesses,
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
		RemainingGuesses: m.RemainingGuesses,
		CreatedAt:        m.CreatedAt,
	}.withSender(sender)
}
