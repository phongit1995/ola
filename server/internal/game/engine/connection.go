package engine

import (
	"time"

	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"
	"ola-chat-server/internal/utils"
)

func (e *Engine) OnConnect(gameID, userID string) {
	key := userKey(gameID, userID)
	afterMatchID := ""
	if e.reconnectActiveMatch(gameID, userID) {
		return
	}

	if data, ok := e.takeFinished(key); ok {
		e.toUser(gameID, userID, protocol.OutEnvelope{Type: protocol.S2CMatchOver, Data: data})
		afterMatchID = data.MatchID
	}

	e.roomMu.Lock()
	defer e.roomMu.Unlock()
	// A room may have started while this connection waited for roomMu.
	if e.reconnectActiveMatch(gameID, userID) {
		return
	}
	if data, ok := e.takeFinished(key); ok {
		e.toUser(gameID, userID, protocol.OutEnvelope{Type: protocol.S2CMatchOver, Data: data})
		afterMatchID = data.MatchID
	}
	if ref, ok := e.store.RoomByUser(gameID, userID); ok {
		if room, exists := e.store.Get(gameID, ref.RoomID); exists && room.hasMember(userID) {
			e.emitRoomWaiting(gameID, userID, room)
			e.emitRoomStateToAfterMatch(room, userID, afterMatchID)
			e.emitRoomSync(gameID, userID, room.ID)
		} else {
			_ = e.store.DeleteUserRef(gameID, userID, ref.RoomID)
			e.emitRoomSync(gameID, userID, "")
		}
	} else {
		e.emitRoomSync(gameID, userID, "")
	}
}

func (e *Engine) reconnectActiveMatch(gameID, userID string) bool {
	if m := e.matchForUser(gameID, userID); m != nil {
		m.mu.Lock()
		if !m.over {
			m.ensureSeats()
			idx := m.playerIndex(userID)
			e.markSeatReconnected(m, idx)
			e.sendMatchFoundTo(m, userID, true)
			for oppIdx := range m.players {
				if oppIdx != idx && m.disconnected[oppIdx] {
					e.toUser(m.GameID, userID, protocol.OutEnvelope{
						Type: protocol.S2COpponentDisconnected,
						Data: e.opponentDisconnectedData(m, oppIdx),
					})
				}
			}
			m.mu.Unlock()
			return true
		}
		m.mu.Unlock()
	}
	return false
}

func (e *Engine) markSeatReconnected(m *Match, idx int) {
	if idx < 0 || !m.disconnected[idx] {
		return
	}
	delete(m.disconnected, idx)
	delete(m.disconnectedAt, idx)
	if len(m.disconnected) == 0 {
		e.cancelGrace(m)
	}
	if m.pausedRemain > 0 && !m.disconnected[m.turnIdx] {
		e.armTimerDuration(m, m.pausedRemain)
		m.pausedRemain = 0
	}
	reconnected := protocol.OpponentReconnectedData{
		UserID:   m.players[idx].ID,
		Turn:     m.turnIdx,
		Deadline: m.deadline.UnixMilli(),
	}
	for otherIdx, other := range m.players {
		if otherIdx == idx || m.disconnected[otherIdx] || m.quit[otherIdx] {
			continue
		}
		e.toUser(m.GameID, other.ID, protocol.OutEnvelope{
			Type: protocol.S2COpponentReconnected,
			Data: reconnected,
		})
	}
	e.toMatch(m.GameID, m.ID, protocol.OutEnvelope{
		Type: protocol.S2COpponentReconnected,
		Data: reconnected,
	})
	if err := e.persistMatch(m); err != nil {
		e.logger.Errorw("Failed to persist reconnected match", "match_id", m.ID, "error", err)
	}
}

func (e *Engine) OnDisconnect(gameID, userID string) {
	if e.disconnectActiveMatch(gameID, userID) {
		return
	}
	e.leaveQueue(gameID, userID)

	// A queue match may have been installed while the user was being removed
	// from the queue. Check the in-memory registry again before touching rooms.
	if e.disconnectActiveMatch(gameID, userID) {
		return
	}

	e.roomMu.Lock()
	defer e.roomMu.Unlock()
	if e.disconnectActiveMatch(gameID, userID) {
		return
	}
	if ref, ok := e.store.RoomByUser(gameID, userID); ok {
		e.leaveRoomLocked(gameID, userID, ref.RoomID, true)
	}
}

func (e *Engine) disconnectActiveMatch(gameID, userID string) bool {
	m := e.matchForUser(gameID, userID)
	if m == nil {
		return false
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	if m.over {
		return false
	}
	m.ensureSeats()
	idx := m.playerIndex(userID)
	if idx < 0 || m.quit[idx] {
		return true
	}
	if m.disconnected[idx] {
		return true
	}
	m.disconnected[idx] = true
	m.disconnectedAt[idx] = time.Now()

	if m.turnIdx == idx && m.pausedRemain == 0 {
		e.invalidateTurnTimer(m)
		remain := time.Until(m.deadline)
		if remain < time.Second {
			remain = time.Second
		}
		m.pausedRemain = remain
	}

	if m.graceTimer == nil {
		e.armGraceTimer(m, time.Duration(e.graceSeconds)*time.Second)
	}

	for oppIdx, opp := range m.players {
		if oppIdx == idx || m.disconnected[oppIdx] || m.quit[oppIdx] {
			continue
		}
		e.toUser(m.GameID, opp.ID, protocol.OutEnvelope{
			Type: protocol.S2COpponentDisconnected,
			Data: e.opponentDisconnectedData(m, idx),
		})
	}
	e.toMatch(m.GameID, m.ID, protocol.OutEnvelope{
		Type: protocol.S2COpponentDisconnected,
		Data: e.opponentDisconnectedData(m, idx),
	})
	if err := e.persistMatch(m); err != nil {
		e.logger.Errorw("Failed to persist disconnected match", "match_id", m.ID, "error", err)
	}
	return true
}

func (e *Engine) armGraceTimer(m *Match, wait time.Duration) {
	if wait < time.Second {
		wait = time.Second
	}
	m.graceGen++
	gen := m.graceGen
	m.graceDeadline = time.Now().Add(wait)
	matchID := m.ID
	m.graceTimer = time.AfterFunc(time.Until(m.graceDeadline), func() {
		utils.SafeCall(e.logger, func() { e.onGraceExpire(matchID, gen) })
	})
}

func (e *Engine) opponentDisconnectedData(m *Match, idx int) protocol.OpponentDisconnectedData {
	turnRemainingMs := int64(0)
	if m.pausedRemain > 0 && m.turnIdx == idx {
		turnRemainingMs = m.pausedRemain.Milliseconds()
	}
	deadline := m.graceDeadline
	if at, ok := m.disconnectedAt[idx]; ok && !at.IsZero() {
		deadline = at.Add(time.Duration(e.graceSeconds) * time.Second)
	}
	return protocol.OpponentDisconnectedData{
		GraceDeadline:   deadline.UnixMilli(),
		TurnRemainingMs: turnRemainingMs,
		UserID:          m.players[idx].ID,
	}
}

func (e *Engine) cancelGrace(m *Match) {
	if m.graceTimer != nil {
		m.graceTimer.Stop()
		m.graceTimer = nil
	}
	m.graceGen++
	m.graceDeadline = time.Time{}
}

func (e *Engine) onGraceExpire(matchID string, gen int) {
	m := e.matchByID(matchID)
	if m == nil {
		return
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	if m.over || m.graceGen != gen {
		return
	}
	m.ensureSeats()
	m.graceTimer = nil

	connected := 0
	for _, i := range m.activeIdxs() {
		if !m.disconnected[i] {
			connected++
		}
	}
	if connected == 0 {
		e.finishMatch(m, e.winnerWhenEveryoneLeft(m), "disconnect")
		return
	}

	const expiryEpsilon = 100 * time.Millisecond
	grace := time.Duration(e.graceSeconds) * time.Second
	now := time.Now()
	firedAt := m.graceDeadline
	if firedAt.IsZero() || now.After(firedAt) {
		firedAt = now
	}
	expired := make([]int, 0, len(m.disconnected))
	var nextWait time.Duration
	for _, i := range m.activeIdxs() {
		if !m.disconnected[i] {
			continue
		}
		personal := m.disconnectedAt[i]
		if personal.IsZero() {
			expired = append(expired, i)
			continue
		}
		if !personal.Add(grace).After(firedAt.Add(expiryEpsilon)) {
			expired = append(expired, i)
			continue
		}
		wait := personal.Add(grace).Sub(now)
		if wait < time.Second {
			wait = time.Second
		}
		if nextWait == 0 || wait < nextWait {
			nextWait = wait
		}
	}

	handler, hasQuitHandler := m.logic.(logic.QuitHandler)
	for _, i := range expired {
		if m.over {
			return
		}
		if hasQuitHandler && len(m.activeIdxs())-1 >= 2 {
			e.eliminatePlayer(m, i, handler, "disconnect")
			continue
		}
		winnerID := e.winnerAfterSeatLeaves(m, i, func(j int) bool { return !m.disconnected[j] })
		e.finishMatch(m, winnerID, "disconnect")
		return
	}
	if m.over {
		return
	}

	stillDisconnected := false
	for _, i := range m.activeIdxs() {
		if m.disconnected[i] {
			stillDisconnected = true
			break
		}
	}
	if stillDisconnected {
		e.armGraceTimer(m, nextWait)
		return
	}
	e.cancelGrace(m)
	if m.pausedRemain > 0 && !m.disconnected[m.turnIdx] {
		e.armTimerDuration(m, m.pausedRemain)
		m.pausedRemain = 0
		if err := e.persistMatch(m); err != nil {
			e.logger.Errorw("Failed to persist match after grace eliminations", "match_id", m.ID, "error", err)
		}
	}
}
