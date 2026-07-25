package engine

import (
	"context"
	"encoding/json"
	"sync"
	"testing"
	"time"

	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"

	"go.uber.org/zap"
)

type finalLifecycleStatusSwapStore struct {
	*memoryActiveMatchStore

	finished ActiveMatchSnapshot
	swapOnce sync.Once
	swapErr  error
}

func (s *finalLifecycleStatusSwapStore) DeleteIfStatus(
	gameID, matchID, status string,
	userIDs ...string,
) (bool, error) {
	s.swapOnce.Do(func() {
		s.swapErr = s.memoryActiveMatchStore.Save(s.finished)
	})
	if s.swapErr != nil {
		return false, s.swapErr
	}
	return s.memoryActiveMatchStore.DeleteIfStatus(gameID, matchID, status, userIDs...)
}

type finalLifecycleBlockingInitLogic struct {
	logic.GameLogic

	entered chan struct{}
	release chan struct{}
	once    sync.Once
}

func (l *finalLifecycleBlockingInitLogic) Init(seed int64) any {
	l.once.Do(func() { close(l.entered) })
	<-l.release
	return l.GameLogic.Init(seed)
}

type finalLifecycleDeleteSignalStore struct {
	*memoryActiveMatchStore

	deleted chan struct{}
	once    sync.Once
}

func (s *finalLifecycleDeleteSignalStore) DeleteIfStatus(
	gameID, matchID, status string,
	userIDs ...string,
) (bool, error) {
	deleted, err := s.memoryActiveMatchStore.DeleteIfStatus(
		gameID,
		matchID,
		status,
		userIDs...,
	)
	if err == nil && deleted {
		s.once.Do(func() { close(s.deleted) })
	}
	return deleted, err
}

type finalLifecycleBlockingAbortSettlement struct {
	*fakeSettlement

	entered chan struct{}
	release chan struct{}
	once    sync.Once
}

func (s *finalLifecycleBlockingAbortSettlement) AbortStart(
	ctx context.Context,
	matchID string,
) ([]SettledBalance, error) {
	s.once.Do(func() { close(s.entered) })
	select {
	case <-s.release:
	case <-ctx.Done():
		return nil, ctx.Err()
	}
	return s.fakeSettlement.AbortStart(ctx, matchID)
}

func waitForFinalLifecycleSignal(t *testing.T, signal <-chan struct{}, failure string) {
	t.Helper()
	select {
	case <-signal:
	case <-time.After(time.Second):
		t.Fatal(failure)
	}
}

func TestFinalLifecycleCorruptPlayingSnapshotAbortsBeforeEscrow(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	stale := recoveryPlayingSnapshot(
		"final-corrupt-playing",
		"final-corrupt-a",
		"final-corrupt-b",
		20,
	)
	current := stale
	// Keep the JSON syntactically valid so the memory store clones it, but make
	// it impossible for persistenceTestLogic to decode into its integer field.
	current.State = json.RawMessage(`{"moveCount":"not-an-integer","winner":-1}`)
	if err := activeStore.Save(current); err != nil {
		t.Fatal(err)
	}

	settlement := &fakeSettlement{}
	gameEngine := newSettlementTestEngine(activeStore, settlement)
	restored, retry := gameEngine.restorePlayingSnapshot(stale, stale.GameID)
	if restored || retry {
		t.Fatalf("corrupt restore returned restored=%v retry=%v", restored, retry)
	}

	escrowCalls, abortCalls, _, _ := settlement.counts()
	if escrowCalls != 0 {
		t.Fatalf("corrupt snapshot reached EscrowStart %d times", escrowCalls)
	}
	if abortCalls != 1 {
		t.Fatalf("corrupt snapshot reached AbortStart %d times, want 1", abortCalls)
	}
	if gameEngine.matchByID(stale.ID) != nil {
		t.Fatal("corrupt snapshot entered the live match registry")
	}
	if _, exists := activeStore.get(stale.GameID, stale.ID); exists {
		t.Fatal("corrupt snapshot remained after its successful abort")
	}
}

func TestFinalLifecycleStalePlayingDeleteCannotRemoveNewerFinishedSnapshot(t *testing.T) {
	playing := recoveryPlayingSnapshot(
		"final-status-cas",
		"final-status-a",
		"final-status-b",
		10,
	)
	finished := playing
	finished.Status = matchStatusFinished
	finished.WinnerID = finished.Players[0].ID
	finished.ResultReason = "win"
	finished.FinishedAt = time.Now().UnixMilli()

	activeStore := &finalLifecycleStatusSwapStore{
		memoryActiveMatchStore: newMemoryActiveMatchStore(),
		finished:               finished,
	}
	if err := activeStore.Save(playing); err != nil {
		t.Fatal(err)
	}
	gameEngine := NewEngine(
		zap.NewNop().Sugar(),
		30,
		30,
		newMemoryRoomStore(),
		activeStore,
	)

	if !gameEngine.deleteSnapshot(playing) {
		t.Fatal("status-mismatched cleanup was not safely handled")
	}
	current, exists := activeStore.get(finished.GameID, finished.ID)
	if !exists {
		t.Fatal("stale playing cleanup deleted the newer finished snapshot")
	}
	if current.Status != matchStatusFinished ||
		current.WinnerID != finished.WinnerID ||
		current.ResultReason != finished.ResultReason {
		t.Fatalf("newer finished snapshot was changed by stale cleanup: %+v", current)
	}
}

func TestFinalLifecycleStalePlayingCleanupDoesNotRestoreRoomAfterFinish(t *testing.T) {
	oldRoom := lifecycleRoom("final-stale-playing-room")
	oldRoom.OwnerID = "final-stale-room-owner"
	oldRoom.OwnerName = "FINAL STALE ROOM OWNER"
	oldRoom.GuestID = "final-stale-room-guest"
	oldRoom.GuestName = "FINAL STALE ROOM GUEST"
	oldRoom.GuestReady = true

	stalePlaying := recoveryPlayingSnapshot(
		"final-stale-room-match",
		oldRoom.OwnerID,
		oldRoom.GuestID,
		15,
	)
	stalePlaying.Room = &oldRoom
	finished := stalePlaying
	finished.Status = matchStatusFinished
	finished.Room = nil
	finished.WinnerID = finished.Players[0].ID
	finished.ResultReason = "win"
	finished.FinishedAt = time.Now().UnixMilli()

	activeStore := newMemoryActiveMatchStore()
	if err := activeStore.Save(finished); err != nil {
		t.Fatal(err)
	}
	rooms := newMemoryRoomStore()
	gameEngine := NewEngine(
		zap.NewNop().Sugar(),
		30,
		30,
		rooms,
		activeStore,
	)

	if !gameEngine.discardRestoredSnapshot(stalePlaying, nil) {
		t.Fatal("stale playing cleanup was not safely handled")
	}
	if _, exists := rooms.Get(oldRoom.GameID, oldRoom.ID); exists {
		t.Fatal("stale playing cleanup restored its old room after the match had finished")
	}
	if _, exists := rooms.RoomByUser(oldRoom.GameID, oldRoom.OwnerID); exists {
		t.Fatal("stale playing cleanup created an old owner room reference")
	}
	current, exists := activeStore.get(finished.GameID, finished.ID)
	if !exists || current.Status != matchStatusFinished {
		t.Fatalf("stale cleanup did not preserve the finished snapshot: %+v", current)
	}
}

func TestFinalLifecycleMatchStoreConditionalDeletePreservesFinishedSnapshotAndIndexes(t *testing.T) {
	store, redisServer, cache := newRedisMatchStoreTest(t)
	playing := redisStoreSnapshot("caro", "final-redis-status-cas")
	if err := store.Save(playing); err != nil {
		t.Fatal(err)
	}
	finished := playing
	finished.Status = matchStatusFinished
	finished.WinnerID = finished.Players[0].ID
	finished.ResultReason = "win"
	finished.FinishedAt = time.Now().UnixMilli()
	if err := store.Save(finished); err != nil {
		t.Fatal(err)
	}

	deleted, err := store.DeleteIfStatus(
		playing.GameID,
		playing.ID,
		matchStatusPlaying,
		playing.Players[0].ID,
		playing.Players[1].ID,
	)
	if err != nil {
		t.Fatal(err)
	}
	if deleted {
		t.Fatal("playing-status cleanup reported deleting a finished snapshot")
	}
	current, exists, err := store.Get(finished.GameID, finished.ID)
	if err != nil {
		t.Fatal(err)
	}
	if !exists || current.Status != matchStatusFinished {
		t.Fatalf("conditional delete did not preserve finished state: %+v", current)
	}

	matchKey := "GAME:caro:MATCH:" + finished.ID
	setKey := "GAME:caro:ACTIVE_MATCHES"
	if !redisServer.Exists(matchKey) {
		t.Fatal("conditional delete removed the finished match key")
	}
	member, err := redisServer.SIsMember(setKey, finished.ID)
	if err != nil || !member {
		t.Fatal("conditional delete removed the finished active-set member")
	}
	for _, player := range finished.Players {
		key := "GAME:caro:USERMATCH:" + player.ID
		matchID, err := cache.GetClient().Get(cache.GetContext(), key).Result()
		if err != nil || matchID != finished.ID {
			t.Fatalf("conditional delete changed %s to %q: %v", key, matchID, err)
		}
	}
}

func TestFinalLifecycleQueueCancellationAfterReservationPreventsInstall(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	settlement := &fakeSettlement{}
	gameEngine := newSettlementTestEngine(activeStore, settlement)
	player := protocol.PlayerInfo{ID: "final-cancelled-player"}
	opponent := protocol.PlayerInfo{ID: "final-cancelled-opponent"}
	keys := []string{
		userKey(persistenceTestGameID, player.ID),
		userKey(persistenceTestGameID, opponent.ID),
	}

	gameEngine.queueMu.Lock()
	for _, key := range keys {
		gameEngine.queuePending[key] = true
	}
	gameEngine.queueMu.Unlock()
	defer func() {
		gameEngine.queueMu.Lock()
		for _, key := range keys {
			delete(gameEngine.queuePending, key)
			delete(gameEngine.queueCancelled, key)
		}
		gameEngine.queueMu.Unlock()
	}()

	releasePlayers, err := gameEngine.reserveQueuedMatch(
		persistenceTestGameID,
		player,
		opponent,
	)
	if err != nil {
		t.Fatalf("reserve queue players: %v", err)
	}
	defer releasePlayers()

	gameLogic, err := logic.Get(persistenceTestGameID)
	if err != nil {
		t.Fatal(err)
	}
	initRelease := make(chan struct{})
	var releaseInit sync.Once
	defer releaseInit.Do(func() { close(initRelease) })
	blockingLogic := &finalLifecycleBlockingInitLogic{
		GameLogic: gameLogic,
		entered:   make(chan struct{}),
		release:   initRelease,
	}
	startDone := make(chan error, 1)
	go func() {
		startDone <- gameEngine.startReservedQueueMatch(
			persistenceTestGameID,
			blockingLogic,
			player,
			opponent,
			keys...,
		)
	}()

	waitForFinalLifecycleSignal(
		t,
		blockingLogic.entered,
		"reserved queue start did not reach the pre-install boundary",
	)
	gameEngine.LeaveQueue(persistenceTestGameID, player.ID)
	gameEngine.queueMu.Lock()
	cancelled := gameEngine.queueCancelled[keys[0]]
	gameEngine.queueMu.Unlock()
	if !cancelled {
		t.Fatal("queue cancellation was not recorded after reservation")
	}

	releaseInit.Do(func() { close(initRelease) })
	select {
	case err = <-startDone:
	case <-time.After(time.Second):
		t.Fatal("cancelled reserved queue start did not return")
	}
	if err == nil {
		t.Fatal("queue start succeeded after cancellation won the install boundary")
	}
	if gameEngine.matchForUser(persistenceTestGameID, player.ID) != nil ||
		gameEngine.matchForUser(persistenceTestGameID, opponent.ID) != nil {
		t.Fatal("cancelled queue pair entered the live match registry")
	}
	snapshots, err := activeStore.List(persistenceTestGameID)
	if err != nil {
		t.Fatal(err)
	}
	if len(snapshots) != 0 {
		t.Fatalf("cancelled queue pair persisted %d active snapshots", len(snapshots))
	}
	escrowCalls, _, _, _ := settlement.counts()
	if escrowCalls != 0 {
		t.Fatalf("cancelled queue pair reached EscrowStart %d times", escrowCalls)
	}
}

func TestFinalLifecycleSuccessfulAbortRestoresRoomWithoutOverwritingNewerState(t *testing.T) {
	run := func(t *testing.T, installNewerRoom bool) {
		t.Helper()
		oldRoom := lifecycleRoom("final-aborted-old-room")
		oldRoom.OwnerID = "final-aborted-owner"
		oldRoom.OwnerName = "FINAL ABORTED OWNER"
		oldRoom.GuestID = "final-aborted-old-guest"
		oldRoom.GuestName = "FINAL ABORTED OLD GUEST"
		oldRoom.GuestReady = true
		snapshot := recoveryPlayingSnapshot(
			"final-aborted-room-match",
			oldRoom.OwnerID,
			oldRoom.GuestID,
			25,
		)
		snapshot.Status = matchStatusAborting
		snapshot.Room = &oldRoom

		activeStore := &finalLifecycleDeleteSignalStore{
			memoryActiveMatchStore: newMemoryActiveMatchStore(),
			deleted:                make(chan struct{}),
		}
		if err := activeStore.Save(snapshot); err != nil {
			t.Fatal(err)
		}
		rooms := newMemoryRoomStore()
		settlement := &finalLifecycleBlockingAbortSettlement{
			fakeSettlement: &fakeSettlement{},
			entered:        make(chan struct{}),
			release:        make(chan struct{}),
		}
		var releaseAbort sync.Once
		defer releaseAbort.Do(func() { close(settlement.release) })
		gameEngine := NewEngine(
			zap.NewNop().Sugar(),
			30,
			30,
			rooms,
			activeStore,
		)
		gameEngine.SetSettlement(settlement)
		gameEngine.queueAbortSettlement(snapshot)

		waitForFinalLifecycleSignal(
			t,
			settlement.entered,
			"aborting snapshot did not reach AbortStart",
		)

		var newerRoom Room
		if installNewerRoom {
			newerRoom = lifecycleRoom("final-newer-room")
			newerRoom.OwnerID = oldRoom.OwnerID
			newerRoom.OwnerName = "FINAL NEWER OWNER STATE"
			newerRoom.GuestID = "final-newer-guest"
			newerRoom.GuestName = "FINAL NEWER GUEST"
			newerRoom.Password = "newer-password"
			if err := rooms.Save(newerRoom); err != nil {
				t.Fatal(err)
			}
		}

		releaseAbort.Do(func() { close(settlement.release) })
		waitForFinalLifecycleSignal(
			t,
			activeStore.deleted,
			"successfully aborted snapshot was not cleaned up",
		)
		_, abortCalls, _, _ := settlement.counts()
		if abortCalls != 1 {
			t.Fatalf("AbortStart calls = %d, want 1", abortCalls)
		}
		if _, exists := activeStore.get(snapshot.GameID, snapshot.ID); exists {
			t.Fatal("successfully aborted snapshot remained durable")
		}

		if installNewerRoom {
			allRooms, err := rooms.List(oldRoom.GameID)
			if err != nil {
				t.Fatal(err)
			}
			if len(allRooms) != 1 || allRooms[0].ID != newerRoom.ID ||
				allRooms[0].Password != newerRoom.Password {
				t.Fatalf("old room snapshot overwrote newer room state: %+v", allRooms)
			}
			if _, exists := rooms.Get(oldRoom.GameID, oldRoom.ID); exists {
				t.Fatal("old room snapshot was resurrected alongside the newer room")
			}
			ref, exists := rooms.RoomByUser(newerRoom.GameID, newerRoom.OwnerID)
			if !exists || ref.RoomID != newerRoom.ID {
				t.Fatalf("newer room membership was overwritten: %+v", ref)
			}
			return
		}

		restored, exists := rooms.Get(oldRoom.GameID, oldRoom.ID)
		if !exists ||
			restored.OwnerID != oldRoom.OwnerID ||
			restored.GuestID != oldRoom.GuestID {
			t.Fatalf("old room was not restored after successful abort: %+v", restored)
		}
		if restored.GuestReady {
			t.Fatal("restored room retained stale ready state")
		}
		for _, userID := range []string{oldRoom.OwnerID, oldRoom.GuestID} {
			ref, exists := rooms.RoomByUser(oldRoom.GameID, userID)
			if !exists || ref.RoomID != oldRoom.ID {
				t.Fatalf("%s does not reference the restored room: %+v", userID, ref)
			}
		}
	}

	t.Run("restores old room when no newer state exists", func(t *testing.T) {
		run(t, false)
	})
	t.Run("preserves room committed while abort is in flight", func(t *testing.T) {
		run(t, true)
	})
}
