package engine

import (
	"encoding/json"
	"fmt"
	"testing"
	"time"

	wargod "ola-chat-server/internal/game/games/war-god"
	"ola-chat-server/internal/game/protocol"

	"go.uber.org/zap"
)

const (
	warGodGameID    = "war-god"
	warGodTileCount = 8
)

func decodeWarGodState(t *testing.T, state any) *wargod.State {
	t.Helper()
	raw, err := json.Marshal(state)
	if err != nil {
		t.Fatalf("marshal war-god state: %v", err)
	}
	parsed := &wargod.State{}
	if err := json.Unmarshal(raw, parsed); err != nil {
		t.Fatalf("unmarshal war-god state: %v", err)
	}
	return parsed
}

func requireWarGodBoard(t *testing.T, board []int) {
	t.Helper()
	if len(board) != 64 {
		t.Fatalf("board has %d cells, want 64", len(board))
	}
	for i, tile := range board {
		if tile < 0 || tile >= warGodTileCount {
			t.Fatalf("board cell %d has invalid tile %d", i, tile)
		}
	}
}

func requireWarGodFighters(t *testing.T, fighters [2]wargod.Fighter) {
	t.Helper()
	for i, fighter := range fighters {
		if fighter.HP < 0 || fighter.HP > 200 || fighter.MP < 0 || fighter.MP > 100 ||
			fighter.Armor < 0 || fighter.Armor > 30 || fighter.Fury < 0 || fighter.Fury > 100 {
			t.Fatalf("fighter %d out of range: %+v", i, fighter)
		}
	}
}

func warGodSwapRaw(t *testing.T, a, b int) json.RawMessage {
	t.Helper()
	return json.RawMessage(fmt.Sprintf(`{"type":"swap","a":%d,"b":%d}`, a, b))
}

func TestWarGodQueueMatchPlaysValidSwapEndToEnd(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)

	gameEngine.JoinQueue(warGodGameID, protocol.PlayerInfo{ID: "wg-a", Name: "WG A"})
	if _, ok := emitter.last("wg-a", protocol.S2CQueueWaiting); !ok {
		t.Fatal("first queued player did not receive QUEUE_WAITING")
	}
	gameEngine.JoinQueue(warGodGameID, protocol.PlayerInfo{ID: "wg-b", Name: "WG B"})

	match := gameEngine.matchForUser(warGodGameID, "wg-a")
	if match == nil || match != gameEngine.matchForUser(warGodGameID, "wg-b") {
		t.Fatal("queue pairing did not create a shared war-god match")
	}

	var initial *wargod.State
	for _, player := range match.players {
		envelope, ok := emitter.last(player.ID, protocol.S2CMatchFound)
		if !ok {
			t.Fatalf("%s did not receive MATCH_FOUND", player.ID)
		}
		found := envelope.Data.(protocol.MatchFoundData)
		if found.GameID != warGodGameID || found.MatchID != match.ID || found.You != match.playerIndex(player.ID) {
			t.Fatalf("unexpected MATCH_FOUND for %s: %+v", player.ID, found)
		}
		initial = decodeWarGodState(t, found.State)
		requireWarGodBoard(t, initial.Board)
		requireWarGodFighters(t, initial.Fighters)
		if initial.Fighters[0].HP != 200 || initial.Fighters[1].HP != 200 {
			t.Fatalf("initial fighters are not at full HP: %+v", initial.Fighters)
		}
	}

	moverIdx := match.turnIdx
	moverID := match.players[moverIdx].ID
	swaps := wargod.ValidSwaps(initial.Board)
	if len(swaps) == 0 {
		t.Fatal("initial war-god board has no valid swaps")
	}
	swap := swaps[0]

	gameEngine.Move(match.GameID, moverID, match.ID, warGodSwapRaw(t, swap[0], swap[1]))
	if match.over {
		t.Fatal("first swap unexpectedly finished the match")
	}
	for _, player := range match.players {
		envelope, ok := emitter.last(player.ID, protocol.S2CState)
		if !ok {
			t.Fatalf("%s did not receive STATE after the swap", player.ID)
		}
		data := envelope.Data.(protocol.StateData)
		state := decodeWarGodState(t, data.State)
		requireWarGodBoard(t, state.Board)
		requireWarGodFighters(t, state.Fighters)
		if len(state.Steps) == 0 || state.Steps[0].Kind != "swap" {
			t.Fatalf("STATE steps do not start with the swap: %+v", state.Steps)
		}
		if state.Steps[0].A == nil || state.Steps[0].B == nil ||
			*state.Steps[0].A != swap[0] || *state.Steps[0].B != swap[1] {
			t.Fatalf("swap step does not echo the move: %+v", state.Steps[0])
		}
		if data.LastBy != moverIdx {
			t.Fatalf("STATE lastBy = %d, want %d", data.LastBy, moverIdx)
		}
		expectedTurn := 1 - moverIdx
		if state.ExtraTurn {
			expectedTurn = moverIdx
		}
		if data.Turn != expectedTurn || match.turnIdx != expectedTurn {
			t.Fatalf("turn = %d (match %d), want %d with extraTurn=%v", data.Turn, match.turnIdx, expectedTurn, state.ExtraTurn)
		}
		if state.MoveCount != 1 {
			t.Fatalf("moveCount = %d, want 1", state.MoveCount)
		}
	}
	snapshot, ok := activeStore.get(match.GameID, match.ID)
	if !ok || snapshot.TurnIndex != match.turnIdx {
		t.Fatalf("swap result was not persisted: %+v", snapshot)
	}
}

func TestWarGodRestoredMatchKeepsTurnAfterRunFourSwap(t *testing.T) {
	board := make([]int, 64)
	for i := range board {
		board[i] = (i%8 + 2*(i/8)) % 6
	}
	board[0], board[1], board[3] = 4, 4, 4
	state, err := json.Marshal(&wargod.State{
		Board:     board,
		Fighters:  [2]wargod.Fighter{{HP: 100}, {HP: 100}},
		Rng:       "12345",
		MoveCount: 4,
	})
	if err != nil {
		t.Fatal(err)
	}
	activeStore := newMemoryActiveMatchStore()
	snapshot := ActiveMatchSnapshot{
		ID:     "wargod-keepturn",
		GameID: warGodGameID,
		Players: []protocol.PlayerInfo{
			{ID: "wg-keep-a", Name: "Keep A"},
			{ID: "wg-keep-b", Name: "Keep B"},
		},
		State:        state,
		StateVersion: 2,
		TurnIndex:    0,
		TurnDeadline: time.Now().Add(5 * time.Minute).UnixMilli(),
		StartedAt:    time.Now().UnixMilli(),
		Status:       matchStatusPlaying,
	}
	if err := activeStore.Save(snapshot); err != nil {
		t.Fatal(err)
	}

	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := gameEngine.matches[snapshot.ID]
	if match == nil {
		t.Fatal("war-god match was not restored from snapshot")
	}
	for _, player := range match.players {
		gameEngine.OnConnect(match.GameID, player.ID)
	}
	if match.turnIdx != 0 {
		t.Fatalf("restored turn = %d, want 0", match.turnIdx)
	}

	gameEngine.Move(match.GameID, match.players[0].ID, match.ID, warGodSwapRaw(t, 2, 10))
	if match.over {
		t.Fatal("run-four swap unexpectedly finished the match")
	}
	if match.turnIdx != 0 {
		t.Fatalf("turn = %d after run-four swap, want kept turn 0", match.turnIdx)
	}
	envelope, ok := emitter.last(match.players[1].ID, protocol.S2CState)
	if !ok {
		t.Fatal("opponent did not receive STATE after the run-four swap")
	}
	data := envelope.Data.(protocol.StateData)
	if data.Turn != 0 || data.LastBy != 0 {
		t.Fatalf("unexpected kept-turn STATE: turn=%d lastBy=%d", data.Turn, data.LastBy)
	}
	newState := decodeWarGodState(t, data.State)
	if !newState.ExtraTurn {
		t.Fatal("run-four swap did not set extraTurn")
	}
	hasBigMatch := false
	for _, step := range newState.Steps {
		if step.Kind == "match" && step.MaxRun >= 4 {
			hasBigMatch = true
		}
	}
	if !hasBigMatch {
		t.Fatalf("steps have no match with maxRun>=4: %+v", newState.Steps)
	}
	persisted, ok := activeStore.get(match.GameID, match.ID)
	if !ok || persisted.TurnIndex != 0 {
		t.Fatalf("kept turn was not persisted: %+v", persisted)
	}
}

func TestWarGodTimeoutSkipsTurnAndThirdConsecutiveTimeoutLoses(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	rooms := newMemoryRoomStore()
	emitter := &captureEmitter{}
	gameEngine := NewEngine(zap.NewNop().Sugar(), 1, 30, rooms, activeStore)
	gameEngine.SetEmitter(emitter)
	defer stopEngineTimers(gameEngine)
	if err := gameEngine.startMatch(
		warGodGameID,
		wargod.Logic{},
		protocol.PlayerInfo{ID: "wg-slow-a", Name: "Slow A"},
		protocol.PlayerInfo{ID: "wg-slow-b", Name: "Slow B"},
		0,
	); err != nil {
		t.Fatalf("start war-god match: %v", err)
	}
	var match *Match
	gameEngine.mu.RLock()
	for _, current := range gameEngine.matches {
		match = current
	}
	gameEngine.mu.RUnlock()
	if match == nil {
		t.Fatal("war-god match was not created")
	}
	firstIdx := match.turnIdx
	firstID := match.players[firstIdx].ID

	waitForCondition(t, 3*time.Second, "turn expiry did not emit STATE", func() bool {
		return emitter.count(firstID, protocol.S2CState) > 0
	})
	match.mu.Lock()
	turnAfterExpiry := match.turnIdx
	runsAfterExpiry := match.timeoutRuns
	overAfterExpiry := match.over
	match.mu.Unlock()
	if overAfterExpiry || gameEngine.matchByID(match.ID) == nil {
		t.Fatal("first timeout finished the match instead of skipping the turn")
	}
	if turnAfterExpiry != 1-firstIdx || runsAfterExpiry[firstIdx] != 1 {
		t.Fatalf("turn=%d runs=%v after expiry, want flipped turn and one run", turnAfterExpiry, runsAfterExpiry)
	}
	envelope, ok := emitter.last(firstID, protocol.S2CState)
	if !ok {
		t.Fatal("timed-out player did not receive STATE")
	}
	data := envelope.Data.(protocol.StateData)
	if data.LastBy != firstIdx || data.Turn != 1-firstIdx || len(data.LastMove) != 0 {
		t.Fatalf("unexpected timeout STATE: %+v", data)
	}
	if emitter.count(firstID, protocol.S2CMatchOver) != 0 {
		t.Fatal("single timeout emitted MATCH_OVER")
	}

	for i := 0; i < 3; i++ {
		fireTurnTimeout(gameEngine, match)
		if match.over {
			t.Fatalf("match finished after %d alternating timeouts", i+2)
		}
	}
	if match.timeoutRuns != [2]int{2, 2} {
		t.Fatalf("timeout runs = %v, want two per player", match.timeoutRuns)
	}

	loserID := match.players[match.turnIdx].ID
	winnerID := match.players[1-match.turnIdx].ID
	fireTurnTimeout(gameEngine, match)
	if !match.over || gameEngine.matchByID(match.ID) != nil {
		t.Fatal("third consecutive timeout did not finish the match")
	}
	for _, playerID := range []string{loserID, winnerID} {
		overEnvelope, ok := emitter.last(playerID, protocol.S2CMatchOver)
		if !ok {
			t.Fatalf("%s did not receive MATCH_OVER", playerID)
		}
		result := overEnvelope.Data.(protocol.MatchOverData)
		if result.Reason != "timeout" || result.WinnerID != winnerID {
			t.Fatalf("unexpected timeout result for %s: %+v", playerID, result)
		}
	}
	if _, exists := activeStore.get(match.GameID, match.ID); exists {
		t.Fatal("finished war-god snapshot remains active")
	}
}
