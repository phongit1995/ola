package story

import (
	"context"
	"errors"
	"sync"
	"testing"

	"github.com/google/uuid"
)

type fakeViewStore struct {
	mu    sync.Mutex
	views map[uuid.UUID]int64
	calls int
	err   error
}

func (f *fakeViewStore) AddViews(_ context.Context, storyID uuid.UUID, views int64) error {
	f.mu.Lock()
	defer f.mu.Unlock()
	f.calls++
	if f.err != nil {
		return f.err
	}
	f.views[storyID] += views
	return nil
}

func (f *fakeViewStore) setErr(err error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	f.err = err
}

func (f *fakeViewStore) callCount() int {
	f.mu.Lock()
	defer f.mu.Unlock()
	return f.calls
}

func (f *fakeViewStore) saved(id uuid.UUID) int64 {
	f.mu.Lock()
	defer f.mu.Unlock()
	return f.views[id]
}

func trackView(t *testing.T, counter *ViewCounter, reader, storyID uuid.UUID) {
	t.Helper()
	if err := counter.track(context.Background(), reader, storyID); err != nil {
		t.Fatal(err)
	}
}

func TestViewCounterSavesWhenTotalReachesRandom(t *testing.T) {
	counter, store, server := newTestViewCounter(t)
	counter.flushAt = func() int { return 3 }

	trackView(t, counter, testID(901), testID(1))
	trackView(t, counter, testID(902), testID(1))
	trackView(t, counter, testID(902), testID(1))
	if got := server.HGet(CacheKeyStoryViewsPending, sid(1)); got != "2" || store.callCount() != 0 {
		t.Fatalf("before random: pending %q, saves %d", got, store.callCount())
	}

	trackView(t, counter, testID(903), testID(1))
	if store.saved(testID(1)) != 3 || store.callCount() != 1 {
		t.Fatalf("at random: saved %d, saves %d", store.saved(testID(1)), store.callCount())
	}
	if server.HGet(CacheKeyStoryViewsPending, sid(1)) != "" {
		t.Fatal("pending not reset after save")
	}

	trackView(t, counter, testID(904), testID(1))
	if got := server.HGet(CacheKeyStoryViewsPending, sid(1)); got != "1" {
		t.Fatalf("pending after reset %q", got)
	}
}

func TestViewCounterDrawsRandomOnEveryView(t *testing.T) {
	counter, store, _ := newTestViewCounter(t)
	draws := []int{10, 10, 2}
	counter.flushAt = func() int {
		next := draws[0]
		draws = draws[1:]
		return next
	}

	trackView(t, counter, testID(901), testID(1))
	trackView(t, counter, testID(902), testID(1))
	if store.callCount() != 0 {
		t.Fatalf("saved before total reached random: %d", store.callCount())
	}
	trackView(t, counter, testID(903), testID(1))
	if store.saved(testID(1)) != 3 {
		t.Fatalf("saved %d", store.saved(testID(1)))
	}
}

func TestRandomFlushAtRange(t *testing.T) {
	seen := map[int]bool{}
	for range 2000 {
		n := randomFlushAt()
		if n < StoryViewFlushMin || n > StoryViewFlushMax {
			t.Fatalf("flushAt %d out of range", n)
		}
		seen[n] = true
	}
	if !seen[StoryViewFlushMin] || !seen[StoryViewFlushMax] {
		t.Fatalf("range ends never drawn: %v", seen)
	}
}

func TestViewCounterSavesByMaxRandom(t *testing.T) {
	counter, store, _ := newTestViewCounter(t)
	for n := 1; n <= StoryViewFlushMax; n++ {
		trackView(t, counter, testID(900+n), testID(1))
	}
	if store.saved(testID(1)) == 0 {
		t.Fatalf("nothing saved after %d views", StoryViewFlushMax)
	}
}

func TestViewCounterGuardExpires(t *testing.T) {
	counter, _, server := newTestViewCounter(t)
	trackView(t, counter, testReader, testID(1))
	trackView(t, counter, testReader, testID(1))
	trackView(t, counter, testReader, testID(2))
	if server.HGet(CacheKeyStoryViewsPending, sid(1)) != "1" || server.HGet(CacheKeyStoryViewsPending, sid(2)) != "1" {
		t.Fatal("same reader counted twice or other story missed")
	}
	server.FastForward(StoryViewGuardTTL)
	trackView(t, counter, testReader, testID(1))
	if got := server.HGet(CacheKeyStoryViewsPending, sid(1)); got != "2" {
		t.Fatalf("after guard expiry pending %q", got)
	}
}

func TestViewCounterRestoresPendingWhenSaveFails(t *testing.T) {
	counter, store, server := newTestViewCounter(t)
	counter.flushAt = func() int { return 2 }
	store.setErr(errors.New("db down"))

	trackView(t, counter, testID(901), testID(1))
	if err := counter.track(context.Background(), testID(902), testID(1)); err == nil {
		t.Fatal("expected save error")
	}
	if got := server.HGet(CacheKeyStoryViewsPending, sid(1)); got != "2" {
		t.Fatalf("pending after failed save %q", got)
	}

	store.setErr(nil)
	trackView(t, counter, testID(903), testID(1))
	if store.saved(testID(1)) != 3 || server.HGet(CacheKeyStoryViewsPending, sid(1)) != "" {
		t.Fatalf("saved %d after recovery", store.saved(testID(1)))
	}
}
