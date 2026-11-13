package engine

import (
	"encoding/json"
	"time"

	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"
)

func (e *Engine) nextTurnIdx(m *Match) int {
	n := len(m.players)
	next := -1
	if order, ok := m.logic.(logic.TurnOrder); ok {
		next = order.NextTurn(m.state, m.turnIdx)
	}
	if next < 0 || next >= n {
		next = (m.turnIdx + 1) % n
	}
	return next
}

func (e *Engine) viewFor(m *Match, playerIdx int) any {
	if viewer, ok := m.logic.(logic.StateViewer); ok {
		if playerIdx >= 0 && playerIdx < len(m.players) {
			return viewer.ViewFor(m.state, playerIdx)
		}
	}
	return m.state
}

func (e *Engine) broadcastState(m *Match, lastMove json.RawMessage, lastBy int) {
	e.broadcastStateAutoMoved(m, lastMove, lastBy, false)
}

func (e *Engine) broadcastStateAutoMoved(m *Match, lastMove json.RawMessage, lastBy int, autoMoved bool) {
	deadline := m.deadline.UnixMilli()
	for idx, p := range m.players {
		e.toUser(m.GameID, p.ID, protocol.OutEnvelope{Type: protocol.S2CState, Data: protocol.StateData{
			MatchID:   m.ID,
			State:     e.viewFor(m, idx),
			Turn:      m.turnIdx,
			Deadline:  deadline,
			LastMove:  lastMove,
			LastBy:    lastBy,
			AutoMoved: autoMoved,
		}})
	}
	if spectatable(m.logic) {
		e.toMatch(m.GameID, m.ID, protocol.OutEnvelope{Type: protocol.S2CState, Data: protocol.StateData{
			MatchID:   m.ID,
			State:     spectatorView(m.logic, m.state),
			Turn:      m.turnIdx,
			Deadline:  deadline,
			LastMove:  lastMove,
			LastBy:    lastBy,
			AutoMoved: autoMoved,
		}})
	}
}

func spectatable(gameLogic logic.GameLogic) bool {
	if _, hidden := gameLogic.(logic.StateViewer); !hidden {
		return true
	}
	_, public := gameLogic.(logic.SpectatorViewer)
	return public
}

func spectatorView(gameLogic logic.GameLogic, state any) any {
	if viewer, ok := gameLogic.(logic.SpectatorViewer); ok {
		return viewer.SpectatorView(state)
	}
	return state
}

func (e *Engine) matchRankings(m *Match) []protocol.RankingEntry {
	ranker, ok := m.logic.(logic.Ranker)
	if !ok {
		return nil
	}
	order := ranker.Rankings(m.state)
	entries := make([]protocol.RankingEntry, 0, len(order))
	for place, idx := range order {
		if idx < 0 || idx >= len(m.players) {
			return nil
		}
		entries = append(entries, protocol.RankingEntry{UserID: m.players[idx].ID, Place: place + 1})
	}
	return entries
}

func anySeatCanWin(int) bool { return true }

func (e *Engine) winnerWhenEveryoneLeft(m *Match) string {
	if handler, ok := m.logic.(logic.EveryoneLeftHandler); ok {
		handler.OnEveryoneLeft(m.state)
	} else if handler, ok := m.logic.(logic.QuitHandler); ok {
		for _, idx := range m.activeIdxs() {
			handler.OnPlayerQuit(m.state, idx)
		}
	} else {
		return ""
	}
	if over, winnerIdx := m.logic.Result(m.state); over && winnerIdx >= 0 && winnerIdx < len(m.players) {
		return m.players[winnerIdx].ID
	}
	return ""
}

// winnerAfterSeatLeaves picks the winner when a leaving seat ends the match.
// Games with a QuitHandler record the quit first and decide through their own
// Result, so a player who already finished first keeps the win after leaving
// and the payout always matches the final ranking.
func (e *Engine) winnerAfterSeatLeaves(m *Match, leavingIdx int, canWin func(int) bool) string {
	if handler, ok := m.logic.(logic.QuitHandler); ok {
		handler.OnPlayerQuit(m.state, leavingIdx)
		if over, winnerIdx := m.logic.Result(m.state); over && winnerIdx >= 0 && winnerIdx < len(m.players) && winnerIdx != leavingIdx {
			if m.quit[winnerIdx] || canWin(winnerIdx) {
				return m.players[winnerIdx].ID
			}
			return ""
		}
	}
	for _, j := range m.activeIdxs() {
		if j != leavingIdx && canWin(j) {
			return m.players[j].ID
		}
	}
	return ""
}

// eliminatePlayer marks one seat as quit and lets the match continue. It must
// be called with m.mu held and only when the game implements QuitHandler and
// at least two active players remain afterwards.
func (e *Engine) eliminatePlayer(m *Match, idx int, handler logic.QuitHandler, cause string) {
	m.quit[idx] = true
	e.releaseSeat(m, idx)
	delete(m.disconnected, idx)
	delete(m.disconnectedAt, idx)
	handler.OnPlayerQuit(m.state, idx)

	if over, winnerID, reason := e.matchResult(m, m.logic); over {
		e.finishMatch(m, winnerID, reason)
		return
	}
	if active := m.activeIdxs(); len(active) < 2 {
		winnerID := ""
		if len(active) == 1 {
			winnerID = m.players[active[0]].ID
		}
		e.finishMatch(m, winnerID, cause)
		return
	}

	if m.turnIdx == idx {
		m.pausedRemain = 0
		m.turnIdx = e.nextTurnIdx(m)
		m.deadline = time.Now().Add(time.Duration(e.logicTurnSeconds(m.logic)) * time.Second)
		if m.disconnected[m.turnIdx] {
			e.invalidateTurnTimer(m)
			m.pausedRemain = time.Until(m.deadline)
			if m.pausedRemain < time.Second {
				m.pausedRemain = time.Second
			}
		} else {
			e.scheduleTurnTimer(m)
		}
	} else if m.pausedRemain > 0 && !m.disconnected[m.turnIdx] {
		e.armTimerDuration(m, m.pausedRemain)
		m.pausedRemain = 0
	}
	if err := e.persistMatch(m); err != nil {
		e.logger.Errorw("Failed to persist match after player quit", "match_id", m.ID, "player_idx", idx, "error", err)
	}
	e.broadcastState(m, nil, idx)
	e.logger.Infow("Player eliminated from match", "match_id", m.ID, "player_idx", idx, "cause", cause)
}

func (e *Engine) Move(gameID, userID, matchID string, move json.RawMessage) {
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
	if matchID != "" && matchID != m.ID {
		return
	}

	m.ensureSeats()
	playerIdx := m.playerIndex(userID)
	if playerIdx != m.turnIdx {
		e.sendError(gameID, userID, protocol.ErrorCodeNotYourTurn, "not your turn")
		return
	}
	e.markSeatReconnected(m, playerIdx)
	if time.Now().After(m.deadline) {
		return
	}

	if err := m.logic.ValidateMove(m.state, playerIdx, move); err != nil {
		e.sendError(gameID, userID, protocol.ErrorCodeInvalidMove, err.Error())
		return
	}

	state, err := m.logic.Apply(m.state, playerIdx, move)
	if err != nil {
		e.sendError(gameID, userID, protocol.ErrorCodeInvalidMove, err.Error())
		return
	}
	previousState := m.state
	previousTurn := m.turnIdx
	previousDeadline := m.deadline
	previousPausedRemain := m.pausedRemain
	previousTimeoutRuns := append([]int(nil), m.timeoutRuns...)
	m.state = state

	if over, winnerID, reason := e.matchResult(m, m.logic); over {
		e.finishMatch(m, winnerID, reason)
		return
	}

	if keeper, ok := m.logic.(logic.TurnKeeper); !ok || !keeper.KeepTurn(m.state) {
		m.turnIdx = e.nextTurnIdx(m)
	}
	m.timeoutRuns[playerIdx] = 0
	m.deadline = time.Now().Add(e.turnDuration(m, playerIdx))
	if m.disconnected[m.turnIdx] {
		e.invalidateTurnTimer(m)
		m.pausedRemain = time.Until(m.deadline)
		if m.pausedRemain < time.Second {
			m.pausedRemain = time.Second
		}
	}
	if err := e.persistMatch(m); err != nil {
		m.state = previousState
		m.turnIdx = previousTurn
		m.deadline = previousDeadline
		m.pausedRemain = previousPausedRemain
		m.timeoutRuns = previousTimeoutRuns
		if m.pausedRemain == 0 {
			e.scheduleTurnTimer(m)
		}
		e.logger.Errorw("Failed to persist match move", "match_id", m.ID, "user_id", userID, "error", err)
		e.sendError(gameID, userID, protocol.ErrorCodeStateSaveFailed, "failed to save the move, please retry")
		return
	}
	e.clearTimeoutMove(m)
	if m.pausedRemain == 0 {
		e.scheduleTurnTimer(m)
	}

	e.broadcastState(m, move, playerIdx)
}

func (e *Engine) Forfeit(gameID, userID, matchID string) {
	e.forfeit(gameID, userID, matchID, false)
}

func (e *Engine) ForfeitAndLeave(gameID, userID, matchID string) {
	e.forfeit(gameID, userID, matchID, true)
}

func (e *Engine) forfeit(gameID, userID, matchID string, leaveAfter bool) {
	m := e.matchForUser(gameID, userID)
	if m == nil {
		return
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	if m.over {
		return
	}
	if matchID != "" && matchID != m.ID {
		return
	}
	m.ensureSeats()
	idx := m.playerIndex(userID)
	if idx < 0 || m.quit[idx] {
		return
	}
	if leaveAfter {
		if m.room != nil && m.room.guestIndex(userID) >= 0 {
			room := *m.room
			removeRoomGuest(&room, userID)
			m.room = &room
		} else if m.room != nil && m.room.OwnerID == userID {
			m.closedRoom = cloneRoom(m.room)
			m.room = nil
		} else if m.closedRoom != nil && m.closedRoom.guestIndex(userID) >= 0 {
			room := *m.closedRoom
			removeRoomGuest(&room, userID)
			m.closedRoom = &room
		}
	}
	if handler, ok := m.logic.(logic.QuitHandler); ok && len(m.activeIdxs())-1 >= 2 {
		e.eliminatePlayer(m, idx, handler, "forfeit")
		return
	}
	e.finishMatch(m, e.winnerAfterSeatLeaves(m, idx, anySeatCanWin), "forfeit")
}
