package engine

import (
	"encoding/json"
	"sync"
	"testing"
	"time"

	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"

	"go.uber.org/zap"
)

type staleSnapshotListStore struct {
	*memoryActiveMatchStore

	mu        sync.Mutex
	armed     bool
	entered   chan struct{}
	release   chan struct{}
	enterOnce sync.Once
}

func newStaleSnapshotListStore() *staleSnapshotListStore {
	return &staleSnapshotListStore{
		memoryActiveMatchStore: newMemoryActiveMatchStore(),
		entered:                make(chan struct{}),
		release:                make(chan struct{}),
	}
}

func (s *staleSnapshotListStore) arm() {
	s.mu.Lock()
	s.armed = true
	s.mu.Unlock()
}

func (s *staleSnapshotListStore) List(gameID string) ([]ActiveMatchSnapshot, error) {
	snapshots, err := s.memoryActiveMatchStore.List(gameID)
	s.mu.Lock()
	block := s.armed && gameID == persistenceTestGameID
	s.mu.Unlock()
	if block {
		s.enterOnce.Do(func() { close(s.entered) })
		<-s.release
	}
	return snapshots, err
}

func TestStalePlayingListCannotResurrectLocallyFinishedMatch(t *testing.T) {
	activeStore := newStaleSnapshotListStore()
	settlement := &fakeSettlement{
		// Keep the old playing Redis snapshot after the deliberately failed
		// terminal Save. This proves the local terminal marker closes the gap
		// that a post-list Get alone cannot close.
		settleErrors: []error{ErrSettlementConflict},
	}
	gameEngine := newSettlementTestEngine(activeStore, settlement)
	gameLogic, err := logic.Get(persistenceTestGameID)
	if err != nil {
		t.Fatal(err)
	}
	if err := gameEngine.startMatch(
		persistenceTestGameID,
		gameLogic,
		registeredTestPlayer("stale-finish-a"),
		registeredTestPlayer("stale-finish-b"),
		10,
	); err != nil {
		t.Fatal(err)
	}
	match := gameEngine.matchForUser(persistenceTestGameID, "stale-finish-a")
	if match == nil {
		t.Fatal("match was not installed")
	}

	activeStore.arm()
	reconcileDone := make(chan struct{})
	go func() {
		defer close(reconcileDone)
		gameEngine.reconcileSettlement()
	}()
	select {
	case <-activeStore.entered:
	case <-time.After(time.Second):
		t.Fatal("reconcile did not capture the playing snapshot")
	}

	activeStore.memoryActiveMatchStore.mu.Lock()
	activeStore.memoryActiveMatchStore.failSave = true
	activeStore.memoryActiveMatchStore.mu.Unlock()
	gameEngine.Move(
		match.GameID,
		match.players[match.turnIdx].ID,
		match.ID,
		json.RawMessage(`{"win":true}`),
	)
	if gameEngine.matchByID(match.ID) != nil {
		t.Fatal("finished match remained in the live registry")
	}

	close(activeStore.release)
	select {
	case <-reconcileDone:
	case <-time.After(time.Second):
		t.Fatal("reconcile did not finish")
	}
	if gameEngine.matchByID(match.ID) != nil {
		t.Fatal("stale playing snapshot resurrected a locally finished match")
	}
	snapshot, exists := activeStore.get(match.GameID, match.ID)
	if !exists || snapshot.Status != matchStatusPlaying {
		t.Fatalf("test did not retain the intended stale playing snapshot: %+v", snapshot)
	}
}

func TestRestoreRetryAbortsWhenPlayerAlreadyCommittedToRoom(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	state, _ := json.Marshal(&persistenceTestState{Winner: -1})
	snapshot := ActiveMatchSnapshot{
		ID: "room-conflicting-restore", GameID: persistenceTestGameID,
		Players: []protocol.PlayerInfo{
			{ID: "room-conflict-a"},
			{ID: "room-conflict-b"},
		},
		State:        state,
		StateVersion: 1,
		Status:       matchStatusPlaying,
		TurnIndex:    0,
		TurnDeadline: time.Now().Add(time.Minute).UnixMilli(),
		StartedAt:    time.Now().UnixMilli(),
		Bet:          15,
	}
	if err := activeStore.Save(snapshot); err != nil {
		t.Fatal(err)
	}
	rooms := newMemoryRoomStore()
	room := lifecycleRoom("newer-room")
	room.OwnerID = snapshot.Players[0].ID
	room.OwnerName = "ROOM OWNER"
	if err := rooms.Save(room); err != nil {
		t.Fatal(err)
	}
	settlement := &fakeSettlement{}
	gameEngine := NewEngine(zap.NewNop().Sugar(), 30, 30, rooms, activeStore)
	gameEngine.SetSettlement(settlement)

	restored, retry := gameEngine.restorePlayingSnapshot(snapshot, snapshot.GameID)
	if restored || retry {
		t.Fatalf("room-conflicting restore returned restored=%v retry=%v", restored, retry)
	}
	if gameEngine.matchByID(snapshot.ID) != nil {
		t.Fatal("restore installed a match for a player already in a room")
	}
	if _, exists := activeStore.get(snapshot.GameID, snapshot.ID); exists {
		t.Fatal("room-conflicting recovery snapshot was not deleted after abort")
	}
	_, abortCalls, _, _ := settlement.counts()
	if abortCalls != 1 {
		t.Fatalf("AbortStart calls = %d, want 1", abortCalls)
	}
	ref, exists := rooms.RoomByUser(room.GameID, room.OwnerID)
	if !exists || ref.RoomID != room.ID {
		t.Fatalf("restore disturbed the newer room membership: %+v", ref)
	}
}

func TestStalePlayingCleanupCannotDeleteNewerFinishedSnapshot(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	finished := recoveryPlayingSnapshot("status-cas", "status-a", "status-b", 10)
	finished.Status = matchStatusFinished
	finished.WinnerID = finished.Players[0].ID
	finished.ResultReason = "win"
	finished.FinishedAt = time.Now().UnixMilli()
	if err := activeStore.Save(finished); err != nil {
		t.Fatal(err)
	}
	gameEngine := NewEngine(zap.NewNop().Sugar(), 30, 30, newMemoryRoomStore(), activeStore)

	stalePlaying := finished
	stalePlaying.Status = matchStatusPlaying
	if !gameEngine.deleteSnapshot(stalePlaying) {
		t.Fatal("status mismatch should be treated as a safely handled cleanup")
	}
	current, exists := activeStore.get(finished.GameID, finished.ID)
	if !exists || current.Status != matchStatusFinished {
		t.Fatalf("stale playing cleanup deleted newer finished outcome: %+v", current)
	}
}

func TestClosedEscrowCleanupSkipsRoomWhenLiveMatchAlreadyFinished(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	rooms := newMemoryRoomStore()
	oldRoom := lifecycleRoom("already-over-old-room")
	oldRoom.GuestID = "already-over-guest"
	oldRoom.GuestName = "OLD GUEST"
	oldRoom.GuestReady = true
	stalePlaying := recoveryPlayingSnapshot(
		"already-over-match",
		oldRoom.OwnerID,
		oldRoom.GuestID,
		10,
	)
	stalePlaying.Room = &oldRoom

	finished := stalePlaying
	finished.Status = matchStatusFinished
	finished.WinnerID = finished.Players[0].ID
	finished.ResultReason = "win"
	finished.FinishedAt = time.Now().UnixMilli()
	if err := activeStore.Save(finished); err != nil {
		t.Fatal(err)
	}
	newRoom := lifecycleRoom("already-over-new-room")
	newRoom.OwnerID = oldRoom.OwnerID
	if err := rooms.Save(newRoom); err != nil {
		t.Fatal(err)
	}
	gameEngine := NewEngine(zap.NewNop().Sugar(), 30, 30, rooms, activeStore)
	alreadyFinished := &Match{ID: finished.ID, GameID: finished.GameID, over: true}

	if !gameEngine.discardRestoredSnapshot(stalePlaying, alreadyFinished) {
		t.Fatal("already-finished cleanup was not treated as handled")
	}
	current, exists := activeStore.get(finished.GameID, finished.ID)
	if !exists || current.Status != matchStatusFinished {
		t.Fatalf("closed-escrow cleanup removed terminal snapshot: %+v", current)
	}
	allRooms, err := rooms.List(newRoom.GameID)
	if err != nil {
		t.Fatal(err)
	}
	if len(allRooms) != 1 || allRooms[0].ID != newRoom.ID {
		t.Fatalf("old playing room overwrote finished canonical room: %+v", allRooms)
	}
}

func TestClosedSnapshotCleanupDoesNotOverwriteNewerRoom(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	rooms := newMemoryRoomStore()
	oldRoom := lifecycleRoom("old-snapshot-room")
	oldRoom.GuestID = "old-guest"
	oldRoom.GuestName = "OLD GUEST"
	oldRoom.GuestReady = true
	snapshot := recoveryPlayingSnapshot(
		"closed-old-room",
		oldRoom.OwnerID,
		oldRoom.GuestID,
		15,
	)
	snapshot.Room = &oldRoom
	if err := activeStore.Save(snapshot); err != nil {
		t.Fatal(err)
	}

	newRoom := lifecycleRoom("new-canonical-room")
	newRoom.OwnerID = oldRoom.OwnerID
	newRoom.OwnerName = oldRoom.OwnerName
	if err := rooms.Save(newRoom); err != nil {
		t.Fatal(err)
	}
	gameEngine := NewEngine(zap.NewNop().Sugar(), 30, 30, rooms, activeStore)

	if !gameEngine.discardRestoredSnapshot(snapshot, nil) {
		t.Fatal("closed snapshot cleanup did not complete")
	}
	allRooms, err := rooms.List(snapshot.GameID)
	if err != nil {
		t.Fatal(err)
	}
	if len(allRooms) != 1 || allRooms[0].ID != newRoom.ID {
		t.Fatalf("closed snapshot resurrected its stale room: %+v", allRooms)
	}
	ref, exists := rooms.RoomByUser(newRoom.GameID, newRoom.OwnerID)
	if !exists || ref.RoomID != newRoom.ID {
		t.Fatalf("stale room cleanup overwrote newer room ref: %+v", ref)
	}
	if _, exists := activeStore.get(snapshot.GameID, snapshot.ID); exists {
		t.Fatal("closed stale snapshot was not deleted")
	}
}

func TestAbortingSnapshotRestoresRoomBeforeDeletion(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	rooms := newMemoryRoomStore()
	room := lifecycleRoom("aborting-room")
	room.GuestID = "aborting-guest"
	room.GuestName = "ABORTING GUEST"
	room.GuestReady = true
	snapshot := recoveryPlayingSnapshot(
		"aborting-room-match",
		room.OwnerID,
		room.GuestID,
		20,
	)
	snapshot.Status = matchStatusAborting
	snapshot.Room = &room
	if err := activeStore.Save(snapshot); err != nil {
		t.Fatal(err)
	}
	settlement := &fakeSettlement{}
	gameEngine := NewEngine(zap.NewNop().Sugar(), 30, 30, rooms, activeStore)
	gameEngine.SetSettlement(settlement)
	gameEngine.queueAbortSettlement(snapshot)

	waitForCondition(t, time.Second, "aborted snapshot was not deleted", func() bool {
		_, exists := activeStore.get(snapshot.GameID, snapshot.ID)
		return !exists
	})
	restored, exists := rooms.Get(room.GameID, room.ID)
	if !exists || restored.OwnerID != room.OwnerID || restored.GuestID != room.GuestID {
		t.Fatalf("aborted room was not restored before snapshot deletion: %+v", restored)
	}
	if restored.GuestReady {
		t.Fatal("restored aborted room retained stale readiness")
	}
	for _, userID := range []string{room.OwnerID, room.GuestID} {
		ref, exists := rooms.RoomByUser(room.GameID, userID)
		if !exists || ref.RoomID != room.ID {
			t.Fatalf("%s does not reference restored aborted room: %+v", userID, ref)
		}
	}
}
