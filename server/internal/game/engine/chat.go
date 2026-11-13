package engine

import (
	"strings"
	"time"
	"unicode/utf8"

	"ola-chat-server/internal/game/protocol"
)

func (e *Engine) Chat(gameID, userID, matchID, text string) {
	m := e.matchForUser(gameID, userID)
	if m == nil {
		e.sendError(gameID, userID, protocol.ErrorCodeNoMatch, "no active match")
		return
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	if m.over {
		e.sendError(gameID, userID, protocol.ErrorCodeNoMatch, "no active match")
		return
	}
	if matchID == "" || matchID != m.ID {
		e.sendError(gameID, userID, protocol.ErrorCodeMatchMismatch, "chat does not belong to the active match")
		return
	}
	text, code, message := validateChatText(text)
	if code != "" {
		e.sendError(gameID, userID, code, message)
		return
	}

	m.ensureSeats()
	senderIdx := m.playerIndex(userID)
	now := time.Now()
	if last := m.lastChatAt[senderIdx]; !last.IsZero() && now.Sub(last) < chatCooldown {
		e.sendError(gameID, userID, protocol.ErrorCodeChatRateLimited, "chat messages are being sent too quickly")
		return
	}
	m.lastChatAt[senderIdx] = now
	data := protocol.ChatMessageData{
		MatchID: m.ID,
		UserID:  userID,
		Name:    m.players[senderIdx].Name,
		Text:    text,
		SentAt:  now.UnixMilli(),
	}
	for _, player := range m.players {
		e.toUser(m.GameID, player.ID, protocol.OutEnvelope{
			Type: protocol.S2CChatMessage,
			Data: data,
		})
	}
	e.toMatch(m.GameID, m.ID, protocol.OutEnvelope{Type: protocol.S2CChatMessage, Data: data})
}

func (e *Engine) RoomChat(gameID, userID, roomID, text string) {
	e.roomMu.Lock()
	defer e.roomMu.Unlock()

	if roomID == "" {
		e.sendError(gameID, userID, protocol.ErrorCodeRoomNotFound, "room id is required")
		return
	}
	room, exists := e.store.Get(gameID, roomID)
	if !exists {
		e.sendError(gameID, userID, protocol.ErrorCodeRoomNotFound, "room not found")
		return
	}
	if !room.hasMember(userID) {
		e.sendError(gameID, userID, protocol.ErrorCodeNotRoomMember, "only room members can chat")
		return
	}
	if len(room.guestList()) == 0 {
		e.sendError(gameID, userID, protocol.ErrorCodeRoomNotFull, "another player is required to chat")
		return
	}
	text, code, message := validateChatText(text)
	if code != "" {
		e.sendError(gameID, userID, code, message)
		return
	}

	now := time.Now()
	rateKey := userKey(gameID, userID)
	if last := e.roomChatLast[rateKey]; !last.IsZero() && now.Sub(last) < chatCooldown {
		e.sendError(gameID, userID, protocol.ErrorCodeChatRateLimited, "chat messages are being sent too quickly")
		return
	}
	e.roomChatLast[rateKey] = now

	senderName := room.OwnerName
	if idx := room.guestIndex(userID); idx >= 0 {
		senderName = room.guestList()[idx].Name
	}
	data := protocol.ChatMessageData{
		RoomID: room.ID,
		UserID: userID,
		Name:   senderName,
		Text:   text,
		SentAt: now.UnixMilli(),
	}
	for _, recipientID := range room.memberIDs() {
		e.toUser(room.GameID, recipientID, protocol.OutEnvelope{
			Type: protocol.S2CChatMessage,
			Data: data,
		})
	}
	if spectatorsAllowed(&room) {
		e.toRoomWatchers(room.GameID, room.ID, protocol.OutEnvelope{Type: protocol.S2CChatMessage, Data: data})
	}
}

func (e *Engine) MatchReaction(gameID, userID, matchID, reactionType string) {
	m := e.matchForUser(gameID, userID)
	if m == nil {
		e.sendError(gameID, userID, protocol.ErrorCodeNoMatch, "no active match")
		return
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	if m.over {
		e.sendError(gameID, userID, protocol.ErrorCodeNoMatch, "no active match")
		return
	}
	if matchID == "" || matchID != m.ID {
		e.sendError(gameID, userID, protocol.ErrorCodeMatchMismatch, "reaction does not belong to the active match")
		return
	}
	if !validReactionType(reactionType) {
		e.sendError(gameID, userID, protocol.ErrorCodeInvalidReaction, "invalid reaction")
		return
	}

	m.ensureSeats()
	senderIdx := m.playerIndex(userID)
	now := time.Now()
	if last := m.lastReactionAt[senderIdx]; !last.IsZero() && now.Sub(last) < reactionCooldown {
		e.sendError(gameID, userID, protocol.ErrorCodeReactionRateLimited, "reactions are being sent too quickly")
		return
	}
	m.lastReactionAt[senderIdx] = now
	data := protocol.ReactionData{
		MatchID: m.ID,
		UserID:  userID,
		Type:    reactionType,
		SentAt:  now.UnixMilli(),
	}
	for _, player := range m.players {
		e.toUser(m.GameID, player.ID, protocol.OutEnvelope{Type: protocol.S2CReaction, Data: data})
	}
	e.toMatch(m.GameID, m.ID, protocol.OutEnvelope{Type: protocol.S2CReaction, Data: data})
}

func validReactionType(reactionType string) bool {
	switch reactionType {
	case protocol.ReactionTypeLike,
		protocol.ReactionTypeLove,
		protocol.ReactionTypeHaha,
		protocol.ReactionTypeWow,
		protocol.ReactionTypeSad,
		protocol.ReactionTypeAngry:
		return true
	default:
		return false
	}
}

func validateChatText(text string) (string, string, string) {
	text = strings.TrimSpace(text)
	if text == "" {
		return "", protocol.ErrorCodeInvalidChat, "chat message cannot be empty"
	}
	if utf8.RuneCountInString(text) > maxChatRunes {
		return "", protocol.ErrorCodeChatTooLong, "chat message is too long"
	}
	return text, "", ""
}

// clearRoomChatRate must be called while roomMu is held.
func (e *Engine) clearRoomChatRate(gameID string, userIDs ...string) {
	for _, userID := range userIDs {
		if userID != "" {
			delete(e.roomChatLast, userKey(gameID, userID))
		}
	}
}
