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

func recoveryPlayingSnapshot(id, player0ID, player1ID string, bet int) ActiveMatchSnapshot {
	state, _ := json.Marshal(&persistenceTestState{Winner: -1})
	now := time.Now()
	return ActiveMatchSnapshot{
		ID:           id,
		GameID:       persistenceTestGameID,
		Players:      []protocol.PlayerInfo{{ID: player0ID}, {ID: player1ID}},
		State:        state,
		StateVersion: 1,
		TurnIndex:    0,
		TurnDeadline: now.Add(time.Minute).UnixMilli(),
		Bet:          bet,
		StartedAt:    now.UnixMilli(),
		Status:       matchStatusPlaying,
	}
}

func TestRestorePaidPlayingSnapshotWaitsForSettlementWhileFreeSnapshotRestores(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	paid := recoveryPlayingSnapshot("paid-waits-for-settlement", "paid-a", "paid-b", 25)
	free := recoveryPlayingSnapshot("free-restores-without-settlement", "free-a", "free-b", 0)
	if err := activeStore.Save(paid); err != nil {
		t.Fatal(err)
	}
	if err := activeStore.Save(free); err != nil {
		t.Fatal(err)
	}

	gameEngine := NewEngine(zap.NewNop().Sugar(), 300, 30, newMemoryRoomStore(), activeStore)
	defer stopEngineTimers(gameEngine)

	// SetEmitter performs the initial restore before a settlement service exists.
	gameEngine.SetEmitter(&captureEmitter{})

	if gameEngine.matchByID(paid.ID) != nil {
		t.Fatal("paid snapshot was installed before its escrow could be verified")
	}
	if _, exists := activeStore.get(paid.GameID, paid.ID); !exists {
		t.Fatal("paid snapshot was deleted while settlement was unavailable")
	}
	if gameEngine.matchByID(free.ID) == nil {
		t.Fatal("zero-bet snapshot was not restored without settlement")
	}

	settlement := &fakeSettlement{}
	gameEngine.SetSettlement(settlement)
	waitForCondition(t, time.Second, "paid snapshot was not installed after settlement became available", func() bool {
		return gameEngine.matchByID(paid.ID) != nil
	})
	if _, exists := activeStore.get(paid.GameID, paid.ID); !exists {
		t.Fatal("installed paid snapshot was unexpectedly deleted")
	}
}

func TestPaidFinishRetainsOutcomeUntilSettlementReturns(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	settlement := &fakeSettlement{}
	gameEngine := newSettlementTestEngine(activeStore, settlement)
	gameLogic, err := logic.Get(persistenceTestGameID)
	if err != nil {
		t.Fatal(err)
	}
	if err := gameEngine.startMatch(
		persistenceTestGameID,
		gameLogic,
		registeredTestPlayer("late-settle-a"),
		registeredTestPlayer("late-settle-b"),
		25,
	); err != nil {
		t.Fatal(err)
	}
	match := gameEngine.matchForUser(persistenceTestGameID, "late-settle-a")
	if match == nil {
		t.Fatal("paid match was not installed")
	}

	gameEngine.SetSettlement(nil)
	gameEngine.Move(
		match.GameID,
		match.players[match.turnIdx].ID,
		match.ID,
		json.RawMessage(`{"win":true}`),
	)
	snapshot, exists := activeStore.get(match.GameID, match.ID)
	if !exists || snapshot.Status != matchStatusFinished {
		t.Fatalf("paid outcome was not retained while settlement was unavailable: %+v", snapshot)
	}
	_, _, settleCalls, _ := settlement.counts()
	if settleCalls != 0 {
		t.Fatalf("finish reached detached settlement service %d times", settleCalls)
	}

	gameEngine.SetSettlement(settlement)
	waitForCondition(t, 2*time.Second, "retained paid outcome was not settled and deleted", func() bool {
		_, exists := activeStore.get(match.GameID, match.ID)
		return !exists
	})
	_, _, settleCalls, _ = settlement.counts()
	if settleCalls != 1 {
		t.Fatalf("settlement calls after service returned = %d, want 1", settleCalls)
	}
}

func TestCorruptPlayingSnapshotAbortsWithoutOpeningEscrow(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	snapshot := recoveryPlayingSnapshot("corrupt-restore", "corrupt-a", "corrupt-b", 20)
	snapshot.State = json.RawMessage(`{"winner":"not-an-integer"}`)
	if err := activeStore.Save(snapshot); err != nil {
		t.Fatal(err)
	}
	settlement := &fakeSettlement{}
	gameEngine := newSettlementTestEngine(activeStore, settlement)

	restored, retry := gameEngine.restorePlayingSnapshot(snapshot, snapshot.GameID)
	if restored || retry {
		t.Fatalf("corrupt restore returned restored=%v retry=%v", restored, retry)
	}
	escrowCalls, abortCalls, _, _ := settlement.counts()
	if escrowCalls != 0 {
		t.Fatalf("corrupt snapshot opened escrow %d times", escrowCalls)
	}
	if abortCalls != 1 {
		t.Fatalf("corrupt snapshot abort calls = %d, want 1 cleanup", abortCalls)
	}
	if _, exists := activeStore.get(snapshot.GameID, snapshot.ID); exists {
		t.Fatal("corrupt recovery snapshot remained after successful abort")
	}
	if gameEngine.matchByID(snapshot.ID) != nil {
		t.Fatal("corrupt recovery snapshot entered the live registry")
	}
}

func TestConcurrentPlayingSnapshotRestoreResolvesPlayerConflictWithoutAbortingDuplicate(t *testing.T) {
	t.Run("different matches sharing a player", func(t *testing.T) {
		activeStore := newMemoryActiveMatchStore()
		first := recoveryPlayingSnapshot("shared-player-first", "shared-player", "first-opponent", 20)
		second := recoveryPlayingSnapshot("shared-player-second", "shared-player", "second-opponent", 20)
		if err := activeStore.Save(first); err != nil {
			t.Fatal(err)
		}
		if err := activeStore.Save(second); err != nil {
			t.Fatal(err)
		}

		settlement := &fakeSettlement{escrowRelease: make(chan struct{})}
		gameEngine := NewEngine(zap.NewNop().Sugar(), 300, 30, newMemoryRoomStore(), activeStore)
		gameEngine.SetSettlement(settlement)
		defer stopEngineTimers(gameEngine)

		var wg sync.WaitGroup
		restored := make([]bool, 2)
		retry := make([]bool, 2)
		snapshots := []ActiveMatchSnapshot{first, second}
		for i := range snapshots {
			wg.Add(1)
			go func(index int) {
				defer wg.Done()
				restored[index], retry[index] = gameEngine.restorePlayingSnapshot(
					snapshots[index],
					snapshots[index].GameID,
				)
			}(i)
		}

		waitForCondition(t, time.Second, "winning restore did not reach escrow verification", func() bool {
			escrowCalls, _, _, _ := settlement.counts()
			return escrowCalls == 1
		})
		close(settlement.escrowRelease)
		wg.Wait()

		restoredCount := 0
		for i := range restored {
			if restored[i] {
				restoredCount++
			}
			if retry[i] {
				t.Fatalf("restore %d unexpectedly requested a retry", i)
			}
		}
		if restoredCount != 1 {
			t.Fatalf("installed restores = %d, want exactly 1", restoredCount)
		}

		gameEngine.mu.RLock()
		matchCount := len(gameEngine.matches)
		gameEngine.mu.RUnlock()
		if matchCount != 1 {
			t.Fatalf("installed matches = %d, want exactly 1", matchCount)
		}

		_, firstExists := activeStore.get(first.GameID, first.ID)
		_, secondExists := activeStore.get(second.GameID, second.ID)
		if firstExists == secondExists {
			t.Fatalf("durable snapshots remaining: first=%v second=%v, want exactly one", firstExists, secondExists)
		}

		_, abortCalls, _, _ := settlement.counts()
		if abortCalls != 1 {
			t.Fatalf("abort calls = %d, want exactly 1 for the conflicting match", abortCalls)
		}
		escrowCalls, _, _, _ := settlement.counts()
		if escrowCalls != 1 {
			t.Fatalf("escrow calls = %d, want only the installed match to verify escrow", escrowCalls)
		}
		settlement.mu.Lock()
		abortedID := settlement.abortCalls[0]
		settlement.mu.Unlock()
		if (abortedID == first.ID) != !firstExists || (abortedID == second.ID) != !secondExists {
			t.Fatalf(
				"aborted match %q does not match deleted snapshots: first=%v second=%v",
				abortedID,
				firstExists,
				secondExists,
			)
		}
	})

	t.Run("same match restored concurrently", func(t *testing.T) {
		activeStore := newMemoryActiveMatchStore()
		snapshot := recoveryPlayingSnapshot("same-match-concurrent-restore", "same-a", "same-b", 20)
		if err := activeStore.Save(snapshot); err != nil {
			t.Fatal(err)
		}

		settlement := &fakeSettlement{escrowRelease: make(chan struct{})}
		gameEngine := NewEngine(zap.NewNop().Sugar(), 300, 30, newMemoryRoomStore(), activeStore)
		gameEngine.SetSettlement(settlement)
		defer stopEngineTimers(gameEngine)

		var wg sync.WaitGroup
		restored := make([]bool, 2)
		retry := make([]bool, 2)
		for i := range restored {
			wg.Add(1)
			go func(index int) {
				defer wg.Done()
				restored[index], retry[index] = gameEngine.restorePlayingSnapshot(snapshot, snapshot.GameID)
			}(i)
		}

		waitForCondition(t, time.Second, "installed duplicate restore did not reach escrow verification", func() bool {
			escrowCalls, _, _, _ := settlement.counts()
			return escrowCalls == 1
		})
		close(settlement.escrowRelease)
		wg.Wait()

		restoredCount := 0
		for i := range restored {
			if restored[i] {
				restoredCount++
			}
			if retry[i] {
				t.Fatalf("restore %d unexpectedly requested a retry", i)
			}
		}
		if restoredCount != 1 {
			t.Fatalf("installed restores = %d, want exactly 1", restoredCount)
		}
		if gameEngine.matchByID(snapshot.ID) == nil {
			t.Fatal("concurrently restored match was not installed")
		}
		if _, exists := activeStore.get(snapshot.GameID, snapshot.ID); !exists {
			t.Fatal("duplicate restore deleted the live match snapshot")
		}
		_, abortCalls, _, _ := settlement.counts()
		if abortCalls != 0 {
			t.Fatalf("duplicate restore issued %d aborts for the same match", abortCalls)
		}
		escrowCalls, _, _, _ := settlement.counts()
		if escrowCalls != 1 {
			t.Fatalf("duplicate restore verified escrow %d times, want 1", escrowCalls)
		}
	})
}

type failFirstSaveActiveMatchStore struct {
	*memoryActiveMatchStore
	saveMu    sync.Mutex
	saveCalls int
}

func newFailFirstSaveActiveMatchStore() *failFirstSaveActiveMatchStore {
	return &failFirstSaveActiveMatchStore{memoryActiveMatchStore: newMemoryActiveMatchStore()}
}

func (s *failFirstSaveActiveMatchStore) Save(snapshot ActiveMatchSnapshot) error {
	s.saveMu.Lock()
	s.saveCalls++
	call := s.saveCalls
	s.saveMu.Unlock()
	if call == 1 {
		return errors.New("initial active snapshot save failed")
	}
	return s.memoryActiveMatchStore.Save(snapshot)
}

func TestInitialSaveAndAbortFailurePreservesAbortingSnapshotUntilRetrySucceeds(t *testing.T) {
	activeStore := newFailFirstSaveActiveMatchStore()
	settlement := &fakeSettlement{abortErr: errors.New("temporary abort failure")}
	gameEngine := NewEngine(zap.NewNop().Sugar(), 300, 30, newMemoryRoomStore(), activeStore)
	gameEngine.SetSettlement(settlement)

	gameLogic, err := logic.Get(persistenceTestGameID)
	if err != nil {
		t.Fatal(err)
	}
	err = gameEngine.startMatch(
		persistenceTestGameID,
		gameLogic,
		registeredTestPlayer("abort-recovery-a"),
		registeredTestPlayer("abort-recovery-b"),
		25,
	)
	if err == nil {
		t.Fatal("match start succeeded despite the initial active snapshot save failure")
	}

	settlement.mu.Lock()
	if len(settlement.escrowCalls) != 1 {
		settlement.mu.Unlock()
		t.Fatalf("escrow calls = %d, want 1", len(settlement.escrowCalls))
	}
	matchID := settlement.escrowCalls[0].MatchID
	settlement.mu.Unlock()

	// One abort is synchronous in startMatch; the queued recovery job makes the
	// second attempt immediately. Keep the transient error active until both
	// have failed so the durable recovery state is observable deterministically.
	waitForCondition(t, time.Second, "abort recovery job did not make its first retry", func() bool {
		_, abortCalls, _, _ := settlement.counts()
		return abortCalls >= 2
	})

	snapshot, exists := activeStore.get(persistenceTestGameID, matchID)
	if !exists {
		t.Fatal("transient abort failure did not preserve a recovery snapshot")
	}
	if snapshot.Status != matchStatusAborting {
		t.Fatalf("recovery snapshot status = %q, want %q", snapshot.Status, matchStatusAborting)
	}
	if gameEngine.matchByID(matchID) != nil ||
		gameEngine.matchForUser(persistenceTestGameID, "abort-recovery-a") != nil ||
		gameEngine.matchForUser(persistenceTestGameID, "abort-recovery-b") != nil {
		t.Fatal("failed match start remained installed while abort recovery was pending")
	}
	gameEngine.abortJobsMu.Lock()
	_, queued := gameEngine.abortJobs[userKey(persistenceTestGameID, matchID)]
	gameEngine.abortJobsMu.Unlock()
	if !queued {
		t.Fatal("aborting recovery snapshot was not queued for retry")
	}

	settlement.mu.Lock()
	settlement.abortErr = nil
	settlement.mu.Unlock()
	waitForCondition(t, 2*time.Second, "successful abort retry did not delete the recovery snapshot", func() bool {
		_, stillExists := activeStore.get(persistenceTestGameID, matchID)
		gameEngine.abortJobsMu.Lock()
		_, stillQueued := gameEngine.abortJobs[userKey(persistenceTestGameID, matchID)]
		gameEngine.abortJobsMu.Unlock()
		return !stillExists && !stillQueued
	})

	_, abortCalls, _, _ := settlement.counts()
	if abortCalls != 3 {
		t.Fatalf("abort calls = %d, want synchronous failure, queued failure, then successful retry", abortCalls)
	}
	if gameEngine.matchByID(matchID) != nil {
		t.Fatal("match appeared after abort recovery completed")
	}
}
