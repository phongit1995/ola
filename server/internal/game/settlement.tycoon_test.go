package game

import (
	"context"
	"database/sql/driver"
	"fmt"
	"testing"
	"time"

	"ola-chat-server/internal/game/engine"
	"ola-chat-server/internal/game/progression"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

const tycoonGameID = "tycoon"

var tycoonSeatIDs = []uuid.UUID{
	uuid.MustParse("11111111-1111-4111-8111-111111111111"),
	uuid.MustParse("22222222-2222-4222-8222-222222222222"),
	uuid.MustParse("33333333-3333-4333-8333-333333333333"),
	uuid.MustParse("44444444-4444-4444-8444-444444444444"),
}

type tycoonLedger struct {
	t        *testing.T
	mock     sqlmock.Sqlmock
	repo     *SettlementRepository
	players  []uuid.UUID
	matchID  uuid.UUID
	rowID    uuid.UUID
	bet      int
	initial  map[uuid.UUID]int
	balances map[uuid.UUID]int
	start    time.Time
}

func newTycoonLedger(t *testing.T, playerCount, bet int) *tycoonLedger {
	t.Helper()
	db, mock := newSettlementMockDB(t)
	players := append([]uuid.UUID(nil), tycoonSeatIDs[:playerCount]...)
	initial := make(map[uuid.UUID]int, playerCount)
	balances := make(map[uuid.UUID]int, playerCount)
	for seat, id := range players {
		initial[id] = 10_000 + seat*1_000
		balances[id] = initial[id]
	}
	return &tycoonLedger{
		t:        t,
		mock:     mock,
		repo:     &SettlementRepository{db: db, logger: zap.NewNop().Sugar(), commissionPercents: map[string]int{tycoonGameID: 5}},
		players:  players,
		matchID:  uuid.MustParse("aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"),
		rowID:    uuid.MustParse("bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb"),
		bet:      bet,
		initial:  initial,
		balances: balances,
		start:    time.Now().Add(-time.Minute).UTC(),
	}
}

func (l *tycoonLedger) playerIDs() []string {
	ids := make([]string, len(l.players))
	for i, id := range l.players {
		ids[i] = id.String()
	}
	return ids
}

func (l *tycoonLedger) escrow() {
	l.t.Helper()
	rec := engine.MatchRecord{
		GameID:    tycoonGameID,
		MatchID:   l.matchID.String(),
		Player0ID: l.players[0].String(),
		Player1ID: l.players[1].String(),
		PlayerIDs: l.playerIDs(),
		Bet:       l.bet,
		Mode:      "room",
		StartedAt: l.start,
	}
	if _, _, err := validateRecord(rec); err != nil {
		l.t.Fatalf("escrow record rejected: %v", err)
	}

	l.mock.ExpectBegin()
	l.mock.ExpectQuery(`INSERT INTO "game_matches"`).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(l.rowID))
	if len(l.players) > 2 {
		rows := sqlmock.NewRows([]string{"id"})
		for range l.players {
			rows.AddRow(uuid.New())
		}
		l.mock.ExpectQuery(`INSERT INTO "game_match_players"`).WillReturnRows(rows)
	}
	if l.bet > 0 {
		for _, id := range orderedUserIDs(l.players...) {
			expectLockedUser(l.mock, id, l.balances[id])
		}
		for _, id := range orderedUserIDs(l.players...) {
			l.balances[id] -= l.bet
			expectKenUpdate(l.mock, id, l.balances[id])
		}
	}
	l.mock.ExpectCommit()

	result, err := l.repo.escrowStart(context.Background(), rec, l.players[0], l.players[1], l.players)
	if err != nil {
		l.t.Fatalf("escrow: %v", err)
	}
	if result.gameID != tycoonGameID {
		l.t.Fatalf("escrow result = %+v", result)
	}
}

func (l *tycoonLedger) matchRow() *sqlmock.Rows {
	return sqlmock.NewRows([]string{
		"id", "game_id", "match_id", "player0_id", "player1_id", "status",
		"mode", "bet", "player_count", "started_at", "escrowed_at", "deleted_at",
	}).AddRow(
		l.rowID, tycoonGameID, l.matchID.String(), l.players[0], l.players[1], matchStatusPlaying,
		"room", l.bet, len(l.players), l.start, l.start, nil,
	)
}

func (l *tycoonLedger) settle(rankingSeats []int, reason string, exitReasons []string) (winner uuid.UUID, persistedKenDelta int) {
	l.t.Helper()
	winner = l.players[rankingSeats[0]]
	rankings := make([]string, len(rankingSeats))
	for i, seat := range rankingSeats {
		rankings[i] = l.players[seat].String()
	}
	const moveCount = 120
	out := engine.MatchOutcome{
		GameID:      tycoonGameID,
		MatchID:     l.matchID.String(),
		Player0ID:   l.players[0].String(),
		Player1ID:   l.players[1].String(),
		PlayerIDs:   l.playerIDs(),
		Rankings:    rankings,
		WinnerID:    winner.String(),
		Reason:      reason,
		EndReason:   "last",
		ExitReasons: exitReasons,
		Bet:         l.bet,
		MoveCount:   moveCount,
		FinishedAt:  time.Now().UTC(),
	}
	if _, _, err := validateOutcome(out); err != nil {
		l.t.Fatalf("outcome rejected: %v", err)
	}

	payout, net := l.repo.WinnerAmounts(tycoonGameID, l.bet, len(l.players))
	l.mock.ExpectBegin()
	l.mock.ExpectQuery(`SELECT \* FROM "game_matches".*match_id = \$1.*FOR UPDATE`).
		WithArgs(l.matchID.String(), 1).
		WillReturnRows(l.matchRow())
	if l.bet > 0 {
		for _, id := range orderedUserIDs(l.players...) {
			expectLockedUser(l.mock, id, l.balances[id])
		}
		l.balances[winner] += payout
		expectKenUpdate(l.mock, winner, l.balances[winner])
	}

	var loser any
	if len(l.players) == 2 {
		other := l.players[rankingSeats[1]]
		loser = other
		args := make([]driver.Value, 0, 16)
		for seat, id := range l.players {
			var exit driver.Value
			if exitReasons[seat] != "" {
				exit = exitReasons[seat]
			}
			place := 1
			if id != winner {
				place = 2
			}
			args = append(args, l.rowID, id, seat, place, 0, exit, sqlmock.AnyArg(), sqlmock.AnyArg())
		}
		l.mock.ExpectQuery(`INSERT INTO "game_match_players"`).
			WithArgs(args...).
			WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(uuid.New()).AddRow(uuid.New()))
	} else {
		for seat, id := range l.players {
			place := 0
			for i, ranked := range rankingSeats {
				if ranked == seat {
					place = i + 1
				}
			}
			if exitReasons[seat] != "" {
				l.mock.ExpectExec(`UPDATE "game_match_players" SET "exit_reason"=\$1,"place"=\$2,"updated_at"=\$3 WHERE game_match_id = \$4 AND user_id = \$5`).
					WithArgs(exitReasons[seat], place, sqlmock.AnyArg(), l.rowID, id).
					WillReturnResult(sqlmock.NewResult(0, 1))
				continue
			}
			l.mock.ExpectExec(`UPDATE "game_match_players" SET "place"=\$1,"updated_at"=\$2 WHERE game_match_id = \$3 AND user_id = \$4`).
				WithArgs(place, sqlmock.AnyArg(), l.rowID, id).
				WillReturnResult(sqlmock.NewResult(0, 1))
		}
	}

	l.mock.ExpectExec(`UPDATE "game_matches" SET "end_reason"=\$1,"finished_at"=\$2,"ken_delta"=\$3,"loser_id"=\$4,"move_count"=\$5,"reason"=\$6,"status"=\$7,"winner_id"=\$8,"updated_at"=\$9 WHERE id = \$10 AND status = \$11`).
		WithArgs(out.EndReason, sqlmock.AnyArg(), net, loser, moveCount, reason, matchStatusFinished, winner, sqlmock.AnyArg(), l.rowID, matchStatusPlaying).
		WillReturnResult(sqlmock.NewResult(0, 1))
	for _, id := range orderedUserIDs(l.players...) {
		gain := progression.MatchExp(out.WinnerID, reason, id.String(), moveCount)
		expectExpGrant(l.mock, id, tycoonGameID, gain, int64(gain))
	}
	l.mock.ExpectCommit()

	if _, err := l.repo.settleFinish(context.Background(), out, l.players[0], l.players[1], l.players); err != nil {
		l.t.Fatalf("settle: %v", err)
	}
	if err := l.mock.ExpectationsWereMet(); err != nil {
		l.t.Fatal(err)
	}
	return winner, net
}

func (l *tycoonLedger) kenDelta(id uuid.UUID) int {
	return l.balances[id] - l.initial[id]
}

func (l *tycoonLedger) assertWinnerTakesPot(winner uuid.UUID, persisted int) {
	l.t.Helper()
	payout, net := l.repo.WinnerAmounts(tycoonGameID, l.bet, len(l.players))
	pot := l.bet * len(l.players)
	if l.bet > 0 && payout != pot-l.bet*5/100 {
		l.t.Fatalf("payout %d, want pot %d minus 5%% of the bet", payout, pot)
	}
	if persisted != net || net != payout-l.bet {
		l.t.Fatalf("persisted ken_delta %d, net %d, want payout %d minus bet %d", persisted, net, payout, l.bet)
	}
	total := 0
	for _, id := range l.players {
		want := -l.bet
		if id == winner {
			want = net
		}
		if got := l.kenDelta(id); got != want {
			l.t.Fatalf("player %s ken delta %d, want %d", id, got, want)
		}
		total += l.kenDelta(id)
	}
	if total != -(l.bet * 5 / 100) {
		l.t.Fatalf("ken moved %d in total, want only the commission %d removed", total, l.bet*5/100)
	}
}

func TestTycoonSettlementFreeTableMovesNoKen(t *testing.T) {
	for _, players := range []int{2, 3, 4} {
		t.Run(fmt.Sprintf("%d players", players), func(t *testing.T) {
			ledger := newTycoonLedger(t, players, 0)
			ledger.escrow()
			ranking := make([]int, players)
			exits := make([]string, players)
			for i := range ranking {
				ranking[i] = players - 1 - i
			}
			exits[0] = "bankrupt"
			winner, persisted := ledger.settle(ranking, "win", exits)
			if persisted != 0 {
				t.Fatalf("free table ken_delta %d, want 0", persisted)
			}
			for _, id := range ledger.players {
				if got := ledger.kenDelta(id); got != 0 {
					t.Fatalf("player %s ken delta %d on a free table (winner %s)", id, got, winner)
				}
			}
		})
	}
}

func TestTycoonSettlementRankOneTakesThePotMinusCommission(t *testing.T) {
	for _, tc := range []struct {
		players int
		bet     int
		ranking []int
		exits   []string
		payout  int
	}{
		{players: 2, bet: 10_000, ranking: []int{1, 0}, exits: []string{"bankrupt", ""}, payout: 19_500},
		{players: 3, bet: 10_000, ranking: []int{2, 0, 1}, exits: []string{"", "bankrupt", ""}, payout: 29_500},
		{players: 4, bet: 10_000, ranking: []int{3, 1, 0, 2}, exits: []string{"", "", "bankrupt", ""}, payout: 39_500},
		{players: 4, bet: 999, ranking: []int{0, 2, 1, 3}, exits: []string{"", "", "", "bankrupt"}, payout: 3_947},
	} {
		t.Run(fmt.Sprintf("%d players bet %d", tc.players, tc.bet), func(t *testing.T) {
			ledger := newTycoonLedger(t, tc.players, tc.bet)
			ledger.escrow()
			for _, id := range ledger.players {
				if got := ledger.kenDelta(id); got != -tc.bet {
					t.Fatalf("after escrow %s ken delta %d, want %d", id, got, -tc.bet)
				}
			}
			winner, persisted := ledger.settle(tc.ranking, "win", tc.exits)
			if payout, _ := ledger.repo.WinnerAmounts(tycoonGameID, tc.bet, tc.players); payout != tc.payout {
				t.Fatalf("payout %d, want %d", payout, tc.payout)
			}
			ledger.assertWinnerTakesPot(winner, persisted)
		})
	}
}

func TestTycoonSettlementForfeitStillLosesTheBet(t *testing.T) {
	for _, tc := range []struct {
		name    string
		players int
		reason  string
		ranking []int
		exits   []string
	}{
		{name: "two players forfeit", players: 2, reason: "forfeit", ranking: []int{1, 0}, exits: []string{"forfeit", ""}},
		{name: "three players one forfeit", players: 3, reason: "win", ranking: []int{2, 0, 1}, exits: []string{"bankrupt", "forfeit", ""}},
		{name: "four players forfeit and timeouts", players: 4, reason: "forfeit", ranking: []int{1, 3, 0, 2}, exits: []string{"forfeit", "", "forfeit", "forfeit"}},
	} {
		t.Run(tc.name, func(t *testing.T) {
			const bet = 2_000
			ledger := newTycoonLedger(t, tc.players, bet)
			ledger.escrow()
			winner, persisted := ledger.settle(tc.ranking, tc.reason, tc.exits)
			ledger.assertWinnerTakesPot(winner, persisted)
			for seat, exit := range tc.exits {
				if exit == "forfeit" {
					if got := ledger.kenDelta(ledger.players[seat]); got != -bet {
						t.Fatalf("forfeiting seat %d ken delta %d, want %d", seat, got, -bet)
					}
				}
			}
		})
	}
}

func TestTycoonSettlementAbortRefundsEverySeat(t *testing.T) {
	for _, players := range []int{2, 4} {
		t.Run(fmt.Sprintf("%d players", players), func(t *testing.T) {
			const bet = 1_500
			ledger := newTycoonLedger(t, players, bet)
			ledger.escrow()

			ledger.mock.ExpectBegin()
			ledger.mock.ExpectQuery(`SELECT \* FROM "game_matches".*match_id = \$1.*FOR UPDATE`).
				WithArgs(ledger.matchID.String(), 1).
				WillReturnRows(ledger.matchRow())
			if players > 2 {
				seats := sqlmock.NewRows([]string{"game_match_id", "user_id", "seat"})
				for seat, id := range ledger.players {
					seats.AddRow(ledger.rowID, id, seat)
				}
				ledger.mock.ExpectQuery(`SELECT \* FROM "game_match_players" WHERE game_match_id = \$1 ORDER BY seat ASC`).
					WithArgs(ledger.rowID).
					WillReturnRows(seats)
			}
			for _, id := range orderedUserIDs(ledger.players...) {
				expectLockedUser(ledger.mock, id, ledger.balances[id])
			}
			for _, id := range orderedUserIDs(ledger.players...) {
				ledger.balances[id] += bet
				expectKenUpdate(ledger.mock, id, ledger.balances[id])
			}
			ledger.mock.ExpectExec(`UPDATE "game_matches" SET "finished_at"=\$1,"ken_delta"=\$2,"reason"=\$3,"status"=\$4,"updated_at"=\$5 WHERE id = \$6 AND status = \$7`).
				WithArgs(sqlmock.AnyArg(), 0, reasonVoid, matchStatusFinished, sqlmock.AnyArg(), ledger.rowID, matchStatusPlaying).
				WillReturnResult(sqlmock.NewResult(0, 1))
			ledger.mock.ExpectCommit()

			result, err := ledger.repo.abortMatch(context.Background(), ledger.matchID.String())
			if err != nil {
				t.Fatalf("abort: %v", err)
			}
			if len(result.userIDs) != players {
				t.Fatalf("abort refunded %d players, want %d", len(result.userIDs), players)
			}
			for _, id := range ledger.players {
				if got := ledger.kenDelta(id); got != 0 {
					t.Fatalf("player %s ken delta %d after refund, want 0", id, got)
				}
			}
		})
	}
}
