package engine

import (
	"context"
	"errors"
	"math"
	"sort"
	"time"

	"ola-chat-server/internal/game/logic"
	"ola-chat-server/internal/game/protocol"
)

const (
	reconcileInterval          = 15 * time.Minute
	settlementOperationTimeout = 5 * time.Second
	reconcileOperationTimeout  = 30 * time.Second
	settlementRetryDelay       = time.Second
	settlementMaxRetryDelay    = 30 * time.Second

	// MaxBet keeps a winner payout (2 * bet) within a PostgreSQL integer.
	MaxBet = math.MaxInt32 / 2
)

var (
	// ErrEscrowClosed means a durable start record exists but can no longer
	// back a playing match (for example, it was already voided/refunded).
	ErrEscrowClosed = errors.New("game escrow is closed")
	// ErrSettlementConflict means durable match identity/lifecycle data does
	// not match the requested operation and retrying unchanged cannot succeed.
	ErrSettlementConflict = errors.New("game settlement data conflicts")
)

type MatchRecord struct {
	GameID    string
	MatchID   string
	Player0ID string
	Player1ID string
	Bet       int
	Mode      string
	StartedAt time.Time
}

type MatchOutcome struct {
	GameID     string
	MatchID    string
	Player0ID  string
	Player1ID  string
	WinnerID   string
	Reason     string
	Bet        int
	MoveCount  int
	FinishedAt time.Time
}

type SettledBalance struct {
	GameID string
	UserID string
	Info   protocol.UserInfoData
}

type Settlement interface {
	Balance(userID string) (int, bool)
	WinnerAmounts(gameID string, bet int) (payout, net int)
	EscrowStart(ctx context.Context, rec MatchRecord) ([]SettledBalance, error)
	AbortStart(ctx context.Context, matchID string) ([]SettledBalance, error)
	SettleFinish(ctx context.Context, out MatchOutcome) ([]SettledBalance, error)
	ReconcileStale(ctx context.Context, activeMatchIDs []string) ([]SettledBalance, error)
}

func (e *Engine) SetSettlement(settlement Settlement) {
	e.settlementMu.Lock()
	e.settlement = settlement
	e.settlementMu.Unlock()
	e.maybeStartSettlementMaintenance()
}

func (e *Engine) currentSettlement() Settlement {
	e.settlementMu.RLock()
	defer e.settlementMu.RUnlock()
	return e.settlement
}

func (e *Engine) maybeStartSettlementMaintenance() {
	if e.currentSettlement() == nil {
		return
	}
	e.restoreMu.Lock()
	restored := e.restored
	e.restoreMu.Unlock()
	if !restored {
		return
	}
	e.maintenanceOnce.Do(func() {
		go e.runSettlementMaintenance()
	})
}

func (e *Engine) runSettlementMaintenance() {
	e.reconcileSettlement()
	ticker := time.NewTicker(reconcileInterval)
	defer ticker.Stop()
	for range ticker.C {
		e.reconcileSettlement()
	}
}

func (e *Engine) reconcileSettlement() {
	settlement := e.currentSettlement()
	if settlement == nil {
		return
	}

	snapshots := make([]ActiveMatchSnapshot, 0)
	activeSet := make(map[string]struct{})
	for _, gameID := range logic.IDs() {
		gameSnapshots, err := e.activeStore.List(gameID)
		if err != nil {
			e.logger.Errorw("Skipped match reconciliation because active matches could not be listed", "game_id", gameID, "error", err)
			return
		}
		for _, snapshot := range gameSnapshots {
			snapshots = append(snapshots, snapshot)
			if snapshot.ID != "" && (snapshot.Status == matchStatusPlaying || snapshot.Status == matchStatusFinished) {
				activeSet[snapshot.ID] = struct{}{}
			}
		}
	}

	activeIDs := make([]string, 0, len(activeSet))
	for matchID := range activeSet {
		activeIDs = append(activeIDs, matchID)
	}
	sort.Strings(activeIDs)

	for _, snapshot := range snapshots {
		switch snapshot.Status {
		case matchStatusPlaying:
			match := e.matchByID(snapshot.ID)
			if match == nil {
				_, retry := e.restorePlayingSnapshot(snapshot, snapshot.GameID)
				if retry {
					e.queuePlayingRestore(snapshot)
				}
				continue
			}
			match.mu.Lock()
			verified := match.escrowVerified
			over := match.over
			match.mu.Unlock()
			if over || verified {
				continue
			}
			record, ok := recordFromSnapshot(snapshot)
			if !ok {
				e.logger.Errorw("Could not verify escrow for invalid active snapshot", "game_id", snapshot.GameID, "match_id", snapshot.ID)
				continue
			}
			ctx, cancel := context.WithTimeout(context.Background(), settlementOperationTimeout)
			balances, err := settlement.EscrowStart(ctx, record)
			cancel()
			if err != nil {
				e.logger.Errorw("Failed to verify escrow for active match", "game_id", snapshot.GameID, "match_id", snapshot.ID, "error", err)
				if errors.Is(err, ErrEscrowClosed) {
					if !e.discardRestoredSnapshot(snapshot, match) {
						e.queuePlayingRestore(snapshot)
					}
				}
				continue
			}
			e.emitSettledBalances(balances, snapshot.GameID)
			if match != nil {
				match.mu.Lock()
				if !match.over {
					match.escrowVerified = true
				}
				match.mu.Unlock()
			}
		case matchStatusFinished:
			outcome, ok := outcomeFromSnapshot(snapshot)
			if !ok {
				e.logger.Errorw("Could not retry settlement for invalid finished snapshot", "game_id", snapshot.GameID, "match_id", snapshot.ID)
				continue
			}
			e.queueFinishedSettlement(snapshot, outcome)
		case matchStatusAborting:
			e.queueAbortSettlement(snapshot)
		}
	}

	ctx, cancel := context.WithTimeout(context.Background(), reconcileOperationTimeout)
	balances, err := settlement.ReconcileStale(ctx, activeIDs)
	cancel()
	e.emitSettledBalances(balances, "")
	if err != nil {
		e.logger.Errorw("Failed to reconcile stale matches", "error", err)
	}
}

func (e *Engine) queuePlayingRestore(snapshot ActiveMatchSnapshot) {
	jobKey := userKey(snapshot.GameID, snapshot.ID)
	e.restoreJobsMu.Lock()
	if _, exists := e.restoreJobs[jobKey]; exists {
		e.restoreJobsMu.Unlock()
		return
	}
	e.restoreJobs[jobKey] = struct{}{}
	e.restoreJobsMu.Unlock()

	go func() {
		defer func() {
			e.restoreJobsMu.Lock()
			delete(e.restoreJobs, jobKey)
			e.restoreJobsMu.Unlock()
		}()

		retryDelay := settlementRetryDelay
		for {
			timer := time.NewTimer(retryDelay)
			<-timer.C
			if snapshot.Bet > 0 && e.currentSettlement() == nil {
				return
			}
			restored, retry := e.restorePlayingSnapshot(snapshot, snapshot.GameID)
			if restored || !retry {
				return
			}
			if retryDelay < settlementMaxRetryDelay {
				retryDelay *= 2
				if retryDelay > settlementMaxRetryDelay {
					retryDelay = settlementMaxRetryDelay
				}
			}
		}
	}()
}

func (e *Engine) queueFinishedSettlement(snapshot ActiveMatchSnapshot, outcome MatchOutcome) {
	jobKey := userKey(snapshot.GameID, snapshot.ID)
	e.settlementJobsMu.Lock()
	if _, exists := e.settlementJobs[jobKey]; exists {
		e.settlementJobsMu.Unlock()
		return
	}
	e.settlementJobs[jobKey] = struct{}{}
	e.settlementJobsMu.Unlock()

	go func() {
		defer func() {
			e.settlementJobsMu.Lock()
			delete(e.settlementJobs, jobKey)
			e.settlementJobsMu.Unlock()
		}()

		settled := false
		roomHandled := false
		retryDelay := settlementRetryDelay
		for {
			settlement := e.currentSettlement()
			if settlement == nil {
				timer := time.NewTimer(retryDelay)
				<-timer.C
				if retryDelay < settlementMaxRetryDelay {
					retryDelay *= 2
					if retryDelay > settlementMaxRetryDelay {
						retryDelay = settlementMaxRetryDelay
					}
				}
				continue
			}
			if !settled {
				ctx, cancel := context.WithTimeout(context.Background(), settlementOperationTimeout)
				balances, err := settlement.SettleFinish(ctx, outcome)
				cancel()
				if err != nil {
					e.logger.Errorw("Failed to settle finished match; will retry", "match_id", outcome.MatchID, "error", err)
					if errors.Is(err, ErrSettlementConflict) {
						// Preserve the durable outcome for manual reconciliation;
						// retrying unchanged cannot resolve an identity conflict.
						return
					}
				} else {
					e.emitSettledBalances(balances, outcome.GameID)
					settled = true
				}
			}
			if settled {
				if !roomHandled {
					current, exists, err := e.activeStore.Get(snapshot.GameID, snapshot.ID)
					if err != nil {
						e.logger.Errorw("Failed to revalidate settled match snapshot; will retry", "match_id", snapshot.ID, "error", err)
						timer := time.NewTimer(retryDelay)
						<-timer.C
						continue
					}
					if exists && current.Status != matchStatusFinished && current.Status != matchStatusPlaying {
						return
					}
					if !e.restoreSnapshotRoom(snapshot) {
						timer := time.NewTimer(retryDelay)
						<-timer.C
						continue
					}
					roomHandled = true
				}
				userIDs := []string{outcome.Player0ID, outcome.Player1ID}
				deleted, err := e.deleteSnapshotWithStatuses(
					snapshot.GameID,
					snapshot.ID,
					userIDs,
					matchStatusFinished,
					matchStatusPlaying,
				)
				if err != nil {
					e.logger.Errorw("Failed to delete settled match snapshot; will retry", "match_id", snapshot.ID, "error", err)
				} else if deleted {
					return
				} else {
					e.logger.Warnw("Kept settled match snapshot because its lifecycle status changed", "match_id", snapshot.ID)
					return
				}
			}

			timer := time.NewTimer(retryDelay)
			<-timer.C
			if retryDelay < settlementMaxRetryDelay {
				retryDelay *= 2
				if retryDelay > settlementMaxRetryDelay {
					retryDelay = settlementMaxRetryDelay
				}
			}
		}
	}()
}

func (e *Engine) queueAbortSettlement(snapshot ActiveMatchSnapshot) {
	jobKey := userKey(snapshot.GameID, snapshot.ID)
	e.abortJobsMu.Lock()
	if _, exists := e.abortJobs[jobKey]; exists {
		e.abortJobsMu.Unlock()
		return
	}
	e.abortJobs[jobKey] = struct{}{}
	e.abortJobsMu.Unlock()

	go func() {
		defer func() {
			e.abortJobsMu.Lock()
			delete(e.abortJobs, jobKey)
			e.abortJobsMu.Unlock()
		}()

		aborted := false
		roomHandled := false
		retryDelay := settlementRetryDelay
		for {
			settlement := e.currentSettlement()
			if settlement != nil && !aborted {
				ctx, cancel := context.WithTimeout(context.Background(), settlementOperationTimeout)
				balances, err := settlement.AbortStart(ctx, snapshot.ID)
				cancel()
				if err != nil {
					e.logger.Errorw("Failed to abort unowned match; will retry", "match_id", snapshot.ID, "error", err)
					if errors.Is(err, ErrSettlementConflict) {
						return
					}
				} else {
					e.emitSettledBalances(balances, snapshot.GameID)
					aborted = true
				}
			}
			if aborted {
				current, exists, err := e.activeStore.Get(snapshot.GameID, snapshot.ID)
				if err != nil {
					e.logger.Errorw("Failed to revalidate aborted match snapshot; will retry", "match_id", snapshot.ID, "error", err)
					timer := time.NewTimer(retryDelay)
					<-timer.C
					continue
				}
				if exists && current.Status == matchStatusFinished {
					return
				}
				if !roomHandled {
					if !e.restoreSnapshotRoom(snapshot) {
						timer := time.NewTimer(retryDelay)
						<-timer.C
						if retryDelay < settlementMaxRetryDelay {
							retryDelay *= 2
							if retryDelay > settlementMaxRetryDelay {
								retryDelay = settlementMaxRetryDelay
							}
						}
						continue
					}
					roomHandled = true
				}
				userIDs := snapshotPlayerIDs(snapshot)
				deleted, err := e.deleteSnapshotWithStatuses(
					snapshot.GameID,
					snapshot.ID,
					userIDs,
					matchStatusAborting,
					matchStatusPlaying,
				)
				if err != nil {
					e.logger.Errorw("Failed to delete aborted match snapshot; will retry", "match_id", snapshot.ID, "error", err)
				} else if deleted {
					return
				} else {
					e.logger.Warnw("Kept aborted match snapshot because its lifecycle status changed", "match_id", snapshot.ID)
					return
				}
			}

			timer := time.NewTimer(retryDelay)
			<-timer.C
			if retryDelay < settlementMaxRetryDelay {
				retryDelay *= 2
				if retryDelay > settlementMaxRetryDelay {
					retryDelay = settlementMaxRetryDelay
				}
			}
		}
	}()
}

func (e *Engine) deleteSnapshotWithStatuses(
	gameID, matchID string,
	userIDs []string,
	statuses ...string,
) (bool, error) {
	for _, status := range statuses {
		deleted, err := e.activeStore.DeleteIfStatus(gameID, matchID, status, userIDs...)
		if err != nil {
			return false, err
		}
		if deleted {
			return true, nil
		}
	}
	return false, nil
}

func snapshotPlayerIDs(snapshot ActiveMatchSnapshot) []string {
	userIDs := make([]string, 0, len(snapshot.Players))
	for _, player := range snapshot.Players {
		if player.ID != "" {
			userIDs = append(userIDs, player.ID)
		}
	}
	return userIDs
}

func (e *Engine) emitSettledBalances(balances []SettledBalance, fallbackGameID string) {
	for _, balance := range balances {
		gameID := balance.GameID
		if gameID == "" {
			gameID = fallbackGameID
		}
		if gameID == "" || balance.UserID == "" {
			continue
		}
		e.toUser(gameID, balance.UserID, protocol.OutEnvelope{Type: protocol.S2CUserInfo, Data: balance.Info})
	}
}

func outcomeFromSnapshot(snapshot ActiveMatchSnapshot) (MatchOutcome, bool) {
	if snapshot.ID == "" || snapshot.GameID == "" || len(snapshot.Players) != 2 {
		return MatchOutcome{}, false
	}
	finishedAt := time.UnixMilli(snapshot.FinishedAt)
	if snapshot.FinishedAt <= 0 {
		finishedAt = time.Now()
	}
	moveCount := 0
	if gameLogic, err := logic.Get(snapshot.GameID); err == nil &&
		snapshot.StateVersion == gameLogic.StateVersion() {
		if state, decodeErr := gameLogic.DecodeState(snapshot.State); decodeErr == nil {
			moveCount = stateMoveCount(gameLogic, state)
		}
	}
	return MatchOutcome{
		GameID:     snapshot.GameID,
		MatchID:    snapshot.ID,
		Player0ID:  snapshot.Players[0].ID,
		Player1ID:  snapshot.Players[1].ID,
		WinnerID:   snapshot.WinnerID,
		Reason:     snapshot.ResultReason,
		Bet:        snapshot.Bet,
		MoveCount:  moveCount,
		FinishedAt: finishedAt,
	}, true
}

func recordFromSnapshot(snapshot ActiveMatchSnapshot) (MatchRecord, bool) {
	if snapshot.ID == "" || snapshot.GameID == "" || len(snapshot.Players) != 2 {
		return MatchRecord{}, false
	}
	startedAt := time.UnixMilli(snapshot.StartedAt)
	if snapshot.StartedAt <= 0 {
		startedAt = time.Now()
	}
	mode := "queue"
	if snapshot.Room != nil {
		mode = "room"
	}
	return MatchRecord{
		GameID:    snapshot.GameID,
		MatchID:   snapshot.ID,
		Player0ID: snapshot.Players[0].ID,
		Player1ID: snapshot.Players[1].ID,
		Bet:       snapshot.Bet,
		Mode:      mode,
		StartedAt: startedAt,
	}, true
}

func (e *Engine) ensureCanBet(gameID, userID string, bet int) bool {
	if bet <= 0 {
		return true
	}
	settlement := e.currentSettlement()
	if settlement == nil {
		e.sendError(gameID, userID, "BET_NOT_ALLOWED", "betting is temporarily unavailable")
		return false
	}
	balance, ok := settlement.Balance(userID)
	if !ok {
		e.sendError(gameID, userID, "BET_NOT_ALLOWED", "betting requires a registered account")
		return false
	}
	if balance < bet {
		e.sendError(gameID, userID, "INSUFFICIENT_KEN", "not enough Ken for this bet")
		return false
	}
	if balance > math.MaxInt32-bet {
		e.sendError(gameID, userID, "BET_NOT_ALLOWED", "this bet could exceed the Ken balance limit")
		return false
	}
	return true
}

type moveCounter interface {
	MoveCount(state any) int
}

func matchMoveCount(m *Match) int {
	return stateMoveCount(m.logic, m.state)
}

func stateMoveCount(gameLogic logic.GameLogic, state any) int {
	if mc, ok := gameLogic.(moveCounter); ok {
		return mc.MoveCount(state)
	}
	return 0
}
