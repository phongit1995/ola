package admingamematch

import (
	"testing"
	"time"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/google/uuid"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

func newMockDB(t *testing.T) (*gorm.DB, sqlmock.Sqlmock) {
	t.Helper()
	sqlDB, mock, err := sqlmock.New(sqlmock.QueryMatcherOption(sqlmock.QueryMatcherRegexp))
	if err != nil {
		t.Fatalf("create sqlmock: %v", err)
	}
	t.Cleanup(func() {
		mock.ExpectClose()
		if err := sqlDB.Close(); err != nil {
			t.Errorf("close sqlmock DB: %v", err)
		}
		if err := mock.ExpectationsWereMet(); err != nil {
			t.Errorf("unmet SQL expectations: %v", err)
		}
	})
	db, err := gorm.Open(postgres.New(postgres.Config{Conn: sqlDB}), &gorm.Config{Logger: logger.Default.LogMode(logger.Silent)})
	if err != nil {
		t.Fatalf("open gorm DB: %v", err)
	}
	return db, mock
}

func intPtr(v int) *int { return &v }

func TestMatchViewTwoPlayerRanksWinnerFirst(t *testing.T) {
	p0, p1 := uuid.New(), uuid.New()
	row := matchRow{
		ID: uuid.New(), GameID: "caro", Player0ID: p0, Player1ID: p1, WinnerID: &p1,
		Status: "finished", Bet: 10_000, KenDelta: 9_500, PlayerCount: 2,
		Player0Username: "a", Player1Username: "b", StartedAt: time.Now(),
	}

	view := matchView(row, nil)

	if view.PlayerCount != 2 || view.HouseTake != 500 {
		t.Fatalf("playerCount=%d houseTake=%d, want 2 and 500", view.PlayerCount, view.HouseTake)
	}
	if len(view.Players) != 2 || view.Players[0].User.ID != p1.String() || view.Players[0].Place != 1 ||
		view.Players[1].User.ID != p0.String() || view.Players[1].Place != 2 || view.Players[1].Seat != 0 {
		t.Fatalf("unexpected players: %+v", view.Players)
	}
}

func TestMatchViewDrawHasNoPlaces(t *testing.T) {
	row := matchRow{ID: uuid.New(), Player0ID: uuid.New(), Player1ID: uuid.New(), Status: "finished", Bet: 5_000, StartedAt: time.Now()}

	view := matchView(row, nil)

	if view.HouseTake != 0 || view.Players[0].Place != 0 || view.Players[1].Place != 0 || view.Players[0].Seat != 0 {
		t.Fatalf("unexpected draw view: %+v", view)
	}
}

func TestMatchViewFourPlayerUsesSeatsAndWholeTableStake(t *testing.T) {
	ids := []uuid.UUID{uuid.New(), uuid.New(), uuid.New(), uuid.New()}
	row := matchRow{
		ID: uuid.New(), GameID: "thirteen", Player0ID: ids[0], Player1ID: ids[1], WinnerID: &ids[2],
		Status: "finished", Bet: 10_000, KenDelta: 29_500, PlayerCount: 4, StartedAt: time.Now(),
	}
	seats := []matchSeatRow{
		{UserID: ids[0], Seat: 0, Place: intPtr(3), Username: "s0"},
		{UserID: ids[1], Seat: 1, Place: intPtr(4), Username: "s1"},
		{UserID: ids[2], Seat: 2, Place: intPtr(1), Username: "s2"},
		{UserID: ids[3], Seat: 3, Place: intPtr(2)},
	}

	view := matchView(row, seats)

	if view.PlayerCount != 4 || view.HouseTake != 500 {
		t.Fatalf("playerCount=%d houseTake=%d, want 4 and 500", view.PlayerCount, view.HouseTake)
	}
	wantSeats := []int{2, 3, 0, 1}
	for i, seat := range wantSeats {
		if got := view.Players[i]; got.Seat != seat || got.Place != i+1 {
			t.Fatalf("player %d = %+v, want seat %d place %d", i, got, seat, i+1)
		}
	}
	if view.Players[1].User.Username != ids[3].String()[:8] {
		t.Fatalf("missing username fallback=%q", view.Players[1].User.Username)
	}
}

func TestMatchViewUnrankedTableKeepsSeatOrderAfterWinner(t *testing.T) {
	ids := []uuid.UUID{uuid.New(), uuid.New(), uuid.New()}
	row := matchRow{ID: uuid.New(), Player0ID: ids[0], Player1ID: ids[1], WinnerID: &ids[1], Status: "finished", PlayerCount: 3, StartedAt: time.Now()}
	seats := []matchSeatRow{{UserID: ids[0], Seat: 0}, {UserID: ids[1], Seat: 1}, {UserID: ids[2], Seat: 2}}

	view := matchView(row, seats)

	if view.Players[0].Seat != 1 || view.Players[0].Place != 1 || view.Players[1].Seat != 0 || view.Players[2].Seat != 2 || view.Players[2].Place != 0 {
		t.Fatalf("unexpected unranked order: %+v", view.Players)
	}
}

func TestListMatchesLoadsSeatsOnlyForMultiSeatTables(t *testing.T) {
	db, mock := newMockDB(t)
	service := NewService(NewRepository(db))
	userID := uuid.New()
	pairID, tableID := uuid.New(), uuid.New()
	p0, p1, p2, p3 := uuid.New(), uuid.New(), uuid.New(), uuid.New()

	mock.ExpectQuery(`SELECT count\(\*\) FROM "game_matches" WHERE game_matches\.deleted_at IS NULL AND \(+game_matches\.player0_id = \$1 OR game_matches\.player1_id = \$2 OR \(game_matches\.player_count > 2 AND EXISTS \( SELECT 1 FROM game_match_players AS gmp WHERE gmp\.game_match_id = game_matches\.id AND gmp\.user_id = \$3\)+$`).
		WithArgs(userID, userID, userID).
		WillReturnRows(sqlmock.NewRows([]string{"count"}).AddRow(2))
	mock.ExpectQuery(`SELECT .*game_matches\.player_count.* FROM "game_matches" LEFT JOIN users AS player0 .*gmp\.user_id = \$3.*LIMIT \$4`).
		WithArgs(userID, userID, userID, 20).
		WillReturnRows(sqlmock.NewRows([]string{"id", "game_id", "player0_id", "player1_id", "winner_id", "status", "bet", "ken_delta", "player_count", "started_at"}).
			AddRow(tableID, "thirteen", p0, p1, p2, "finished", 0, 0, 4, time.Now()).
			AddRow(pairID, "caro", p0, p1, p0, "finished", 0, 0, 2, time.Now()))
	mock.ExpectQuery(`SELECT .* FROM game_match_players AS seats LEFT JOIN users ON users\.id = seats\.user_id WHERE seats\.game_match_id IN \(\$1\) ORDER BY seats\.game_match_id ASC, seats\.seat ASC`).
		WithArgs(tableID).
		WillReturnRows(sqlmock.NewRows([]string{"game_match_id", "user_id", "seat", "place", "username"}).
			AddRow(tableID, p0, 0, 2, "a").
			AddRow(tableID, p1, 1, 3, "b").
			AddRow(tableID, p2, 2, 1, "c").
			AddRow(tableID, p3, 3, 4, "d"))

	res, err := service.ListMatches(AdminMatchFilter{UserID: &userID}, 20, 0)
	if err != nil {
		t.Fatal(err)
	}
	if res.Total != 2 || len(res.Items) != 2 {
		t.Fatalf("total=%d items=%d, want 2/2", res.Total, len(res.Items))
	}
	if table := res.Items[0]; table.PlayerCount != 4 || len(table.Players) != 4 || table.Players[0].User.Username != "c" || table.Players[3].User.Username != "d" {
		t.Fatalf("unexpected table view: %+v", table)
	}
	if pair := res.Items[1]; pair.PlayerCount != 2 || len(pair.Players) != 2 || pair.Players[0].User.ID != p0.String() {
		t.Fatalf("unexpected pair view: %+v", pair)
	}
}

func TestPlayerAggregatesCountEverySeat(t *testing.T) {
	db, mock := newMockDB(t)
	repo := NewRepository(db)

	mock.ExpectQuery(`SELECT seats\.user_id AS user_id.*count\(\*\) filter \(where game_matches\.winner_id <> seats\.user_id\) AS losses.*WHEN game_matches\.winner_id IS NOT NULL THEN -game_matches\.bet.* FROM "game_matches" CROSS JOIN LATERAL \( SELECT gmp\.user_id FROM game_match_players AS gmp .* AS seats JOIN users ON users\.id = seats\.user_id .*GROUP BY seats\.user_id.*HAVING count\(\*\) >= \$2 ORDER BY net_ken DESC LIMIT \$3`).
		WithArgs("thirteen", 1, 10).
		WillReturnRows(sqlmock.NewRows([]string{"user_id", "username", "matches", "wins", "losses", "staked", "net_ken"}).
			AddRow(uuid.New(), "vua_bai", 4, 1, 3, 40_000, -500))

	rows, err := repo.PlayerAggregates(AdminMatchFilter{GameID: "thirteen"}, 1, 10)
	if err != nil {
		t.Fatal(err)
	}
	if len(rows) != 1 || rows[0].Losses != 3 || rows[0].NetKen != -500 {
		t.Fatalf("unexpected rows: %+v", rows)
	}
}

func TestPairAggregatesPairEverySeatOfATable(t *testing.T) {
	db, mock := newMockDB(t)
	repo := NewRepository(db)

	mock.ExpectQuery(`SELECT seat_a\.user_id AS a_id, seat_b\.user_id AS b_id.*winner_id IN \(seat_a\.user_id, seat_b\.user_id\)\) AS decided.* AS seat_a CROSS JOIN LATERAL .* AS seat_b WHERE .*seat_a\.user_id < seat_b\.user_id.*GROUP BY seat_a\.user_id, seat_b\.user_id HAVING count\(\*\) >= \$1 ORDER BY matches DESC LIMIT \$2`).
		WithArgs(3, 20).
		WillReturnRows(sqlmock.NewRows([]string{"a_id", "b_id", "matches", "decided"}).AddRow(uuid.New(), uuid.New(), 5, 4))

	rows, err := repo.PairAggregates(AdminMatchFilter{}, 3, 20)
	if err != nil {
		t.Fatal(err)
	}
	if len(rows) != 1 || rows[0].Decided != 4 {
		t.Fatalf("unexpected rows: %+v", rows)
	}
}

func TestStatsUseWholeTableStake(t *testing.T) {
	db, mock := newMockDB(t)
	repo := NewRepository(db)

	mock.ExpectQuery(`sum\(bet::bigint \* GREATEST\(player_count, 2\)\) filter \(where status = 'finished'\), 0\) as total_volume, .*sum\(bet::bigint \* \(GREATEST\(player_count, 2\) - 1\) - ken_delta\) filter`).
		WillReturnRows(sqlmock.NewRows([]string{"total_matches", "total_volume", "house_take"}).AddRow(1, int64(2_160_000_000), int64(5_000_000)))

	o, err := repo.StatsOverview(AdminMatchFilter{})
	if err != nil {
		t.Fatal(err)
	}
	if o.TotalVolume != 2_160_000_000 || o.HouseTake != 5_000_000 {
		t.Fatalf("unexpected overview: %+v", o)
	}
}
