package game

import (
	"bytes"
	"context"
	"errors"
	"log"
	"math"
	"strings"
	"testing"
	"time"

	"ola-chat-server/internal/game/engine"
	"ola-chat-server/internal/game/progression"
	"ola-chat-server/internal/models"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

func newSettlementMockDB(t *testing.T) (*gorm.DB, sqlmock.Sqlmock) {
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

	db, err := gorm.Open(postgres.New(postgres.Config{Conn: sqlDB}), &gorm.Config{
		Logger: logger.Default.LogMode(logger.Silent),
	})
	if err != nil {
		t.Fatalf("open gorm DB: %v", err)
	}
	return db, mock
}

func TestSettlementValidation(t *testing.T) {
	now := time.Now()
	valid := engine.MatchRecord{
		GameID:    "caro",
		MatchID:   uuid.NewString(),
		Player0ID: uuid.NewString(),
		Player1ID: uuid.NewString(),
		Mode:      "room",
		Bet:       10,
		StartedAt: now,
	}

	if _, _, err := validateRecord(valid); err != nil {
		t.Fatalf("valid record rejected: %v", err)
	}

	invalidPlayer := valid
	invalidPlayer.Player0ID = "invalid-player-id"
	if _, _, err := validateRecord(invalidPlayer); !errors.Is(err, errInvalidMatch) {
		t.Fatalf("invalid player id should fail, got %v", err)
	}
	invalidPlayer.Bet = 0
	if _, _, err := validateRecord(invalidPlayer); !errors.Is(err, errInvalidMatch) {
		t.Fatalf("zero-bet record with invalid player id should fail, got %v", err)
	}

	tooLarge := valid
	tooLarge.Bet = engine.MaxBet + 1
	if _, _, err := validateRecord(tooLarge); !errors.Is(err, errInvalidMatch) {
		t.Fatalf("oversized bet should fail, got %v", err)
	}

	invalidOutcome := engine.MatchOutcome{
		GameID:     valid.GameID,
		MatchID:    valid.MatchID,
		Player0ID:  "invalid-player-id",
		Player1ID:  valid.Player1ID,
		WinnerID:   valid.Player1ID,
		Reason:     "win",
		Bet:        valid.Bet,
		MoveCount:  9,
		FinishedAt: now,
	}
	if _, _, err := validateOutcome(invalidOutcome); !errors.Is(err, errInvalidMatch) {
		t.Fatalf("outcome with invalid player id should fail, got %v", err)
	}
	invalidOutcome.Bet = 0
	if _, _, err := validateOutcome(invalidOutcome); !errors.Is(err, errInvalidMatch) {
		t.Fatalf("zero-bet outcome with invalid player id should fail, got %v", err)
	}

	if _, err := checkedCredit(math.MaxInt32-4, 5); !errors.Is(err, errKenBalanceCap) {
		t.Fatalf("overflowing credit should fail, got %v", err)
	}

	p0, p1, _ := validateRecord(valid)
	closed := models.GameMatch{
		GameID:     valid.GameID,
		MatchID:    valid.MatchID,
		Player0ID:  p0,
		Player1ID:  p1,
		Status:     matchStatusFinished,
		Mode:       valid.Mode,
		Bet:        valid.Bet,
		EscrowedAt: now,
	}
	if err := verifyMatchRecord(closed, valid, p0, p1); !errors.Is(err, engine.ErrEscrowClosed) {
		t.Fatalf("closed escrow error=%v, want %v", err, engine.ErrEscrowClosed)
	}
}

func TestSettlementResultReasonValidation(t *testing.T) {
	tests := []struct {
		reason    string
		hasWinner bool
		wantError bool
	}{
		{reason: "win", hasWinner: true},
		{reason: "forfeit", hasWinner: true},
		{reason: "timeout", hasWinner: true},
		{reason: "draw"},
		{reason: "void"},
		{reason: "disconnect"},
		{reason: "disconnect", hasWinner: true},
		{reason: "win", wantError: true},
		{reason: "draw", hasWinner: true, wantError: true},
		{reason: "unknown", hasWinner: true, wantError: true},
	}
	for _, test := range tests {
		t.Run(test.reason, func(t *testing.T) {
			err := validateResultReason(test.reason, test.hasWinner)
			if (err != nil) != test.wantError {
				t.Fatalf("validateResultReason(%q, %v) error=%v, wantError=%v",
					test.reason, test.hasWinner, err, test.wantError)
			}
		})
	}
}

func TestSettleFinishRejectsMissingEscrow(t *testing.T) {
	db, mock := newSettlementMockDB(t)
	repo := &SettlementRepository{db: db, logger: zap.NewNop().Sugar()}
	matchID := uuid.NewString()
	p0 := uuid.NewString()
	p1 := uuid.NewString()

	mock.ExpectBegin()
	mock.ExpectQuery(`SELECT \* FROM "game_matches".*match_id = \$1.*FOR UPDATE`).
		WithArgs(matchID, 1).
		WillReturnRows(sqlmock.NewRows([]string{"id"}))
	mock.ExpectRollback()

	_, err := repo.SettleFinish(context.Background(), engine.MatchOutcome{
		GameID:     "caro",
		MatchID:    matchID,
		Player0ID:  p0,
		Player1ID:  p1,
		WinnerID:   p0,
		Reason:     "win",
		Bet:        10,
		MoveCount:  9,
		FinishedAt: time.Now(),
	})
	if !errors.Is(err, errMatchNotEscrowed) {
		t.Fatalf("missing escrow error=%v, want %v", err, errMatchNotEscrowed)
	}
}

func TestAbortStartMissingEscrowIsIdempotentWithoutRecordNotFoundLog(t *testing.T) {
	db, mock := newSettlementMockDB(t)
	var logs bytes.Buffer
	db = db.Session(&gorm.Session{
		Logger: logger.New(log.New(&logs, "", 0), logger.Config{
			LogLevel: logger.Info,
		}),
	})
	repo := &SettlementRepository{db: db, logger: zap.NewNop().Sugar()}
	matchID := uuid.NewString()

	mock.ExpectBegin()
	mock.ExpectQuery(`SELECT \* FROM "game_matches".*match_id = \$1.*FOR UPDATE`).
		WithArgs(matchID, 1).
		WillReturnRows(sqlmock.NewRows([]string{"id"}))
	mock.ExpectCommit()

	balances, err := repo.AbortStart(context.Background(), matchID)
	if err != nil {
		t.Fatalf("abort missing escrow: %v", err)
	}
	if len(balances) != 0 {
		t.Fatalf("abort missing escrow balances=%v, want none", balances)
	}
	if strings.Contains(logs.String(), gorm.ErrRecordNotFound.Error()) {
		t.Fatalf("abort missing escrow produced a false error log: %s", logs.String())
	}
}

func TestSettleFinishRejectsOutcomeThatConflictsWithEscrow(t *testing.T) {
	db, mock := newSettlementMockDB(t)
	repo := &SettlementRepository{db: db, logger: zap.NewNop().Sugar()}
	p0 := uuid.New()
	p1 := uuid.New()
	matchID := uuid.New()
	rowID := uuid.New()
	now := time.Now().UTC()

	mock.ExpectBegin()
	mock.ExpectQuery(`SELECT \* FROM "game_matches".*match_id = \$1.*FOR UPDATE`).
		WithArgs(matchID.String(), 1).
		WillReturnRows(sqlmock.NewRows([]string{
			"id", "game_id", "match_id", "player0_id", "player1_id", "status",
			"mode", "bet", "started_at", "escrowed_at", "deleted_at",
		}).AddRow(
			rowID, "caro", matchID, p0, p1, matchStatusPlaying,
			"room", 25, now.Add(-time.Minute), now, nil,
		))
	mock.ExpectRollback()

	_, err := repo.settleFinish(context.Background(), engine.MatchOutcome{
		GameID:     "caro",
		MatchID:    matchID.String(),
		Player0ID:  p0.String(),
		Player1ID:  p1.String(),
		WinnerID:   p0.String(),
		Reason:     "win",
		Bet:        100,
		MoveCount:  9,
		FinishedAt: now.Add(time.Minute),
	}, p0, p1, []uuid.UUID{p0, p1})
	if !errors.Is(err, errMatchConflict) {
		t.Fatalf("mismatched bet error=%v, want %v", err, errMatchConflict)
	}
}

func TestSettleFinishRetryDoesNotUpdateBalancesAgain(t *testing.T) {
	db, mock := newSettlementMockDB(t)
	repo := &SettlementRepository{db: db, logger: zap.NewNop().Sugar()}
	p0 := uuid.New()
	p1 := uuid.New()
	matchID := uuid.New()
	rowID := uuid.New()
	now := time.Now().UTC()
	finishedAt := now.Add(time.Minute)
	out := engine.MatchOutcome{
		GameID:     "caro",
		MatchID:    matchID.String(),
		Player0ID:  p0.String(),
		Player1ID:  p1.String(),
		WinnerID:   p0.String(),
		Reason:     "win",
		Bet:        25,
		MoveCount:  9,
		FinishedAt: finishedAt,
	}

	mock.ExpectBegin()
	mock.ExpectQuery(`SELECT \* FROM "game_matches".*match_id = \$1.*FOR UPDATE`).
		WithArgs(matchID.String(), 1).
		WillReturnRows(sqlmock.NewRows([]string{
			"id", "game_id", "match_id", "player0_id", "player1_id", "winner_id",
			"loser_id", "status", "reason", "mode", "bet", "ken_delta", "move_count",
			"started_at", "escrowed_at", "finished_at", "deleted_at",
		}).AddRow(
			rowID, out.GameID, out.MatchID, p0, p1, p0,
			p1, matchStatusFinished, out.Reason, "room", out.Bet, out.Bet, out.MoveCount,
			now.Add(-time.Minute), now, finishedAt, nil,
		))
	mock.ExpectCommit()

	result, err := repo.settleFinish(context.Background(), out, p0, p1, []uuid.UUID{p0, p1})
	if err != nil {
		t.Fatalf("idempotent finish: %v", err)
	}
	if result.gameID != out.GameID || len(result.userIDs) != 2 {
		t.Fatalf("unexpected idempotent finish result: %+v", result)
	}
}

func TestSettleFinishCreditsWinnerFromEscrowedBet(t *testing.T) {
	db, mock := newSettlementMockDB(t)
	repo := &SettlementRepository{db: db, logger: zap.NewNop().Sugar(), commissionPercents: map[string]int{"caro": 5}}
	p0 := uuid.MustParse("11111111-1111-4111-8111-111111111111")
	p1 := uuid.MustParse("22222222-2222-4222-8222-222222222222")
	matchID := uuid.MustParse("33333333-3333-4333-8333-333333333333")
	rowID := uuid.MustParse("44444444-4444-4444-8444-444444444444")
	now := time.Now().UTC()
	out := engine.MatchOutcome{
		GameID:     "caro",
		MatchID:    matchID.String(),
		Player0ID:  p0.String(),
		Player1ID:  p1.String(),
		WinnerID:   p0.String(),
		Reason:     "win",
		Bet:        25,
		MoveCount:  9,
		FinishedAt: now.Add(time.Minute),
	}

	mock.ExpectBegin()
	mock.ExpectQuery(`SELECT \* FROM "game_matches".*match_id = \$1.*FOR UPDATE`).
		WithArgs(matchID.String(), 1).
		WillReturnRows(sqlmock.NewRows([]string{
			"id", "game_id", "match_id", "player0_id", "player1_id", "status",
			"mode", "bet", "started_at", "escrowed_at", "deleted_at",
		}).AddRow(
			rowID, out.GameID, out.MatchID, p0, p1, matchStatusPlaying,
			"room", out.Bet, now.Add(-time.Minute), now, nil,
		))
	expectLockedUser(mock, p0, 75)
	expectLockedUser(mock, p1, 55)
	expectKenUpdate(mock, p0, 124)
	mock.ExpectExec(`UPDATE "game_matches" SET .*WHERE id = .*status = `).
		WillReturnResult(sqlmock.NewResult(0, 1))
	expectExpGrant(mock, p0, out.GameID, 54, 54)
	expectExpGrant(mock, p1, out.GameID, 19, 19)
	mock.ExpectCommit()

	result, err := repo.settleFinish(context.Background(), out, p0, p1, []uuid.UUID{p0, p1})
	if err != nil {
		t.Fatalf("settle winner: %v", err)
	}
	if result.gameID != out.GameID || len(result.userIDs) != 2 {
		t.Fatalf("unexpected settle result: %+v", result)
	}
}

func TestWinnerAmountsApplyPerGameCommission(t *testing.T) {
	repo := &SettlementRepository{commissionPercents: map[string]int{"caro": 5, "war-god": 5}}
	payout, net := repo.WinnerAmounts("caro", 10_000)
	if payout != 19_500 || net != 9_500 {
		t.Fatalf("caro amounts = payout %d, net %d; want 19500 and 9500", payout, net)
	}

	payout, net = repo.WinnerAmounts("war-god", 10_000)
	if payout != 19_500 || net != 9_500 {
		t.Fatalf("war-god amounts = payout %d, net %d; want 19500 and 9500", payout, net)
	}

	payout, net = repo.WinnerAmounts("other-game", 10_000)
	if payout != 20_000 || net != 10_000 {
		t.Fatalf("uncommissioned amounts = payout %d, net %d; want 20000 and 10000", payout, net)
	}
}

func TestEscrowStartIsIdempotentAndDebitsOnce(t *testing.T) {
	db, mock := newSettlementMockDB(t)
	repo := &SettlementRepository{db: db, logger: zap.NewNop().Sugar()}
	p0 := uuid.MustParse("11111111-1111-4111-8111-111111111111")
	p1 := uuid.MustParse("22222222-2222-4222-8222-222222222222")
	matchID := uuid.MustParse("33333333-3333-4333-8333-333333333333")
	rowID := uuid.MustParse("44444444-4444-4444-8444-444444444444")
	startedAt := time.Now().Add(-time.Second).UTC()
	rec := engine.MatchRecord{
		GameID:    "caro",
		MatchID:   matchID.String(),
		Player0ID: p0.String(),
		Player1ID: p1.String(),
		Mode:      "room",
		Bet:       25,
		StartedAt: startedAt,
	}

	mock.ExpectBegin()
	mock.ExpectQuery(`INSERT INTO "game_matches"`).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(rowID))
	expectLockedUser(mock, p0, 100)
	expectLockedUser(mock, p1, 80)
	expectKenUpdate(mock, p0, 75)
	expectKenUpdate(mock, p1, 55)
	mock.ExpectCommit()

	result, err := repo.escrowStart(context.Background(), rec, p0, p1, []uuid.UUID{p0, p1})
	if err != nil {
		t.Fatalf("first escrow: %v", err)
	}
	if result.gameID != rec.GameID || len(result.userIDs) != 2 {
		t.Fatalf("unexpected escrow result: %+v", result)
	}

	escrowedAt := startedAt.Add(time.Second)
	mock.ExpectBegin()
	mock.ExpectQuery(`INSERT INTO "game_matches"`).
		WillReturnRows(sqlmock.NewRows([]string{"id"}))
	mock.ExpectQuery(`SELECT \* FROM "game_matches".*match_id = \$1.*FOR UPDATE`).
		WithArgs(rec.MatchID, 1).
		WillReturnRows(sqlmock.NewRows([]string{
			"id", "game_id", "match_id", "player0_id", "player1_id", "status",
			"mode", "bet", "started_at", "escrowed_at", "deleted_at",
		}).AddRow(
			rowID, rec.GameID, rec.MatchID, p0, p1, matchStatusPlaying,
			rec.Mode, rec.Bet, startedAt, escrowedAt, nil,
		))
	mock.ExpectCommit()

	result, err = repo.escrowStart(context.Background(), rec, p0, p1, []uuid.UUID{p0, p1})
	if err != nil {
		t.Fatalf("idempotent escrow: %v", err)
	}
	if result.gameID != rec.GameID || len(result.userIDs) != 2 {
		t.Fatalf("unexpected idempotent result: %+v", result)
	}
}

func expectLockedUser(mock sqlmock.Sqlmock, userID uuid.UUID, ken int) {
	mock.ExpectQuery(`SELECT \* FROM "users".*id = \$1.*FOR UPDATE`).
		WithArgs(userID, 1).
		WillReturnRows(sqlmock.NewRows([]string{"id", "ken", "deleted_at"}).
			AddRow(userID, ken, nil))
}

func expectKenUpdate(mock sqlmock.Sqlmock, userID uuid.UUID, ken int) {
	mock.ExpectExec(`UPDATE "users" SET .*"ken"=\$1.*WHERE id = \$3`).
		WithArgs(ken, sqlmock.AnyArg(), userID).
		WillReturnResult(sqlmock.NewResult(0, 1))
}

func expectExpGrant(mock sqlmock.Sqlmock, userID uuid.UUID, gameID string, gain int, total int64) {
	mock.ExpectQuery(`INSERT INTO user_game_levels .*ON CONFLICT .*RETURNING exp`).
		WithArgs(userID, gameID, gain, progression.LevelFromExp(int64(gain))).
		WillReturnRows(sqlmock.NewRows([]string{"exp"}).AddRow(total))
	mock.ExpectExec(`UPDATE "user_game_levels" SET "level"=\$1`).
		WithArgs(progression.LevelFromExp(total), sqlmock.AnyArg(), userID, gameID).
		WillReturnResult(sqlmock.NewResult(0, 1))
}
