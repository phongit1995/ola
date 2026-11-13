package engine

import (
	"time"

	"ola-chat-server/internal/game/protocol"
)

func (e *Engine) winnerAmounts(gameID string, bet, playerCount int) (payout, net int) {
	if bet <= 0 {
		return 0, 0
	}
	playerCount = max(playerCount, 2)
	if settlement := e.currentSettlement(); settlement != nil {
		return settlement.WinnerAmounts(gameID, bet, playerCount)
	}
	return bet * playerCount, bet * (playerCount - 1)
}

func (e *Engine) finishMatch(m *Match, winnerID string, reason string) {
	gone := func(userID string) bool {
		idx := m.playerIndex(userID)
		if idx < 0 {
			return false
		}
		return m.disconnected[idx] || m.quit[idx]
	}
	if m.room != nil && (len(m.disconnected) > 0 || len(m.quit) > 0) {
		if gone(m.room.OwnerID) {
			if m.closedRoom == nil {
				m.closedRoom = cloneRoom(m.room)
			}
			m.room = nil
		} else {
			room := *m.room
			room.normalize()
			for _, g := range append([]RoomGuest(nil), room.Guests...) {
				if gone(g.ID) {
					removeRoomGuest(&room, g.ID)
				}
			}
			m.room = &room
		}
	} else if len(m.disconnected) > 0 && m.room == nil {
		m.room = nil
	}
	m.over = true
	m.winnerID = winnerID
	m.resultReason = reason
	m.finishedAt = time.Now()
	// Block maintenance from reinstalling an older playing snapshot while this
	// terminal state is being persisted and removed from the live registry.
	e.markMatchTerminal(m.ID)
	if m.timer != nil {
		m.timer.Stop()
	}
	if m.graceTimer != nil {
		m.graceTimer.Stop()
	}
	if err := e.persistMatch(m); err != nil {
		e.logger.Errorw("Failed to persist final match snapshot", "match_id", m.ID, "error", err)
	}
	rankings := e.matchRankings(m)
	rankedIDs := make([]string, 0, len(rankings))
	for _, entry := range rankings {
		rankedIDs = append(rankedIDs, entry.UserID)
	}
	outcome := MatchOutcome{
		GameID:     m.GameID,
		MatchID:    m.ID,
		Player0ID:  m.players[0].ID,
		Player1ID:  m.players[1].ID,
		PlayerIDs:  matchPlayerIDs(m),
		Rankings:   rankedIDs,
		WinnerID:   winnerID,
		Reason:     reason,
		Bet:        m.bet,
		MoveCount:  matchMoveCount(m),
		FinishedAt: m.finishedAt,
	}
	outcome.EndReason, outcome.ExitReasons = describeResult(m.logic, m.state, len(m.players))
	snapshot, snapshotErr := e.snapshotForMatch(m)
	if snapshotErr != nil {
		e.logger.Errorw("Failed to prepare final match snapshot for settlement retry", "match_id", m.ID, "error", snapshotErr)
		snapshot = ActiveMatchSnapshot{
			ID:      m.ID,
			GameID:  m.GameID,
			Players: append([]protocol.PlayerInfo(nil), m.players...),
		}
	}
	var waitingRoom *Room
	if m.room != nil {
		room := prepareNextRound(*m.room, winnerID)
		if err := e.store.Save(room); err != nil {
			e.logger.Errorw("Failed to restore waiting room after match", "match_id", m.ID, "room_id", room.ID, "error", err)
		} else {
			waitingRoom = &room
		}
	}
	payout, kenDelta := 0, 0
	if winnerID != "" {
		payout, kenDelta = e.winnerAmounts(m.GameID, m.bet, len(m.players))
	}
	// Exp only reaches the database through settlement, so a match that will
	// never be settled must not announce gains the players would lose on
	// reconnect.
	willSettle := e.currentSettlement() != nil || m.bet > 0
	var expGains []protocol.ExpGainEntry
	if willSettle {
		expGains = matchExpGains(matchPlayerIDs(m), winnerID, reason, outcome.MoveCount)
	}
	data := protocol.MatchOverData{
		MatchID:  m.ID,
		WinnerID: winnerID,
		Reason:   reason,
		State:    m.state,
		Bet:      m.bet,
		Payout:   payout,
		KenDelta: kenDelta,
		Rankings: rankings,
		ExpGains: expGains,
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
	if willSettle {
		snapshot.roomSaved = waitingRoom != nil
		e.queueFinishedSettlement(snapshot, outcome)
	} else if _, err := e.activeStore.DeleteIfStatus(
		m.GameID,
		m.ID,
		matchStatusFinished,
		matchPlayerIDs(m)...,
	); err != nil {
		e.logger.Errorw("Failed to delete finished active match", "match_id", m.ID, "error", err)
	}
	if waitingRoom != nil {
		e.emitRoomUpsert(*waitingRoom)
		for _, memberID := range waitingRoom.memberIDs() {
			e.emitRoomWaiting(waitingRoom.GameID, memberID, *waitingRoom)
		}
		e.emitRoomStateAfterMatch(*waitingRoom, m.ID)
	} else if m.listedRoomID != "" {
		e.emitRoomRemoved(m.GameID, m.listedRoomID)
	}
	if m.closedRoom != nil {
		reason := "owner_left"
		if ownerIdx := m.playerIndex(m.closedRoom.OwnerID); ownerIdx >= 0 && m.disconnected[ownerIdx] {
			reason = "owner_disconnected"
		}
		e.emitRoomClosedExcept(*m.closedRoom, m.closedRoom.OwnerID, reason)
	}
	for _, key := range keys {
		e.scheduleFinishedCleanup(key, m.ID)
	}
	e.logger.Infow("Match finished", "match_id", m.ID, "winner", winnerID, "reason", reason)
}

func (e *Engine) scheduleFinishedCleanup(key, matchID string) {
	time.AfterFunc(finishedResultTTL, func() {
		e.finishedMu.Lock()
		if current, ok := e.finished[key]; ok && current.MatchID == matchID {
			delete(e.finished, key)
		}
		e.finishedMu.Unlock()
	})
}
