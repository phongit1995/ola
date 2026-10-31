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

	monthFrom, monthTo := leaderboardRangeAt(now, "month")
	if want := time.Date(2026, time.June, 30, 17, 0, 0, 0, time.UTC); !monthFrom.Equal(want) {
		t.Fatalf("month start=%s, want %s", monthFrom, want)
	}
	if !monthTo.Equal(now) {
		t.Fatalf("month end=%s, want %s", monthTo, now)
	}

	lateNight := time.Date(2026, time.July, 31, 18, 0, 0, 0, time.UTC)
	if from, _ := leaderboardRangeAt(lateNight, "month"); !from.Equal(time.Date(2026, time.July, 31, 17, 0, 0, 0, time.UTC)) {
		t.Fatalf("month start after GMT+7 midnight=%s, want August 1 local", from)
	}
}

func TestThirteenLeaderboardCountsEverySeat(t *testing.T) {
	db, mock := newSettlementMockDB(t)
	repo := &Repository{db: db}
	firstID := uuid.New()
	secondID := uuid.New()

	mock.ExpectQuery(`SELECT .* FROM "game_matches" CROSS JOIN LATERAL \( SELECT gmp\.user_id FROM game_match_players AS gmp .*game_matches\.player_count > 2 UNION ALL .*game_matches\.player_count <= 2 \) AS seats JOIN users ON users\.id = seats\.user_id .*game_matches\.game_id = \$1.*HAVING COUNT\(\*\) FILTER \(WHERE seats\.user_id = game_matches\.winner_id\) > 0 ORDER BY wins DESC, losses ASC, ken DESC.*LIMIT \$5`).
		WithArgs("thirteen", matchStatusFinished, sqlmock.AnyArg(), sqlmock.AnyArg(), leaderboardLimit).
		WillReturnRows(sqlmock.NewRows([]string{"user_id", "username", "vip_type", "vip_end_time", "ken", "wins", "losses", "game_exp"}).
			AddRow(firstID.String(), "vua_bai", nil, nil, int64(0), int64(5), int64(7), int64(900)).
			AddRow(secondID.String(), "tay_moi", nil, nil, int64(28_500), int64(5), int64(9), int64(0)))

	data, err := repo.Leaderboard("thirteen", "month")
	if err != nil {
		t.Fatal(err)
	}
	if data.Period != "month" {
		t.Fatalf("period=%q, want month", data.Period)
	}
	if len(data.Items) != 2 {
		t.Fatalf("items=%d, want 2", len(data.Items))
	}
	if got := data.Items[0]; got.Rank != 1 || got.UserID != firstID.String() || got.Wins != 5 || got.Losses != 7 || got.Level < 2 {
		t.Fatalf("unexpected first entry: %+v", got)
	}
	if got := data.Items[1]; got.Rank != 2 || got.Ken != 28_500 || got.Losses != 9 || got.Level != 1 {
		t.Fatalf("unexpected second entry: %+v", got)
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

	mock.ExpectQuery(`SELECT .* FROM "game_matches" LEFT JOIN users AS player0 .*game_matches\.game_id = \$1.*ORDER BY game_matches\.finished_at DESC.*LIMIT \$7`).
		WithArgs("caro", matchStatusFinished, userID, userID, userID, reasonVoid, matchHistoryLimit).
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
	if got := data.Items[0]; got.PlayerCount != 2 || got.Place != 1 || len(got.Players) != 2 ||
		got.Players[0].UserID != userID.String() || got.Players[1].Place != 2 {
		t.Fatalf("unexpected win players: %+v", got)
	}
	if got := data.Items[1]; got.Place != 2 || got.Players[0].UserID != loseOpponentID.String() || got.Players[0].Place != 1 {
		t.Fatalf("unexpected lose players: %+v", got)
	}
	if got := data.Items[2]; got.Place != 0 || got.Players[0].Place != 0 || got.Players[1].Place != 0 {
		t.Fatalf("unexpected draw players: %+v", got)
	}
}

func TestMatchHistoryIncludesMultiPlayerSeats(t *testing.T) {
	db, mock := newSettlementMockDB(t)
	repo := &Repository{db: db}
	userID := uuid.New()
	seat0 := uuid.New()
	seat1 := uuid.New()
	seat3 := uuid.New()
	fourID := uuid.New()
	threeID := uuid.New()
	now := time.Now()
	activeVip := "27"

	mock.ExpectQuery(`SELECT .* FROM "game_matches" .*game_matches\.player_count > 2 AND EXISTS \( SELECT 1 FROM game_match_players AS gmp WHERE gmp\.game_match_id = game_matches\.id AND gmp\.user_id = \$5\).*LIMIT \$7`).
		WithArgs("thirteen", matchStatusFinished, userID, userID, userID, reasonVoid, matchHistoryLimit).
		WillReturnRows(sqlmock.NewRows([]string{
			"game_match_id", "match_id", "played_at", "player_count", "player0_id", "player1_id", "winner_id",
			"bet", "ken_delta", "player0_name", "player1_name",
			"player0_vip", "player0_vip_end", "player1_vip", "player1_vip_end",
		}).
			AddRow(fourID, "m-four", now, 4, seat0, seat1, seat1, 10_000, 28_000, "a", "b", nil, nil, nil, nil).
			AddRow(threeID, "m-three", now.Add(-time.Minute), 3, seat0, userID, userID, 0, 0, "a", "you", nil, nil, nil, nil))
	mock.ExpectQuery(`SELECT .* FROM game_match_players AS seats LEFT JOIN users ON users\.id = seats\.user_id WHERE seats\.game_match_id IN \(\$1,\$2\) ORDER BY seats\.game_match_id ASC, seats\.seat ASC`).
		WithArgs(fourID, threeID).
		WillReturnRows(sqlmock.NewRows([]string{"game_match_id", "user_id", "place", "username", "vip_type", "vip_end_time"}).
			AddRow(fourID, seat0, 3, "a", nil, nil).
			AddRow(fourID, seat1, 1, "b", activeVip, now.Add(time.Hour)).
			AddRow(fourID, userID, 2, "you", nil, nil).
			AddRow(fourID, seat3, 4, nil, nil, nil).
			AddRow(threeID, seat0, nil, "a", nil, nil).
			AddRow(threeID, userID, nil, "you", nil, nil).
			AddRow(threeID, seat3, nil, "c", nil, nil))

	data, err := repo.MatchHistory("thirteen", userID.String())
	if err != nil {
		t.Fatal(err)
	}
	if len(data.Items) != 2 {
		t.Fatalf("items=%d, want 2", len(data.Items))
	}
	four := data.Items[0]
	if four.PlayerCount != 4 || four.Place != 2 || four.Outcome != "lose" || four.KenDelta != -10_000 || len(four.Players) != 4 {
		t.Fatalf("unexpected four-player entry: %+v", four)
	}
	wantOrder := []string{seat1.String(), userID.String(), seat0.String(), seat3.String()}
	for i, id := range wantOrder {
		if four.Players[i].UserID != id || four.Players[i].Place != i+1 {
			t.Fatalf("player %d = %+v, want %s at place %d", i, four.Players[i], id, i+1)
		}
	}
	if four.Players[0].VipType == nil || *four.Players[0].VipType != activeVip {
		t.Fatalf("winner vip=%v, want %s", four.Players[0].VipType, activeVip)
	}
	if four.Players[3].Username != seat3.String()[:8] {
		t.Fatalf("missing username fallback=%q", four.Players[3].Username)
	}
	if four.OpponentID != seat1.String() {
		t.Fatalf("opponent=%s, want winner %s", four.OpponentID, seat1)
	}

	three := data.Items[1]
	if three.PlayerCount != 3 || three.Place != 1 || three.Outcome != "win" || three.KenDelta != 0 ||
		three.Players[0].UserID != userID.String() || three.Players[1].Place != 0 || three.Players[2].Place != 0 {
		t.Fatalf("unexpected unranked three-player entry: %+v", three)
	}
}
