package engine

import (
	"errors"
	"sync"
	"testing"
	"time"

	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"

	"go.uber.org/zap"
)

type roomTransitionSettlement struct {
	*fakeSettlement

	balanceUser    string
	balanceEntered chan struct{}
	balanceRelease chan struct{}
	balanceOnce    sync.Once
}

func (s *roomTransitionSettlement) Balance(userID string) (int, bool) {
	if userID == s.balanceUser {
		if s.balanceEntered != nil {
			s.balanceOnce.Do(func() { close(s.balanceEntered) })
		}
		if s.balanceRelease != nil {
			<-s.balanceRelease
		}
	}
	return MaxBet, true
}

func newRoomTransitionTestEngine(
	settlement Settlement,
) (*Engine, *memoryRoomStore, *captureEmitter) {
	rooms := newMemoryRoomStore()
	emitter := &captureEmitter{}
	gameEngine := NewEngine(
		zap.NewNop().Sugar(),
		300,
		30,
		rooms,
		newMemoryActiveMatchStore(),
	)
	gameEngine.SetSettlement(settlement)
	gameEngine.SetEmitter(emitter)
	return gameEngine, rooms, emitter
}

func waitForRoomTransitionSignal(t *testing.T, signal <-chan struct{}, failure string) {
	t.Helper()
	select {
	case <-signal:
	case <-time.After(time.Second):
		t.Fatal(failure)
	}
}

func waitForRoomTransitionDone(t *testing.T, done <-chan struct{}, failure string) {
	t.Helper()
	select {
	case <-done:
	case <-time.After(time.Second):
		t.Fatal(failure)
	}
}

func TestJoinRoomDoesNotCommitAfterJoinerGetsQueueMatch(t *testing.T) {
	settlement := &roomTransitionSettlement{
		fakeSettlement: &fakeSettlement{},
		balanceUser:    "joining-player",
		balanceEntered: make(chan struct{}),
		balanceRelease: make(chan struct{}),
	}
	var releaseBalance sync.Once
	defer releaseBalance.Do(func() { close(settlement.balanceRelease) })

	gameEngine, rooms, _ := newRoomTransitionTestEngine(settlement)
	defer stopEngineTimers(gameEngine)

	room := lifecycleRoom("balance-room")
	if err := rooms.Save(room); err != nil {
		t.Fatal(err)
	}
	gameEngine.JoinQueue(
		persistenceTestGameID,
		protocol.PlayerInfo{ID: "queue-opponent", Name: "Queue Opponent"},
	)

	joinDone := make(chan struct{})
	go func() {
		defer close(joinDone)
		gameEngine.JoinRoom(
			persistenceTestGameID,
			protocol.PlayerInfo{ID: "joining-player", Name: "Joining Player"},
			room.ID,
			"",
		)
	}()
	waitForRoomTransitionSignal(
		t,
		settlement.balanceEntered,
		"JoinRoom did not block in its balance check",
	)

	// The room transition has released roomMu while checking the balance. The
	// same user is therefore able to complete an unrelated queue match first.
	gameEngine.JoinQueue(
		persistenceTestGameID,
		protocol.PlayerInfo{ID: "joining-player", Name: "Joining Player"},
	)
	queueMatch := gameEngine.matchForUser(persistenceTestGameID, "joining-player")
	if queueMatch == nil ||
		gameEngine.matchForUser(persistenceTestGameID, "queue-opponent") != queueMatch {
		t.Fatal("joining player did not enter the expected queue match")
	}

	releaseBalance.Do(func() { close(settlement.balanceRelease) })
	waitForRoomTransitionDone(t, joinDone, "JoinRoom did not return after balance release")

	storedRoom, exists := rooms.Get(room.GameID, room.ID)
	if !exists {
		t.Fatal("the owner's waiting room was unexpectedly removed")
	}
	if storedRoom.GuestID != "" {
		t.Fatalf(
			"JoinRoom committed after the joiner entered a match; guest = %q",
			storedRoom.GuestID,
		)
	}
	if ref, exists := rooms.RoomByUser(room.GameID, "joining-player"); exists {
		t.Fatalf("matched joiner also has room membership %+v", ref)
	}

	gameEngine.mu.RLock()
	matchCount := len(gameEngine.matches)
	userMatchCount := len(gameEngine.byUser)
	gameEngine.mu.RUnlock()
	if matchCount != 1 || userMatchCount != 2 {
		t.Fatalf(
			"expected only the queue match to remain, got %d matches and %d user refs",
			matchCount,
			userMatchCount,
		)
	}
	if gameEngine.matchForUser(room.GameID, room.OwnerID) != nil {
		t.Fatal("waiting-room owner was incorrectly attached to the queue match")
	}
}

func TestDelayedQueueStartCannotInstallAfterRoomCommit(t *testing.T) {
	gameEngine, rooms, _ := newRoomTransitionTestEngine(&fakeSettlement{})
	player := lifecyclePlayer("delayed-queue-player")
	opponent := lifecyclePlayer("delayed-queue-opponent")
	gameEngine.CreateRoom(persistenceTestGameID, player, 0, "")

	ref, exists := rooms.RoomByUser(persistenceTestGameID, player.ID)
	if !exists {
		t.Fatal("room transition did not commit")
	}

	// Model a queue pair that was selected just before CreateRoom committed but
	// whose start goroutine did not run until after the room reservation ended.
	gameEngine.queueMu.Lock()
	gameEngine.queuePending[userKey(persistenceTestGameID, player.ID)] = true
	gameEngine.queuePending[userKey(persistenceTestGameID, opponent.ID)] = true
	gameEngine.queueMu.Unlock()

	release, err := gameEngine.reserveQueuedMatch(persistenceTestGameID, player, opponent)
	if release != nil {
		release()
	}
	if err == nil {
		t.Fatal("delayed queue start reserved players after room commit")
	}
	if gameEngine.matchForUser(persistenceTestGameID, player.ID) != nil {
		t.Fatal("delayed queue start installed a match for a room member")
	}
	currentRef, exists := rooms.RoomByUser(persistenceTestGameID, player.ID)
	if !exists || currentRef.RoomID != ref.RoomID {
		t.Fatalf("delayed queue start disturbed committed room ref: %+v", currentRef)
	}
	gameEngine.queueMu.Lock()
	cancelled := gameEngine.queueCancelled[userKey(persistenceTestGameID, player.ID)]
	delete(gameEngine.queuePending, userKey(persistenceTestGameID, player.ID))
	delete(gameEngine.queuePending, userKey(persistenceTestGameID, opponent.ID))
	delete(gameEngine.queueCancelled, userKey(persistenceTestGameID, player.ID))
	gameEngine.queueMu.Unlock()
	if !cancelled {
		t.Fatal("room member's delayed queue entry was not cancelled")
	}
}

func TestReservedQueueStartRechecksCancellationBeforeInstall(t *testing.T) {
	settlement := &fakeSettlement{}
	gameEngine, _, _ := newRoomTransitionTestEngine(settlement)
	player := lifecyclePlayer("cancelled-reserved-player")
	opponent := lifecyclePlayer("cancelled-reserved-opponent")
	keys := []string{
		userKey(persistenceTestGameID, player.ID),
		userKey(persistenceTestGameID, opponent.ID),
	}
	release, reserved := gameEngine.reserveRoomUsers(
		persistenceTestGameID,
		player.ID,
		opponent.ID,
	)
	if !reserved {
		t.Fatal("could not reserve queue players for test")
	}
	defer release()

	gameEngine.queueMu.Lock()
	for _, key := range keys {
		gameEngine.queuePending[key] = true
	}
	gameEngine.queueCancelled[keys[0]] = true
	gameEngine.queueMu.Unlock()

	gameLogic, err := logic.Get(persistenceTestGameID)
	if err != nil {
		t.Fatal(err)
	}
	err = gameEngine.startReservedQueueMatch(
		persistenceTestGameID,
		gameLogic,
		player,
		opponent,
		keys...,
	)
	if err == nil {
		t.Fatal("cancelled reserved queue start installed a match")
	}
	if gameEngine.matchForUser(persistenceTestGameID, player.ID) != nil ||
		gameEngine.matchForUser(persistenceTestGameID, opponent.ID) != nil {
		t.Fatal("cancelled queue pair entered live registry")
	}
	escrowCalls, _, _, _ := settlement.counts()
	if escrowCalls != 0 {
		t.Fatalf("cancelled queue pair opened escrow %d times", escrowCalls)
	}

	gameEngine.queueMu.Lock()
	for _, key := range keys {
		delete(gameEngine.queuePending, key)
		delete(gameEngine.queueCancelled, key)
	}
	gameEngine.queueMu.Unlock()
}

func TestFailedRoomStartRestoresOnlyWhileBothPlayersRemainEligible(t *testing.T) {
	t.Run("restores unchanged room when neither player transitions", func(t *testing.T) {
		settlement := &fakeSettlement{
			escrowEntered: make(chan struct{}),
			escrowRelease: make(chan struct{}),
			escrowErr:     errors.New("escrow unavailable"),
		}
		var releaseEscrow sync.Once
		defer releaseEscrow.Do(func() { close(settlement.escrowRelease) })

		gameEngine, rooms, _ := newRoomTransitionTestEngine(settlement)
		room := lifecycleRoom("unchanged-room")
		room.GuestID = "guest"
		room.GuestName = "GUEST"
		room.GuestReady = true
		if err := rooms.Save(room); err != nil {
			t.Fatal(err)
		}

		startDone := make(chan struct{})
		go func() {
			defer close(startDone)
			gameEngine.StartRoom(room.GameID, room.OwnerID, room.ID)
		}()
		waitForRoomTransitionSignal(
			t,
			settlement.escrowEntered,
			"StartRoom did not block while recording escrow",
		)
		releaseEscrow.Do(func() { close(settlement.escrowRelease) })
		waitForRoomTransitionDone(t, startDone, "StartRoom did not return after escrow failure")

		restored, exists := rooms.Get(room.GameID, room.ID)
		if !exists || restored.OwnerID != room.OwnerID ||
			restored.GuestID != room.GuestID || !restored.GuestReady {
			t.Fatalf("eligible room was not restored unchanged: %+v", restored)
		}
		for _, userID := range []string{room.OwnerID, room.GuestID} {
			ref, exists := rooms.RoomByUser(room.GameID, userID)
			if !exists || ref.RoomID != room.ID {
				t.Fatalf("%s does not reference restored room %q: %+v", userID, room.ID, ref)
			}
		}
	})

	t.Run("serializes a competing owner room transition", func(t *testing.T) {
		settlement := &roomTransitionSettlement{
			fakeSettlement: &fakeSettlement{
				escrowEntered: make(chan struct{}),
				escrowRelease: make(chan struct{}),
				escrowErr:     errors.New("escrow unavailable"),
			},
			balanceUser:    "owner",
			balanceEntered: make(chan struct{}),
			balanceRelease: make(chan struct{}),
		}
		var releaseBalance sync.Once
		var releaseEscrow sync.Once
		defer releaseBalance.Do(func() { close(settlement.balanceRelease) })
		defer releaseEscrow.Do(func() { close(settlement.escrowRelease) })

		gameEngine, rooms, _ := newRoomTransitionTestEngine(settlement)
		room := lifecycleRoom("old-room")
		room.GuestID = "guest"
		room.GuestName = "GUEST"
		room.GuestReady = true
		if err := rooms.Save(room); err != nil {
			t.Fatal(err)
		}

		// Let CreateRoom pass its first active-match check, then hold it in the
		// remote balance lookup until StartRoom has removed the old room and
		// installed its provisional match.
		createDone := make(chan struct{})
		go func() {
			defer close(createDone)
			gameEngine.CreateRoom(
				room.GameID,
				lifecyclePlayer(room.OwnerID),
				7,
				"new-password",
			)
		}()
		waitForRoomTransitionSignal(
			t,
			settlement.balanceEntered,
			"competing CreateRoom did not block in its balance check",
		)

		startDone := make(chan struct{})
		go func() {
			defer close(startDone)
			gameEngine.StartRoom(room.GameID, room.OwnerID, room.ID)
		}()
		waitForRoomTransitionSignal(
			t,
			settlement.escrowEntered,
			"StartRoom did not block while recording escrow",
		)

		releaseBalance.Do(func() { close(settlement.balanceRelease) })
		waitForCondition(
			t,
			time.Second,
			"competing CreateRoom did not acquire roomMu",
			func() bool {
				if gameEngine.roomMu.TryLock() {
					gameEngine.roomMu.Unlock()
					return false
				}
				return true
			},
		)

		// CreateRoom now owns roomMu and is waiting for the provisional match
		// to resolve. The room-start reservation must prevent it from committing
		// a second room in the failure window.
		releaseEscrow.Do(func() { close(settlement.escrowRelease) })
		waitForRoomTransitionDone(t, createDone, "competing CreateRoom did not finish")
		waitForRoomTransitionDone(t, startDone, "failed StartRoom did not finish")

		allRooms, err := rooms.List(room.GameID)
		if err != nil {
			t.Fatal(err)
		}
		if len(allRooms) != 1 {
			t.Fatalf(
				"failed StartRoom restored stale room alongside the replacement: %+v",
				allRooms,
			)
		}
		restored := allRooms[0]
		if restored.ID != room.ID || restored.OwnerID != room.OwnerID ||
			restored.GuestID != room.GuestID || !restored.GuestReady {
			t.Fatalf("unexpected room after serialized failed start: %+v", restored)
		}
		ownerRef, exists := rooms.RoomByUser(room.GameID, room.OwnerID)
		if !exists || ownerRef.RoomID != room.ID {
			t.Fatalf("owner does not reference the restored room: %+v", ownerRef)
		}
		guestRef, exists := rooms.RoomByUser(room.GameID, room.GuestID)
		if !exists || guestRef.RoomID != room.ID {
			t.Fatalf("guest does not reference the restored room: %+v", guestRef)
		}

		gameEngine.mu.RLock()
		matchCount := len(gameEngine.matches)
		userMatchCount := len(gameEngine.byUser)
		gameEngine.mu.RUnlock()
		if matchCount != 0 || userMatchCount != 0 {
			t.Fatalf(
				"failed room start left %d matches and %d matched-user refs",
				matchCount,
				userMatchCount,
			)
		}
		gameEngine.queueMu.Lock()
		ownerQueued := queueHasPlayer(gameEngine.queues[room.GameID], room.OwnerID)
		guestQueued := queueHasPlayer(gameEngine.queues[room.GameID], room.GuestID)
		gameEngine.queueMu.Unlock()
		if ownerQueued || guestQueued {
			t.Fatalf(
				"room participant is both queued and in a room: owner=%v guest=%v",
				ownerQueued,
				guestQueued,
			)
		}
	})
}
