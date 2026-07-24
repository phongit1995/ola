package engine

import (
	"encoding/json"
	"errors"
	"sync"
	"testing"
	"time"

	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"

	"go.uber.org/zap"
)

const persistenceTestGameID = "persistence-test"

type persistenceTestState struct {
	MoveCount int `json:"moveCount"`
	Winner    int `json:"winner"`
}

type persistenceTestMove struct {
	Win  bool `json:"win"`
	Draw bool `json:"draw"`
}

type persistenceTestLogic struct{}

func (persistenceTestLogic) ID() string          { return persistenceTestGameID }
func (persistenceTestLogic) StateVersion() int   { return 1 }
func (persistenceTestLogic) Init(seed int64) any { return &persistenceTestState{Winner: -1} }
func (persistenceTestLogic) DecodeState(data json.RawMessage) (any, error) {
	var state persistenceTestState
	if err := json.Unmarshal(data, &state); err != nil {
		return nil, err
	}
	return &state, nil
}
func (persistenceTestLogic) ValidateMove(state any, playerIdx int, move json.RawMessage) error {
	var command persistenceTestMove
	return json.Unmarshal(move, &command)
}
func (persistenceTestLogic) Apply(state any, playerIdx int, move json.RawMessage) (any, error) {
	var command persistenceTestMove
	if err := json.Unmarshal(move, &command); err != nil {
		return state, err
	}
	current := state.(*persistenceTestState)
	next := &persistenceTestState{MoveCount: current.MoveCount + 1, Winner: -1}
	if command.Win {
		next.Winner = playerIdx
	} else if command.Draw {
		next.Winner = -2
	}
	return next, nil
}
func (persistenceTestLogic) Result(state any) (bool, int) {
	winner := state.(*persistenceTestState).Winner
	switch winner {
	case -1:
		return false, -1
	case -2:
		return true, -1
	default:
		return true, winner
	}
}

func init() {
	logic.Register(persistenceTestLogic{})
}

type memoryRoomStore struct {
	rooms           map[string]Room
	refs            map[string]userRoomRef
	failSave        bool
	failDelete      bool
	failList        bool
	claimOK         bool
	roomByUserCalls int
}

type blockingListRoomStore struct {
	*memoryRoomStore
	entered chan struct{}
	release chan struct{}
}

func newBlockingListRoomStore() *blockingListRoomStore {
	return &blockingListRoomStore{
		memoryRoomStore: newMemoryRoomStore(),
		entered:         make(chan struct{}),
		release:         make(chan struct{}),
	}
}

func (s *blockingListRoomStore) List(gameID string) ([]Room, error) {
	close(s.entered)
	<-s.release
	return s.memoryRoomStore.List(gameID)
}

func newMemoryRoomStore() *memoryRoomStore {
	return &memoryRoomStore{
		rooms:   make(map[string]Room),
		refs:    make(map[string]userRoomRef),
		claimOK: true,
	}
}

func memoryRoomKey(gameID, value string) string { return gameID + ":" + value }

func (s *memoryRoomStore) Save(room Room) error {
	if s.failSave {
		return errors.New("save room failed")
	}
	s.rooms[memoryRoomKey(room.GameID, room.ID)] = room
	ref := userRoomRef{GameID: room.GameID, RoomID: room.ID}
	s.refs[memoryRoomKey(room.GameID, room.OwnerID)] = ref
	if room.GuestID != "" {
		s.refs[memoryRoomKey(room.GameID, room.GuestID)] = ref
	}
	return nil
}

func (s *memoryRoomStore) Get(gameID, roomID string) (Room, bool) {
	room, ok := s.rooms[memoryRoomKey(gameID, roomID)]
	return room, ok
}

func (s *memoryRoomStore) Delete(gameID, roomID string, userIDs ...string) error {
	if s.failDelete {
		return errors.New("delete room failed")
	}
	delete(s.rooms, memoryRoomKey(gameID, roomID))
	for _, userID := range userIDs {
		delete(s.refs, memoryRoomKey(gameID, userID))
	}
	return nil
}

func (s *memoryRoomStore) DeleteUserRef(gameID, userID, roomID string) error {
	key := memoryRoomKey(gameID, userID)
	if ref, ok := s.refs[key]; ok && ref.RoomID == roomID {
		delete(s.refs, key)
	}
	return nil
}

func (s *memoryRoomStore) List(gameID string) ([]Room, error) {
	if s.failList {
		return nil, errors.New("list rooms failed")
	}
	rooms := make([]Room, 0)
	for _, room := range s.rooms {
		if room.GameID == gameID {
			rooms = append(rooms, room)
		}
	}
	return rooms, nil
}

func (s *memoryRoomStore) RoomByUser(gameID, userID string) (userRoomRef, bool) {
	s.roomByUserCalls++
	ref, ok := s.refs[memoryRoomKey(gameID, userID)]
	return ref, ok
}

func (s *memoryRoomStore) Claim(gameID, roomID string) (func(), bool) {
	return func() {}, s.claimOK
}

type memoryActiveMatchStore struct {
	mu         sync.Mutex
	matches    map[string]ActiveMatchSnapshot
	failSave   bool
	failDelete bool
}

type blockingActiveMatchStore struct {
	base      *memoryActiveMatchStore
	mu        sync.Mutex
	matchID   string
	entered   chan struct{}
	release   chan struct{}
	enterOnce sync.Once
}

func newBlockingActiveMatchStore() *blockingActiveMatchStore {
	return &blockingActiveMatchStore{
		base:    newMemoryActiveMatchStore(),
		entered: make(chan struct{}),
		release: make(chan struct{}),
	}
}

func (s *blockingActiveMatchStore) block(matchID string) {
	s.mu.Lock()
	s.matchID = matchID
	s.mu.Unlock()
}

func (s *blockingActiveMatchStore) Save(snapshot ActiveMatchSnapshot) error {
	s.mu.Lock()
	blocked := snapshot.ID == s.matchID
	s.mu.Unlock()
	if blocked {
		s.enterOnce.Do(func() { close(s.entered) })
		<-s.release
	}
	return s.base.Save(snapshot)
}

func (s *blockingActiveMatchStore) Delete(gameID, matchID string, userIDs ...string) error {
	return s.base.Delete(gameID, matchID, userIDs...)
}

func (s *blockingActiveMatchStore) List(gameID string) ([]ActiveMatchSnapshot, error) {
	return s.base.List(gameID)
}

func newMemoryActiveMatchStore() *memoryActiveMatchStore {
	return &memoryActiveMatchStore{matches: make(map[string]ActiveMatchSnapshot)}
}

func activeSnapshotKey(gameID, matchID string) string { return gameID + ":" + matchID }

func cloneSnapshot(snapshot ActiveMatchSnapshot) ActiveMatchSnapshot {
	data, _ := json.Marshal(snapshot)
	var cloned ActiveMatchSnapshot
	_ = json.Unmarshal(data, &cloned)
	return cloned
}

func (s *memoryActiveMatchStore) Save(snapshot ActiveMatchSnapshot) error {
	s.mu.Lock()
	defer s.mu.Unlock()
	if s.failSave {
		return errors.New("save failed")
	}
	s.matches[activeSnapshotKey(snapshot.GameID, snapshot.ID)] = cloneSnapshot(snapshot)
	return nil
}

func (s *memoryActiveMatchStore) Delete(gameID, matchID string, userIDs ...string) error {
	s.mu.Lock()
	defer s.mu.Unlock()
	if s.failDelete {
		return errors.New("delete failed")
	}
	delete(s.matches, activeSnapshotKey(gameID, matchID))
	return nil
}

func (s *memoryActiveMatchStore) List(gameID string) ([]ActiveMatchSnapshot, error) {
	s.mu.Lock()
	defer s.mu.Unlock()
	matches := make([]ActiveMatchSnapshot, 0)
	for _, snapshot := range s.matches {
		if snapshot.GameID == gameID {
			matches = append(matches, cloneSnapshot(snapshot))
		}
	}
	return matches, nil
}

func (s *memoryActiveMatchStore) get(gameID, matchID string) (ActiveMatchSnapshot, bool) {
	s.mu.Lock()
	defer s.mu.Unlock()
	snapshot, ok := s.matches[activeSnapshotKey(gameID, matchID)]
	return cloneSnapshot(snapshot), ok
}

type capturedMessage struct {
	gameID string
	userID string
	env    protocol.OutEnvelope
}

type captureEmitter struct {
	mu       sync.Mutex
	messages []capturedMessage
}

func (e *captureEmitter) ToUser(gameID, userID string, env protocol.OutEnvelope) {
	e.mu.Lock()
	defer e.mu.Unlock()
	e.messages = append(e.messages, capturedMessage{gameID: gameID, userID: userID, env: env})
}

func (e *captureEmitter) ToGame(gameID string, env protocol.OutEnvelope) {
	e.mu.Lock()
	defer e.mu.Unlock()
	e.messages = append(e.messages, capturedMessage{gameID: gameID, env: env})
}

func (e *captureEmitter) last(userID, messageType string) (protocol.OutEnvelope, bool) {
	e.mu.Lock()
	defer e.mu.Unlock()
	for i := len(e.messages) - 1; i >= 0; i-- {
		message := e.messages[i]
		if message.userID == userID && message.env.Type == messageType {
			return message.env, true
		}
	}
	return protocol.OutEnvelope{}, false
}

func newPersistenceTestEngine(activeStore ActiveMatchRepository) (*Engine, *memoryRoomStore, *captureEmitter) {
	rooms := newMemoryRoomStore()
	emitter := &captureEmitter{}
	gameEngine := NewEngine(zap.NewNop().Sugar(), 300, 30, rooms, activeStore)
	gameEngine.SetEmitter(emitter)
	return gameEngine, rooms, emitter
}

func startPersistenceTestMatch(t *testing.T, gameEngine *Engine) *Match {
	t.Helper()
	gameLogic, err := logic.Get(persistenceTestGameID)
	if err != nil {
		t.Fatal(err)
	}
	if err := gameEngine.startMatch(
		persistenceTestGameID,
		gameLogic,
		protocol.PlayerInfo{ID: "player-a", Name: "Player A"},
		protocol.PlayerInfo{ID: "player-b", Name: "Player B"},
		10,
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

func stopEngineTimers(gameEngine *Engine) {
	gameEngine.mu.RLock()
	matches := make([]*Match, 0, len(gameEngine.matches))
	for _, match := range gameEngine.matches {
		matches = append(matches, match)
	}
	gameEngine.mu.RUnlock()
	for _, match := range matches {
		match.mu.Lock()
		if match.timer != nil {
			match.timer.Stop()
		}
		if match.graceTimer != nil {
			match.graceTimer.Stop()
		}
		match.mu.Unlock()
	}
}

func TestStartMatchPersistsInitialSnapshot(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, _ := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)

	match := startPersistenceTestMatch(t, gameEngine)
	snapshot, ok := activeStore.get(match.GameID, match.ID)
	if !ok {
		t.Fatal("initial snapshot was not saved")
	}
	if snapshot.Status != matchStatusPlaying || snapshot.StateVersion != 1 {
		t.Fatalf("unexpected snapshot metadata: %+v", snapshot)
	}
	if len(snapshot.Players) != 2 {
		t.Fatalf("unexpected players: %+v", snapshot)
	}
	if snapshot.TurnDeadline <= time.Now().UnixMilli() || snapshot.StartedAt <= 0 {
		t.Fatal("initial timer metadata was not persisted")
	}
}

func TestStartMatchFailsWhenInitialSnapshotCannotBeSaved(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	activeStore.failSave = true
	gameEngine, _, _ := newPersistenceTestEngine(activeStore)
	gameLogic, _ := logic.Get(persistenceTestGameID)

	err := gameEngine.startMatch(
		persistenceTestGameID,
		gameLogic,
		protocol.PlayerInfo{ID: "player-a", Name: "Player A"},
		protocol.PlayerInfo{ID: "player-b", Name: "Player B"},
		0,
	)
	if err == nil {
		t.Fatal("start match succeeded while Redis save failed")
	}
	if len(gameEngine.matches) != 0 || len(gameEngine.byUser) != 0 {
		t.Fatal("failed match was installed into the engine")
	}
}

func TestMovePersistsStateAndTurn(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, _ := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startPersistenceTestMatch(t, gameEngine)
	playerID := match.players[match.turnIdx].ID

	gameEngine.Move(match.GameID, playerID, match.ID, json.RawMessage(`{"win":false}`))

	snapshot, ok := activeStore.get(match.GameID, match.ID)
	if !ok {
		t.Fatal("snapshot disappeared after move")
	}
	state, err := persistenceTestLogic{}.DecodeState(snapshot.State)
	if err != nil {
		t.Fatal(err)
	}
	if state.(*persistenceTestState).MoveCount != 1 || snapshot.TurnIndex != 1 {
		t.Fatalf("move state was not persisted: %+v", snapshot)
	}
}

func TestSlowPersistenceInOneMatchDoesNotBlockAnotherMatch(t *testing.T) {
	activeStore := newBlockingActiveMatchStore()
	gameEngine, _, _ := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	gameLogic, _ := logic.Get(persistenceTestGameID)
	for _, players := range [][2]string{{"a", "b"}, {"c", "d"}} {
		if err := gameEngine.startMatch(
			persistenceTestGameID,
			gameLogic,
			protocol.PlayerInfo{ID: players[0], Name: players[0]},
			protocol.PlayerInfo{ID: players[1], Name: players[1]},
			0,
		); err != nil {
			t.Fatal(err)
		}
	}

	first := gameEngine.matchForUser(persistenceTestGameID, "a")
	second := gameEngine.matchForUser(persistenceTestGameID, "c")
	if first == nil || second == nil || first == second {
		t.Fatal("two independent matches were not installed")
	}
	activeStore.block(first.ID)
	firstDone := make(chan struct{})
	go func() {
		gameEngine.Move(first.GameID, first.players[first.turnIdx].ID, first.ID, json.RawMessage(`{"win":false}`))
		close(firstDone)
	}()
	select {
	case <-activeStore.entered:
	case <-time.After(time.Second):
		t.Fatal("first match did not reach blocked persistence")
	}

	secondDone := make(chan struct{})
	go func() {
		gameEngine.Move(second.GameID, second.players[second.turnIdx].ID, second.ID, json.RawMessage(`{"win":false}`))
		close(secondDone)
	}()
	select {
	case <-secondDone:
	case <-time.After(time.Second):
		close(activeStore.release)
		t.Fatal("slow persistence in one match blocked an unrelated match")
	}
	close(activeStore.release)
	select {
	case <-firstDone:
	case <-time.After(time.Second):
		t.Fatal("first match did not resume after persistence was released")
	}
}

func TestSlowRoomListDoesNotBlockActiveMatch(t *testing.T) {
	rooms := newBlockingListRoomStore()
	activeStore := newMemoryActiveMatchStore()
	emitter := &captureEmitter{}
	gameEngine := NewEngine(zap.NewNop().Sugar(), 300, 30, rooms, activeStore)
	gameEngine.SetEmitter(emitter)
	defer stopEngineTimers(gameEngine)
	match := startPersistenceTestMatch(t, gameEngine)

	listDone := make(chan struct{})
	go func() {
		gameEngine.ListRooms(match.GameID, "viewer")
		close(listDone)
	}()
	select {
	case <-rooms.entered:
	case <-time.After(time.Second):
		t.Fatal("room listing did not start")
	}

	moveDone := make(chan struct{})
	go func() {
		gameEngine.Move(match.GameID, match.players[match.turnIdx].ID, match.ID, json.RawMessage(`{"win":false}`))
		close(moveDone)
	}()
	select {
	case <-moveDone:
	case <-time.After(time.Second):
		close(rooms.release)
		t.Fatal("slow room listing blocked an active match")
	}
	close(rooms.release)
	select {
	case <-listDone:
	case <-time.After(time.Second):
		t.Fatal("room listing did not finish after release")
	}
}

func TestMoveRollsBackWhenSnapshotSaveFails(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startPersistenceTestMatch(t, gameEngine)
	playerID := match.players[match.turnIdx].ID
	previousDeadline := match.deadline
	activeStore.failSave = true

	gameEngine.Move(match.GameID, playerID, match.ID, json.RawMessage(`{"win":false}`))

	state := match.state.(*persistenceTestState)
	if state.MoveCount != 0 || match.turnIdx != 0 || !match.deadline.Equal(previousDeadline) {
		t.Fatal("failed move changed in-memory match state")
	}
	env, ok := emitter.last(playerID, protocol.S2CError)
	if !ok || env.Data.(protocol.ErrorData).Code != "STATE_SAVE_FAILED" {
		t.Fatal("player did not receive STATE_SAVE_FAILED")
	}
}

func TestDisconnectAndReconnectArePersisted(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, _ := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startPersistenceTestMatch(t, gameEngine)
	playerID := match.players[match.turnIdx].ID

	gameEngine.OnDisconnect(match.GameID, playerID)
	snapshot, _ := activeStore.get(match.GameID, match.ID)
	if !snapshot.Disconnected[match.turnIdx] || snapshot.GraceDeadline <= 0 || snapshot.PausedRemainMillis <= 0 {
		t.Fatalf("disconnect state was not persisted: %+v", snapshot)
	}

	gameEngine.OnConnect(match.GameID, playerID)
	snapshot, _ = activeStore.get(match.GameID, match.ID)
	if len(snapshot.Disconnected) != 0 || snapshot.GraceDeadline != 0 || snapshot.PausedRemainMillis != 0 {
		t.Fatalf("reconnect state was not cleared: %+v", snapshot)
	}
}

func TestActiveMatchDisconnectSkipsRoomLookup(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, rooms, _ := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startPersistenceTestMatch(t, gameEngine)
	playerID := match.players[match.turnIdx].ID

	gameEngine.OnDisconnect(match.GameID, playerID)
	if rooms.roomByUserCalls != 0 {
		t.Fatalf("active match disconnect performed %d unnecessary room lookups", rooms.roomByUserCalls)
	}
}

func TestMovePausesTurnWhenItPassesToDisconnectedOpponent(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startPersistenceTestMatch(t, gameEngine)
	currentIdx := match.turnIdx
	disconnectedIdx := 1 - currentIdx
	currentID := match.players[currentIdx].ID
	disconnectedID := match.players[disconnectedIdx].ID

	gameEngine.OnDisconnect(match.GameID, disconnectedID)
	if match.pausedRemain != 0 || match.timer == nil {
		t.Fatal("current player's timer should continue until the turn changes")
	}

	gameEngine.Move(match.GameID, currentID, match.ID, json.RawMessage(`{"win":false}`))
	if match.turnIdx != disconnectedIdx {
		t.Fatalf("turn = %d, want disconnected player %d", match.turnIdx, disconnectedIdx)
	}
	if match.pausedRemain <= 0 || match.timer != nil {
		t.Fatal("turn timer was not paused for the disconnected player")
	}
	snapshot, ok := activeStore.get(match.GameID, match.ID)
	if !ok || snapshot.TurnIndex != disconnectedIdx || snapshot.PausedRemainMillis <= 0 || !snapshot.Disconnected[disconnectedIdx] {
		t.Fatalf("paused disconnected turn was not persisted: %+v", snapshot)
	}

	gameEngine.onTimeout(match.ID, match.turnIdx, match.turnGen)
	if match.over || gameEngine.matches[match.ID] == nil || emitter.count(currentID, protocol.S2CMatchOver) != 0 {
		t.Fatal("paused disconnected turn was incorrectly finished by timeout")
	}

	gameEngine.OnConnect(match.GameID, disconnectedID)
	if match.pausedRemain != 0 || match.timer == nil || len(match.disconnected) != 0 {
		t.Fatal("turn timer did not resume after the disconnected player returned")
	}
}

func TestStaleTurnTimerCallbackIsIgnoredAfterPauseAndResume(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(gameEngine)
	match := startPersistenceTestMatch(t, gameEngine)
	currentID := match.players[match.turnIdx].ID
	oldTurn := match.turnIdx
	oldGeneration := match.turnGen

	gameEngine.OnDisconnect(match.GameID, currentID)
	if match.turnGen == oldGeneration || match.pausedRemain <= 0 || match.timer != nil {
		t.Fatal("disconnect did not invalidate and pause the current timer")
	}
	gameEngine.OnConnect(match.GameID, currentID)
	resumedGeneration := match.turnGen
	if resumedGeneration == oldGeneration || match.timer == nil || match.pausedRemain != 0 {
		t.Fatal("reconnect did not arm a new timer generation")
	}

	gameEngine.onTimeout(match.ID, oldTurn, oldGeneration)
	if match.over || gameEngine.matches[match.ID] == nil || emitter.count(currentID, protocol.S2CMatchOver) != 0 {
		t.Fatal("stale pre-pause timer callback finished the resumed match")
	}

	gameEngine.onTimeout(match.ID, oldTurn, resumedGeneration)
	if !match.over || gameEngine.matches[match.ID] != nil {
		t.Fatal("current timer generation did not finish the timed-out match")
	}
	envelope, ok := emitter.last(currentID, protocol.S2CMatchOver)
	if !ok || envelope.Data.(protocol.MatchOverData).Reason != "timeout" {
		t.Fatal("current timer callback did not emit timeout result")
	}
}

func TestRestoreActiveMatchAndResumeAfterBothPlayersReconnect(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	firstEngine, _, _ := newPersistenceTestEngine(activeStore)
	match := startPersistenceTestMatch(t, firstEngine)
	firstPlayer := match.players[match.turnIdx].ID
	gameEngineID := match.GameID
	matchID := match.ID
	firstEngine.Move(gameEngineID, firstPlayer, matchID, json.RawMessage(`{"win":false}`))
	stopEngineTimers(firstEngine)

	secondEngine, _, emitter := newPersistenceTestEngine(activeStore)
	defer stopEngineTimers(secondEngine)
	restored := secondEngine.matches[matchID]
	if restored == nil {
		t.Fatal("active match was not restored")
	}
	if restored.state.(*persistenceTestState).MoveCount != 1 {
		t.Fatal("restored state does not match the saved snapshot")
	}
	if len(restored.disconnected) != 2 || restored.pausedRemain <= 0 || restored.graceTimer == nil {
		t.Fatal("restored match did not wait for both players to reconnect")
	}

	secondEngine.OnConnect(restored.GameID, restored.players[0].ID)
	if _, ok := emitter.last(restored.players[0].ID, protocol.S2COpponentDisconnected); !ok {
		t.Fatal("first returning player was not told that the opponent is disconnected")
	}
	if len(restored.disconnected) != 1 || restored.timer != nil {
		t.Fatal("turn timer resumed before both players reconnected")
	}

	secondEngine.OnConnect(restored.GameID, restored.players[1].ID)
	if len(restored.disconnected) != 0 || restored.timer == nil || restored.graceTimer != nil {
		t.Fatal("turn timer did not resume after both players reconnected")
	}
	if _, ok := emitter.last(restored.players[1].ID, protocol.S2CMatchFound); !ok {
		t.Fatal("returning player did not receive resumed MATCH_FOUND")
	}
}

func TestRestoreFinishedSnapshotMakesResultAvailableOnReconnect(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	state, _ := json.Marshal(&persistenceTestState{MoveCount: 3, Winner: 0})
	snapshot := ActiveMatchSnapshot{
		ID: "finished-match", GameID: persistenceTestGameID,
		Players: []protocol.PlayerInfo{{ID: "player-a", Name: "A"}, {ID: "player-b", Name: "B"}},
		State:   state, StateVersion: 1, Status: matchStatusFinished,
		WinnerID: "player-a", ResultReason: "win", Bet: 5,
	}
	if err := activeStore.Save(snapshot); err != nil {
		t.Fatal(err)
	}
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	if _, exists := activeStore.get(snapshot.GameID, snapshot.ID); exists {
		t.Fatal("finished tombstone was not removed after restore")
	}

	gameEngine.OnConnect(snapshot.GameID, "player-a")
	env, ok := emitter.last("player-a", protocol.S2CMatchOver)
	if !ok || env.Data.(protocol.MatchOverData).WinnerID != "player-a" {
		t.Fatal("finished result was not delivered after reconnect")
	}
}

func TestFinishedTombstoneSurvivesDeleteFailureAndIsRecovered(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, _ := newPersistenceTestEngine(activeStore)
	match := startPersistenceTestMatch(t, gameEngine)
	matchID := match.ID
	gameID := match.GameID
	winnerID := match.players[match.turnIdx].ID
	activeStore.failDelete = true

	gameEngine.Move(gameID, winnerID, matchID, json.RawMessage(`{"win":true}`))
	snapshot, exists := activeStore.get(gameID, matchID)
	if !exists || snapshot.Status != matchStatusFinished || snapshot.WinnerID != winnerID {
		t.Fatalf("finished tombstone was not retained: %+v", snapshot)
	}

	activeStore.failDelete = false
	restoredEngine, _, emitter := newPersistenceTestEngine(activeStore)
	if _, exists := activeStore.get(gameID, matchID); exists {
		t.Fatal("recovered finished tombstone was not deleted")
	}
	restoredEngine.OnConnect(gameID, winnerID)
	env, ok := emitter.last(winnerID, protocol.S2CMatchOver)
	if !ok || env.Data.(protocol.MatchOverData).WinnerID != winnerID {
		t.Fatal("recovered winner did not receive MATCH_OVER")
	}
}

func TestFinishPathsDeleteActiveSnapshot(t *testing.T) {
	tests := []struct {
		name       string
		finish     func(*Engine, *Match)
		reason     string
		winnerMode string
	}{
		{
			name: "winning move",
			finish: func(gameEngine *Engine, match *Match) {
				gameEngine.Move(match.GameID, match.players[match.turnIdx].ID, match.ID, json.RawMessage(`{"win":true}`))
			},
			reason: "win", winnerMode: "present",
		},
		{
			name: "draw",
			finish: func(gameEngine *Engine, match *Match) {
				gameEngine.Move(match.GameID, match.players[match.turnIdx].ID, match.ID, json.RawMessage(`{"draw":true}`))
			},
			reason: "draw", winnerMode: "empty",
		},
		{
			name: "forfeit",
			finish: func(gameEngine *Engine, match *Match) {
				gameEngine.Forfeit(match.GameID, match.players[0].ID, match.ID)
			},
			reason: "forfeit", winnerMode: "present",
		},
		{
			name: "timeout",
			finish: func(gameEngine *Engine, match *Match) {
				if match.timer != nil {
					match.timer.Stop()
				}
				gameEngine.onTimeout(match.ID, match.turnIdx, match.turnGen)
			},
			reason: "timeout", winnerMode: "present",
		},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			activeStore := newMemoryActiveMatchStore()
			gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
			match := startPersistenceTestMatch(t, gameEngine)
			matchID := match.ID
			players := append([]protocol.PlayerInfo(nil), match.players...)
			test.finish(gameEngine, match)

			if _, exists := activeStore.get(persistenceTestGameID, matchID); exists {
				t.Fatal("finished active snapshot was not deleted")
			}
			if gameEngine.matches[matchID] != nil {
				t.Fatal("finished match remained in memory")
			}
			env, ok := emitter.last(players[0].ID, protocol.S2CMatchOver)
			if !ok {
				t.Fatal("player did not receive MATCH_OVER")
			}
			result := env.Data.(protocol.MatchOverData)
			if result.Reason != test.reason {
				t.Fatalf("unexpected result reason: %s", result.Reason)
			}
			if test.winnerMode == "empty" && result.WinnerID != "" {
				t.Fatalf("draw unexpectedly has winner %s", result.WinnerID)
			}
			if test.winnerMode == "present" && result.WinnerID == "" {
				t.Fatal("finished match has no winner")
			}
		})
	}
}

func TestGraceExpiryHandlesOneOrBothDisconnectedPlayers(t *testing.T) {
	t.Run("one disconnected", func(t *testing.T) {
		activeStore := newMemoryActiveMatchStore()
		gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
		match := startPersistenceTestMatch(t, gameEngine)
		disconnectedID := match.players[0].ID
		winnerID := match.players[1].ID
		gameEngine.OnDisconnect(match.GameID, disconnectedID)
		if match.graceTimer != nil {
			match.graceTimer.Stop()
		}
		gameEngine.onGraceExpire(match.ID, match.graceGen)
		env, ok := emitter.last(winnerID, protocol.S2CMatchOver)
		if !ok || env.Data.(protocol.MatchOverData).WinnerID != winnerID {
			t.Fatal("connected player did not win after grace expiry")
		}
	})

	t.Run("both disconnected", func(t *testing.T) {
		activeStore := newMemoryActiveMatchStore()
		gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
		match := startPersistenceTestMatch(t, gameEngine)
		players := append([]protocol.PlayerInfo(nil), match.players...)
		gameEngine.OnDisconnect(match.GameID, players[0].ID)
		gameEngine.OnDisconnect(match.GameID, players[1].ID)
		if match.graceTimer != nil {
			match.graceTimer.Stop()
		}
		gameEngine.onGraceExpire(match.ID, match.graceGen)
		env, ok := emitter.last(players[0].ID, protocol.S2CMatchOver)
		if !ok || env.Data.(protocol.MatchOverData).WinnerID != "" {
			t.Fatal("both-disconnected match should finish without a winner")
		}
	})
}

func TestQueueAndRoomStartRecoverWhenRedisSaveFails(t *testing.T) {
	t.Run("queue players are requeued", func(t *testing.T) {
		activeStore := newMemoryActiveMatchStore()
		gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
		gameEngine.JoinQueue(persistenceTestGameID, protocol.PlayerInfo{ID: "player-a", Name: "A"})
		activeStore.failSave = true
		gameEngine.JoinQueue(persistenceTestGameID, protocol.PlayerInfo{ID: "player-b", Name: "B"})
		if len(gameEngine.queues[persistenceTestGameID]) != 2 {
			t.Fatal("players were not requeued after match persistence failure")
		}
		env, ok := emitter.last("player-b", protocol.S2CError)
		if !ok || env.Data.(protocol.ErrorData).Code != "MATCH_START_FAILED" {
			t.Fatal("queued player did not receive MATCH_START_FAILED")
		}
	})

	t.Run("room is restored", func(t *testing.T) {
		activeStore := newMemoryActiveMatchStore()
		gameEngine, rooms, emitter := newPersistenceTestEngine(activeStore)
		room := Room{
			ID: "room-1", GameID: persistenceTestGameID,
			OwnerID: "owner", OwnerName: "Owner", OwnerReady: true,
			GuestID: "guest", GuestName: "Guest", GuestReady: true,
		}
		if err := rooms.Save(room); err != nil {
			t.Fatal(err)
		}
		activeStore.failSave = true
		gameEngine.StartRoom(room.GameID, room.OwnerID, room.ID)
		if restored, exists := rooms.Get(room.GameID, room.ID); !exists || restored.GuestID != room.GuestID {
			t.Fatal("room was not restored after active match save failed")
		}
		env, ok := emitter.last(room.OwnerID, protocol.S2CError)
		if !ok || env.Data.(protocol.ErrorData).Code != "ROOM_START_FAILED" {
			t.Fatal("room owner did not receive ROOM_START_FAILED")
		}
		requireRoomUpsert(t, emitter, room.ID, 2)
	})
}

func TestRestoreSkipsUnsupportedOrMalformedSnapshots(t *testing.T) {
	tests := []struct {
		name     string
		snapshot ActiveMatchSnapshot
	}{
		{
			name: "unsupported version",
			snapshot: ActiveMatchSnapshot{
				ID: "bad-version", GameID: persistenceTestGameID,
				Players: []protocol.PlayerInfo{{ID: "a"}, {ID: "b"}},
				State:   json.RawMessage(`{"moveCount":0,"winner":-1}`), StateVersion: 99,
				Status: matchStatusPlaying,
			},
		},
		{
			name: "malformed state",
			snapshot: ActiveMatchSnapshot{
				ID: "bad-state", GameID: persistenceTestGameID,
				Players: []protocol.PlayerInfo{{ID: "a"}, {ID: "b"}},
				State:   json.RawMessage(`{"moveCount":`), StateVersion: 1,
				Status: matchStatusPlaying,
			},
		},
		{
			name: "invalid turn",
			snapshot: ActiveMatchSnapshot{
				ID: "bad-turn", GameID: persistenceTestGameID,
				Players: []protocol.PlayerInfo{{ID: "a"}, {ID: "b"}},
				State:   json.RawMessage(`{"moveCount":0,"winner":-1}`), StateVersion: 1,
				Status: matchStatusPlaying, TurnIndex: 2,
			},
		},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			activeStore := newMemoryActiveMatchStore()
			if err := activeStore.Save(test.snapshot); err != nil {
				t.Fatal(err)
			}
			gameEngine, _, _ := newPersistenceTestEngine(activeStore)
			if len(gameEngine.matches) != 0 || len(gameEngine.byUser) != 0 {
				t.Fatal("invalid snapshot was restored")
			}
		})
	}
}
