package wordchain

import (
	"context"
	"errors"
	"fmt"
	"ola-chat-server/internal/models"
	"sync"
	"testing"
	"time"

	"github.com/google/uuid"
	"github.com/redis/go-redis/v9"
)

type recordingScoreLog struct {
	mu         sync.Mutex
	err        error
	records    []models.WordChainScore
	rows       []LeaderboardRow
	sort       string
	from       time.Time
	to         time.Time
	wins       []models.WordChainScore
	winsUser   *uuid.UUID
	winsBefore *uuid.UUID
	winsLimit  int
}

func (l *recordingScoreLog) Record(_ context.Context, score *models.WordChainScore) error {
	l.mu.Lock()
	defer l.mu.Unlock()
	if l.err != nil {
		return l.err
	}
	l.records = append(l.records, *score)
	return nil
}

func (l *recordingScoreLog) Leaderboard(_ context.Context, sort string, from, to time.Time, _ uuid.UUID, _ int) ([]LeaderboardRow, error) {
	l.mu.Lock()
	defer l.mu.Unlock()
	l.sort, l.from, l.to = sort, from, to
	return l.rows, nil
}

func (l *recordingScoreLog) Wins(_ context.Context, userID, before *uuid.UUID, limit int) ([]models.WordChainScore, error) {
	l.mu.Lock()
	defer l.mu.Unlock()
	l.winsUser, l.winsBefore, l.winsLimit = userID, before, limit
	return l.wins[:min(limit, len(l.wins))], nil
}

func scoreLog(svc *Service) *recordingScoreLog {
	return svc.scores.(*recordingScoreLog)
}

func redisScore(t *testing.T, svc *Service, key string, userID uuid.UUID) int64 {
	t.Helper()
	score, err := svc.store.Score(context.Background(), key, userID.String())
	if err != nil {
		t.Fatal(err)
	}
	return score
}

func TestCorrectWordIsRecordedAsScore(t *testing.T) {
	svc := newTestService(t)
	session := saveState(t, svc, newSession("mặt trời", time.Now()))
	userID := uuid.New()
	res, err := processMove(session, userID.String(), "trời đất", acceptAllOracle{})
	if err != nil {
		t.Fatal(err)
	}

	resp, err := svc.commitMove(context.Background(), userID, nil, "trời đất", session.Revision, res)
	if err != nil {
		t.Fatal(err)
	}
	records := scoreLog(svc).records
	if len(records) != 1 {
		t.Fatalf("records = %+v, want 1", records)
	}
	got := records[0]
	if got.MessageID.String() != resp.Message.ID || got.SessionID.String() != session.SessionID || got.UserID != userID {
		t.Fatalf("record ids = %+v", got)
	}
	if got.Word != "trời đất" || got.PreviousWord != "mặt trời" || got.Points != PointsPerWord || got.IsWin {
		t.Fatalf("record = %+v", got)
	}
	if got.CreatedAt.Location() != time.UTC {
		t.Fatalf("created_at must be UTC, got %v", got.CreatedAt.Location())
	}
	if wins := redisScore(t, svc, CacheKeyWins, userID); wins != 0 {
		t.Fatalf("wins = %d, want 0", wins)
	}
}

func TestWinningWordAddsPointAndWin(t *testing.T) {
	svc := newTestService(t)
	session := saveState(t, svc, newSession("mặt trời", time.Now()))
	userID := uuid.New()
	res, err := processMove(session, userID.String(), "trời đất", deadEndOracle{next: "nước mặt"})
	if err != nil {
		t.Fatal(err)
	}
	if res.Code != CodeWin {
		t.Fatalf("code = %s, want win", res.Code)
	}

	resp, err := svc.commitMove(context.Background(), userID, nil, "trời đất", session.Revision, res)
	if err != nil {
		t.Fatal(err)
	}
	if resp.Points != 1 {
		t.Fatalf("points = %d, want 1", resp.Points)
	}
	if points, wins := redisScore(t, svc, CacheKeyPoints, userID), redisScore(t, svc, CacheKeyWins, userID); points != 1 || wins != 1 {
		t.Fatalf("points = %d, wins = %d, want 1 and 1", points, wins)
	}
	records := scoreLog(svc).records
	if len(records) != 1 || !records[0].IsWin || records[0].Word != "trời đất" || records[0].PreviousWord != "mặt trời" {
		t.Fatalf("records = %+v", records)
	}
}

func TestWrongWordIsNotRecorded(t *testing.T) {
	svc := newTestService(t)
	session := saveState(t, svc, newSession("mặt trời", time.Now()))
	userID := uuid.New()
	res, err := processMove(session, userID.String(), "đất nước", acceptAllOracle{})
	if err != nil {
		t.Fatal(err)
	}

	if _, err := svc.commitMove(context.Background(), userID, nil, "đất nước", session.Revision, res); err != nil {
		t.Fatal(err)
	}
	if records := scoreLog(svc).records; len(records) != 0 {
		t.Fatalf("wrong word must not be recorded: %+v", records)
	}
}

func TestMoveSucceedsWhenScoreRecordFails(t *testing.T) {
	svc := newTestService(t)
	scoreLog(svc).err = errors.New("postgres down")
	session := saveState(t, svc, newSession("mặt trời", time.Now()))
	userID := uuid.New()
	res, err := processMove(session, userID.String(), "trời đất", acceptAllOracle{})
	if err != nil {
		t.Fatal(err)
	}

	resp, err := svc.commitMove(context.Background(), userID, nil, "trời đất", session.Revision, res)
	if err != nil {
		t.Fatalf("move must succeed without postgres: %v", err)
	}
	if resp.Points != 1 || redisScore(t, svc, CacheKeyPoints, userID) != 1 {
		t.Fatalf("points must still be counted: %+v", resp)
	}
}

func seedScores(t *testing.T, svc *Service, key string, scores map[uuid.UUID]float64) {
	t.Helper()
	for userID, score := range scores {
		if err := svc.store.client.ZAdd(context.Background(), key, redis.Z{Score: score, Member: userID.String()}).Err(); err != nil {
			t.Fatal(err)
		}
	}
}

func TestAllTimeLeaderboardSortsByPointsOrWins(t *testing.T) {
	svc := newTestService(t)
	a, b, c := uuid.New(), uuid.New(), uuid.New()
	seedScores(t, svc, CacheKeyPoints, map[uuid.UUID]float64{a: 10, b: 5, c: 8})
	seedScores(t, svc, CacheKeyWins, map[uuid.UUID]float64{a: 1, b: 3})
	ctx := context.Background()

	byPoints, err := svc.leaderboardRows(ctx, c, LeaderboardSortPoints, LeaderboardPeriodAll)
	if err != nil {
		t.Fatal(err)
	}
	want := []LeaderboardRow{
		{UserID: a, Points: 10, Wins: 1, Rank: 1, Total: 3},
		{UserID: c, Points: 8, Wins: 0, Rank: 2, Total: 3},
		{UserID: b, Points: 5, Wins: 3, Rank: 3, Total: 3},
	}
	if fmt.Sprint(byPoints) != fmt.Sprint(want) {
		t.Fatalf("by points = %+v, want %+v", byPoints, want)
	}

	byWins, err := svc.leaderboardRows(ctx, c, LeaderboardSortWins, LeaderboardPeriodAll)
	if err != nil {
		t.Fatal(err)
	}
	want = []LeaderboardRow{
		{UserID: b, Points: 5, Wins: 3, Rank: 1, Total: 2},
		{UserID: a, Points: 10, Wins: 1, Rank: 2, Total: 2},
	}
	if fmt.Sprint(byWins) != fmt.Sprint(want) {
		t.Fatalf("by wins = %+v, want %+v (player without wins is not ranked)", byWins, want)
	}
}

func TestAllTimeLeaderboardAddsMyRankOutsideTop(t *testing.T) {
	svc := newTestService(t)
	scores := make(map[uuid.UUID]float64)
	for i := range LeaderboardLimit {
		scores[uuid.New()] = float64(100 + i)
	}
	me := uuid.New()
	scores[me] = 1
	seedScores(t, svc, CacheKeyPoints, scores)

	rows, err := svc.leaderboardRows(context.Background(), me, LeaderboardSortPoints, LeaderboardPeriodAll)
	if err != nil {
		t.Fatal(err)
	}
	if len(rows) != LeaderboardLimit+1 {
		t.Fatalf("rows = %d, want %d", len(rows), LeaderboardLimit+1)
	}
	last := rows[len(rows)-1]
	if last.UserID != me || last.Rank != LeaderboardLimit+1 || last.Points != 1 || last.Total != LeaderboardLimit+1 {
		t.Fatalf("my row = %+v", last)
	}
}

func TestPeriodLeaderboardReadsPostgres(t *testing.T) {
	svc := newTestService(t)
	me := uuid.New()
	scoreLog(svc).rows = []LeaderboardRow{{UserID: me, Points: 4, Wins: 1, Rank: 1, Total: 1}}

	rows, err := svc.leaderboardRows(context.Background(), me, LeaderboardSortWins, LeaderboardPeriodWeek)
	if err != nil {
		t.Fatal(err)
	}
	log := scoreLog(svc)
	if len(rows) != 1 || log.sort != LeaderboardSortWins {
		t.Fatalf("rows = %+v, sort = %s", rows, log.sort)
	}
	from, _ := periodRange(time.Now(), LeaderboardPeriodWeek)
	if !log.from.Equal(from) || !log.to.After(log.from) {
		t.Fatalf("range = %v..%v, want from %v", log.from, log.to, from)
	}
}

func TestPeriodRangeUsesVietnamTime(t *testing.T) {
	vn := func(year int, month time.Month, day int) time.Time {
		return time.Date(year, month, day, 0, 0, 0, 0, gmt7).UTC()
	}
	cases := []struct {
		name   string
		now    time.Time
		period string
		want   time.Time
	}{
		{"late utc night is next day in vietnam", time.Date(2026, 9, 30, 23, 30, 0, 0, time.UTC), LeaderboardPeriodDay, vn(2026, 10, 1)},
		{"week starts on monday", time.Date(2026, 9, 30, 23, 30, 0, 0, time.UTC), LeaderboardPeriodWeek, vn(2026, 9, 28)},
		{"sunday belongs to the week before", time.Date(2026, 10, 4, 3, 0, 0, 0, time.UTC), LeaderboardPeriodWeek, vn(2026, 9, 28)},
		{"month starts on day one", time.Date(2026, 9, 30, 23, 30, 0, 0, time.UTC), LeaderboardPeriodMonth, vn(2026, 10, 1)},
		{"month mid way", time.Date(2026, 10, 20, 5, 0, 0, 0, time.UTC), LeaderboardPeriodMonth, vn(2026, 10, 1)},
	}
	for _, tc := range cases {
		from, to := periodRange(tc.now, tc.period)
		if !from.Equal(tc.want) || !to.Equal(tc.now) {
			t.Errorf("%s: range = %v..%v, want from %v to %v", tc.name, from, to, tc.want, tc.now)
		}
	}
}

func TestLeaderboardParamsFallBackToDefaults(t *testing.T) {
	if got := normalizeLeaderboardSort("drop table"); got != LeaderboardSortPoints {
		t.Fatalf("sort = %s", got)
	}
	if got := normalizeLeaderboardPeriod("year"); got != LeaderboardPeriodAll {
		t.Fatalf("period = %s", got)
	}
	if got := normalizeLeaderboardPeriod(LeaderboardPeriodMonth); got != LeaderboardPeriodMonth {
		t.Fatalf("period = %s", got)
	}
}

func fakeWins(count int) []models.WordChainScore {
	wins := make([]models.WordChainScore, count)
	for i := range wins {
		wins[i] = models.WordChainScore{MessageID: uuid.New(), UserID: uuid.New(), IsWin: true}
	}
	return wins
}

func TestWinPageUsesCursorAndDetectsMore(t *testing.T) {
	svc := newTestService(t)
	log := scoreLog(svc)
	log.wins = fakeWins(3)
	me := uuid.New()
	cursor := uuid.New()

	rows, hasMore, err := svc.winPage(context.Background(), &me, cursor.String(), 2)
	if err != nil {
		t.Fatal(err)
	}
	if len(rows) != 2 || !hasMore {
		t.Fatalf("rows = %d, hasMore = %v, want 2 and true", len(rows), hasMore)
	}
	if log.winsLimit != 3 || log.winsBefore == nil || *log.winsBefore != cursor || log.winsUser == nil || *log.winsUser != me {
		t.Fatalf("query = user %v before %v limit %d", log.winsUser, log.winsBefore, log.winsLimit)
	}

	rows, hasMore, err = svc.winPage(context.Background(), nil, "", 3)
	if err != nil {
		t.Fatal(err)
	}
	if len(rows) != 3 || hasMore || log.winsBefore != nil || log.winsUser != nil {
		t.Fatalf("last page: rows = %d, hasMore = %v, before = %v, user = %v", len(rows), hasMore, log.winsBefore, log.winsUser)
	}
}

func TestWinPageIgnoresBrokenCursor(t *testing.T) {
	svc := newTestService(t)
	scoreLog(svc).wins = fakeWins(2)

	rows, hasMore, err := svc.winPage(context.Background(), nil, "not-an-id", 20)
	if err != nil || len(rows) != 0 || hasMore {
		t.Fatalf("rows = %d, hasMore = %v, err = %v", len(rows), hasMore, err)
	}
}
