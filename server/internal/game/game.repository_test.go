package game

import (
	"testing"
	"time"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/google/uuid"
)

func TestLeaderboardRangeUsesGMT7Calendar(t *testing.T) {
	now := time.Date(2026, time.July, 25, 11, 30, 0, 0, time.UTC)

	dayFrom, dayTo := leaderboardRangeAt(now, "day")
	if want := time.Date(2026, time.July, 24, 17, 0, 0, 0, time.UTC); !dayFrom.Equal(want) {
		t.Fatalf("day start=%s, want %s", dayFrom, want)
	}
	if !dayTo.Equal(now) {
		t.Fatalf("day end=%s, want %s", dayTo, now)
	}

	weekFrom, weekTo := leaderboardRangeAt(now, "week")
	if want := time.Date(2026, time.July, 19, 17, 0, 0, 0, time.UTC); !weekFrom.Equal(want) {
		t.Fatalf("week start=%s, want %s", weekFrom, want)
	}
	if !weekTo.Equal(now) {
		t.Fatalf("week end=%s, want %s", weekTo, now)
	}
}

func TestLeaderboardReturnsRankedKenAndOnlyActiveVip(t *testing.T) {
	db, mock := newSettlementMockDB(t)
	repo := &Repository{db: db}
	activeID := uuid.New()
	expiredID := uuid.New()
	activeVip := "129"
	expiredVip := "45"

	mock.ExpectQuery(`SELECT .* FROM "game_matches" JOIN users .*game_matches\.game_id = \$1.*LIMIT \$5`).
		WithArgs("caro", matchStatusFinished, sqlmock.AnyArg(), sqlmock.AnyArg(), leaderboardLimit).
		WillReturnRows(sqlmock.NewRows([]string{"user_id", "username", "vip_type", "vip_end_time", "ken"}).
			AddRow(activeID.String(), "vua_caro", activeVip, time.Now().Add(time.Hour), int64(50000)).
			AddRow(expiredID.String(), "co_thu", expiredVip, time.Now().Add(-time.Hour), int64(25000)))

	data, err := repo.Leaderboard("caro", "unexpected")
	if err != nil {
		t.Fatal(err)
	}
	if data.Period != "day" {
		t.Fatalf("period=%q, want day", data.Period)
	}
	if len(data.Items) != 2 {
		t.Fatalf("items=%d, want 2", len(data.Items))
	}
	if got := data.Items[0]; got.Rank != 1 || got.UserID != activeID.String() || got.Username != "vua_caro" ||
		got.Ken != 50000 || got.VipType == nil || *got.VipType != activeVip {
		t.Fatalf("unexpected first entry: %+v", got)
	}
	if got := data.Items[1]; got.Rank != 2 || got.UserID != expiredID.String() || got.Ken != 25000 || got.VipType != nil {
		t.Fatalf("unexpected second entry: %+v", got)
	}
}

func TestMatchHistoryReturnsRealOpponentAndOutcome(t *testing.T) {
	db, mock := newSettlementMockDB(t)
	repo := &Repository{db: db}
	userID := uuid.New()
	winOpponentID := uuid.New()
	loseOpponentID := uuid.New()
	drawOpponentID := uuid.New()
	winMatchID := uuid.NewString()
	loseMatchID := uuid.NewString()
	drawMatchID := uuid.NewString()
	now := time.Now()

	mock.ExpectQuery(`SELECT .* FROM "game_matches" LEFT JOIN users AS player0 .*game_matches\.game_id = \$1.*ORDER BY game_matches\.finished_at DESC.*LIMIT \$6`).
		WithArgs("caro", matchStatusFinished, userID, userID, reasonVoid, matchHistoryLimit).
		WillReturnRows(sqlmock.NewRows([]string{
			"match_id", "played_at", "player0_id", "player1_id", "winner_id",
			"bet", "player0_name", "player1_name",
		}).
			AddRow(winMatchID, now, userID, winOpponentID, userID, 10_000, "you", "doi_thu_1").
			AddRow(loseMatchID, now.Add(-time.Minute), loseOpponentID, userID, loseOpponentID, 20_000, "doi_thu_2", "you").
			AddRow(drawMatchID, now.Add(-2*time.Minute), userID, drawOpponentID, nil, 0, "you", "doi_thu_3"))

	data, err := repo.MatchHistory("caro", userID.String())
	if err != nil {
		t.Fatal(err)
	}
	if len(data.Items) != 3 {
		t.Fatalf("items=%d, want 3", len(data.Items))
	}

	if got := data.Items[0]; got.ID != winMatchID || got.OpponentID != winOpponentID.String() ||
		got.OpponentName != "doi_thu_1" || got.Bet != 10_000 || got.Outcome != "win" ||
		got.PlayedAt != now.UnixMilli() {
		t.Fatalf("unexpected win history: %+v", got)
	}
	if got := data.Items[1]; got.ID != loseMatchID || got.OpponentID != loseOpponentID.String() ||
		got.OpponentName != "doi_thu_2" || got.Outcome != "lose" {
		t.Fatalf("unexpected lose history: %+v", got)
	}
	if got := data.Items[2]; got.ID != drawMatchID || got.OpponentID != drawOpponentID.String() ||
		got.OpponentName != "doi_thu_3" || got.Outcome != "draw" {
		t.Fatalf("unexpected draw history: %+v", got)
	}
}
