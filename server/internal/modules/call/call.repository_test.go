package call

import (
	"ola-chat-server/internal/models"
	"regexp"
	"testing"
	"time"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/google/uuid"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func newMockRepo(t *testing.T) (*Repository, sqlmock.Sqlmock) {
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

	return NewRepository(gormDB), mock
}

func TestFindOngoingByUserCastsUUIDForArrayColumn(t *testing.T) {
	repo, mock := newMockRepo(t)
	userID := uuid.New()
	ringingSince := time.Now().Add(-time.Minute)

	mock.ExpectQuery(regexp.QuoteMeta(`::uuid = ANY(participants)`)).
		WithArgs("active", "ringing", sqlmock.AnyArg(), userID.String(), 1).
		WillReturnRows(sqlmock.NewRows([]string{"id"}))

	call, err := repo.FindOngoingByUser(userID, ringingSince)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if call != nil {
		t.Fatalf("expected nil call, got %+v", call)
	}
	if err := mock.ExpectationsWereMet(); err != nil {
		t.Fatalf("unmet expectations: %v", err)
	}
}

func TestFindOngoingByUserBoundsOnlyRingingByTime(t *testing.T) {
	repo, mock := newMockRepo(t)
	userID := uuid.New()

	mock.ExpectQuery(regexp.QuoteMeta(
		`(status = $1 OR (status = $2 AND started_at >= $3))`,
	)).
		WithArgs("active", "ringing", sqlmock.AnyArg(), userID.String(), 1).
		WillReturnRows(sqlmock.NewRows([]string{"id"}))

	if _, err := repo.FindOngoingByUser(userID, time.Now()); err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if err := mock.ExpectationsWereMet(); err != nil {
		t.Fatalf("unmet expectations: %v", err)
	}
}

func TestCreateIfNoOngoingLocksParticipantsInStableOrder(t *testing.T) {
	repo, mock := newMockRepo(t)

	first := uuid.MustParse("11111111-1111-1111-1111-111111111111")
	second := uuid.MustParse("22222222-2222-2222-2222-222222222222")

	mock.ExpectBegin()
	mock.ExpectExec(regexp.QuoteMeta(`pg_advisory_xact_lock`)).
		WithArgs(first.String()).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec(regexp.QuoteMeta(`pg_advisory_xact_lock`)).
		WithArgs(second.String()).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectQuery(regexp.QuoteMeta(`::uuid = ANY(participants)`)).
		WithArgs("active", "ringing", sqlmock.AnyArg(), first.String(), 1).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).
			AddRow(uuid.New()))
	mock.ExpectCommit()

	call := &models.Call{
		ConversationID: uuid.New(),
		CallerID:       first,
		CallType:       models.CallTypeAudio,
		RoomName:       "room",
		Status:         models.CallStatusRinging,
		Participants:   []string{first.String(), second.String()},
		StartedAt:      time.Now(),
	}

	created, err := repo.CreateIfNoOngoing(
		call,
		[]uuid.UUID{second, first},
		first,
		time.Now().Add(-time.Minute),
	)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if created {
		t.Fatal("expected no insert when an ongoing call exists")
	}
	if err := mock.ExpectationsWereMet(); err != nil {
		t.Fatalf("unmet expectations: %v", err)
	}
}
