package engine

import (
	"encoding/json"
	"slices"
	"testing"
	"time"

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
func (turnControlTestLogic) MinPlayers() int        { return 2 }
func (turnControlTestLogic) MaxPlayers() int        { return 4 }
func (turnControlTestLogic) OnPlayerQuit(state any, playerIdx int) {
}
func (turnControlTestLogic) TurnStartDelay(state any, previousPlayerIdx, nextPlayerIdx int) time.Duration {
	if previousPlayerIdx < 0 {
		return 300 * time.Millisecond
	}
	return 1500 * time.Millisecond
}

var (
	_ logic.TurnKeeper       = turnControlTestLogic{}
	_ logic.TurnStartDelayer = turnControlTestLogic{}
	_ logic.TimeoutSkipper   = turnControlTestLogic{}
	_ logic.PlayerCounter    = turnControlTestLogic{}
	_ logic.QuitHandler      = turnControlTestLogic{}
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

func TestPlayerCanForfeitOrExitOutsideTheirTurn(t *testing.T) {
	tests := []struct {
		name string
		act  func(*Engine, *Match, string)
	}{
		{
			name: "forfeit",
			act: func(gameEngine *Engine, match *Match, userID string) {
				gameEngine.Forfeit(match.GameID, userID, match.ID)
			},
		},
		{
			name: "exit",
			act: func(gameEngine *Engine, match *Match, userID string) {
				gameEngine.ForfeitAndLeave(match.GameID, userID, match.ID)
			},
		},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			activeStore := newMemoryActiveMatchStore()
			gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
			defer stopEngineTimers(gameEngine)
			match := startTurnControlTestMatch(t, gameEngine)
			actorID := match.players[1-match.turnIdx].ID
			winnerID := match.players[match.turnIdx].ID

			test.act(gameEngine, match, actorID)

			envelope, ok := emitter.last(actorID, protocol.S2CMatchOver)
			if !ok {
				t.Fatal("player acting outside their turn did not receive MATCH_OVER")
			}
			data := envelope.Data.(protocol.MatchOverData)
			if data.Reason != "forfeit" || data.WinnerID != winnerID {
				t.Fatalf("unexpected result outside player turn: %+v", data)
			}
		})
	}
}

func TestTurnStartDelayExtendsAuthoritativeDeadline(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	startedAt := time.Now()
	match := startTurnControlTestMatch(t, gameEngine)
	minimumInitialDeadline := startedAt.Add(time.Duration(gameEngine.turnSeconds)*time.Second + 250*time.Millisecond)
	if match.deadline.Before(minimumInitialDeadline) {
		t.Fatalf("initial deadline = %v, want at least %v", match.deadline, minimumInitialDeadline)
	}

	currentIdx := match.turnIdx
	currentID := match.players[currentIdx].ID
	movedAt := time.Now()
	gameEngine.Move(match.GameID, currentID, match.ID, json.RawMessage(`{"keep":false}`))
	minimumMoveDeadline := movedAt.Add(time.Duration(gameEngine.turnSeconds)*time.Second + 1400*time.Millisecond)
	if match.deadline.Before(minimumMoveDeadline) {
		t.Fatalf("move deadline = %v, want at least %v", match.deadline, minimumMoveDeadline)
	}
	for _, player := range match.players {
		envelope, ok := emitter.last(player.ID, protocol.S2CState)
		if !ok || envelope.Data.(protocol.StateData).Deadline != match.deadline.UnixMilli() {
			t.Fatalf("%s did not receive the delayed authoritative deadline", player.ID)
		}
	}
}

func TestDualDisconnectReconnectPublishesRearmedDeadline(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startTurnControlTestMatch(t, gameEngine)
	currentID := match.players[match.turnIdx].ID
	otherID := match.players[1-match.turnIdx].ID

	gameEngine.OnDisconnect(match.GameID, currentID)
	gameEngine.OnDisconnect(match.GameID, otherID)
	match.mu.Lock()
	if match.pausedRemain <= 0 {
		match.mu.Unlock()
		t.Fatal("current-player disconnect did not preserve remaining turn time")
	}
	if match.timer != nil {
		match.timer.Stop()
	}
	match.deadline = time.Now().Add(-time.Second)
	match.mu.Unlock()

	emitter.clear()
	gameEngine.OnConnect(match.GameID, currentID)
	staleEnvelope, ok := emitter.last(currentID, protocol.S2CMatchFound)
	if !ok {
		t.Fatal("first reconnecting player did not receive resumed MATCH_FOUND")
	}
	stale := staleEnvelope.Data.(protocol.MatchFoundData)
	if stale.Deadline >= time.Now().UnixMilli() {
		t.Fatalf("test setup expected an expired paused deadline, got %d", stale.Deadline)
	}

	emitter.clear()
	rearmedAt := time.Now()
	gameEngine.OnConnect(match.GameID, otherID)
	reconnectedEnvelope, ok := emitter.last(currentID, protocol.S2COpponentReconnected)
	if !ok {
		t.Fatal("already-reconnected current player did not receive OPPONENT_RECONNECTED")
	}
	reconnected, ok := reconnectedEnvelope.Data.(protocol.OpponentReconnectedData)
	if !ok {
		t.Fatalf("unexpected reconnect payload: %#v", reconnectedEnvelope.Data)
	}
	match.mu.Lock()
	wantTurn := match.turnIdx
	wantDeadline := match.deadline.UnixMilli()
	match.mu.Unlock()
	if reconnected.Turn != wantTurn || reconnected.Deadline != wantDeadline {
		t.Fatalf("reconnect turn sync = %+v, want turn=%d deadline=%d", reconnected, wantTurn, wantDeadline)
	}
	if reconnected.Deadline <= rearmedAt.UnixMilli() {
		t.Fatalf("reconnect deadline was not re-armed: %+v", reconnected)
	}
	if emitter.count(currentID, protocol.S2CMatchFound) != 0 {
		t.Fatal("already-connected player should receive a turn sync, not a duplicate MATCH_FOUND")
	}
}

func TestOwnerExitDoesNotCloseRoomWhileQuitHandlerMatchContinues(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	room := Room{
		ID:         "continuing-room",
		GameID:     turnControlTestGameID,
		OwnerID:    "owner",
		OwnerName:  "Owner",
		MaxPlayers: 3,
		Guests: []RoomGuest{
			{ID: "guest-a", Name: "Guest A", Ready: true},
			{ID: "guest-b", Name: "Guest B", Ready: true},
		},
	}
	room.normalize()
	players := []protocol.PlayerInfo{
		{ID: room.OwnerID, Name: room.OwnerName},
		{ID: room.Guests[0].ID, Name: room.Guests[0].Name},
		{ID: room.Guests[1].ID, Name: room.Guests[1].Name},
	}
	if err := gameEngine.startMatchWithRoom(
		room.GameID,
		turnControlTestLogic{},
		players,
		0,
		&room,
		false,
		nil,
	); err != nil {
		t.Fatalf("start three-player room match: %v", err)
	}
	match := gameEngine.matchForUser(room.GameID, room.OwnerID)
	if match == nil {
		t.Fatal("three-player room match was not created")
	}

	emitter.clear()
	gameEngine.ForfeitAndLeave(room.GameID, room.OwnerID, match.ID)

	match.mu.Lock()
	over := match.over
	ownerIdx := match.playerIndex(room.OwnerID)
	ownerQuit := ownerIdx >= 0 && match.quit[ownerIdx]
	match.mu.Unlock()
	if over || !ownerQuit {
		t.Fatalf("owner exit should eliminate only that seat: over=%t ownerQuit=%t", over, ownerQuit)
	}
	for _, guest := range room.Guests {
		if emitter.count(guest.ID, protocol.S2CRoomClosed) != 0 ||
			emitter.count(guest.ID, protocol.S2CRoomSync) != 0 {
			t.Fatalf("continuing match sent premature room closure to %s", guest.ID)
		}
		if gameEngine.matchForUser(room.GameID, guest.ID) != match {
			t.Fatalf("remaining player %s lost the active match", guest.ID)
		}
	}
	snapshot, ok := activeStore.get(match.GameID, match.ID)
	if !ok || snapshot.Room != nil || snapshot.ClosedRoom == nil || snapshot.ClosedRoom.ID != room.ID {
		t.Fatalf("owner-left lifecycle was not persisted: %#v", snapshot)
	}

	stopEngineTimers(gameEngine)
	restoredEngine, _, restoredEmitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(restoredEngine)
	restoredMatch := restoredEngine.matchForUser(match.GameID, room.Guests[0].ID)
	if restoredMatch == nil || restoredMatch.closedRoom == nil || restoredMatch.closedRoom.ID != room.ID {
		t.Fatal("restored continuing match lost the pending room closure")
	}
	restoredEmitter.clear()
	restoredEngine.ForfeitAndLeave(restoredMatch.GameID, room.Guests[0].ID, restoredMatch.ID)
	departingID := room.Guests[0].ID
	if restoredEmitter.count(departingID, protocol.S2CMatchOver) != 1 ||
		restoredEmitter.count(departingID, protocol.S2CRoomClosed) != 0 ||
		restoredEmitter.count(departingID, protocol.S2CRoomSync) != 0 {
		t.Fatalf("departing guest received the deferred room closure")
	}
	remainingID := room.Guests[1].ID
	if restoredEmitter.count(remainingID, protocol.S2CMatchOver) != 1 ||
		restoredEmitter.count(remainingID, protocol.S2CRoomClosed) != 1 ||
		restoredEmitter.count(remainingID, protocol.S2CRoomSync) != 1 {
		t.Fatalf("finished match did not close the owner-left room for %s", remainingID)
	}
	requireMessageOrder(t, restoredEmitter, remainingID, protocol.S2CMatchOver, protocol.S2CRoomClosed)
	requireMessageOrder(t, restoredEmitter, remainingID, protocol.S2CRoomClosed, protocol.S2CRoomSync)
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
	if !ok || snapshot.TurnIndex != nextIdx || !slices.Equal(snapshot.TimeoutRuns, []int{1, 0}) {
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
	if !slices.Equal(match.timeoutRuns, []int{2, 2}) {
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
	if !ok || !slices.Equal(snapshot.TimeoutRuns, []int{0, 0}) {
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
	match.timeoutRuns = []int{2, 1}
	match.mu.Unlock()
	activeStore.failSave = true

	gameEngine.Move(match.GameID, currentID, match.ID, json.RawMessage(`{"keep":false}`))
	if !slices.Equal(match.timeoutRuns, []int{2, 1}) || match.turnIdx != currentIdx {
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
	if !ok || !slices.Equal(snapshot.TimeoutRuns, []int{1, 0}) {
		t.Fatalf("timeout runs were not persisted: %+v", snapshot)
	}
	stopEngineTimers(firstEngine)

	secondEngine, _, _ := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(secondEngine)
	restored := secondEngine.matches[matchID]
	if restored == nil {
		t.Fatal("active match was not restored")
	}
	if !slices.Equal(restored.timeoutRuns, []int{1, 0}) {
		t.Fatalf("restored timeout runs = %v, want [1 0]", restored.timeoutRuns)
	}
}
