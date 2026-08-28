package engine

import (
	"encoding/json"
	"slices"
	"sync/atomic"
	"testing"
	"time"

	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"
)

const timeoutMoveTestGameID = "timeout-move-test"

type timeoutMoveTestState struct {
	MoveCount int  `json:"moveCount"`
	Stuck     bool `json:"stuck"`
	Winner    int  `json:"winner"`
}

type timeoutMoveTestLogic struct{}

func (timeoutMoveTestLogic) ID() string        { return timeoutMoveTestGameID }
func (timeoutMoveTestLogic) StateVersion() int { return 1 }
func (timeoutMoveTestLogic) Init(seed int64) any {
	return &timeoutMoveTestState{Winner: -1}
}
func (timeoutMoveTestLogic) DecodeState(data json.RawMessage) (any, error) {
	var state timeoutMoveTestState
	if err := json.Unmarshal(data, &state); err != nil {
		return nil, err
	}
	return &state, nil
}
func (timeoutMoveTestLogic) ValidateMove(state any, playerIdx int, move json.RawMessage) error {
	var command struct{}
	return json.Unmarshal(move, &command)
}
func (timeoutMoveTestLogic) Apply(state any, playerIdx int, move json.RawMessage) (any, error) {
	current := state.(*timeoutMoveTestState)
	return &timeoutMoveTestState{MoveCount: current.MoveCount + 1, Stuck: current.Stuck, Winner: -1}, nil
}
func (timeoutMoveTestLogic) Result(state any) (bool, int) {
	winner := state.(*timeoutMoveTestState).Winner
	if winner < 0 {
		return false, -1
	}
	return true, winner
}
var timeoutMoveCalls atomic.Int32

func (timeoutMoveTestLogic) MoveOnTimeout(state any, playerIdx int) (json.RawMessage, bool) {
	timeoutMoveCalls.Add(1)
	if state.(*timeoutMoveTestState).Stuck {
		return nil, false
	}
	return json.RawMessage(`{"auto":true}`), true
}

var _ logic.TimeoutMover = timeoutMoveTestLogic{}

func init() {
	logic.Register(timeoutMoveTestLogic{})
}

func startTimeoutMoveTestMatch(t *testing.T, gameEngine *Engine) *Match {
	t.Helper()
	gameLogic, err := logic.Get(timeoutMoveTestGameID)
	if err != nil {
		t.Fatal(err)
	}
	if err := gameEngine.startMatch(
		timeoutMoveTestGameID,
		gameLogic,
		protocol.PlayerInfo{ID: "auto-a", Name: "Auto A"},
		protocol.PlayerInfo{ID: "auto-b", Name: "Auto B"},
		0,
	); err != nil {
		t.Fatalf("start match: %v", err)
	}
	gameEngine.mu.RLock()
	defer gameEngine.mu.RUnlock()
	for _, match := range gameEngine.matches {
		if match.GameID == timeoutMoveTestGameID {
			return match
		}
	}
	t.Fatal("match was not created")
	return nil
}

// expireTurnAndFire drives a timeout the way the real turn timer does, with the
// deadline already in the past, so tests can observe what Move sees afterwards.
func expireTurnAndFire(gameEngine *Engine, match *Match) {
	match.mu.Lock()
	if match.timer != nil {
		match.timer.Stop()
	}
	match.deadline = time.Now().Add(-time.Millisecond)
	turn := match.turnIdx
	gen := match.turnGen
	match.mu.Unlock()
	gameEngine.onTimeout(match.ID, turn, gen)
}

func TestTimeoutMoverPlaysFallbackMoveInsteadOfLosing(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startTimeoutMoveTestMatch(t, gameEngine)
	timedOutIdx := match.turnIdx
	nextIdx := 1 - timedOutIdx

	fireTurnTimeout(gameEngine, match)
	if match.over || gameEngine.matches[match.ID] == nil {
		t.Fatal("timeout with a fallback move finished the match")
	}
	if match.turnIdx != nextIdx {
		t.Fatalf("turn = %d, want %d", match.turnIdx, nextIdx)
	}
	if match.timeoutRuns[timedOutIdx] != 1 {
		t.Fatalf("timeout runs = %v, want one for player %d", match.timeoutRuns, timedOutIdx)
	}
	if match.state.(*timeoutMoveTestState).MoveCount != 1 {
		t.Fatal("fallback move was not applied to the state")
	}
	if match.timer == nil {
		t.Fatal("timeout move did not rearm the turn timer")
	}
	for _, player := range match.players {
		envelope, ok := emitter.last(player.ID, protocol.S2CState)
		if !ok {
			t.Fatalf("%s did not receive STATE after the timeout move", player.ID)
		}
		data := envelope.Data.(protocol.StateData)
		if data.Turn != nextIdx || data.LastBy != timedOutIdx || len(data.LastMove) == 0 {
			t.Fatalf("unexpected timeout-move STATE for %s: %+v", player.ID, data)
		}
		if !data.AutoMoved {
			t.Fatalf("STATE for %s did not mark the move as server-played", player.ID)
		}
		if emitter.count(player.ID, protocol.S2CMatchOver) != 0 {
			t.Fatalf("%s received MATCH_OVER after a single timeout", player.ID)
		}
	}
	snapshot, ok := activeStore.get(match.GameID, match.ID)
	if !ok || snapshot.TurnIndex != nextIdx || !slices.Equal(snapshot.TimeoutRuns, []int{1, 0}) {
		t.Fatalf("timeout move was not persisted: %+v", snapshot)
	}
}

func TestThirdConsecutiveTimeoutMoveForfeitsMatch(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startTimeoutMoveTestMatch(t, gameEngine)
	loserID := match.players[match.turnIdx].ID
	winnerID := match.players[1-match.turnIdx].ID

	for i := 0; i < 4; i++ {
		fireTurnTimeout(gameEngine, match)
		if match.over {
			t.Fatalf("match finished after %d alternating timeouts", i+1)
		}
	}
	if !slices.Equal(match.timeoutRuns, []int{2, 2}) {
		t.Fatalf("timeout runs = %v, want two per player", match.timeoutRuns)
	}
	if match.state.(*timeoutMoveTestState).MoveCount != 4 {
		t.Fatalf("move count = %d, want one fallback move per timeout",
			match.state.(*timeoutMoveTestState).MoveCount)
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

func TestMoveResetsTimeoutRunsForTimeoutMover(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, _ := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startTimeoutMoveTestMatch(t, gameEngine)
	currentIdx := match.turnIdx

	fireTurnTimeout(gameEngine, match)
	fireTurnTimeout(gameEngine, match)
	if !slices.Equal(match.timeoutRuns, []int{1, 1}) {
		t.Fatalf("timeout runs = %v, want one per player", match.timeoutRuns)
	}

	gameEngine.Move(match.GameID, match.players[currentIdx].ID, match.ID, json.RawMessage(`{}`))
	if match.timeoutRuns[currentIdx] != 0 {
		t.Fatalf("timeout runs = %v, want reset for player %d", match.timeoutRuns, currentIdx)
	}
}

func TestPlayerMoveIsNotMarkedAutoMoved(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startTimeoutMoveTestMatch(t, gameEngine)
	currentIdx := match.turnIdx

	gameEngine.Move(match.GameID, match.players[currentIdx].ID, match.ID, json.RawMessage(`{}`))

	for _, player := range match.players {
		envelope, ok := emitter.last(player.ID, protocol.S2CState)
		if !ok {
			t.Fatalf("%s did not receive STATE after a normal move", player.ID)
		}
		if envelope.Data.(protocol.StateData).AutoMoved {
			t.Fatalf("STATE for %s marked a player's own move as server-played", player.ID)
		}
	}
}

func TestUnsavableTimeoutMoveRetriesInsteadOfForfeiting(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startTimeoutMoveTestMatch(t, gameEngine)
	timedOutIdx := match.turnIdx
	timedOutID := match.players[timedOutIdx].ID

	activeStore.failSave = true
	expireTurnAndFire(gameEngine, match)

	if match.over || gameEngine.matches[match.ID] == nil {
		t.Fatal("a store outage forfeited the match")
	}
	if emitter.count(timedOutID, protocol.S2CMatchOver) != 0 {
		t.Fatal("a store outage sent MATCH_OVER to the timed-out player")
	}
	if !slices.Equal(match.timeoutRuns, []int{0, 0}) {
		t.Fatalf("timeout runs = %v, want no run charged for a store outage", match.timeoutRuns)
	}
	if match.turnIdx != timedOutIdx {
		t.Fatalf("turn = %d, want the timed-out player %d to keep the turn", match.turnIdx, timedOutIdx)
	}
	if match.state.(*timeoutMoveTestState).MoveCount != 0 {
		t.Fatal("unsaved fallback move was left applied to the state")
	}
	if match.timer == nil {
		t.Fatal("store outage did not arm a retry")
	}
	// The retry must not reopen the expired turn, so the deadline stays past.
	if remaining := time.Until(match.deadline); remaining > 0 {
		t.Fatalf("retry pushed the turn deadline %v into the future", remaining)
	}

	activeStore.failSave = false
	expireTurnAndFire(gameEngine, match)

	if match.over {
		t.Fatal("the retry forfeited the match")
	}
	if match.state.(*timeoutMoveTestState).MoveCount != 1 {
		t.Fatal("the retry did not play the fallback move")
	}
	if !slices.Equal(match.timeoutRuns, []int{1, 0}) {
		t.Fatalf("timeout runs = %v, want a single run after the retry succeeded", match.timeoutRuns)
	}
	if match.timeoutMove != nil || match.timeoutMoveFails != 0 {
		t.Fatalf("retry bookkeeping was not cleared: move=%s fails=%d",
			match.timeoutMove, match.timeoutMoveFails)
	}
	snapshot, ok := activeStore.get(match.GameID, match.ID)
	if !ok || !slices.Equal(snapshot.TimeoutRuns, []int{1, 0}) {
		t.Fatalf("retried timeout move was not persisted: %+v", snapshot)
	}
}

func TestRetryWindowStillRejectsTheExpiredPlayersMove(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startTimeoutMoveTestMatch(t, gameEngine)
	timedOutIdx := match.turnIdx
	timedOutID := match.players[timedOutIdx].ID

	activeStore.failSave = true
	expireTurnAndFire(gameEngine, match)
	activeStore.failSave = false

	if remaining := time.Until(match.deadline); remaining > 0 {
		t.Fatalf("retry moved the turn deadline into the future by %v", remaining)
	}

	before := emitter.count(timedOutID, protocol.S2CState)
	gameEngine.Move(match.GameID, timedOutID, match.ID, json.RawMessage(`{}`))

	if match.state.(*timeoutMoveTestState).MoveCount != 0 {
		t.Fatal("the expired player was allowed to move inside the retry window")
	}
	if emitter.count(timedOutID, protocol.S2CState) != before {
		t.Fatal("a move inside the retry window produced a STATE broadcast")
	}
}

func TestTimeoutMoveIsComputedOnceAcrossRetries(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, _ := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startTimeoutMoveTestMatch(t, gameEngine)

	activeStore.failSave = true
	timeoutMoveCalls.Store(0)
	for i := 0; i < 3; i++ {
		fireTurnTimeout(gameEngine, match)
	}
	if match.timeoutMoveFails != 3 {
		t.Fatalf("failure count = %d, want 3", match.timeoutMoveFails)
	}

	activeStore.failSave = false
	fireTurnTimeout(gameEngine, match)

	if calls := timeoutMoveCalls.Load(); calls != 1 {
		t.Fatalf("MoveOnTimeout ran %d times across four attempts, want 1", calls)
	}
	if match.state.(*timeoutMoveTestState).MoveCount != 1 {
		t.Fatal("the cached fallback move was not applied once the store recovered")
	}
}

func TestTimeoutMoveRetryBackoffGrowsAndIsCapped(t *testing.T) {
	if got := timeoutMoveRetryBackoff(1); got != timeoutMoveRetryDelay {
		t.Fatalf("first retry delay = %v, want %v", got, timeoutMoveRetryDelay)
	}
	if got := timeoutMoveRetryBackoff(2); got != 2*timeoutMoveRetryDelay {
		t.Fatalf("second retry delay = %v, want %v", got, 2*timeoutMoveRetryDelay)
	}
	for _, attempt := range []int{maxTimeoutMoveRetries, 40, 100} {
		if got := timeoutMoveRetryBackoff(attempt); got != maxTimeoutMoveRetryDelay {
			t.Fatalf("retry delay for attempt %d = %v, want the %v cap",
				attempt, got, maxTimeoutMoveRetryDelay)
		}
	}
}

func TestExhaustedTimeoutRetriesAbortMatchAndRefund(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startTimeoutMoveTestMatch(t, gameEngine)

	activeStore.failSave = true
	for i := 0; i <= maxTimeoutMoveRetries; i++ {
		if match.over {
			t.Fatalf("match aborted after %d attempts, want %d", i, maxTimeoutMoveRetries+1)
		}
		fireTurnTimeout(gameEngine, match)
	}

	if !match.over || gameEngine.matches[match.ID] != nil {
		t.Fatal("exhausted retries did not end the match")
	}
	for _, player := range match.players {
		envelope, ok := emitter.last(player.ID, protocol.S2CMatchOver)
		if !ok {
			t.Fatalf("%s was not told the match was aborted", player.ID)
		}
		data := envelope.Data.(protocol.MatchOverData)
		if data.Reason != matchReasonAborted {
			t.Fatalf("abort reason for %s = %q, want %q", player.ID, data.Reason, matchReasonAborted)
		}
		if data.WinnerID != "" {
			t.Fatalf("technical abort declared %q the winner", data.WinnerID)
		}
		if data.Payout != 0 || data.KenDelta != 0 {
			t.Fatalf("technical abort paid out for %s: %+v", player.ID, data)
		}
	}
	if !slices.Equal(match.timeoutRuns, []int{0, 0}) {
		t.Fatalf("timeout runs = %v, want no run charged for a store outage", match.timeoutRuns)
	}
	if match.state.(*timeoutMoveTestState).MoveCount != 0 {
		t.Fatal("aborted match kept an unsaved move applied")
	}
}

func TestTimeoutWithoutFallbackMoveForfeitsMatch(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startTimeoutMoveTestMatch(t, gameEngine)
	loserID := match.players[match.turnIdx].ID
	winnerID := match.players[1-match.turnIdx].ID

	match.mu.Lock()
	match.state.(*timeoutMoveTestState).Stuck = true
	match.mu.Unlock()

	fireTurnTimeout(gameEngine, match)
	if !match.over {
		t.Fatal("timeout without a fallback move did not finish the match")
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
