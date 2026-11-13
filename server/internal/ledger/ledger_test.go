package ledger

import (
	"errors"
	"regexp"
	"testing"

	"ola-chat-server/internal/models"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/google/uuid"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func newMockDB(t *testing.T) (*gorm.DB, sqlmock.Sqlmock) {
	t.Helper()

	db, mock, err := sqlmock.New()
	if err != nil {
		t.Fatalf("open sqlmock: %v", err)
	}
	t.Cleanup(func() { _ = db.Close() })

	gormDB, err := gorm.Open(postgres.New(postgres.Config{
		Conn:                 db,
		PreferSimpleProtocol: true,
	}), &gorm.Config{})
	if err != nil {
		t.Fatalf("open gorm: %v", err)
	}
	return gormDB, mock
}

func TestDebitInsufficientBalanceTouchesNothing(t *testing.T) {
	db, mock := newMockDB(t)
	u := &models.User{Ken: 10}
	u.ID = uuid.New()

	row, err := Debit(db, u, 11, Entry{Type: models.KenTxTypeVipPackage})
	if !errors.Is(err, ErrInsufficientKen) {
		t.Fatalf("expected ErrInsufficientKen, got %v", err)
	}
	if err.Error() != "insufficient ken balance" {
		t.Fatalf("unexpected message %q", err.Error())
	}
	if row != nil {
		t.Fatalf("expected no ledger row, got %+v", row)
	}
	if u.Ken != 10 {
		t.Fatalf("balance changed to %d", u.Ken)
	}
	if err := mock.ExpectationsWereMet(); err != nil {
		t.Fatalf("unexpected sql: %v", err)
	}
}

func TestDebitUpdatesBalanceAndWritesLedgerRow(t *testing.T) {
	db, mock := newMockDB(t)
	u := &models.User{Ken: 100}
	u.ID = uuid.New()
	refID := uuid.New()
	actorID := u.ID

	mock.ExpectBegin()
	mock.ExpectExec(regexp.QuoteMeta(`UPDATE "users" SET "ken"=$1`)).
		WithArgs(70, sqlmock.AnyArg(), u.ID).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectQuery(regexp.QuoteMeta(`INSERT INTO "ken_transactions"`)).
		WithArgs(nil, u.ID, "debit", "CLAN_CREATE", 30, 100, 70, "create clan #x", "clan", refID, "user", actorID, sqlmock.AnyArg(), sqlmock.AnyArg()).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(uuid.New()))
	mock.ExpectCommit()

	var row *models.KenTransaction
	err := db.Transaction(func(tx *gorm.DB) error {
		var err error
		row, err = Debit(tx, u, 30, Entry{
			Type:        models.KenTxTypeClanCreate,
			Description: "create clan #x",
			RefType:     "clan",
			RefID:       &refID,
			ActorType:   models.KenActorUser,
			ActorID:     &actorID,
			Metadata:    models.JSONB{"k": "v"},
		})
		return err
	})
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if u.Ken != 70 {
		t.Fatalf("expected balance 70, got %d", u.Ken)
	}
	if row == nil {
		t.Fatal("expected ledger row")
	}
	if row.UserID != u.ID || row.Direction != models.KenDirectionDebit || row.Type != models.KenTxTypeClanCreate {
		t.Fatalf("unexpected row identity %+v", row)
	}
	if row.Amount != 30 || row.BalanceBefore != 100 || row.BalanceAfter != 70 {
		t.Fatalf("unexpected row amounts %+v", row)
	}
	if row.Description != "create clan #x" || row.RefType != "clan" || row.RefID != &refID || row.ActorType != models.KenActorUser || row.ActorID != &actorID || row.Metadata["k"] != "v" {
		t.Fatalf("unexpected row entry fields %+v", row)
	}
	if err := mock.ExpectationsWereMet(); err != nil {
		t.Fatalf("unmet expectations: %v", err)
	}
}

func TestCreditZeroAmountUpdatesWithoutLedgerRow(t *testing.T) {
	db, mock := newMockDB(t)
	u := &models.User{Ken: 5}
	u.ID = uuid.New()

	mock.ExpectBegin()
	mock.ExpectExec(regexp.QuoteMeta(`UPDATE "users" SET "ken"=$1`)).
		WithArgs(5, sqlmock.AnyArg(), u.ID).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectCommit()

	var row *models.KenTransaction
	err := db.Transaction(func(tx *gorm.DB) error {
		var err error
		row, err = Credit(tx, u, 0, Entry{Type: models.KenTxTypeTopup})
		return err
	})
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if row != nil {
		t.Fatalf("expected no ledger row, got %+v", row)
	}
	if err := mock.ExpectationsWereMet(); err != nil {
		t.Fatalf("unmet expectations: %v", err)
	}
}

func TestCreditAddsToBalance(t *testing.T) {
	db, mock := newMockDB(t)
	u := &models.User{Ken: 5}
	u.ID = uuid.New()

	mock.ExpectBegin()
	mock.ExpectExec(regexp.QuoteMeta(`UPDATE "users" SET "ken"=$1`)).
		WithArgs(25, sqlmock.AnyArg(), u.ID).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectQuery(regexp.QuoteMeta(`INSERT INTO "ken_transactions"`)).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(uuid.New()))
	mock.ExpectCommit()

	var row *models.KenTransaction
	err := db.Transaction(func(tx *gorm.DB) error {
		var err error
		row, err = Credit(tx, u, 20, Entry{Type: models.KenTxTypeTopup})
		return err
	})
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if u.Ken != 25 || row == nil || row.Direction != models.KenDirectionCredit || row.BalanceBefore != 5 || row.BalanceAfter != 25 {
		t.Fatalf("unexpected result balance=%d row=%+v", u.Ken, row)
	}
	if err := mock.ExpectationsWereMet(); err != nil {
		t.Fatalf("unmet expectations: %v", err)
	}
}

func TestLockUserPairLocksInStableOrder(t *testing.T) {
	db, mock := newMockDB(t)
	low := uuid.MustParse("11111111-1111-1111-1111-111111111111")
	high := uuid.MustParse("22222222-2222-2222-2222-222222222222")

	mock.ExpectQuery(regexp.QuoteMeta(`FOR UPDATE`)).
		WithArgs(low, 1).
		WillReturnRows(sqlmock.NewRows([]string{"id", "ken"}).AddRow(low, 1))
	mock.ExpectQuery(regexp.QuoteMeta(`FOR UPDATE`)).
		WithArgs(high, 1).
		WillReturnRows(sqlmock.NewRows([]string{"id", "ken"}).AddRow(high, 2))

	first, second, err := LockUserPair(db, high, low)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if first.ID != high || first.Ken != 2 || second.ID != low || second.Ken != 1 {
		t.Fatalf("unexpected pair first=%+v second=%+v", first.ID, second.ID)
	}
	if err := mock.ExpectationsWereMet(); err != nil {
		t.Fatalf("unmet expectations: %v", err)
	}
}
