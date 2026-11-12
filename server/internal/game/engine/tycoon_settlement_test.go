package engine

import (
	"errors"
	"fmt"
	"testing"
	"time"

	"ola-chat-server/internal/game/games/tycoon"
	"ola-chat-server/internal/game/protocol"
)

const tycoonTestCommission = 5

func tycoonSettleCall(t *testing.T, settlement *fakeSettlement) MatchOutcome {
	t.Helper()
	waitForCondition(t, 2*time.Second, "tycoon match was not settled", func() bool {
		settlement.mu.Lock()
		defer settlement.mu.Unlock()
		return len(settlement.settleCalls) > 0
	})
	settlement.mu.Lock()
	defer settlement.mu.Unlock()
	first := settlement.settleCalls[0]
	for _, call := range settlement.settleCalls[1:] {
		if call.MatchID != first.MatchID || call.WinnerID != first.WinnerID || call.Bet != first.Bet ||
			fmt.Sprint(call.Rankings) != fmt.Sprint(first.Rankings) || fmt.Sprint(call.PlayerIDs) != fmt.Sprint(first.PlayerIDs) {
			t.Fatalf("settlement retry %+v differs from first settlement %+v", call, first)
		}
	}
	return first
}

func tycoonEscrowCall(t *testing.T, settlement *fakeSettlement) MatchRecord {
	t.Helper()
	settlement.mu.Lock()
	defer settlement.mu.Unlock()
	if len(settlement.escrowCalls) != 1 {
		t.Fatalf("escrow calls = %d, want 1", len(settlement.escrowCalls))
	}
	return settlement.escrowCalls[0]
}

func tycoonMatchOver(t *testing.T, emitter *captureEmitter, match *Match) protocol.MatchOverData {
	t.Helper()
	var first protocol.MatchOverData
	for idx, player := range match.players {
		env, ok := emitter.last(player.ID, protocol.S2CMatchOver)
		if !ok {
			t.Fatalf("seat %d got no MATCH_OVER", idx)
		}
		data := env.Data.(protocol.MatchOverData)
		if idx == 0 {
			first = data
			continue
		}
		if data.WinnerID != first.WinnerID || data.Payout != first.Payout || data.KenDelta != first.KenDelta || data.Bet != first.Bet {
			t.Fatalf("seat %d MATCH_OVER %+v differs from seat 0 %+v", idx, data, first)
		}
	}
	return first
}

func tycoonClientKenDelta(over protocol.MatchOverData, userID string) int {
	if over.Bet <= 0 {
		return 0
	}
	for _, entry := range over.Rankings {
		if entry.UserID == userID && entry.Place == 1 {
			return over.KenDelta
		}
	}
	return -over.Bet
}

func tycoonSettledKenDelta(record MatchRecord, outcome MatchOutcome, settlement Settlement) map[string]int {
	deltas := make(map[string]int, len(record.AllPlayerIDs()))
	for _, id := range record.AllPlayerIDs() {
		deltas[id] -= record.Bet
	}
	if outcome.Bet > 0 && outcome.WinnerID != "" {
		payout, _ := settlement.WinnerAmounts(outcome.GameID, outcome.Bet, len(outcome.AllPlayerIDs()))
		deltas[outcome.WinnerID] += payout
	}
	return deltas
}

func assertTycoonKenSettlement(
	t *testing.T,
	settlement *fakeSettlement,
	emitter *captureEmitter,
	match *Match,
	bet int,
) (protocol.MatchOverData, MatchOutcome) {
	t.Helper()
	players := len(match.players)
	over := tycoonMatchOver(t, emitter, match)
	record := tycoonEscrowCall(t, settlement)
	outcome := tycoonSettleCall(t, settlement)

	if record.GameID != tycoon.GameID || record.Bet != bet || len(record.AllPlayerIDs()) != players {
		t.Fatalf("escrow record = %+v, want tycoon bet %d for %d seats", record, bet, players)
	}
	if outcome.GameID != tycoon.GameID || outcome.Bet != bet || len(outcome.AllPlayerIDs()) != players {
		t.Fatalf("settle outcome = %+v, want tycoon bet %d for %d seats", outcome, bet, players)
	}
	if len(over.Rankings) != players || len(outcome.Rankings) != players {
		t.Fatalf("rankings MATCH_OVER %v outcome %v, want %d seats", over.Rankings, outcome.Rankings, players)
	}
	for i, entry := range over.Rankings {
		if entry.Place != i+1 || entry.UserID != outcome.Rankings[i] {
			t.Fatalf("MATCH_OVER rankings %v differ from settled rankings %v", over.Rankings, outcome.Rankings)
		}
	}
	if over.WinnerID == "" || over.WinnerID != over.Rankings[0].UserID || outcome.WinnerID != over.WinnerID {
		t.Fatalf("winner MATCH_OVER %q settle %q, want rank 1 %q", over.WinnerID, outcome.WinnerID, over.Rankings[0].UserID)
	}

	wantPayout, wantNet := 0, 0
	if bet > 0 {
		wantPayout, wantNet = settlement.WinnerAmounts(tycoon.GameID, bet, players)
	}
	if over.Bet != bet || over.Payout != wantPayout || over.KenDelta != wantNet {
		t.Fatalf("MATCH_OVER bet %d payout %d kenDelta %d, want %d / %d / %d", over.Bet, over.Payout, over.KenDelta, bet, wantPayout, wantNet)
	}

	settled := tycoonSettledKenDelta(record, outcome, settlement)
	total := 0
	for _, player := range match.players {
		want := -bet
		if player.ID == over.WinnerID {
			want = over.Payout - bet
		}
		if bet == 0 {
			want = 0
		}
		if settled[player.ID] != want {
			t.Fatalf("settled ken delta for %s = %d, want %d", player.ID, settled[player.ID], want)
		}
		if got := tycoonClientKenDelta(over, player.ID); got != want {
			t.Fatalf("MATCH_OVER ken delta for %s = %d, want %d", player.ID, got, want)
		}
		total += want
	}
	commission := bet * tycoonTestCommission / 100
	if total != -commission {
		t.Fatalf("ken deltas sum to %d, want -%d commission", total, commission)
	}
	return over, outcome
}

func TestTycoonFreeTableMovesNoKen(t *testing.T) {
	for _, players := range []int{2, 3, 4} {
		t.Run(fmt.Sprintf("%d players", players), func(t *testing.T) {
			settlement := &fakeSettlement{commissionPercent: tycoonTestCommission}
			gameEngine, emitter, match := startTycoonBetMatch(t, players, 0, settlement)
			defer stopEngineTimers(gameEngine)

			playTycoonToEnd(t, gameEngine, emitter, match)
			over, _ := assertTycoonKenSettlement(t, settlement, emitter, match, 0)
			if over.Payout != 0 || over.KenDelta != 0 {
				t.Fatalf("free table MATCH_OVER payout %d kenDelta %d", over.Payout, over.KenDelta)
			}
		})
	}
}

func TestTycoonBetTablePaysRankOneThePotMinusCommission(t *testing.T) {
	for _, tc := range []struct {
		players    int
		bet        int
		wantPayout int
	}{
		{players: 2, bet: 1000, wantPayout: 1950},
		{players: 3, bet: 1000, wantPayout: 2950},
		{players: 4, bet: 1000, wantPayout: 3950},
		{players: 3, bet: 333, wantPayout: 983},
	} {
		t.Run(fmt.Sprintf("%d players bet %d", tc.players, tc.bet), func(t *testing.T) {
			settlement := &fakeSettlement{commissionPercent: tycoonTestCommission}
			gameEngine, emitter, match := startTycoonBetMatch(t, tc.players, tc.bet, settlement)
			defer stopEngineTimers(gameEngine)

			playTycoonToEnd(t, gameEngine, emitter, match)
			over, _ := assertTycoonKenSettlement(t, settlement, emitter, match, tc.bet)
			if over.Payout != tc.wantPayout || over.KenDelta != tc.wantPayout-tc.bet {
				t.Fatalf("payout %d kenDelta %d, want %d and %d", over.Payout, over.KenDelta, tc.wantPayout, tc.wantPayout-tc.bet)
			}
		})
	}
}

func TestTycoonForfeitStillLosesTheBet(t *testing.T) {
	const bet = 1000
	for _, tc := range []struct {
		name      string
		players   int
		forfeits  []int
		wantLast  []int
		wantEnded bool
	}{
		{name: "two players forfeit ends the match", players: 2, forfeits: []int{0}, wantLast: []int{0}, wantEnded: true},
		{name: "three players one forfeit", players: 3, forfeits: []int{1}, wantLast: []int{1}},
		{name: "four players two forfeits", players: 4, forfeits: []int{2, 0}, wantLast: []int{0, 2}},
		{name: "four players three forfeits", players: 4, forfeits: []int{3, 0, 1}, wantLast: []int{1, 0, 3}, wantEnded: true},
	} {
		t.Run(tc.name, func(t *testing.T) {
			settlement := &fakeSettlement{commissionPercent: tycoonTestCommission}
			gameEngine, emitter, match := startTycoonBetMatch(t, tc.players, bet, settlement)
			defer stopEngineTimers(gameEngine)

			forfeited := make(map[string]bool, len(tc.forfeits))
			for _, seat := range tc.forfeits {
				userID := match.players[seat].ID
				forfeited[userID] = true
				gameEngine.ForfeitAndLeave(match.GameID, userID, match.ID)
			}
			if match.over != tc.wantEnded {
				t.Fatalf("match over = %v after forfeits, want %v", match.over, tc.wantEnded)
			}
			if !match.over {
				playTycoonToEnd(t, gameEngine, emitter, match)
			}

			over, outcome := assertTycoonKenSettlement(t, settlement, emitter, match, bet)
			if forfeited[over.WinnerID] {
				t.Fatalf("forfeiting player %s won", over.WinnerID)
			}
			tail := over.Rankings[len(over.Rankings)-len(tc.wantLast):]
			for i, seat := range tc.wantLast {
				if tail[i].UserID != match.players[seat].ID {
					t.Fatalf("rankings %v, want forfeiting seats %v last", over.Rankings, tc.wantLast)
				}
			}
			for seat, player := range match.players {
				if !forfeited[player.ID] {
					continue
				}
				if got := tycoonClientKenDelta(over, player.ID); got != -bet {
					t.Fatalf("forfeiting seat %d ken delta %d, want %d", seat, got, -bet)
				}
				if len(outcome.ExitReasons) != tc.players || outcome.ExitReasons[seat] != tycoon.ExitForfeit {
					t.Fatalf("exit reasons %v, want seat %d forfeit", outcome.ExitReasons, seat)
				}
			}
		})
	}
}

func TestTycoonTimedOutSeatLosesTheBet(t *testing.T) {
	const bet = 500
	settlement := &fakeSettlement{commissionPercent: tycoonTestCommission}
	gameEngine, emitter, match := startTycoonBetMatch(t, 3, bet, settlement)
	defer stopEngineTimers(gameEngine)

	idle := 0
	for i := 0; i < 500 && !match.over && !match.quit[idle]; i++ {
		if match.turnIdx == idle {
			fireTurnTimeout(gameEngine, match)
			continue
		}
		userID, raw := tycoonBotMove(t, match)
		gameEngine.Move(match.GameID, userID, match.ID, raw)
	}
	if match.over || !match.quit[idle] {
		t.Fatalf("idle seat was not eliminated (over=%v)", match.over)
	}
	playTycoonToEnd(t, gameEngine, emitter, match)

	over, _ := assertTycoonKenSettlement(t, settlement, emitter, match, bet)
	idleID := match.players[idle].ID
	if over.Rankings[len(over.Rankings)-1].UserID != idleID {
		t.Fatalf("rankings %v, want idle seat last", over.Rankings)
	}
	if got := tycoonClientKenDelta(over, idleID); got != -bet {
		t.Fatalf("idle seat ken delta %d, want %d", got, -bet)
	}
}

func TestTycoonFailedEscrowRefundsEveryone(t *testing.T) {
	for _, players := range []int{2, 4} {
		t.Run(fmt.Sprintf("%d players", players), func(t *testing.T) {
			settlement := &fakeSettlement{commissionPercent: tycoonTestCommission, escrowErr: errors.New("insufficient ken for bet")}
			gameEngine, _, _ := newPersistenceTestEngine(newMemoryActiveMatchStore())
			gameEngine.SetSettlement(settlement)
			defer stopEngineTimers(gameEngine)

			seats := make([]protocol.PlayerInfo, 0, players)
			for i := 0; i < players; i++ {
				id := fmt.Sprintf("ty-refund-%d", i)
				seats = append(seats, protocol.PlayerInfo{ID: id, Name: id})
			}
			if err := gameEngine.startMatchWithRoom(tycoon.GameID, tycoon.Logic{}, seats, 1000, nil, false, nil); err == nil {
				t.Fatal("match started although escrow failed")
			}
			escrow, abort, settle, _ := settlement.counts()
			if escrow != 1 || abort != 1 || settle != 0 {
				t.Fatalf("escrow %d abort %d settle %d, want 1 / 1 / 0", escrow, abort, settle)
			}
			record := tycoonEscrowCall(t, settlement)
			settlement.mu.Lock()
			abortedID := settlement.abortCalls[0]
			settlement.mu.Unlock()
			if abortedID != record.MatchID || len(record.AllPlayerIDs()) != players {
				t.Fatalf("aborted %q for record %+v", abortedID, record)
			}
			gameEngine.mu.RLock()
			live := len(gameEngine.matches)
			gameEngine.mu.RUnlock()
			if live != 0 {
				t.Fatalf("%d live matches after failed escrow", live)
			}
		})
	}
}
