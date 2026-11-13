package engine

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"slices"
	"sort"
	"time"

	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"
	"ola-chat-server/internal/utils"
)

func (e *Engine) persistMatch(m *Match) error {
	snapshot, err := e.snapshotForMatch(m)
	if err != nil {
		return err
	}
	return e.activeStore.Save(snapshot)
}

func (e *Engine) snapshotForMatch(m *Match) (ActiveMatchSnapshot, error) {
	state, err := json.Marshal(m.state)
	if err != nil {
		return ActiveMatchSnapshot{}, fmt.Errorf("marshal match state: %w", err)
	}
	status := matchStatusPlaying
	if m.over {
		status = matchStatusFinished
	}
	snapshot := ActiveMatchSnapshot{
		ID:                 m.ID,
		GameID:             m.GameID,
		Players:            m.players,
		State:              state,
		StateVersion:       m.logic.StateVersion(),
		TurnIndex:          m.turnIdx,
		TimeoutRuns:        m.timeoutRuns,
		TurnDeadline:       m.deadline.UnixMilli(),
		Bet:                m.bet,
		StartedAt:          m.startedAt.UnixMilli(),
		Status:             status,
		WinnerID:           m.winnerID,
		ResultReason:       m.resultReason,
		Disconnected:       m.disconnected,
		PausedRemainMillis: m.pausedRemain.Milliseconds(),
		Room:               m.room,
		ClosedRoom:         m.closedRoom,
	}
	for idx := range m.quit {
		if m.quit[idx] {
			snapshot.Quit = append(snapshot.Quit, idx)
		}
	}
	sort.Ints(snapshot.Quit)
	if !m.graceDeadline.IsZero() {
		snapshot.GraceDeadline = m.graceDeadline.UnixMilli()
	}
	if !m.finishedAt.IsZero() {
		snapshot.FinishedAt = m.finishedAt.UnixMilli()
	}
	return snapshot, nil
}

func (e *Engine) restoreActiveMatches() {
	restored := 0
	for _, gameID := range logic.IDs() {
		snapshots, err := e.activeStore.List(gameID)
		if err != nil {
			e.logger.Errorw("Failed to load active matches", "game_id", gameID, "error", err)
			continue
		}
		for _, snapshot := range snapshots {
			if snapshot.Status == matchStatusFinished {
				e.restoreFinishedSnapshot(snapshot)
				continue
			}
			if snapshot.Status == matchStatusAborting {
				e.queueAbortSettlement(snapshot)
				continue
			}
			didRestore, retry := e.restorePlayingSnapshot(snapshot, gameID)
			if retry {
				e.queuePlayingRestore(snapshot)
			}
			if didRestore {
				restored++
			}
		}
	}
	if restored > 0 {
		e.logger.Infow("Restored active matches from Redis", "count", restored)
	}
}

const maxEnginePlayers = 8

func validPlayingSnapshotShape(snapshot ActiveMatchSnapshot, expectedGameID string) bool {
	return snapshot.ID != "" && snapshot.GameID == expectedGameID &&
		len(snapshot.Players) >= 2 && len(snapshot.Players) <= maxEnginePlayers &&
		snapshot.TurnIndex >= 0 && snapshot.TurnIndex < len(snapshot.Players)
}

func (e *Engine) restorePlayingSnapshot(snapshot ActiveMatchSnapshot, expectedGameID string) (bool, bool) {
	if snapshot.Status != matchStatusPlaying {
		e.logger.Warnw("Skipped active match with unknown status", "match_id", snapshot.ID, "status", snapshot.Status)
		return false, false
	}
	if !validPlayingSnapshotShape(snapshot, expectedGameID) {
		e.logger.Warnw("Skipped invalid active match snapshot", "game_id", expectedGameID, "match_id", snapshot.ID)
		return false, false
	}
	if e.matchByID(snapshot.ID) != nil {
		return false, false
	}
	current, exists, err := e.activeStore.Get(expectedGameID, snapshot.ID)
	if err != nil {
		e.logger.Errorw("Failed to revalidate active match before restore", "game_id", expectedGameID, "match_id", snapshot.ID, "error", err)
		return false, true
	}
	if !exists {
		return false, false
	}
	if current.Status == matchStatusFinished {
		e.handleFinishedRestore(current)
		return false, false
	}
	if current.Status != matchStatusPlaying {
		e.logger.Warnw("Skipped active match with unknown current status", "match_id", current.ID, "status", current.Status)
		return false, false
	}
	if current.ID != snapshot.ID || !validPlayingSnapshotShape(current, expectedGameID) {
		e.logger.Warnw("Skipped invalid current active match snapshot", "game_id", expectedGameID, "match_id", current.ID)
		return false, false
	}
	snapshot = current
	settlement := e.currentSettlement()
	if snapshot.Bet > 0 && settlement == nil {
		// A paid match must never become playable before its escrow can be
		// verified. SetSettlement triggers reconciliation once it is available.
		return false, false
	}
	gameLogic, err := logic.Get(snapshot.GameID)
	if err != nil {
		e.logger.Errorw("Skipped active match with unknown game", "match_id", snapshot.ID, "error", err)
		e.abortUnrecoverableRestore(snapshot, settlement)
		return false, false
	}
	if len(snapshot.Players) > logic.MaxPlayers(gameLogic) {
		e.logger.Errorw("Skipped active match with unsupported player count", "match_id", snapshot.ID, "players", len(snapshot.Players))
		e.abortUnrecoverableRestore(snapshot, settlement)
		return false, false
	}
	if snapshot.StateVersion != gameLogic.StateVersion() {
		e.logger.Errorw("Skipped active match with unsupported state version",
			"match_id", snapshot.ID,
			"saved_version", snapshot.StateVersion,
			"current_version", gameLogic.StateVersion(),
		)
		e.abortUnrecoverableRestore(snapshot, settlement)
		return false, false
	}
	state, err := gameLogic.DecodeState(snapshot.State)
	if err != nil {
		e.logger.Errorw("Failed to decode active match state", "match_id", snapshot.ID, "error", err)
		e.abortUnrecoverableRestore(snapshot, settlement)
		return false, false
	}
	startedAt := time.UnixMilli(snapshot.StartedAt)
	if snapshot.StartedAt <= 0 {
		startedAt = time.Now()
	}
	deadline := time.UnixMilli(snapshot.TurnDeadline)
	if snapshot.TurnDeadline <= 0 {
		deadline = time.Now().Add(time.Duration(e.logicTurnSeconds(gameLogic)) * time.Second)
	}
	pausedRemain := time.Duration(snapshot.PausedRemainMillis) * time.Millisecond
	if pausedRemain <= 0 {
		pausedRemain = time.Until(deadline)
		if pausedRemain < time.Second {
			pausedRemain = time.Second
		}
	}
	m := &Match{
		ID:           snapshot.ID,
		GameID:       snapshot.GameID,
		logic:        gameLogic,
		players:      snapshot.Players,
		state:        state,
		turnIdx:      snapshot.TurnIndex,
		timeoutRuns:  append([]int(nil), snapshot.TimeoutRuns...),
		deadline:     deadline,
		bet:          snapshot.Bet,
		disconnected: make(map[int]bool, len(snapshot.Players)),
		pausedRemain: pausedRemain,
		startedAt:    startedAt,
		graceGen:     1,
		room:         cloneRoom(snapshot.Room),
		closedRoom:   cloneRoom(snapshot.ClosedRoom),
	}
	m.ensureSeats()
	for _, idx := range snapshot.Quit {
		if idx >= 0 && idx < len(m.players) {
			m.quit[idx] = true
		}
	}
	now := time.Now()
	for idx := range m.players {
		if !m.quit[idx] {
			m.disconnected[idx] = true
			m.disconnectedAt[idx] = now
		}
	}
	if snapshot.Room != nil && listsPlayingRooms(snapshot.GameID) {
		m.listedRoomID = snapshot.Room.ID
	}
	m.graceDeadline = time.Now().Add(time.Duration(e.graceSeconds) * time.Second)

	// Install a locked provisional match before touching escrow. That makes
	// room, queue, and concurrent restore transitions observe one owner for
	// these users while the database call is in flight.
	e.roomMu.Lock()
	roomConflict := e.snapshotHasRoomMemberLocked(snapshot)
	m.mu.Lock()
	installResult := matchPlayerConflict
	if !roomConflict {
		installResult = e.installRestoredMatch(m)
	}
	e.roomMu.Unlock()
	switch installResult {
	case matchAlreadyInstalled, matchTerminal:
		m.mu.Unlock()
		return false, false
	case matchRoomTransition:
		m.mu.Unlock()
		return false, true
	case matchPlayerConflict:
		m.mu.Unlock()
		e.logger.Warnw("Skipped active match because its id or a player is already restored", "match_id", snapshot.ID)
		return false, e.abortConflictingRestore(snapshot, settlement)
	}

	if settlement != nil {
		record, ok := recordFromSnapshot(snapshot)
		if !ok {
			m.over = true
			e.removeMatch(m)
			m.mu.Unlock()
			e.abortUnrecoverableRestore(snapshot, settlement)
			return false, false
		}
		ctx, cancel := context.WithTimeout(context.Background(), settlementOperationTimeout)
		balances, escrowErr := settlement.EscrowStart(ctx, record)
		cancel()
		if escrowErr != nil {
			m.over = true
			e.removeMatch(m)
			m.mu.Unlock()
			e.logger.Errorw("Skipped restored match because its escrow could not be verified", "match_id", snapshot.ID, "error", escrowErr)
			if errors.Is(escrowErr, ErrEscrowClosed) {
				return false, !e.discardRestoredSnapshot(snapshot, nil)
			}
			if errors.Is(escrowErr, ErrSettlementConflict) {
				return false, false
			}
			return false, true
		}
		e.emitSettledBalances(balances, snapshot.GameID)
		m.escrowVerified = true
	}

	e.restoreTimersLocked(m)
	m.mu.Unlock()
	return true, false
}

func (e *Engine) snapshotHasRoomMemberLocked(snapshot ActiveMatchSnapshot) bool {
	for idx, player := range snapshot.Players {
		if slices.Contains(snapshot.Quit, idx) {
			continue
		}
		ref, exists := e.store.RoomByUser(snapshot.GameID, player.ID)
		if !exists {
			continue
		}
		if room, ok := e.store.Get(snapshot.GameID, ref.RoomID); ok && room.hasMember(player.ID) {
			return true
		}
		_ = e.store.DeleteUserRef(snapshot.GameID, player.ID, ref.RoomID)
	}
	return false
}

func (e *Engine) abortConflictingRestore(snapshot ActiveMatchSnapshot, settlement Settlement) bool {
	if settlement == nil {
		// Keep zero-bet recovery state until settlement is available rather
		// than deleting a possible durable match record blindly.
		return false
	}
	ctx, cancel := context.WithTimeout(context.Background(), settlementOperationTimeout)
	balances, abortErr := settlement.AbortStart(ctx, snapshot.ID)
	cancel()
	if abortErr != nil {
		e.logger.Errorw("Failed to abort conflicting restored match", "match_id", snapshot.ID, "error", abortErr)
		return !errors.Is(abortErr, ErrSettlementConflict)
	}
	e.emitSettledBalances(balances, snapshot.GameID)
	if !e.restoreSnapshotRoom(snapshot) {
		return true
	}
	return !e.deleteSnapshot(snapshot)
}

func (e *Engine) abortUnrecoverableRestore(snapshot ActiveMatchSnapshot, settlement Settlement) {
	if settlement == nil {
		return
	}
	if e.abortConflictingRestore(snapshot, settlement) {
		snapshot.Status = matchStatusAborting
		if err := e.activeStore.Save(snapshot); err != nil {
			e.logger.Errorw("Failed to persist unrecoverable match cleanup", "match_id", snapshot.ID, "error", err)
		}
		e.queueAbortSettlement(snapshot)
	}
}

func (e *Engine) handleFinishedRestore(snapshot ActiveMatchSnapshot) {
	e.markMatchTerminal(snapshot.ID)
	snapshot.roomSaved = e.restoreFinishedSnapshot(snapshot)
	if outcome, ok := outcomeFromSnapshot(snapshot); ok && e.currentSettlement() != nil {
		e.queueFinishedSettlement(snapshot, outcome)
	}
}

func (e *Engine) discardRestoredSnapshot(snapshot ActiveMatchSnapshot, match *Match) bool {
	current, exists, err := e.activeStore.Get(snapshot.GameID, snapshot.ID)
	if err != nil {
		e.logger.Errorw("Failed to revalidate discarded match snapshot", "match_id", snapshot.ID, "error", err)
		return false
	}
	if exists && current.Status != snapshot.Status {
		// A newer lifecycle state owns both the snapshot and any room rollback.
		return true
	}
	if match != nil {
		match.mu.Lock()
		if match.over {
			match.mu.Unlock()
			// The live match completed while escrow verification was in flight.
			// Its finished snapshot/room now owns cleanup; never apply the
			// older playing snapshot over that terminal state.
			return true
		}
		match.over = true
		e.invalidateTurnTimer(match)
		if match.graceTimer != nil {
			match.graceTimer.Stop()
			match.graceTimer = nil
		}
		match.mu.Unlock()
		e.removeMatch(match)
	}
	if !e.restoreSnapshotRoom(snapshot) {
		return false
	}
	return e.deleteSnapshot(snapshot)
}

func (e *Engine) restoreSnapshotRoom(snapshot ActiveMatchSnapshot) bool {
	if snapshot.Room == nil || snapshot.roomSaved {
		return true
	}
	room := prepareNextRound(*snapshot.Room, snapshot.WinnerID)
	memberIDs := room.memberIDs()

	e.roomMu.Lock()
	defer e.roomMu.Unlock()
	release, reserved := e.reserveRoomUsers(room.GameID, memberIDs...)
	if !reserved {
		for _, userID := range memberIDs {
			if e.matchForUser(room.GameID, userID) != nil {
				return true
			}
			if ref, exists := e.store.RoomByUser(room.GameID, userID); exists {
				if current, ok := e.store.Get(room.GameID, ref.RoomID); ok && current.hasMember(userID) {
					return true
				}
			}
		}
		// An in-flight room transition owns a reservation but has not committed
		// canonical state yet. Retain the snapshot and retry after it resolves.
		return false
	}
	defer release()

	for _, userID := range memberIDs {
		if e.hasActiveMatch(room.GameID, userID) {
			return true
		}
		if ref, exists := e.store.RoomByUser(room.GameID, userID); exists {
			if current, ok := e.store.Get(room.GameID, ref.RoomID); ok && current.hasMember(userID) {
				return true
			}
			_ = e.store.DeleteUserRef(room.GameID, userID, ref.RoomID)
		}
	}

	e.queueMu.Lock()
	defer e.queueMu.Unlock()
	for _, userID := range memberIDs {
		key := userKey(room.GameID, userID)
		if e.queuePending[key] || queueHasPlayer(e.queues[room.GameID], userID) {
			return true
		}
	}
	if err := e.store.Save(room); err != nil {
		e.logger.Errorw("Failed to restore waiting room from match snapshot", "match_id", snapshot.ID, "room_id", room.ID, "error", err)
		return false
	}
	return true
}

func (e *Engine) restoreTimersLocked(m *Match) {
	if m.pausedRemain <= 0 {
		e.scheduleTurnTimer(m)
	} else if len(m.disconnected) == 0 {
		remain := m.pausedRemain
		m.pausedRemain = 0
		e.armTimerDuration(m, remain)
		if err := e.persistMatch(m); err != nil {
			e.logger.Errorw("Failed to normalize restored match timer", "match_id", m.ID, "error", err)
		}
	}
	if len(m.disconnected) == 0 {
		return
	}
	if m.graceDeadline.IsZero() {
		m.graceDeadline = time.Now().Add(time.Duration(e.graceSeconds) * time.Second)
	}
	gen := m.graceGen
	matchID := m.ID
	m.graceTimer = time.AfterFunc(time.Until(m.graceDeadline), func() {
		utils.SafeCall(e.logger, func() { e.onGraceExpire(matchID, gen) })
	})
}

func (e *Engine) deleteSnapshot(snapshot ActiveMatchSnapshot) bool {
	userIDs := make([]string, 0, len(snapshot.Players))
	for _, player := range snapshot.Players {
		userIDs = append(userIDs, player.ID)
	}
	deleted, err := e.activeStore.DeleteIfStatus(snapshot.GameID, snapshot.ID, snapshot.Status, userIDs...)
	if err != nil {
		e.logger.Errorw("Failed to delete stale match snapshot", "match_id", snapshot.ID, "error", err)
		return false
	} else if !deleted {
		e.logger.Infow("Kept match snapshot because its lifecycle status changed", "match_id", snapshot.ID, "expected_status", snapshot.Status)
	}
	return true
}

func (e *Engine) restoreFinishedSnapshot(snapshot ActiveMatchSnapshot) bool {
	gameLogic, err := logic.Get(snapshot.GameID)
	if err != nil || snapshot.StateVersion != gameLogic.StateVersion() {
		e.logger.Errorw("Could not restore finished match result because its game state is unsupported", "game_id", snapshot.GameID, "match_id", snapshot.ID)
		return false
	}
	var state any = snapshot.State
	moveCount := 0
	if decoded, err := gameLogic.DecodeState(snapshot.State); err == nil {
		state = decoded
		moveCount = stateMoveCount(gameLogic, decoded)
	}
	payout, kenDelta := 0, 0
	if snapshot.WinnerID != "" {
		payout, kenDelta = e.winnerAmounts(snapshot.GameID, snapshot.Bet, len(snapshot.Players))
	}
	var expGains []protocol.ExpGainEntry
	if e.currentSettlement() != nil || snapshot.Bet > 0 {
		expGains = matchExpGains(snapshotPlayerIDs(snapshot), snapshot.WinnerID, snapshot.ResultReason, moveCount)
	}
	data := protocol.MatchOverData{
		MatchID:  snapshot.ID,
		WinnerID: snapshot.WinnerID,
		Reason:   snapshot.ResultReason,
		State:    state,
		Bet:      snapshot.Bet,
		Payout:   payout,
		KenDelta: kenDelta,
		ExpGains: expGains,
	}
	roomRestored := e.restoreSnapshotRoom(snapshot)
	if !roomRestored {
		e.logger.Errorw("Deferred waiting-room restore from finished match", "match_id", snapshot.ID)
	}
	keys := make([]string, 0, len(snapshot.Players))
	e.finishedMu.Lock()
	for _, player := range snapshot.Players {
		key := userKey(snapshot.GameID, player.ID)
		e.finished[key] = data
		keys = append(keys, key)
	}
	e.finishedMu.Unlock()
	for _, key := range keys {
		e.scheduleFinishedCleanup(key, snapshot.ID)
	}
	return roomRestored
}
