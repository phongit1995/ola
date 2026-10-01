package wordchain

import (
	"context"
	"fmt"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"time"

	"github.com/google/uuid"
)

func newMessage(id, sessionID uuid.UUID, now time.Time) Message {
	return Message{storedMessage: storedMessage{
		ID:        id.String(),
		SessionID: sessionID.String(),
		CreatedAt: now.UTC().Format(time.RFC3339Nano),
	}}
}

func botMessage(sessionID uuid.UUID, messageType, content, word string, now time.Time) Message {
	msg := newMessage(uuid.New(), sessionID, now)
	msg.Type = messageType
	msg.SenderType = constants.WordChainSenderTypeBot
	msg.Content = content
	msg.Word = word
	return msg
}

func moveMessage(id, sessionID uuid.UUID, senderID string, sender *models.User, content string, res MoveResult, now time.Time) Message {
	msg := newMessage(id, sessionID, now)
	msg.Type = constants.WordChainMessageTypeMove
	msg.SenderType = constants.WordChainSenderTypeUser
	msg.SenderID = senderID
	msg.Content = content
	msg.Word = res.Normalized
	msg.Code = res.Code
	msg.Reaction = reactionFor(res.Code)
	msg.RequiredSyllable = res.RequiredSyllable
	return msg.withSender(sender)
}

func winMessage(sessionID uuid.UUID, move Message, now time.Time) Message {
	content := fmt.Sprintf("🏆 **THẮNG!** Từ \"%s\" không còn từ nào để nối tiếp!", lastWord(move.Word))
	return botMessage(sessionID, constants.WordChainMessageTypeWin, content, move.Word, now)
}

func wrongAnswerMessage(sessionID uuid.UUID, state GameState, res MoveResult, now time.Time) Message {
	var reason string
	switch res.Code {
	case constants.WordChainCodeInvalidFormat:
		reason = fmt.Sprintf("Từ bắt buộc phải gồm 2 âm tiết và bắt đầu bằng **\"%s\"**!", res.RequiredSyllable)
	case constants.WordChainCodeMismatch:
		reason = fmt.Sprintf("Từ đầu của bạn phải là **\"%s\"**!", res.RequiredSyllable)
	case constants.WordChainCodeRepeated:
		reason = "**Từ này đã được trả lời trước đó!**"
	default:
		reason = "**Từ không có trong bộ từ điển!**"
	}
	guesses := fmt.Sprintf("Bạn còn **%d** lần đoán.", res.RemainingGuesses)
	if res.RemainingGuesses == 0 {
		guesses = "Bạn đã hết lượt đoán cho từ này, chờ người khác nối đúng nhé."
	}
	content := fmt.Sprintf("%s %s\nTừ hiện tại: **%s**", reason, guesses, state.Word)
	msg := botMessage(sessionID, constants.WordChainMessageTypeWrongAnswer, content, state.Word, now)
	msg.Code = res.Code
	msg.RequiredSyllable = res.RequiredSyllable
	remaining := res.RemainingGuesses
	msg.RemainingGuesses = &remaining
	return msg
}

func gameStartedMessage(sessionID uuid.UUID, word string, now time.Time) Message {
	content := fmt.Sprintf("**Game mới bắt đầu!**\nTừ hiện tại: **%s**", word)
	return botMessage(sessionID, constants.WordChainMessageTypeGameStarted, content, word, now)
}

func sessionStartedMessage(state GameState) Message {
	content := fmt.Sprintf("**Phiên mới bắt đầu!**\nTừ bắt đầu: **%s**", state.Word)
	return botMessage(state.SessionID, constants.WordChainMessageTypeSessionStarted, content, state.Word, state.SessionStartedAt)
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

func (m storedMessage) toMessage(sender *models.User) Message {
	return Message{storedMessage: m}.withSender(sender)
}

func (s *Service) messagePage(ctx context.Context, limit int, beforeID string) (*MessageListResponse, error) {
	stored, err := s.store.ListMessages(ctx, limit, beforeID)
	if err != nil {
		return nil, err
	}
	idSet := make(map[uuid.UUID]struct{})
	for _, m := range stored {
		if id, err := uuid.Parse(m.SenderID); err == nil {
			idSet[id] = struct{}{}
		}
	}
	ids := make([]uuid.UUID, 0, len(idSet))
	for id := range idSet {
		ids = append(ids, id)
	}
	users := s.userCache.GetUsersBatch(ids, true)

	items := make([]Message, 0, len(stored))
	for _, m := range stored {
		var sender *models.User
		if id, err := uuid.Parse(m.SenderID); err == nil {
			sender = users[id]
		}
		items = append(items, m.toMessage(sender))
	}
	resp := &MessageListResponse{Items: items, HasMore: len(stored) == limit}
	if len(items) > 0 {
		resp.NextBefore = items[len(items)-1].ID
	}
	return resp, nil
}
