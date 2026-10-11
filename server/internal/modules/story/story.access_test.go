package story

import (
	"context"
	"fmt"
	"testing"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"

	miniredis "github.com/alicebob/miniredis/v2"
	"github.com/google/uuid"
)

type accessFixture struct {
	service  *Service
	store    *fakeStore
	comments *fakeCommentStore
	source   *fakeSource
	settings *fakeReadingSettings
	users    *fakeUsers
	redis    *miniredis.Miniredis
}

func newAccessFixture(t *testing.T, freePerDay int) *accessFixture {
	t.Helper()
	store := newFakeStore(1)
	store.chapters[testID(1)] = []models.StoryChapter{
		{ID: testID(10), StoryID: testID(1), Position: 1, ContentText: "một"},
		{ID: testID(11), StoryID: testID(1), Position: 2, ContentText: "hai"},
		{ID: testID(12), StoryID: testID(1), Position: 3, ContentText: "ba"},
	}
	source := &fakeSource{content: "nguồn"}
	service := newTestService(store, source)
	cache, server := newTestCache(t)
	fixture := &accessFixture{
		service:  service,
		store:    store,
		comments: newFakeCommentStore(),
		source:   source,
		settings: &fakeReadingSettings{cfg: setting.StoryReadingConfig{Enabled: true, FreeChaptersPerDay: freePerDay, CommentUnlockMinChars: 10}},
		users:    &fakeUsers{users: map[uuid.UUID]*models.User{}},
		redis:    server,
	}
	service.comments = fixture.comments
	service.settings = fixture.settings
	service.users = fixture.users
	service.cache = cache
	return fixture
}

func (f *accessFixture) read(t *testing.T, position string, prefetch bool) *ChapterResponse {
	t.Helper()
	chapter, err := f.service.Chapter(context.Background(), testReader, sid(1), position, prefetch)
	if err != nil {
		t.Fatal(err)
	}
	return chapter
}

func TestReadingDisabledReadsEverything(t *testing.T) {
	f := newAccessFixture(t, 0)
	f.settings.cfg.Enabled = false
	for _, position := range []string{"1", "2", "3"} {
		if chapter := f.read(t, position, false); chapter.Locked || chapter.Content == "" || chapter.Access.Enabled {
			t.Fatalf("chapter %s: %+v", position, chapter)
		}
	}
}

func TestFreeChaptersPerDay(t *testing.T) {
	f := newAccessFixture(t, 2)

	first := f.read(t, "1", false)
	if first.Locked || first.Access.FreeUsed != 1 || first.Access.FreeLimit != 2 {
		t.Fatalf("chapter 1: %+v", first)
	}
	if again := f.read(t, "1", false); again.Locked || again.Access.FreeUsed != 1 {
		t.Fatalf("re-reading chapter 1 should be free: %+v", again)
	}
	if second := f.read(t, "2", false); second.Locked || second.Access.FreeUsed != 2 {
		t.Fatalf("chapter 2: %+v", second)
	}
	third := f.read(t, "3", false)
	if !third.Locked || third.Content != "" || third.Access.FreeUsed != 2 {
		t.Fatalf("chapter 3 should be locked: %+v", third)
	}
	if third.PrevPosition == nil || *third.PrevPosition != 2 || third.ID != sid(12) {
		t.Fatalf("locked chapter keeps navigation: %+v", third)
	}
	if again := f.read(t, "2", false); again.Locked {
		t.Fatal("chapter read today must stay readable")
	}
}

func TestPrefetchDoesNotUseFreeChapter(t *testing.T) {
	f := newAccessFixture(t, 1)

	if peek := f.read(t, "1", true); !peek.Locked || peek.Access.FreeUsed != 0 {
		t.Fatalf("prefetch before reading: %+v", peek)
	}
	if read := f.read(t, "1", false); read.Locked || read.Access.FreeUsed != 1 {
		t.Fatalf("read: %+v", read)
	}
	if peek := f.read(t, "1", true); peek.Locked || peek.Content != "một" {
		t.Fatalf("prefetch of a chapter already read today: %+v", peek)
	}
}

func TestLockedChapterSkipsContentAndViews(t *testing.T) {
	f := newAccessFixture(t, 0)
	f.store.chapters[testID(1)][0].ContentText = ""
	views, _, viewRedis := newTestViewCounter(t)
	f.service.views = views

	if chapter := f.read(t, "1", false); !chapter.Locked {
		t.Fatalf("expected locked: %+v", chapter)
	}
	time.Sleep(20 * time.Millisecond)
	if f.source.calls.Load() != 0 || len(viewRedis.Keys()) != 0 {
		t.Fatalf("locked chapter fetched content (%d) or tracked view (%v)", f.source.calls.Load(), viewRedis.Keys())
	}
}

func TestVipReadsEverything(t *testing.T) {
	f := newAccessFixture(t, 0)
	future := time.Now().Add(time.Hour)
	f.users.users[testReader] = testUser(testReader, "", &future)
	if chapter := f.read(t, "3", false); chapter.Locked || !chapter.Access.Vip {
		t.Fatalf("vip: %+v", chapter)
	}

	past := time.Now().Add(-time.Hour)
	f.users.users[testReader] = testUser(testReader, "", &past)
	if chapter := f.read(t, "3", false); !chapter.Locked || chapter.Access.Vip {
		t.Fatalf("expired vip: %+v", chapter)
	}
}

func TestUnlockedStoryReadsEverything(t *testing.T) {
	f := newAccessFixture(t, 0)
	if chapter := f.read(t, "2", false); !chapter.Locked {
		t.Fatal("expected locked before commenting")
	}
	f.comments.unlocks[[2]uuid.UUID{testReader, testID(1)}] = true
	if chapter := f.read(t, "2", false); chapter.Locked || !chapter.Access.Unlocked {
		t.Fatalf("unlocked: %+v", chapter)
	}
}

func TestCommentUnlocksLockedStory(t *testing.T) {
	f := newAccessFixture(t, 0)
	ctx := context.Background()
	if _, err := f.service.CreateComment(ctx, testReader, sid(1), CreateStoryCommentRequest{Content: "ngắn"}); err != nil {
		t.Fatal(err)
	}
	if chapter := f.read(t, "1", false); !chapter.Locked {
		t.Fatal("short comment must not unlock")
	}
	created, err := f.service.CreateComment(ctx, testReader, sid(1), CreateStoryCommentRequest{Content: "truyện này hay lắm"})
	if err != nil || !created.Unlocked {
		t.Fatalf("long comment: %+v, %v", created, err)
	}
	if chapter := f.read(t, "1", false); chapter.Locked {
		t.Fatal("story should be unlocked after commenting")
	}
}

func TestFreeChaptersResetEachDay(t *testing.T) {
	f := newAccessFixture(t, 1)
	yesterday := fmt.Sprintf(CacheKeyStoryFreeReads, testReader.String(), readingDay(time.Now().Add(-24*time.Hour)))
	if _, err := f.redis.SAdd(yesterday, sid(10), sid(11)); err != nil {
		t.Fatal(err)
	}
	if chapter := f.read(t, "3", false); chapter.Locked || chapter.Access.FreeUsed != 1 {
		t.Fatalf("new day: %+v", chapter)
	}
	today := fmt.Sprintf(CacheKeyStoryFreeReads, testReader.String(), readingDay(time.Now()))
	if ttl := f.redis.TTL(today); ttl <= 0 || ttl > StoryFreeReadsTTL {
		t.Fatalf("free reads key ttl %v", ttl)
	}
}

func TestReadingDayUsesVietnamTime(t *testing.T) {
	cases := map[string]string{
		"2026-10-10T16:59:59Z": "20261010",
		"2026-10-10T17:00:00Z": "20261011",
	}
	for raw, want := range cases {
		at, _ := time.Parse(time.RFC3339, raw)
		if got := readingDay(at); got != want {
			t.Fatalf("%s: got %s want %s", raw, got, want)
		}
	}
}

func TestReadingFailsOpen(t *testing.T) {
	f := newAccessFixture(t, 0)
	f.redis.Close()
	if chapter := f.read(t, "1", false); chapter.Locked {
		t.Fatal("redis down must not lock chapters")
	}
	f.comments.err = fmt.Errorf("db down")
	if chapter := f.read(t, "2", false); chapter.Locked {
		t.Fatal("unlock lookup failure must not lock chapters")
	}
}

func TestDetailShowsAccessWithoutUsingFreeChapter(t *testing.T) {
	f := newAccessFixture(t, 3)
	f.read(t, "1", false)
	detail, err := f.service.Detail(context.Background(), testReader, sid(1))
	if err != nil {
		t.Fatal(err)
	}
	if detail.Access == nil || detail.Access.FreeUsed != 1 || detail.Access.FreeLimit != 3 || !detail.Access.Enabled {
		t.Fatalf("detail access: %+v", detail.Access)
	}
	if again, _ := f.service.Detail(context.Background(), testReader, sid(1)); again.Access.FreeUsed != 1 {
		t.Fatalf("detail consumed a free chapter: %+v", again.Access)
	}
}

func TestReadingConfigIsCached(t *testing.T) {
	f := newAccessFixture(t, 5)
	f.read(t, "1", false)
	f.read(t, "2", false)
	if f.settings.calls != 1 {
		t.Fatalf("config loaded %d times, want 1", f.settings.calls)
	}

	f.settings.cfg.FreeChaptersPerDay = 1
	f.settings.err = fmt.Errorf("db down")
	f.service.readingAt = time.Now().Add(-StoryReadingConfigTTL)
	if chapter := f.read(t, "3", false); chapter.Locked || chapter.Access.FreeLimit != 5 {
		t.Fatalf("load error must keep the cached config: %+v", chapter.Access)
	}

	f.settings.err = nil
	if chapter := f.read(t, "3", false); chapter.Access.FreeLimit != 1 || f.settings.calls != 3 {
		t.Fatalf("expired cache must reload: %+v, calls %d", chapter.Access, f.settings.calls)
	}
}

func TestFailedContentRefundsFreeChapter(t *testing.T) {
	f := newAccessFixture(t, 2)
	f.store.chapters[testID(1)][1].ContentText = ""
	f.source.err = fmt.Errorf("source down")
	today := fmt.Sprintf(CacheKeyStoryFreeReads, testReader.String(), readingDay(time.Now()))

	if _, err := f.service.Chapter(context.Background(), testReader, sid(1), "2", false); err == nil {
		t.Fatal("expected content error")
	}
	if ok, _ := f.redis.SIsMember(today, sid(11)); ok {
		t.Fatal("failed chapter must not use a free chapter")
	}

	if _, err := f.redis.SAdd(today, sid(11)); err != nil {
		t.Fatal(err)
	}
	if _, err := f.service.Chapter(context.Background(), testReader, sid(1), "2", false); err == nil {
		t.Fatal("expected content error")
	}
	if ok, _ := f.redis.SIsMember(today, sid(11)); !ok {
		t.Fatal("chapter counted by an earlier read must stay counted")
	}

	f.source.err = nil
	if chapter := f.read(t, "2", false); chapter.Locked || chapter.Content != "nguồn" || chapter.Access.FreeUsed != 1 {
		t.Fatalf("read after source recovers: %+v", chapter)
	}
}
