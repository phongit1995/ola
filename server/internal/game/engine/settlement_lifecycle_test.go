package engine

import (
	"context"
	"encoding/json"
	"errors"
	"reflect"
	"sync"
	"testing"
	"time"

	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"

	"go.uber.org/zap"
)

type fakeSettlement struct {
	mu sync.Mutex

	escrowEntered chan struct{}
	escrowRelease chan struct{}
	escrowOnce    sync.Once
	escrowErr     error
	escrowCalls   []MatchRecord

	abortErr   error
	abortCalls []string

	settleNotify chan struct{}
	settleErrors []error
	settleCalls  []MatchOutcome

	reconcileNotify chan struct{}
	reconcileErr    error
	reconcileResult []SettledBalance
	reconcileCalls  [][]string
}

type failingListActiveMatchStore struct {
	*memoryActiveMatchStore
}

func (s *failingListActiveMatchStore) List(string) ([]ActiveMatchSnapshot, error) {
	return nil, errors.New("list active matches failed")
}

func (s *fakeSettlement) Balance(string) (int, bool) {
	return MaxBet, true
}

func (s *fakeSettlement) EscrowStart(ctx context.Context, rec MatchRecord) ([]SettledBalance, error) {
	s.mu.Lock()
	s.escrowCalls = append(s.escrowCalls, rec)
	entered := s.escrowEntered
	release := s.escrowRelease
	err := s.escrowErr
	s.mu.Unlock()
	if entered != nil {
		s.escrowOnce.Do(func() { close(entered) })
	}
	if release != nil {
		select {
		case <-release:
		case <-ctx.Done():
			return nil, ctx.Err()
		}
	}
	return nil, err
}

func (s *fakeSettlement) AbortStart(_ context.Context, matchID string) ([]SettledBalance, error) {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.abortCalls = append(s.abortCalls, matchID)
	return nil, s.abortErr
}

func (s *fakeSettlement) SettleFinish(_ context.Context, out MatchOutcome) ([]SettledBalance, error) {
	s.mu.Lock()
	s.settleCalls = append(s.settleCalls, out)
	var err error
	if len(s.settleErrors) > 0 {
		err = s.settleErrors[0]
		s.settleErrors = s.settleErrors[1:]
	}
	notify := s.settleNotify
	s.mu.Unlock()
	if notify != nil {
		select {
		case notify <- struct{}{}:
		default:
		}
	}
	return nil, err
}

func (s *fakeSettlement) ReconcileStale(_ context.Context, activeMatchIDs []string) ([]SettledBalance, error) {
	s.mu.Lock()
	s.reconcileCalls = append(s.reconcileCalls, append([]string(nil), activeMatchIDs...))
	err := s.reconcileErr
	result := append([]SettledBalance(nil), s.reconcileResult...)
	notify := s.reconcileNotify
	s.mu.Unlock()
	if notify != nil {
		select {
		case notify <- struct{}{}:
		default:
		}
	}
	return result, err
}

func (s *fakeSettlement) counts() (escrow, abort, settle, reconcile int) {
	s.mu.Lock()
	defer s.mu.Unlock()
	return len(s.escrowCalls), len(s.abortCalls), len(s.settleCalls), len(s.reconcileCalls)
}

func newSettlementTestEngine(activeStore ActiveMatchRepository, settlement Settlement) *Engine {
	gameEngine := NewEngine(zap.NewNop().Sugar(), 1, 30, newMemoryRoomStore(), activeStore)
	gameEngine.SetSettlement(settlement)
	return gameEngine
}

func registeredTestPlayer(id string) protocol.PlayerInfo {
	return protocol.PlayerInfo{ID: id, Name: id}
}

func waitForCondition(t *testing.T, timeout time.Duration, message string, condition func() bool) {
	t.Helper()
	deadline := time.Now().Add(timeout)
	for time.Now().Before(deadline) {
		if condition() {
			return
		}
		time.Sleep(10 * time.Millisecond)
	}
	t.Fatal(message)
}

func TestStartMatchEscrowsBeforePersistAndStartsDeadlineAfterEscrow(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	settlement := &fakeSettlement{
		escrowEntered: make(chan struct{}),
		escrowRelease: make(chan struct{}),
	}
	gameEngine := newSettlementTestEngine(activeStore, settlement)
	gameLogic, err := logic.Get(persistenceTestGameID)
	if err != nil {
		t.Fatal(err)
	}

	startDone := make(chan error, 1)
	go func() {
		startDone <- gameEngine.startMatch(
			persistenceTestGameID,
			gameLogic,
			registeredTestPlayer("escrow-a"),
			registeredTestPlayer("escrow-b"),
			10,
		)
	}()

	select {
	case <-settlement.escrowEntered:
	case <-time.After(time.Second):
		t.Fatal("start did not reach escrow")
	}
	activeStore.mu.Lock()
	persistedBeforeEscrow := len(activeStore.matches)
	activeStore.mu.Unlock()
	if persistedBeforeEscrow != 0 {
		t.Fatal("active snapshot was persisted before escrow completed")
	}

	time.Sleep(50 * time.Millisecond)
	releasedAt := time.Now()
	close(settlement.escrowRelease)
	if err := <-startDone; err != nil {
		t.Fatalf("start match: %v", err)
	}
	defer stopEngineTimers(gameEngine)

	gameEngine.mu.RLock()
	var match *Match
	for _, current := range gameEngine.matches {
		match = current
	}
	gameEngine.mu.RUnlock()
	if match == nil {
		t.Fatal("match was not installed")
	}
	snapshot, ok := activeStore.get(match.GameID, match.ID)
	if !ok {
		t.Fatal("active snapshot was not persisted after escrow")
	}
	if deadline := time.UnixMilli(snapshot.TurnDeadline); deadline.Before(releasedAt.Add(900 * time.Millisecond)) {
		t.Fatalf("first deadline %v includes escrow latency; escrow completed at %v", deadline, releasedAt)
	}
}

func TestQueueOperationsContinueWhileAnotherMatchRecordsItsStart(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	settlement := &fakeSettlement{
		escrowEntered: make(chan struct{}),
		escrowRelease: make(chan struct{}),
	}
	gameEngine := newSettlementTestEngine(activeStore, settlement)
	gameEngine.JoinQueue(persistenceTestGameID, protocol.PlayerInfo{ID: "queue-a"})

	matchStartDone := make(chan struct{})
	go func() {
		gameEngine.JoinQueue(persistenceTestGameID, protocol.PlayerInfo{ID: "queue-b"})
		close(matchStartDone)
	}()
	select {
	case <-settlement.escrowEntered:
	case <-time.After(time.Second):
		t.Fatal("queued match did not reach start recording")
	}

	queueOperationDone := make(chan struct{})
	go func() {
		gameEngine.JoinQueue(persistenceTestGameID, protocol.PlayerInfo{ID: "queue-c"})
		gameEngine.LeaveQueue(persistenceTestGameID, "queue-c")
		close(queueOperationDone)
	}()
	select {
	case <-queueOperationDone:
	case <-time.After(250 * time.Millisecond):
		t.Fatal("unrelated queue operations were blocked by match start recording")
	}

	close(settlement.escrowRelease)
	select {
	case <-matchStartDone:
	case <-time.After(time.Second):
		t.Fatal("queued match did not finish starting")
	}
	defer stopEngineTimers(gameEngine)
}

func TestStartMatchAbortsEscrowWhenInitialPersistFails(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	activeStore.failSave = true
	settlement := &fakeSettlement{}
	gameEngine := newSettlementTestEngine(activeStore, settlement)
	gameLogic, _ := logic.Get(persistenceTestGameID)

	err := gameEngine.startMatch(
		persistenceTestGameID,
		gameLogic,
		registeredTestPlayer("abort-a"),
		registeredTestPlayer("abort-b"),
		25,
	)
	if err == nil {
		t.Fatal("start succeeded when active snapshot persistence failed")
	}
	escrowCalls, abortCalls, _, _ := settlement.counts()
	if escrowCalls != 1 || abortCalls != 1 {
		t.Fatalf("settlement calls = escrow %d, abort %d; want 1 each", escrowCalls, abortCalls)
	}
	if len(gameEngine.matches) != 0 || len(gameEngine.byUser) != 0 {
		t.Fatal("failed start remained installed")
	}
}

func TestStartMatchAbortsAfterAmbiguousEscrowError(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	settlement := &fakeSettlement{escrowErr: errors.New("escrow commit result unknown")}
	gameEngine := newSettlementTestEngine(activeStore, settlement)
	gameLogic, _ := logic.Get(persistenceTestGameID)

	err := gameEngine.startMatch(
		persistenceTestGameID,
		gameLogic,
		registeredTestPlayer("unknown-a"),
		registeredTestPlayer("unknown-b"),
		25,
	)
	if err == nil {
		t.Fatal("start succeeded after an ambiguous escrow failure")
	}
	escrowCalls, abortCalls, _, _ := settlement.counts()
	if escrowCalls != 1 || abortCalls != 1 {
		t.Fatalf("settlement calls = escrow %d, abort %d; want 1 each", escrowCalls, abortCalls)
	}
}

func TestFinishEmitsImmediatelyAndRetainsSnapshotUntilSettlementRetrySucceeds(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	settleNotify := make(chan struct{}, 4)
	settlement := &fakeSettlement{
		settleNotify: settleNotify,
		settleErrors: []error{errors.New("temporary settlement failure"), nil},
	}
	gameEngine := newSettlementTestEngine(activeStore, settlement)
	emitter := &captureEmitter{}
	gameEngine.emitterMu.Lock()
	gameEngine.emitter = emitter
	gameEngine.emitterMu.Unlock()
	gameLogic, _ := logic.Get(persistenceTestGameID)
	if err := gameEngine.startMatch(
		persistenceTestGameID,
		gameLogic,
		registeredTestPlayer("finish-a"),
		registeredTestPlayer("finish-b"),
		15,
	); err != nil {
		t.Fatal(err)
	}
	match := gameEngine.matchForUser(persistenceTestGameID, "finish-a")
	if match == nil {
		t.Fatal("match was not installed")
	}
	winnerID := match.players[match.turnIdx].ID

	gameEngine.Move(match.GameID, winnerID, match.ID, json.RawMessage(`{"win":true}`))
	if _, ok := emitter.last(winnerID, protocol.S2CMatchOver); !ok {
		t.Fatal("MATCH_OVER was not emitted without waiting for settlement")
	}
	select {
	case <-settleNotify:
	case <-time.After(time.Second):
		t.Fatal("finish did not start settlement")
	}
	if snapshot, ok := activeStore.get(match.GameID, match.ID); !ok || snapshot.Status != matchStatusFinished {
		t.Fatalf("failed settlement did not retain the finished snapshot: %+v", snapshot)
	}

	select {
	case <-settleNotify:
	case <-time.After(2 * time.Second):
		t.Fatal("failed settlement was not retried")
	}
	waitForCondition(t, time.Second, "settled snapshot was not deleted", func() bool {
		_, exists := activeStore.get(match.GameID, match.ID)
		return !exists
	})
}

func TestFinishedSnapshotDeleteRetryDoesNotRepeatSuccessfulSettlement(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	activeStore.failDelete = true
	settleNotify := make(chan struct{}, 2)
	settlement := &fakeSettlement{settleNotify: settleNotify}
	gameEngine := newSettlementTestEngine(activeStore, settlement)
	gameLogic, _ := logic.Get(persistenceTestGameID)
	if err := gameEngine.startMatch(
		persistenceTestGameID,
		gameLogic,
		registeredTestPlayer("delete-a"),
		registeredTestPlayer("delete-b"),
		10,
	); err != nil {
		t.Fatal(err)
	}
	match := gameEngine.matchForUser(persistenceTestGameID, "delete-a")
	gameEngine.Move(match.GameID, match.players[match.turnIdx].ID, match.ID, json.RawMessage(`{"win":true}`))

	select {
	case <-settleNotify:
	case <-time.After(time.Second):
		t.Fatal("finish was not settled")
	}
	if _, exists := activeStore.get(match.GameID, match.ID); !exists {
		t.Fatal("snapshot was deleted despite the simulated Redis failure")
	}
	activeStore.mu.Lock()
	activeStore.failDelete = false
	activeStore.mu.Unlock()
	waitForCondition(t, 2*time.Second, "snapshot delete was not retried", func() bool {
		_, exists := activeStore.get(match.GameID, match.ID)
		return !exists
	})
	_, _, settleCalls, _ := settlement.counts()
	if settleCalls != 1 {
		t.Fatalf("successful settlement was repeated %d times while retrying Redis delete", settleCalls)
	}
}

func TestRestoreFinishedSnapshotSettlesBeforeDeleteWhenSettlementIsSetLater(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	state, _ := json.Marshal(&persistenceTestState{MoveCount: 4, Winner: 0})
	snapshot := ActiveMatchSnapshot{
		ID: "restore-finished-settle", GameID: persistenceTestGameID,
		Players:      []protocol.PlayerInfo{{ID: "restore-a"}, {ID: "restore-b"}},
		State:        state,
		StateVersion: 1,
		Status:       matchStatusFinished,
		WinnerID:     "restore-a",
		ResultReason: "win",
		Bet:          20,
		FinishedAt:   time.Now().UnixMilli(),
	}
	if err := activeStore.Save(snapshot); err != nil {
		t.Fatal(err)
	}

	gameEngine := NewEngine(zap.NewNop().Sugar(), 30, 30, newMemoryRoomStore(), activeStore)
	emitter := &captureEmitter{}
	gameEngine.SetEmitter(emitter)
	if _, exists := activeStore.get(snapshot.GameID, snapshot.ID); !exists {
		t.Fatal("restore deleted the durable outcome before settlement was available")
	}

	settleNotify := make(chan struct{}, 1)
	settlement := &fakeSettlement{
		settleNotify:    settleNotify,
		reconcileNotify: make(chan struct{}, 1),
	}
	gameEngine.SetSettlement(settlement)
	select {
	case <-settleNotify:
	case <-time.After(time.Second):
		t.Fatal("finished restore was not settled after settlement was attached")
	}
	waitForCondition(t, time.Second, "restored snapshot was not deleted after successful settlement", func() bool {
		_, exists := activeStore.get(snapshot.GameID, snapshot.ID)
		return !exists
	})

	settlement.mu.Lock()
	if len(settlement.settleCalls) != 1 || settlement.settleCalls[0].MatchID != snapshot.ID {
		t.Fatalf("unexpected restored settlement calls: %+v", settlement.settleCalls)
	}
	settlement.mu.Unlock()
}

func TestReconcileReceivesSortedActiveRedisMatchIDs(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	for _, matchID := range []string{"match-z", "match-a"} {
		state, _ := json.Marshal(&persistenceTestState{Winner: -1})
		if err := activeStore.Save(ActiveMatchSnapshot{
			ID: matchID, GameID: persistenceTestGameID,
			Players:      []protocol.PlayerInfo{{ID: matchID + "-a"}, {ID: matchID + "-b"}},
			State:        state,
			StateVersion: 1,
			Status:       matchStatusPlaying,
			TurnIndex:    0,
			TurnDeadline: time.Now().Add(time.Minute).UnixMilli(),
			StartedAt:    time.Now().UnixMilli(),
		}); err != nil {
			t.Fatal(err)
		}
	}
	reconcileNotify := make(chan struct{}, 1)
	settlement := &fakeSettlement{reconcileNotify: reconcileNotify}
	gameEngine := NewEngine(zap.NewNop().Sugar(), 30, 30, newMemoryRoomStore(), activeStore)
	gameEngine.SetSettlement(settlement)
	gameEngine.SetEmitter(&captureEmitter{})
	defer stopEngineTimers(gameEngine)

	select {
	case <-reconcileNotify:
	case <-time.After(time.Second):
		t.Fatal("maintenance did not reconcile after restore")
	}
	settlement.mu.Lock()
	defer settlement.mu.Unlock()
	if len(settlement.reconcileCalls) == 0 {
		t.Fatal("reconcile was not called")
	}
	if got, want := settlement.reconcileCalls[0], []string{"match-a", "match-z"}; !reflect.DeepEqual(got, want) {
		t.Fatalf("active match IDs = %v, want %v", got, want)
	}
}

func TestRestorePlayingSnapshotKeepsDurableStateWhenEscrowVerificationFails(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	state, _ := json.Marshal(&persistenceTestState{Winner: -1})
	snapshot := ActiveMatchSnapshot{
		ID: "restore-escrow-error", GameID: persistenceTestGameID,
		Players:      []protocol.PlayerInfo{{ID: "verify-a"}, {ID: "verify-b"}},
		State:        state,
		StateVersion: 1,
		Status:       matchStatusPlaying,
		TurnIndex:    0,
		TurnDeadline: time.Now().Add(time.Minute).UnixMilli(),
		StartedAt:    time.Now().UnixMilli(),
		Bet:          30,
	}
	if err := activeStore.Save(snapshot); err != nil {
		t.Fatal(err)
	}
	settlement := &fakeSettlement{escrowErr: errors.New("database unavailable")}
	gameEngine := NewEngine(zap.NewNop().Sugar(), 30, 30, newMemoryRoomStore(), activeStore)
	gameEngine.SetSettlement(settlement)
	gameEngine.SetEmitter(&captureEmitter{})

	if gameEngine.matchForUser(snapshot.GameID, snapshot.Players[0].ID) != nil {
		t.Fatal("match was restored without verified escrow")
	}
	if _, exists := activeStore.get(snapshot.GameID, snapshot.ID); !exists {
		t.Fatal("transient escrow verification failure deleted the durable snapshot")
	}
	settlement.mu.Lock()
	settlement.escrowErr = nil
	settlement.mu.Unlock()
	waitForCondition(t, 2*time.Second, "restored match was not installed after escrow verification recovered", func() bool {
		return gameEngine.matchForUser(snapshot.GameID, snapshot.Players[0].ID) != nil
	})
	defer stopEngineTimers(gameEngine)
}

func TestRestorePlayingSnapshotDiscardsPermanentlyClosedEscrow(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	state, _ := json.Marshal(&persistenceTestState{Winner: -1})
	snapshot := ActiveMatchSnapshot{
		ID: "restore-closed-escrow", GameID: persistenceTestGameID,
		Players:      []protocol.PlayerInfo{{ID: "closed-a"}, {ID: "closed-b"}},
		State:        state,
		StateVersion: 1,
		Status:       matchStatusPlaying,
		TurnIndex:    0,
		TurnDeadline: time.Now().Add(time.Minute).UnixMilli(),
		StartedAt:    time.Now().UnixMilli(),
		Bet:          30,
	}
	if err := activeStore.Save(snapshot); err != nil {
		t.Fatal(err)
	}
	settlement := &fakeSettlement{escrowErr: errors.Join(errors.New("voided match"), ErrEscrowClosed)}
	gameEngine := NewEngine(zap.NewNop().Sugar(), 30, 30, newMemoryRoomStore(), activeStore)
	gameEngine.SetSettlement(settlement)
	gameEngine.SetEmitter(&captureEmitter{})

	if gameEngine.matchForUser(snapshot.GameID, snapshot.Players[0].ID) != nil {
		t.Fatal("match with closed escrow was restored")
	}
	if _, exists := activeStore.get(snapshot.GameID, snapshot.ID); exists {
		t.Fatal("permanently unfunded snapshot was retained for futile retries")
	}
}

func TestReconcileIsSkippedWhenAnyActiveMatchListFails(t *testing.T) {
	activeStore := &failingListActiveMatchStore{memoryActiveMatchStore: newMemoryActiveMatchStore()}
	reconcileNotify := make(chan struct{}, 1)
	settlement := &fakeSettlement{reconcileNotify: reconcileNotify}
	gameEngine := NewEngine(zap.NewNop().Sugar(), 30, 30, newMemoryRoomStore(), activeStore)
	gameEngine.SetSettlement(settlement)
	gameEngine.SetEmitter(&captureEmitter{})

	select {
	case <-reconcileNotify:
		t.Fatal("reconcile ran without a complete active match list")
	case <-time.After(100 * time.Millisecond):
	}
	_, _, _, reconcileCalls := settlement.counts()
	if reconcileCalls != 0 {
		t.Fatalf("reconcile calls = %d, want 0", reconcileCalls)
	}
}

func TestReconcileEmitsCommittedBalancesEvenWhenAnotherStaleMatchFails(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	reconcileNotify := make(chan struct{}, 1)
	settlement := &fakeSettlement{
		reconcileNotify: reconcileNotify,
		reconcileErr:    errors.New("one stale match failed"),
		reconcileResult: []SettledBalance{{
			GameID: persistenceTestGameID,
			UserID: "reconciled-user",
			Info:   protocol.UserInfoData{Ken: 123},
		}},
	}
	gameEngine := NewEngine(zap.NewNop().Sugar(), 30, 30, newMemoryRoomStore(), activeStore)
	emitter := &captureEmitter{}
	gameEngine.SetSettlement(settlement)
	gameEngine.SetEmitter(emitter)

	select {
	case <-reconcileNotify:
	case <-time.After(time.Second):
		t.Fatal("maintenance did not reconcile")
	}
	waitForCondition(t, time.Second, "partial reconcile balance was not emitted", func() bool {
		_, ok := emitter.last("reconciled-user", protocol.S2CUserInfo)
		return ok
	})
}

func TestCreateRoomRejectsBetWhosePayoutWouldOverflowPostgresInteger(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, _, emitter := newPersistenceTestEngine(activeStore)
	owner := protocol.PlayerInfo{ID: "max-bet-owner", Name: "Owner"}

	gameEngine.CreateRoom(persistenceTestGameID, owner, MaxBet+1, "")

	requireErrorCode(t, emitter, owner.ID, "INVALID_BET")
}

func TestPaidRoomFailsClosedWithoutSettlementService(t *testing.T) {
	activeStore := newMemoryActiveMatchStore()
	gameEngine, rooms, emitter := newPersistenceTestEngine(activeStore)
	owner := registeredTestPlayer("paid-owner")

	gameEngine.CreateRoom(persistenceTestGameID, owner, 10, "")

	requireErrorCode(t, emitter, owner.ID, "BET_NOT_ALLOWED")
	if len(rooms.rooms) != 0 {
		t.Fatal("paid room was created without a settlement service")
	}

	gameLogic, _ := logic.Get(persistenceTestGameID)
	if err := gameEngine.startMatch(
		persistenceTestGameID,
		gameLogic,
		registeredTestPlayer("paid-a"),
		registeredTestPlayer("paid-b"),
		10,
	); err == nil {
		t.Fatal("paid match started without a settlement service")
	}
}
