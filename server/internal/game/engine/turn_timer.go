package engine

import (
	"time"

	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"
	"ola-chat-server/internal/utils"
)

func (e *Engine) armTimerDuration(m *Match, d time.Duration) {
	m.deadline = time.Now().Add(d)
	e.scheduleTurnTimer(m)
}

func (e *Engine) logicTurnSeconds(gameLogic logic.GameLogic) int {
	if timer, ok := gameLogic.(logic.TurnTimer); ok {
		if s := timer.TurnSeconds(); s > 0 {
			return s
		}
	}
	return e.turnSeconds
}

func (e *Engine) turnDuration(m *Match, previousPlayerIdx int) time.Duration {
	duration := time.Duration(e.logicTurnSeconds(m.logic)) * time.Second
	delayer, ok := m.logic.(logic.TurnStartDelayer)
	if !ok {
		return duration
	}
	delay := delayer.TurnStartDelay(m.state, previousPlayerIdx, m.turnIdx)
	if delay < 0 {
		delay = 0
	}
	if delay > maxTurnStartDelay {
		delay = maxTurnStartDelay
	}
	return duration + delay
}

func (e *Engine) scheduleTurnTimer(m *Match) {
	e.scheduleTurnTimerIn(m, time.Until(m.deadline))
}

// scheduleTurnTimerIn arms the turn timer for an explicit duration without
// moving m.deadline, so a retry can be scheduled while the turn stays expired
// and Move keeps rejecting late moves.
func (e *Engine) scheduleTurnTimerIn(m *Match, d time.Duration) {
	if m.timer != nil {
		m.timer.Stop()
	}
	m.turnGen++
	matchID := m.ID
	turnAtArm := m.turnIdx
	genAtArm := m.turnGen
	m.timer = time.AfterFunc(d, func() {
		utils.SafeCall(e.logger, func() { e.onTimeout(matchID, turnAtArm, genAtArm) })
	})
}

func (e *Engine) invalidateTurnTimer(m *Match) {
	if m.timer != nil {
		m.timer.Stop()
		m.timer = nil
	}
	m.turnGen++
}

func (e *Engine) onTimeout(matchID string, expectedTurn, expectedGen int) {
	m := e.matchByID(matchID)
	if m == nil {
		return
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	if m.over || m.turnIdx != expectedTurn || m.turnGen != expectedGen ||
		m.pausedRemain > 0 || m.disconnected[m.turnIdx] {
		return
	}
	m.ensureSeats()
	timeoutWinner := func() string {
		return e.winnerAfterSeatLeaves(m, m.turnIdx, anySeatCanWin)
	}
	if mover, ok := m.logic.(logic.TimeoutMover); ok {
		timedOut := m.turnIdx
		m.timeoutRuns[timedOut]++
		if m.timeoutRuns[timedOut] < MaxConsecutiveTimeouts {
			switch e.applyTimeoutMove(m, mover, timedOut) {
			case timeoutMovePlayed:
				return
			case timeoutMoveDeferred:
				// A store outage must never cost a player the match, so the
				// timeout is retried instead of counted against them.
				m.timeoutRuns[timedOut]--
				m.timeoutMoveFails++
				if m.timeoutMoveFails > maxTimeoutMoveRetries {
					e.abortMatchTechnically(m)
					return
				}
				e.scheduleTurnTimerIn(m, timeoutMoveRetryBackoff(m.timeoutMoveFails))
				return
			}
		}
		e.clearTimeoutMove(m)
		if handler, ok := m.logic.(logic.QuitHandler); ok && len(m.activeIdxs())-1 >= 2 {
			e.eliminatePlayer(m, timedOut, handler, "timeout")
			return
		}
		e.finishMatch(m, timeoutWinner(), "timeout")
		return
	}
	if skipper, ok := m.logic.(logic.TimeoutSkipper); !ok || !skipper.TimeoutSkipsTurn() {
		e.finishMatch(m, timeoutWinner(), "timeout")
		return
	}
	m.timeoutRuns[m.turnIdx]++
	if m.timeoutRuns[m.turnIdx] >= MaxConsecutiveTimeouts {
		if handler, ok := m.logic.(logic.QuitHandler); ok && len(m.activeIdxs())-1 >= 2 {
			e.eliminatePlayer(m, m.turnIdx, handler, "timeout")
			return
		}
		e.finishMatch(m, timeoutWinner(), "timeout")
		return
	}
	timedOut := m.turnIdx
	if handler, ok := m.logic.(logic.TurnSkipHandler); ok {
		handler.OnTurnSkipped(m.state, timedOut)
	}
	if over, winnerID, reason := e.matchResult(m, m.logic); over {
		e.finishMatch(m, winnerID, reason)
		return
	}
	m.turnIdx = e.nextTurnIdx(m)
	m.deadline = time.Now().Add(time.Duration(e.logicTurnSeconds(m.logic)) * time.Second)
	if m.disconnected[m.turnIdx] {
		e.invalidateTurnTimer(m)
		m.pausedRemain = time.Until(m.deadline)
		if m.pausedRemain < time.Second {
			m.pausedRemain = time.Second
		}
	}
	if err := e.persistMatch(m); err != nil {
		e.logger.Errorw("Failed to persist skipped turn after timeout", "match_id", m.ID, "error", err)
	}
	if m.pausedRemain == 0 {
		e.scheduleTurnTimer(m)
	}
	e.broadcastState(m, nil, timedOut)
}

type timeoutMoveOutcome int

const (
	// timeoutMoveNoMove means the game has no move to play, so the normal
	// timeout forfeit applies.
	timeoutMoveNoMove timeoutMoveOutcome = iota
	timeoutMovePlayed
	// timeoutMoveDeferred means the move is legal but could not be saved. The
	// match state is unchanged and the timeout must be retried, never forfeited.
	timeoutMoveDeferred
)

func timeoutMoveRetryBackoff(attempt int) time.Duration {
	delay := timeoutMoveRetryDelay << (attempt - 1)
	if delay > maxTimeoutMoveRetryDelay || delay <= 0 {
		return maxTimeoutMoveRetryDelay
	}
	return delay
}

func (e *Engine) clearTimeoutMove(m *Match) {
	m.timeoutMove = nil
	m.timeoutMoveFails = 0
}

// applyTimeoutMove plays the game's fallback move for a player who ran out of
// time. The caller must hold m.mu.
func (e *Engine) applyTimeoutMove(m *Match, mover logic.TimeoutMover, playerIdx int) timeoutMoveOutcome {
	// The state is unchanged while retries are pending, so the move computed on
	// the first attempt stays valid and is never searched for again.
	move := m.timeoutMove
	if move == nil {
		chosen, ok := mover.MoveOnTimeout(m.state, playerIdx)
		if !ok {
			return timeoutMoveNoMove
		}
		move = chosen
		m.timeoutMove = chosen
	}
	state, err := m.logic.Apply(m.state, playerIdx, move)
	if err != nil {
		e.logger.Errorw("Failed to apply timeout move",
			"match_id", m.ID, "player_idx", playerIdx, "error", err)
		return timeoutMoveNoMove
	}
	previousState := m.state
	previousTurn := m.turnIdx
	previousDeadline := m.deadline
	previousPausedRemain := m.pausedRemain
	m.state = state

	if over, winnerID, reason := e.matchResult(m, m.logic); over {
		e.clearTimeoutMove(m)
		e.finishMatch(m, winnerID, reason)
		return timeoutMovePlayed
	}

	if keeper, ok := m.logic.(logic.TurnKeeper); !ok || !keeper.KeepTurn(m.state) {
		m.turnIdx = e.nextTurnIdx(m)
	}
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
		e.logger.Errorw("Failed to persist timeout move; will retry",
			"match_id", m.ID, "player_idx", playerIdx, "error", err)
		return timeoutMoveDeferred
	}
	e.clearTimeoutMove(m)
	if m.pausedRemain == 0 {
		e.scheduleTurnTimer(m)
	}
	e.broadcastStateAutoMoved(m, move, playerIdx, true)
	return timeoutMovePlayed
}

// abortMatchTechnically ends a match the engine can no longer advance because
// its state will not save. Nobody wins or loses: the escrow is refunded through
// the abort settlement path instead of being paid out.
func (e *Engine) abortMatchTechnically(m *Match) {
	m.over = true
	e.clearTimeoutMove(m)
	e.markMatchTerminal(m.ID)
	e.invalidateTurnTimer(m)
	e.cancelGrace(m)
	data := protocol.MatchOverData{
		MatchID: m.ID,
		Reason:  matchReasonAborted,
		State:   m.state,
		Bet:     m.bet,
	}
	keys := make([]string, 0, len(m.players))
	for _, p := range m.players {
		keys = append(keys, userKey(m.GameID, p.ID))
	}
	e.finishedMu.Lock()
	for _, key := range keys {
		e.finished[key] = data
	}
	e.finishedMu.Unlock()
	e.removeMatch(m)
	for _, p := range m.players {
		e.toUser(m.GameID, p.ID, protocol.OutEnvelope{Type: protocol.S2CMatchOver, Data: data})
	}
	e.notifySpectatorsMatchOver(m, data)
	if m.room != nil {
		e.emitRoomClosed(*m.room, "match_aborted")
	} else if m.listedRoomID != "" {
		e.emitRoomRemoved(m.GameID, m.listedRoomID)
	}
	e.preserveAbortRecovery(m)
	for _, key := range keys {
		e.scheduleFinishedCleanup(key, m.ID)
	}
	e.logger.Errorw("Match aborted after repeated snapshot failures",
		"match_id", m.ID, "game_id", m.GameID, "attempts", maxTimeoutMoveRetries)
}
