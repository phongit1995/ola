package game

import (
	"bytes"
	"cmp"
	"math/rand/v2"
	"slices"
	"strings"
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

	data, err := repo.Leaderboard("thirteen", "month", "", "")
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

	data, err := repo.Leaderboard("caro", "unexpected", "", "")
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

	data, err := repo.Leaderboard("war-god", "day", "", "")
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

	data, err := repo.Leaderboard("other-game", "day", "", "")
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

func TestLevelLeaderboardRanksByExpAndReturnsExp(t *testing.T) {
	db, mock := newSettlementMockDB(t)
	repo := &Repository{db: db}
	topID := uuid.New()

	mock.ExpectQuery(`SELECT .* FROM user_game_levels AS levels JOIN users ON users\.id = levels\.user_id WHERE levels\.game_id = \$1 AND levels\.exp > 0 .*ORDER BY levels\.exp DESC, users\.username ASC, levels\.user_id ASC LIMIT \$2`).
		WithArgs("tycoon", leaderboardLimit).
		WillReturnRows(sqlmock.NewRows([]string{"user_id", "username", "vip_type", "vip_end_time", "ken", "wins", "losses", "game_exp"}).
			AddRow(topID.String(), "cay_cap", nil, nil, int64(0), int64(0), int64(0), int64(900)))

	data, err := repo.Leaderboard("tycoon", "week", "level", topID.String())
	if err != nil {
		t.Fatal(err)
	}
	if data.Board != "level" || len(data.Items) != 1 {
		t.Fatalf("unexpected data: %+v", data)
	}
	if got := data.Items[0]; got.Exp != 900 || got.Level < 2 || got.Matches != 0 {
		t.Fatalf("unexpected entry: %+v", got)
	}
	if data.Me == nil || data.Me.Rank != 1 || data.Me.UserID != topID.String() {
		t.Fatalf("me=%+v, want the top row", data.Me)
	}
}

func TestTycoonLeaderboardFindsMeOutsideTop(t *testing.T) {
	db, mock := newSettlementMockDB(t)
	repo := &Repository{db: db}
	meID := uuid.New()
	columns := []string{"user_id", "username", "vip_type", "vip_end_time", "ken", "wins", "losses", "game_exp"}
	top := sqlmock.NewRows(columns)
	for i := 0; i < leaderboardLimit; i++ {
		top.AddRow(uuid.New().String(), "top", nil, nil, int64(0), int64(3), int64(1), int64(0))
	}

	mock.ExpectQuery(`SELECT .* FROM "game_matches" CROSS JOIN LATERAL .* ORDER BY wins DESC, losses ASC, ken DESC.*LIMIT \$5`).
		WithArgs("tycoon", matchStatusFinished, sqlmock.AnyArg(), sqlmock.AnyArg(), leaderboardLimit).
		WillReturnRows(top)
	mock.ExpectQuery(`SELECT seats\.user_id, .* FROM "game_matches" CROSS JOIN LATERAL .* AND seats\.user_id = \$5 GROUP BY seats\.user_id, .* HAVING .* LIMIT \$6$`).
		WithArgs("tycoon", matchStatusFinished, sqlmock.AnyArg(), sqlmock.AnyArg(), meID, 1).
		WillReturnRows(sqlmock.NewRows(columns).
			AddRow(meID.String(), "toi", nil, nil, int64(7), int64(1), int64(4), int64(0)))
	mock.ExpectQuery(`^SELECT COUNT\(\*\) FROM \(SELECT seats\.user_id, .* HAVING COUNT\(\*\) FILTER \(WHERE seats\.user_id = game_matches\.winner_id\) > 0\) AS board_rows WHERE board_rows\.wins >= \$5 AND \(board_rows\.wins > \$6 OR \(board_rows\.wins = \$7 AND \(board_rows\.losses < \$8 OR \(board_rows\.losses = \$9 AND \(board_rows\.ken > \$10 OR \(board_rows\.ken = \$11 AND \(board_rows\.username < \$12 OR \(board_rows\.username = \$13 AND \(board_rows\.user_id < \$14\)\)\)\)\)\)\)\)\)$`).
		WithArgs("tycoon", matchStatusFinished, sqlmock.AnyArg(), sqlmock.AnyArg(),
			int64(1), int64(1), int64(1), int64(4), int64(4), int64(7), int64(7), "toi", "toi", meID).
		WillReturnRows(sqlmock.NewRows([]string{"count"}).AddRow(int64(136)))

	data, err := repo.Leaderboard("tycoon", "day", "", meID.String())
	if err != nil {
		t.Fatal(err)
	}
	if data.Board != "wins" || len(data.Items) != leaderboardLimit || data.Items[0].Matches != 4 {
		t.Fatalf("unexpected board=%q items=%d first=%+v", data.Board, len(data.Items), data.Items[0])
	}
	if data.Me == nil || data.Me.Rank != 137 || data.Me.Wins != 1 || data.Me.Matches != 5 || data.Me.Ken != 7 {
		t.Fatalf("me=%+v, want rank 137 with 5 matches", data.Me)
	}
	if err := mock.ExpectationsWereMet(); err != nil {
		t.Fatal(err)
	}
}

func fullLeaderboardRows(columns []string, row func(*sqlmock.Rows)) *sqlmock.Rows {
	rows := sqlmock.NewRows(columns)
	for i := 0; i < leaderboardLimit; i++ {
		row(rows)
	}
	return rows
}

func TestLevelLeaderboardCountsUsersAheadOfMeOutsideTop(t *testing.T) {
	db, mock := newSettlementMockDB(t)
	repo := &Repository{db: db}
	meID := uuid.New()
	columns := []string{"user_id", "username", "vip_type", "vip_end_time", "ken", "wins", "losses", "game_exp"}

	mock.ExpectQuery(`FROM user_game_levels AS levels .*ORDER BY levels\.exp DESC, users\.username ASC, levels\.user_id ASC LIMIT \$2`).
		WithArgs("thirteen", leaderboardLimit).
		WillReturnRows(fullLeaderboardRows(columns, func(rows *sqlmock.Rows) {
			rows.AddRow(uuid.New().String(), "top", nil, nil, int64(0), int64(0), int64(0), int64(5000))
		}))
	mock.ExpectQuery(`^SELECT levels\.user_id, .* FROM user_game_levels AS levels JOIN users ON users\.id = levels\.user_id WHERE \(levels\.game_id = \$1 AND levels\.exp > 0 AND users\.deleted_at IS NULL\) AND levels\.user_id = \$2 LIMIT \$3$`).
		WithArgs("thirteen", meID, 1).
		WillReturnRows(sqlmock.NewRows(columns).
			AddRow(meID.String(), "toi", nil, nil, int64(0), int64(0), int64(0), int64(420)))
	mock.ExpectQuery(`^SELECT COUNT\(\*\) FROM \(SELECT levels\.user_id, .* FROM user_game_levels AS levels JOIN users ON users\.id = levels\.user_id WHERE levels\.game_id = \$1 AND levels\.exp > 0 AND users\.deleted_at IS NULL\) AS board_rows WHERE board_rows\.game_exp >= \$2 AND \(board_rows\.game_exp > \$3 OR \(board_rows\.game_exp = \$4 AND \(board_rows\.username < \$5 OR \(board_rows\.username = \$6 AND \(board_rows\.user_id < \$7\)\)\)\)\)$`).
		WithArgs("thirteen", int64(420), int64(420), int64(420), "toi", "toi", meID).
		WillReturnRows(sqlmock.NewRows([]string{"count"}).AddRow(int64(250)))

	data, err := repo.Leaderboard("thirteen", "day", "level", meID.String())
	if err != nil {
		t.Fatal(err)
	}
	if data.Me == nil || data.Me.Rank != 251 || data.Me.Exp != 420 || data.Me.Matches != 0 {
		t.Fatalf("me=%+v, want rank 251 with exp 420", data.Me)
	}
}

func TestLeaderboardSkipsRankCountWhenMeIsNotOnBoard(t *testing.T) {
	db, mock := newSettlementMockDB(t)
	repo := &Repository{db: db}
	meID := uuid.New()
	columns := []string{"user_id", "username", "vip_type", "vip_end_time", "ken", "wins", "losses", "game_exp"}

	mock.ExpectQuery(`FROM "game_matches" CROSS JOIN LATERAL .*LIMIT \$5`).
		WithArgs("thirteen", matchStatusFinished, sqlmock.AnyArg(), sqlmock.AnyArg(), leaderboardLimit).
		WillReturnRows(fullLeaderboardRows(columns, func(rows *sqlmock.Rows) {
			rows.AddRow(uuid.New().String(), "top", nil, nil, int64(0), int64(3), int64(1), int64(0))
		}))
	mock.ExpectQuery(`AND seats\.user_id = \$5 GROUP BY .* LIMIT \$6$`).
		WithArgs("thirteen", matchStatusFinished, sqlmock.AnyArg(), sqlmock.AnyArg(), meID, 1).
		WillReturnRows(sqlmock.NewRows(columns))

	data, err := repo.Leaderboard("thirteen", "week", "wins", meID.String())
	if err != nil {
		t.Fatal(err)
	}
	if data.Me != nil || len(data.Items) != leaderboardLimit {
		t.Fatalf("me=%+v items=%d, want no pinned row", data.Me, len(data.Items))
	}
}

func TestCaroLeaderboardMeQueryUsesWinnerOrLoserFilter(t *testing.T) {
	db, mock := newSettlementMockDB(t)
	repo := &Repository{db: db}
	meID := uuid.New()
	columns := []string{"user_id", "username", "vip_type", "vip_end_time", "ken", "wins", "losses", "game_exp"}

	mock.ExpectQuery(`FROM "game_matches" CROSS JOIN LATERAL \(VALUES.*LIMIT \$5`).
		WithArgs("caro", matchStatusFinished, sqlmock.AnyArg(), sqlmock.AnyArg(), leaderboardLimit).
		WillReturnRows(fullLeaderboardRows(columns, func(rows *sqlmock.Rows) {
			rows.AddRow(uuid.New().String(), "top", nil, nil, int64(10), int64(3), int64(0), int64(0))
		}))
	mock.ExpectQuery(`AND \(\(game_matches\.winner_id = \$5 OR game_matches\.loser_id = \$6\) AND results\.user_id = \$7\) GROUP BY results\.user_id, .* LIMIT \$8$`).
		WithArgs("caro", matchStatusFinished, sqlmock.AnyArg(), sqlmock.AnyArg(), meID, meID, meID, 1).
		WillReturnRows(sqlmock.NewRows(columns).
			AddRow(meID.String(), "toi", nil, nil, int64(5), int64(2), int64(2), int64(0)))
	mock.ExpectQuery(`^SELECT COUNT\(\*\) FROM \(SELECT results\.user_id, .*\) AS board_rows WHERE board_rows\.wins >= \$5 AND .*board_rows\.user_id < \$14\)+$`).
		WithArgs("caro", matchStatusFinished, sqlmock.AnyArg(), sqlmock.AnyArg(),
			int64(2), int64(2), int64(2), int64(2), int64(2), int64(5), int64(5), "toi", "toi", meID).
		WillReturnRows(sqlmock.NewRows([]string{"count"}).AddRow(int64(100)))

	data, err := repo.Leaderboard("caro", "day", "", meID.String())
	if err != nil {
		t.Fatal(err)
	}
	if data.Me == nil || data.Me.Rank != 101 || data.Me.Matches != 4 {
		t.Fatalf("me=%+v, want rank 101", data.Me)
	}
}

func TestTycoonMatchHistoryReturnsEndAndExitReasons(t *testing.T) {
	db, mock := newSettlementMockDB(t)
	repo := &Repository{db: db}
	userID := uuid.New()
	winnerID := uuid.New()
	rowID := uuid.New()
	matchID := uuid.NewString()
	now := time.Now()
	place1, place2 := 1, 2
	forfeit := "forfeit"
	endReason := "groups"

	mock.ExpectQuery(`SELECT .*game_matches\.end_reason.* FROM "game_matches" .*game_matches\.game_id = \$1.*LIMIT \$7`).
		WithArgs("tycoon", matchStatusFinished, userID, userID, userID, reasonVoid, matchHistoryLimit).
		WillReturnRows(sqlmock.NewRows([]string{
			"game_match_id", "match_id", "played_at", "player_count", "player0_id", "player1_id", "winner_id",
			"bet", "ken_delta", "end_reason", "player0_name", "player1_name",
		}).AddRow(rowID, matchID, now, 2, winnerID, userID, winnerID, 5_000, 4_750, endReason, "chu_dat", "you"))
	mock.ExpectQuery(`SELECT seats\.game_match_id, seats\.user_id, seats\.place, seats\.exit_reason.* FROM game_match_players AS seats .*WHERE seats\.game_match_id IN \(\$1\)`).
		WithArgs(rowID).
		WillReturnRows(sqlmock.NewRows([]string{"game_match_id", "user_id", "place", "exit_reason", "username"}).
			AddRow(rowID, winnerID, place1, nil, "chu_dat").
			AddRow(rowID, userID, place2, forfeit, "you"))

	data, err := repo.MatchHistory("tycoon", userID.String())
	if err != nil {
		t.Fatal(err)
	}
	if len(data.Items) != 1 {
		t.Fatalf("items=%d, want 1", len(data.Items))
	}
	got := data.Items[0]
	if got.EndReason != endReason || got.ExitReason != forfeit || got.Place != 2 || got.KenDelta != -5_000 || got.OpponentID != winnerID.String() {
		t.Fatalf("unexpected entry: %+v", got)
	}
	if len(got.Players) != 2 || got.Players[0].KenDelta != 4_750 || got.Players[1].ExitReason != forfeit || got.Players[1].KenDelta != -5_000 {
		t.Fatalf("unexpected players: %+v", got.Players)
	}
	if err := mock.ExpectationsWereMet(); err != nil {
		t.Fatal(err)
	}
}

type aheadNode struct {
	op       string
	children []aheadNode
	column   string
	cmp      string
	arg      int
}

func parseAheadCondition(t *testing.T, cond string) aheadNode {
	t.Helper()
	tokens := strings.Fields(strings.NewReplacer("(", " ( ", ")", " ) ").Replace(cond))
	pos, arg := 0, 0
	var expr func() aheadNode
	factor := func() aheadNode {
		if tokens[pos] == "(" {
			pos++
			node := expr()
			if tokens[pos] != ")" {
				t.Fatalf("expected ) at %d in %q", pos, cond)
			}
			pos++
			return node
		}
		column := strings.TrimPrefix(tokens[pos], "board_rows.")
		if column == tokens[pos] || tokens[pos+2] != "?" {
			t.Fatalf("unexpected comparison at %d in %q", pos, cond)
		}
		node := aheadNode{column: column, cmp: tokens[pos+1], arg: arg}
		pos += 3
		arg++
		return node
	}
	chain := func(op string, next func() aheadNode) aheadNode {
		node := aheadNode{op: op, children: []aheadNode{next()}}
		for pos < len(tokens) && tokens[pos] == op {
			pos++
			node.children = append(node.children, next())
		}
		return node
	}
	term := func() aheadNode { return chain("AND", factor) }
	expr = func() aheadNode { return chain("OR", term) }
	node := expr()
	if pos != len(tokens) {
		t.Fatalf("trailing tokens in %q", cond)
	}
	return node
}

func compareLeaderboardColumn(row leaderboardRow, column string, value any) int {
	switch column {
	case "user_id":
		other := value.(uuid.UUID)
		return bytes.Compare(row.UserID[:], other[:])
	case "username":
		return strings.Compare(row.Username, value.(string))
	}
	var mine int64
	switch column {
	case "wins":
		mine = row.Wins
	case "losses":
		mine = row.Losses
	case "ken":
		mine = row.Ken
	case "game_exp":
		mine = row.GameExp
	case "matches":
		mine = row.Matches
	default:
		panic(column)
	}
	return cmp.Compare(mine, value.(int64))
}

func evalAhead(node aheadNode, row leaderboardRow, args []any) bool {
	switch node.op {
	case "AND":
		for _, child := range node.children {
			if !evalAhead(child, row, args) {
				return false
			}
		}
		return true
	case "OR":
		for _, child := range node.children {
			if evalAhead(child, row, args) {
				return true
			}
		}
		return false
	}
	c := compareLeaderboardColumn(row, node.column, args[node.arg])
	switch node.cmp {
	case ">":
		return c > 0
	case ">=":
		return c >= 0
	case "<":
		return c < 0
	case "<=":
		return c <= 0
	case "=":
		return c == 0
	}
	panic(node.cmp)
}

func valueOfColumn(row leaderboardRow, column string) any {
	switch column {
	case "user_id":
		return row.UserID
	case "username":
		return row.Username
	case "wins":
		return row.Wins
	case "losses":
		return row.Losses
	case "ken":
		return row.Ken
	case "game_exp":
		return row.GameExp
	case "matches":
		return row.Matches
	}
	panic(column)
}

func TestLeaderboardAheadCountMatchesRowNumberOnTies(t *testing.T) {
	db, _ := newSettlementMockDB(t)
	repo := &Repository{db: db}
	keysFor := func(gameID, board string) []leaderboardKey {
		return repo.leaderboardQuery(gameID, board, time.Time{}, time.Time{}).keys
	}
	legacyRankOrders := map[string]struct {
		gameID string
		board  string
	}{
		"wins DESC, losses ASC, ken DESC, username ASC, user_id ASC": {gameID: "tycoon"},
		"game_exp DESC, username ASC, user_id ASC":                   {gameID: "tycoon", board: "level"},
		"ken DESC, matches DESC, username ASC, user_id ASC":          {gameID: "other-game"},
	}
	for _, gameID := range []string{"thirteen", "caro", "war-god", "xiangqi"} {
		if got := keysFor(gameID, ""); len(got) != len(leaderboardKeysWinLoss) || got[0].column != "wins" {
			t.Fatalf("%s keys=%d, want win/loss keys", gameID, len(got))
		}
	}
	rng := rand.New(rand.NewPCG(7, 11))
	names := []string{"an", "An", "binh", "chi", "chi"}
	for rankOrder, target := range legacyRankOrders {
		keys := keysFor(target.gameID, target.board)
		var parts []string
		for _, key := range keys {
			dir := "ASC"
			if key.desc {
				dir = "DESC"
			}
			parts = append(parts, key.column+" "+dir)
		}
		if got := strings.Join(parts, ", "); got != rankOrder {
			t.Fatalf("keys order %q, want legacy %q", got, rankOrder)
		}
		for round := 0; round < 50; round++ {
			rows := make([]leaderboardRow, 40)
			for i := range rows {
				rows[i] = leaderboardRow{
					UserID:   uuid.New(),
					Username: names[rng.IntN(len(names))],
					Wins:     rng.Int64N(3) + 1,
					Losses:   rng.Int64N(3),
					Ken:      rng.Int64N(2) * 100,
					GameExp:  rng.Int64N(3) * 50,
					Matches:  rng.Int64N(2) + 1,
				}
			}
			sorted := slices.Clone(rows)
			slices.SortFunc(sorted, func(a, b leaderboardRow) int {
				for _, part := range strings.Split(rankOrder, ", ") {
					column, dir, _ := strings.Cut(part, " ")
					c := compareLeaderboardColumn(a, column, valueOfColumn(b, column))
					if dir == "DESC" {
						c = -c
					}
					if c != 0 {
						return c
					}
				}
				return 0
			})
			for want, me := range sorted {
				cond, args := leaderboardAheadCondition(keys, me)
				tree := parseAheadCondition(t, cond)
				ahead := 0
				for _, other := range rows {
					if evalAhead(tree, other, args) {
						ahead++
					}
				}
				if ahead+1 != want+1 {
					t.Fatalf("%s: rank=%d, ROW_NUMBER=%d for %+v", rankOrder, ahead+1, want+1, me)
				}
			}
		}
	}
}
