package engine

import (
	"encoding/json"
	"testing"

	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"
)

const turnControlTestGameID = "turn-control-test"

type turnControlTestState struct {
	MoveCount int  `json:"moveCount"`
	ExtraTurn bool `json:"extraTurn"`
	Winner    int  `json:"winner"`
}

type turnControlTestMove struct {
	Keep bool `json:"keep"`
	Win  bool `json:"win"`
}

type turnControlTestLogic struct{}

func (turnControlTestLogic) ID() string          { return turnControlTestGameID }
func (turnControlTestLogic) StateVersion() int   { return 1 }
func (turnControlTestLogic) Init(seed int64) any { return &turnControlTestState{Winner: -1} }
func (turnControlTestLogic) DecodeState(data json.RawMessage) (any, error) {
	var state turnControlTestState
	if err := json.Unmarshal(data, &state); err != nil {
		return nil, err
	}
	return &state, nil
}
func (turnControlTestLogic) ValidateMove(state any, playerIdx int, move json.RawMessage) error {
	var command turnControlTestMove
	return json.Unmarshal(move, &command)
}
func (turnControlTestLogic) Apply(state any, playerIdx int, move json.RawMessage) (any, error) {
	var command turnControlTestMove
	if err := json.Unmarshal(move, &command); err != nil {
		return state, err
	}
	current := state.(*turnControlTestState)
	next := &turnControlTestState{MoveCount: current.MoveCount + 1, ExtraTurn: command.Keep, Winner: -1}
	if command.Win {
		next.Winner = playerIdx
	}
	return next, nil
}
func (turnControlTestLogic) Result(state any) (bool, int) {
	winner := state.(*turnControlTestState).Winner
	if winner < 0 {
		return false, -1
	}
	return true, winner
}
func (turnControlTestLogic) KeepTurn(state any) bool {
	return state.(*turnControlTestState).ExtraTurn
}
func (turnControlTestLogic) TimeoutSkipsTurn() bool { return true }

var (
	_ logic.TurnKeeper     = turnControlTestLogic{}
	_ logic.TimeoutSkipper = turnControlTestLogic{}
)

func init() {
	logic.Register(turnControlTestLogic{})
}

func startTurnControlTestMatch(t *testing.T, gameEngine *Engine) *Match {
	t.Helper()
	gameLogic, err := logic.Get(turnControlTestGameID)
	if err != nil {
		t.Fatal(err)
	}
	if err := gameEngine.startMatch(
		turnControlTestGameID,
		gameLogic,
		protocol.PlayerInfo{ID: "keeper-a", Name: "Keeper A"},
		protocol.PlayerInfo{ID: "keeper-b", Name: "Keeper B"},
		0,
	); err != nil {
		t.Fatalf("start match: %v", err)
	}
	gameEngine.mu.RLock()
	defer gameEngine.mu.RUnlock()
	for _, match := range gameEngine.matches {
		return match
	}
	t.Fatal("match was not created")
	return nil
}

func fireTurnTimeout(gameEngine *Engine, match *Match) {
	match.mu.Lock()
	if match.timer != nil {
		match.timer.Stop()
	}
	turn := match.turnIdx
	gen := match.turnGen
	match.mu.Unlock()
	gameEngine.onTimeout(match.ID, turn, gen)
}

func TestTurnKeeperKeepsTurnAfterMove(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startTurnControlTestMatch(t, gameEngine)
	currentIdx := match.turnIdx
	currentID := match.players[currentIdx].ID

	gameEngine.Move(match.GameID, currentID, match.ID, json.RawMessage(`{"keep":true}`))
	if match.turnIdx != currentIdx {
		t.Fatalf("turn = %d, want kept turn %d", match.turnIdx, currentIdx)
	}
	if match.timer == nil {
		t.Fatal("kept turn did not rearm the turn timer")
	}
	for _, player := range match.players {
		envelope, ok := emitter.last(player.ID, protocol.S2CState)
		if !ok {
			t.Fatalf("%s did not receive STATE", player.ID)
		}
		data := envelope.Data.(protocol.StateData)
		if data.Turn != currentIdx || data.LastBy != currentIdx {
			t.Fatalf("unexpected kept-turn STATE for %s: %+v", player.ID, data)
		}
		if data.Deadline != match.deadline.UnixMilli() {
			t.Fatalf("kept turn did not reset the deadline for %s", player.ID)
		}
	}
	snapshot, ok := activeStore.get(match.GameID, match.ID)
	if !ok || snapshot.TurnIndex != currentIdx {
		t.Fatalf("kept turn was not persisted: %+v", snapshot)
	}

	gameEngine.Move(match.GameID, currentID, match.ID, json.RawMessage(`{"keep":false}`))
	if match.turnIdx != 1-currentIdx {
		t.Fatalf("turn = %d, want flipped turn %d", match.turnIdx, 1-currentIdx)
	}
}

func TestTimeoutSkipperSkipsTurnInsteadOfLosing(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startTurnControlTestMatch(t, gameEngine)
	timedOutIdx := match.turnIdx
	nextIdx := 1 - timedOutIdx

	fireTurnTimeout(gameEngine, match)
	if match.over || gameEngine.matches[match.ID] == nil {
		t.Fatal("skipped timeout finished the match")
	}
	if match.turnIdx != nextIdx || match.timeoutRuns[timedOutIdx] != 1 {
		t.Fatalf("turn = %d runs = %v, want turn %d and one timeout run", match.turnIdx, match.timeoutRuns, nextIdx)
	}
	if match.timer == nil {
		t.Fatal("skipped timeout did not rearm the turn timer")
	}
	for _, player := range match.players {
		envelope, ok := emitter.last(player.ID, protocol.S2CState)
		if !ok {
			t.Fatalf("%s did not receive STATE after skipped timeout", player.ID)
		}
		data := envelope.Data.(protocol.StateData)
		if data.Turn != nextIdx || data.LastBy != timedOutIdx || len(data.LastMove) != 0 {
			t.Fatalf("unexpected skipped-timeout STATE for %s: %+v", player.ID, data)
		}
		if emitter.count(player.ID, protocol.S2CMatchOver) != 0 {
			t.Fatalf("%s received MATCH_OVER after a single timeout", player.ID)
		}
	}
	snapshot, ok := activeStore.get(match.GameID, match.ID)
	if !ok || snapshot.TurnIndex != nextIdx || snapshot.TimeoutRuns != [2]int{1, 0} {
		t.Fatalf("skipped timeout was not persisted: %+v", snapshot)
	}
}

func TestThirdConsecutiveTimeoutBySamePlayerLosesMatch(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startTurnControlTestMatch(t, gameEngine)
	loserID := match.players[0].ID
	winnerID := match.players[1].ID

	for i := 0; i < 4; i++ {
		fireTurnTimeout(gameEngine, match)
		if match.over {
			t.Fatalf("match finished after %d alternating timeouts", i+1)
		}
	}
	if match.timeoutRuns != [2]int{2, 2} {
		t.Fatalf("timeout runs = %v, want two per player", match.timeoutRuns)
	}

	fireTurnTimeout(gameEngine, match)
	if !match.over || gameEngine.matches[match.ID] != nil {
		t.Fatal("third consecutive timeout did not finish the match")
	}
	envelope, ok := emitter.last(loserID, protocol.S2CMatchOver)
	if !ok {
		t.Fatal("timed-out player did not receive MATCH_OVER")
	}
	data := envelope.Data.(protocol.MatchOverData)
	if data.Reason != "timeout" || data.WinnerID != winnerID {
		t.Fatalf("unexpected timeout result: %+v", data)
	}
}

func TestValidMoveResetsTimeoutRunCounter(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startTurnControlTestMatch(t, gameEngine)
	currentIdx := match.turnIdx
	currentID := match.players[currentIdx].ID
	opponentID := match.players[1-currentIdx].ID

	match.mu.Lock()
	match.timeoutRuns[currentIdx] = 2
	match.mu.Unlock()

	gameEngine.Move(match.GameID, currentID, match.ID, json.RawMessage(`{"keep":false}`))
	if match.timeoutRuns[currentIdx] != 0 {
		t.Fatalf("timeout runs = %v, want reset for player %d", match.timeoutRuns, currentIdx)
	}
	snapshot, ok := activeStore.get(match.GameID, match.ID)
	if !ok || snapshot.TimeoutRuns != [2]int{0, 0} {
		t.Fatalf("reset timeout runs were not persisted: %+v", snapshot)
	}

	gameEngine.Move(match.GameID, opponentID, match.ID, json.RawMessage(`{"keep":false}`))
	fireTurnTimeout(gameEngine, match)
	if match.over || match.timeoutRuns[currentIdx] != 1 {
		t.Fatalf("timeout after reset run counter lost the match: over=%v runs=%v", match.over, match.timeoutRuns)
	}
	if emitter.count(currentID, protocol.S2CMatchOver) != 0 {
		t.Fatal("player lost despite a valid move between timeouts")
	}
}

func TestMoveRollbackRestoresTimeoutRuns(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startTurnControlTestMatch(t, gameEngine)
	currentIdx := match.turnIdx
	currentID := match.players[currentIdx].ID

	match.mu.Lock()
	match.timeoutRuns = [2]int{2, 1}
	match.mu.Unlock()
	activeStore.failSave = true

	gameEngine.Move(match.GameID, currentID, match.ID, json.RawMessage(`{"keep":false}`))
	if match.timeoutRuns != [2]int{2, 1} || match.turnIdx != currentIdx {
		t.Fatalf("failed move did not roll back timeout runs: %v", match.timeoutRuns)
	}
	requireErrorCode(t, emitter, currentID, "STATE_SAVE_FAILED")
}

func TestTimeoutRunsSnapshotRoundtrip(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	firstEngine, _, _ := newPersistenceTestEngine(activeStore)
	match := startTurnControlTestMatch(t, firstEngine)
	matchID := match.ID

	fireTurnTimeout(firstEngine, match)
	snapshot, ok := activeStore.get(match.GameID, matchID)
	if !ok || snapshot.TimeoutRuns != [2]int{1, 0} {
		t.Fatalf("timeout runs were not persisted: %+v", snapshot)
	}
	stopEngineTimers(firstEngine)

	secondEngine, _, _ := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(secondEngine)
	restored := secondEngine.matches[matchID]
	if restored == nil {
		t.Fatal("active match was not restored")
	}
	if restored.timeoutRuns != [2]int{1, 0} {
		t.Fatalf("restored timeout runs = %v, want [1 0]", restored.timeoutRuns)
	}
}
