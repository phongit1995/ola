package engine

import (
	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"
)

type Deliver func(envelope protocol.OutEnvelope)

func spectateError(deliver Deliver, code, message string) bool {
	deliver(protocol.OutEnvelope{Type: protocol.S2CError, Data: protocol.ErrorData{Code: code, Message: message}})
	return false
}

func (e *Engine) SpectateList(gameID, userID string) {
	snapshots, err := e.activeStore.List(gameID)
	if err != nil {
		e.logger.Errorw("Failed to list matches for spectating", "game_id", gameID, "error", err)
		e.sendError(gameID, userID, protocol.ErrorCodeSpectateFailed, "failed to load matches")
		return
	}
	entries := make([]protocol.SpectateListEntry, 0, len(snapshots))
	for _, snapshot := range snapshots {
		if snapshot.Status != matchStatusPlaying || snapshot.GameID != gameID {
			continue
		}
		count, countErr := e.activeStore.SpectatorCount(gameID, snapshot.ID)
		if countErr != nil {
			e.logger.Warnw("Failed to count spectators", "match_id", snapshot.ID, "error", countErr)
		}
		entry := protocol.SpectateListEntry{
			MatchID:    snapshot.ID,
			Players:    snapshot.Players,
			Bet:        snapshot.Bet,
			StartedAt:  snapshot.StartedAt,
			Spectators: count,
		}
		if snapshot.Room != nil {
			entry.RoomID = snapshot.Room.ID
		}
		entries = append(entries, entry)
	}
	e.toUser(gameID, userID, protocol.OutEnvelope{
		Type: protocol.S2CSpectateList,
		Data: protocol.SpectateListData{Matches: entries},
	})
}

// SpectateJoin must be called after the caller's socket has joined the match
// room; the snapshot is delivered while the match lock is held so no STATE can
// slip in between the snapshot and the live stream. spectatorID identifies one
// socket (not a user) so every tab holds its own seat.
func (e *Engine) SpectateJoin(gameID, userID, matchID, spectatorID string, deliver Deliver) bool {
	gameLogic, err := logic.Get(gameID)
	if err != nil {
		return spectateError(deliver, protocol.ErrorCodeUnknownGame, err.Error())
	}
	if !spectatable(gameLogic) {
		return spectateError(deliver, protocol.ErrorCodeSpectateNotSupported, "this game cannot be spectated")
	}
	if matchID == "" || spectatorID == "" {
		return spectateError(deliver, protocol.ErrorCodeMatchNotFound, "match not found")
	}
	if e.hasActiveMatch(gameID, userID) {
		return spectateError(deliver, protocol.ErrorCodeSpectateOwnMatch, "you are playing a match")
	}

	count, status, err := e.activeStore.AddSpectator(gameID, matchID, spectatorID, MaxSpectators)
	if err != nil {
		e.logger.Errorw("Failed to add spectator", "match_id", matchID, "user_id", userID, "error", err)
		return spectateError(deliver, protocol.ErrorCodeSpectateFailed, "failed to join as spectator")
	}
	switch status {
	case SpectatorMatchNotFound:
		return spectateError(deliver, protocol.ErrorCodeMatchNotFound, "match not found")
	case SpectatorFull:
		return spectateError(deliver, protocol.ErrorCodeSpectateFull, "spectator slots are full")
	}

	release := func() {
		if removeErr := e.activeStore.RemoveSpectator(gameID, matchID, spectatorID); removeErr != nil {
			e.logger.Warnw("Failed to roll back spectator", "match_id", matchID, "error", removeErr)
		}
	}
	joined, ok := e.deliverSpectateSnapshot(gameID, userID, matchID, count, deliver)
	if !ok {
		release()
		return false
	}
	if !joined {
		release()
		return spectateError(deliver, protocol.ErrorCodeSpectateOwnMatch, "you are playing this match")
	}
	return true
}

func (e *Engine) SpectateLeave(gameID, matchID, spectatorID string, deliver Deliver) {
	if matchID == "" || spectatorID == "" {
		return
	}
	if err := e.activeStore.RemoveSpectator(gameID, matchID, spectatorID); err != nil {
		e.logger.Warnw("Failed to remove spectator", "match_id", matchID, "error", err)
	}
	if deliver != nil {
		deliver(protocol.OutEnvelope{
			Type: protocol.S2CSpectateLeft,
			Data: protocol.SpectateLeftData{MatchID: matchID, Reason: protocol.SpectateLeftReasonLeft},
		})
	}
}

func isPlayer(players []protocol.PlayerInfo, userID string) bool {
	for _, p := range players {
		if p.ID == userID {
			return true
		}
	}
	return false
}

// Returns (joined, found). joined=false with found=true means the user is a player.
func (e *Engine) deliverSpectateSnapshot(gameID, userID, matchID string, count int, deliver Deliver) (bool, bool) {
	if m := e.matchByID(matchID); m != nil && m.GameID == gameID {
		m.mu.Lock()
		defer m.mu.Unlock()
		if m.over {
			deliver(protocol.OutEnvelope{Type: protocol.S2CError, Data: protocol.ErrorData{Code: protocol.ErrorCodeMatchNotFound, Message: "match not found"}})
			return false, false
		}
		if isPlayer(m.players, userID) {
			return false, true
		}
		roomOwnerID := ""
		if m.room != nil {
			roomOwnerID = m.room.OwnerID
		}
		deliver(protocol.OutEnvelope{Type: protocol.S2CSpectateJoined, Data: protocol.SpectateJoinedData{
			MatchID:     m.ID,
			GameID:      m.GameID,
			Players:     append([]protocol.PlayerInfo(nil), m.players...),
			State:       m.state,
			Turn:        m.turnIdx,
			Deadline:    m.deadline.UnixMilli(),
			Bet:         m.bet,
			RoomOwnerID: roomOwnerID,
			Spectators:  count,
		}})
		return true, true
	}

	snapshot, found, err := e.activeStore.Get(gameID, matchID)
	if err != nil {
		e.logger.Errorw("Failed to load match snapshot for spectating", "match_id", matchID, "error", err)
		deliver(protocol.OutEnvelope{Type: protocol.S2CError, Data: protocol.ErrorData{Code: protocol.ErrorCodeSpectateFailed, Message: "failed to join as spectator"}})
		return false, false
	}
	if !found || snapshot.Status != matchStatusPlaying || snapshot.GameID != gameID {
		deliver(protocol.OutEnvelope{Type: protocol.S2CError, Data: protocol.ErrorData{Code: protocol.ErrorCodeMatchNotFound, Message: "match not found"}})
		return false, false
	}
	if isPlayer(snapshot.Players, userID) {
		return false, true
	}
	roomOwnerID := ""
	if snapshot.Room != nil {
		roomOwnerID = snapshot.Room.OwnerID
	}
	deliver(protocol.OutEnvelope{Type: protocol.S2CSpectateJoined, Data: protocol.SpectateJoinedData{
		MatchID:     snapshot.ID,
		GameID:      snapshot.GameID,
		Players:     snapshot.Players,
		State:       snapshot.State,
		Turn:        snapshot.TurnIndex,
		Deadline:    snapshot.TurnDeadline,
		Bet:         snapshot.Bet,
		RoomOwnerID: roomOwnerID,
		Spectators:  count,
	}})
	return true, true
}

func (e *Engine) notifySpectatorsMatchOver(m *Match, data protocol.MatchOverData) {
	if !spectatable(m.logic) {
		return
	}
	data.Payout = 0
	data.KenDelta = 0
	e.toMatch(m.GameID, m.ID, protocol.OutEnvelope{Type: protocol.S2CMatchOver, Data: data})
	e.toMatch(m.GameID, m.ID, protocol.OutEnvelope{
		Type: protocol.S2CSpectateLeft,
		Data: protocol.SpectateLeftData{MatchID: m.ID, Reason: protocol.SpectateLeftReasonMatchOver},
	})
	if err := e.activeStore.ClearSpectators(m.GameID, m.ID); err != nil {
		e.logger.Warnw("Failed to clear spectators", "match_id", m.ID, "error", err)
	}
}
