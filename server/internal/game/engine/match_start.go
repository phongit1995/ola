package engine

import (
	"context"
	"fmt"
	"math/rand"
	"time"

	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"

	"github.com/google/uuid"
)

func (e *Engine) startMatch(gameID string, gameLogic logic.GameLogic, p0, p1 protocol.PlayerInfo, bet int) error {
	return e.startMatchWithRoom(gameID, gameLogic, []protocol.PlayerInfo{p0, p1}, bet, nil, false, nil)
}

func (e *Engine) startReservedQueueMatch(
	gameID string,
	gameLogic logic.GameLogic,
	p0, p1 protocol.PlayerInfo,
	queueKeys ...string,
) error {
	return e.startMatchWithRoom(gameID, gameLogic, []protocol.PlayerInfo{p0, p1}, 0, nil, true, queueKeys)
}

func (e *Engine) startReservedQueuePlayers(
	gameID string,
	gameLogic logic.GameLogic,
	players []protocol.PlayerInfo,
	queueKeys []string,
) error {
	return e.startMatchWithRoom(gameID, gameLogic, players, 0, nil, true, queueKeys)
}

func (e *Engine) startRoomMatch(gameID string, gameLogic logic.GameLogic, players []protocol.PlayerInfo, bet int, room Room) error {
	return e.startMatchWithRoom(gameID, gameLogic, players, bet, &room, true, nil)
}

func (e *Engine) startMatchWithRoom(
	gameID string,
	gameLogic logic.GameLogic,
	players []protocol.PlayerInfo,
	bet int,
	room *Room,
	allowRoomReservation bool,
	queueKeys []string,
) error {
	if bet < 0 || bet > MaxBetFor(len(players)) {
		return fmt.Errorf("bet is outside the allowed range")
	}
	if len(players) < logic.MinPlayers(gameLogic) || len(players) > logic.MaxPlayers(gameLogic) {
		return fmt.Errorf("invalid player count for this game")
	}
	settlement := e.currentSettlement()
	if bet > 0 && settlement == nil {
		return fmt.Errorf("betting is temporarily unavailable")
	}
	players = seatPlayers(gameLogic, players, room)

	seed := time.Now().UnixNano()
	initialState := gameLogic.Init(seed)
	if pi, ok := gameLogic.(logic.PlayerInit); ok {
		initialState = pi.InitPlayers(seed, len(players))
	}
	if li, ok := gameLogic.(logic.LeaderInit); ok && room != nil && room.LastWinnerID != "" {
		if leader := seatOf(players, room.LastWinnerID); leader >= 0 {
			initialState = li.InitPlayersLed(seed, len(players), leader)
		}
	}
	m := &Match{
		ID:           uuid.NewString(),
		GameID:       gameID,
		logic:        gameLogic,
		players:      players,
		state:        initialState,
		turnIdx:      0,
		bet:          bet,
		disconnected: make(map[int]bool),
		startedAt:    time.Now(),
		room:         room,
	}
	m.ensureSeats()
	if starter, ok := m.state.(interface{ StartingTurn() int }); ok {
		if idx := starter.StartingTurn(); idx >= 0 && idx < len(players) {
			m.turnIdx = idx
		}
	}
	if room != nil && listsPlayingRooms(gameID) {
		m.listedRoomID = room.ID
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	var installed bool
	queueCancelled := false
	if len(queueKeys) > 0 {
		e.queueMu.Lock()
		for _, key := range queueKeys {
			if e.queueCancelled[key] {
				queueCancelled = true
				break
			}
		}
		if !queueCancelled {
			installed = e.installReservedRoomMatch(m)
		}
		e.queueMu.Unlock()
	} else if allowRoomReservation {
		installed = e.installReservedRoomMatch(m)
	} else {
		installed = e.installMatch(m)
	}
	if queueCancelled {
		return fmt.Errorf("queue entry was cancelled")
	}
	if !installed {
		return fmt.Errorf("one or more players already have an active match")
	}
	var startBalances []SettledBalance
	if settlement != nil {
		mode := "queue"
		if room != nil {
			mode = "room"
		}
		record := MatchRecord{
			GameID:    gameID,
			MatchID:   m.ID,
			Player0ID: m.players[0].ID,
			Player1ID: m.players[1].ID,
			PlayerIDs: matchPlayerIDs(m),
			Bet:       bet,
			Mode:      mode,
			StartedAt: m.startedAt,
		}
		ctx, cancel := context.WithTimeout(context.Background(), settlementOperationTimeout)
		balances, err := settlement.EscrowStart(ctx, record)
		cancel()
		if err != nil {
			m.over = true
			e.removeMatch(m)
			abortCtx, abortCancel := context.WithTimeout(context.Background(), settlementOperationTimeout)
			abortBalances, abortErr := settlement.AbortStart(abortCtx, m.ID)
			abortCancel()
			if abortErr != nil {
				e.logger.Errorw("Failed to abort match after start record error", "match_id", m.ID, "error", abortErr)
				e.preserveAbortRecovery(m)
			} else {
				e.emitSettledBalances(abortBalances, gameID)
			}
			return fmt.Errorf("record match start: %w", err)
		}
		startBalances = balances
		m.escrowVerified = true
	}

	// The first turn begins only after the start record/escrow is durable.
	m.deadline = time.Now().Add(e.turnDuration(m, -1))
	if err := e.persistMatch(m); err != nil {
		m.over = true
		e.removeMatch(m)
		persistErr := fmt.Errorf("persist active match: %w", err)
		abortSucceeded := settlement == nil
		if settlement != nil {
			ctx, cancel := context.WithTimeout(context.Background(), settlementOperationTimeout)
			balances, abortErr := settlement.AbortStart(ctx, m.ID)
			cancel()
			if abortErr != nil {
				e.logger.Errorw("Failed to abort escrow after active match persistence failure", "match_id", m.ID, "error", abortErr)
				persistErr = fmt.Errorf("%w; abort match start: %v", persistErr, abortErr)
				e.preserveAbortRecovery(m)
			} else {
				e.emitSettledBalances(balances, gameID)
				abortSucceeded = true
			}
		}
		if abortSucceeded {
			if delErr := e.activeStore.Delete(gameID, m.ID, matchPlayerIDs(m)...); delErr != nil {
				e.logger.Errorw("Failed to clean up match after persistence failure", "match_id", m.ID, "error", delErr)
			}
		}
		return persistErr
	}
	finishedKeys := make([]string, 0, len(m.players))
	for _, p := range m.players {
		finishedKeys = append(finishedKeys, userKey(gameID, p.ID))
	}
	e.clearFinished(finishedKeys...)
	e.scheduleTurnTimer(m)
	e.sendMatchFound(m, false)
	e.emitSettledBalances(startBalances, gameID)
	e.logger.Infow("Match started", "match_id", m.ID, "game_id", gameID, "players", matchPlayerIDs(m))
	if over, winnerID, reason := e.matchResult(m, gameLogic); over {
		e.finishMatch(m, winnerID, reason)
	}
	return nil
}

func (e *Engine) matchResult(m *Match, gameLogic logic.GameLogic) (bool, string, string) {
	over, winnerIdx := gameLogic.Result(m.state)
	if !over {
		return false, "", ""
	}
	if winnerIdx >= 0 && winnerIdx < len(m.players) {
		return true, m.players[winnerIdx].ID, "win"
	}
	return true, "", "draw"
}

func matchPlayerIDs(m *Match) []string {
	ids := make([]string, 0, len(m.players))
	for _, p := range m.players {
		ids = append(ids, p.ID)
	}
	return ids
}

func (e *Engine) preserveAbortRecovery(m *Match) {
	snapshot, err := e.snapshotForMatch(m)
	if err != nil {
		e.logger.Errorw("Failed to prepare abort recovery snapshot", "match_id", m.ID, "error", err)
		snapshot = ActiveMatchSnapshot{
			ID:      m.ID,
			GameID:  m.GameID,
			Players: append([]protocol.PlayerInfo(nil), m.players...),
			Status:  matchStatusFinished,
		}
	}
	snapshot.Status = matchStatusAborting
	if err := e.activeStore.Save(snapshot); err != nil {
		e.logger.Errorw("Failed to persist abort recovery snapshot", "match_id", m.ID, "error", err)
	}
	e.queueAbortSettlement(snapshot)
}

func (e *Engine) sendMatchFound(m *Match, resumed bool) {
	for _, p := range m.players {
		e.sendMatchFoundTo(m, p.ID, resumed)
	}
}

func (e *Engine) sendMatchFoundTo(m *Match, userID string, resumed bool) {
	roomOwnerID := ""
	if m.room != nil {
		roomOwnerID = m.room.OwnerID
	}
	idx := m.playerIndex(userID)
	e.toUser(m.GameID, userID, protocol.OutEnvelope{
		Type: protocol.S2CMatchFound,
		Data: protocol.MatchFoundData{
			MatchID:     m.ID,
			GameID:      m.GameID,
			Players:     m.players,
			You:         idx,
			State:       e.viewFor(m, idx),
			Turn:        m.turnIdx,
			Deadline:    m.deadline.UnixMilli(),
			Resumed:     resumed,
			Bet:         m.bet,
			RoomOwnerID: roomOwnerID,
		},
	})
	if resumed && spectatable(m.logic) {
		e.toUser(m.GameID, userID, e.spectatorsEnvelope(m.GameID, m.ID))
	}
}

func keepsSeats(gameLogic logic.GameLogic) bool {
	keeper, ok := gameLogic.(logic.SeatKeeper)
	return ok && keeper.KeepsSeatsBetweenRounds()
}

func seatPlayers(gameLogic logic.GameLogic, players []protocol.PlayerInfo, room *Room) []protocol.PlayerInfo {
	players = append([]protocol.PlayerInfo(nil), players...)
	keeper := room != nil && keepsSeats(gameLogic)
	if keeper && len(room.SeatOrder) > 0 {
		players = keepSeatOrder(players, room.SeatOrder)
	} else {
		rand.Shuffle(len(players), func(i, j int) {
			players[i], players[j] = players[j], players[i]
		})
	}
	if !keeper {
		return players
	}
	room.SeatOrder = make([]string, len(players))
	for i, p := range players {
		room.SeatOrder[i] = p.ID
	}
	return players
}

func keepSeatOrder(players []protocol.PlayerInfo, seatOrder []string) []protocol.PlayerInfo {
	byID := make(map[string]protocol.PlayerInfo, len(players))
	for _, p := range players {
		byID[p.ID] = p
	}
	ordered := make([]protocol.PlayerInfo, 0, len(players))
	placed := make(map[string]bool, len(players))
	for _, id := range seatOrder {
		if p, ok := byID[id]; ok && !placed[id] {
			ordered = append(ordered, p)
			placed[id] = true
		}
	}
	for _, p := range players {
		if !placed[p.ID] {
			ordered = append(ordered, p)
			placed[p.ID] = true
		}
	}
	return ordered
}
