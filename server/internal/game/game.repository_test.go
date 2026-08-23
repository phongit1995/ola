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

func TestCaroLeaderboardReturnsWinLossRankingAndOnlyActiveVip(t *testing.T) {
	db, mock := newSettlementMockDB(t)
	repo := &Repository{db: db}
	activeID := uuid.New()
	expiredID := uuid.New()
	activeVip := "129"
	expiredVip := "45"

	mock.ExpectQuery(`SELECT .* FROM "game_matches" CROSS JOIN LATERAL .*JOIN users .*game_matches\.game_id = \$1.*ORDER BY wins DESC, losses ASC, ken DESC.*LIMIT \$5`).
		WithArgs("caro", matchStatusFinished, sqlmock.AnyArg(), sqlmock.AnyArg(), leaderboardLimit).
		WillReturnRows(sqlmock.NewRows([]string{"user_id", "username", "vip_type", "vip_end_time", "ken", "wins", "losses"}).
			AddRow(activeID.String(), "vua_caro", activeVip, time.Now().Add(time.Hour), int64(50000), int64(12), int64(3)).
			AddRow(expiredID.String(), "co_thu", expiredVip, time.Now().Add(-time.Hour), int64(25000), int64(10), int64(2)))

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
		got.Ken != 50000 || got.Wins != 12 || got.Losses != 3 ||
		got.VipType == nil || *got.VipType != activeVip {
		t.Fatalf("unexpected first entry: %+v", got)
	}
	if got := data.Items[1]; got.Rank != 2 || got.UserID != expiredID.String() || got.Ken != 25000 ||
		got.Wins != 10 || got.Losses != 2 || got.VipType != nil {
		t.Fatalf("unexpected second entry: %+v", got)
	}
}

func TestWarGodLeaderboardReturnsWinLossRanking(t *testing.T) {
	db, mock := newSettlementMockDB(t)
	repo := &Repository{db: db}
	userID := uuid.New()

	mock.ExpectQuery(`SELECT .* FROM "game_matches" CROSS JOIN LATERAL .*JOIN users .*game_matches\.game_id = \$1.*ORDER BY wins DESC, losses ASC, ken DESC.*LIMIT \$5`).
		WithArgs("war-god", matchStatusFinished, sqlmock.AnyArg(), sqlmock.AnyArg(), leaderboardLimit).
		WillReturnRows(sqlmock.NewRows([]string{"user_id", "username", "vip_type", "vip_end_time", "ken", "wins", "losses"}).
			AddRow(userID.String(), "chien_than", nil, nil, int64(80000), int64(9), int64(1)))

	data, err := repo.Leaderboard("war-god", "day")
	if err != nil {
		t.Fatal(err)
	}
	if len(data.Items) != 1 {
		t.Fatalf("items=%d, want 1", len(data.Items))
	}
	if got := data.Items[0]; got.Rank != 1 || got.UserID != userID.String() ||
		got.Ken != 80000 || got.Wins != 9 || got.Losses != 1 {
		t.Fatalf("unexpected entry: %+v", got)
	}
}

func TestOtherGameLeaderboardKeepsKenRanking(t *testing.T) {
	db, mock := newSettlementMockDB(t)
	repo := &Repository{db: db}

	mock.ExpectQuery(`SELECT .* FROM "game_matches" JOIN users .*game_matches\.game_id = \$1.*HAVING COALESCE\(SUM\(game_matches\.ken_delta\), 0\) > 0 ORDER BY ken DESC, COUNT\(\*\) DESC.*LIMIT \$5`).
		WithArgs("other-game", matchStatusFinished, sqlmock.AnyArg(), sqlmock.AnyArg(), leaderboardLimit).
		WillReturnRows(sqlmock.NewRows([]string{"user_id", "username", "vip_type", "vip_end_time", "ken"}))

	data, err := repo.Leaderboard("other-game", "day")
	if err != nil {
		t.Fatal(err)
	}
	if len(data.Items) != 0 {
		t.Fatalf("items=%d, want 0", len(data.Items))
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
	activeVip := "12"
	expiredVip := "7"

	mock.ExpectQuery(`SELECT .* FROM "game_matches" LEFT JOIN users AS player0 .*game_matches\.game_id = \$1.*ORDER BY game_matches\.finished_at DESC.*LIMIT \$6`).
		WithArgs("caro", matchStatusFinished, userID, userID, reasonVoid, matchHistoryLimit).
		WillReturnRows(sqlmock.NewRows([]string{
			"match_id", "played_at", "player0_id", "player1_id", "winner_id",
			"bet", "ken_delta", "player0_name", "player1_name",
			"player0_vip", "player0_vip_end", "player1_vip", "player1_vip_end",
		}).
			AddRow(winMatchID, now, userID, winOpponentID, userID, 10_000, 9_500, "you", "doi_thu_1",
				nil, nil, activeVip, now.Add(time.Hour)).
			AddRow(loseMatchID, now.Add(-time.Minute), loseOpponentID, userID, loseOpponentID, 20_000, 19_000, "doi_thu_2", "you",
				expiredVip, now.Add(-time.Hour), nil, nil).
			AddRow(drawMatchID, now.Add(-2*time.Minute), userID, drawOpponentID, nil, 0, 0, "you", "doi_thu_3",
				nil, nil, nil, nil))

	data, err := repo.MatchHistory("caro", userID.String())
	if err != nil {
		t.Fatal(err)
	}
	if len(data.Items) != 3 {
		t.Fatalf("items=%d, want 3", len(data.Items))
	}

	if got := data.Items[0]; got.ID != winMatchID || got.OpponentID != winOpponentID.String() ||
		got.OpponentName != "doi_thu_1" || got.Bet != 10_000 || got.Outcome != "win" ||
		got.KenDelta != 9_500 || got.PlayedAt != now.UnixMilli() ||
		got.OpponentVipType == nil || *got.OpponentVipType != activeVip {
		t.Fatalf("unexpected win history: %+v", got)
	}
	if got := data.Items[1]; got.ID != loseMatchID || got.OpponentID != loseOpponentID.String() ||
		got.OpponentName != "doi_thu_2" || got.Outcome != "lose" || got.KenDelta != -20_000 ||
		got.OpponentVipType != nil {
		t.Fatalf("unexpected lose history: %+v", got)
	}
	if got := data.Items[2]; got.ID != drawMatchID || got.OpponentID != drawOpponentID.String() ||
		got.OpponentName != "doi_thu_3" || got.Outcome != "draw" || got.KenDelta != 0 {
		t.Fatalf("unexpected draw history: %+v", got)
	}
}
