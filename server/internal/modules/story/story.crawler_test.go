package story

import (
	"context"
	"errors"
	"fmt"
	"net"
	"slices"
	"strconv"
	"strings"
	"sync"
	"testing"
	"time"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/services"

	miniredis "github.com/alicebob/miniredis/v2"
	"go.uber.org/zap"
)

type fakeCrawlerSettings struct {
	cfg       setting.StoryCrawlerConfig
	updatedAt *time.Time
	dead      []string
}

func (f *fakeCrawlerSettings) GetStoryCrawler() (setting.StoryCrawlerConfig, error) {
	return f.cfg, nil
}

func (f *fakeCrawlerSettings) GetStoryCrawlerVersion() (setting.StoryCrawlerConfig, *time.Time, error) {
	return f.cfg, f.updatedAt, nil
}

func (f *fakeCrawlerSettings) MarkStoryCookieDead(cookie string, at time.Time) (bool, error) {
	f.dead = append(f.dead, cookie)
	for i := range f.cfg.Cookies {
		if f.cfg.Cookies[i].Cookie == cookie && f.cfg.Cookies[i].Status == constants.StoryCookieStatusActive {
			f.cfg.Cookies[i].Status = constants.StoryCookieStatusDead
			f.cfg.Cookies[i].DeadAt = &at
			return true, nil
		}
	}
	return false, nil
}

type fakeCatalog struct {
	posts       []SourcePost
	pages       map[string]StoryPageInfo
	links       map[int64][]ChapterLink
	pageErrors  map[string]error
	linkErrors  map[int64]error
	requests    int64
	sinceAsked  []time.Time
	limitAsked  []int
	storyPages  []string
	retryAsked  [][]int64
	userAgent   string
	cookie      string
	liveCookies map[string]bool
	pageLogout  map[string]bool
	loginChecks []string
	pageCookies []string
}

func (f *fakeCatalog) count() { f.requests++ }

func (f *fakeCatalog) RecentPosts(_ context.Context, since time.Time, limit int) (PostPage, error) {
	f.count()
	f.sinceAsked = append(f.sinceAsked, since)
	f.limitAsked = append(f.limitAsked, limit)
	var matched []SourcePost
	for _, item := range f.posts {
		if modified, err := gmtTime(item.ModifiedGMT); err == nil && modified.After(since) {
			matched = append(matched, item)
		}
	}
	slices.SortStableFunc(matched, func(a, b SourcePost) int { return strings.Compare(b.ModifiedGMT, a.ModifiedGMT) })
	return PostPage{Posts: matched[:min(limit, len(matched))], Total: len(matched), TotalPages: 1}, nil
}

func (f *fakeCatalog) PostsByID(_ context.Context, ids []int64) ([]SourcePost, error) {
	f.count()
	f.retryAsked = append(f.retryAsked, ids)
	var found []SourcePost
	for _, item := range f.posts {
		if slices.Contains(ids, item.ID) {
			found = append(found, item)
		}
	}
	return found, nil
}

func (f *fakeCatalog) Categories(context.Context) (map[int64]string, error) {
	f.count()
	return map[int64]string{1: "Đọc Truyện", 3: "Truyện Ngắn", 126: "Tiểu Thuyết"}, nil
}

func (f *fakeCatalog) TagNames(_ context.Context, ids []int64) (map[int64]string, error) {
	if len(ids) > 0 {
		f.count()
	}
	names := map[int64]string{}
	for _, id := range ids {
		names[id] = "tag" + strconv.FormatInt(id, 10)
	}
	return names, nil
}

func (f *fakeCatalog) StoryPage(_ context.Context, link string) (StoryPageInfo, error) {
	f.count()
	f.storyPages = append(f.storyPages, link)
	f.pageCookies = append(f.pageCookies, f.cookie)
	if err := f.pageErrors[link]; err != nil {
		return StoryPageInfo{}, err
	}
	info, ok := f.pages[link]
	if !ok {
		info = StoryPageInfo{AuthorName: "Tác giả", Status: StoryStatusOngoing, Nonce: "abc"}
	}
	info.LoggedIn = f.liveCookies[f.cookie] && !f.pageLogout[f.cookie]
	return info, nil
}

func (f *fakeCatalog) CheckLogin(context.Context) (bool, error) {
	f.count()
	f.loginChecks = append(f.loginChecks, f.cookie)
	return f.liveCookies[f.cookie], nil
}

func (f *fakeCatalog) SetCookie(cookie string) { f.cookie = cookie }

func (f *fakeCatalog) ChapterLinks(_ context.Context, storyID int64, _ string) ([]ChapterLink, error) {
	f.count()
	if err := f.linkErrors[storyID]; err != nil {
		return nil, err
	}
	return f.links[storyID], nil
}

func (f *fakeCatalog) SetUserAgent(userAgent string) { f.userAgent = userAgent }

func (f *fakeCatalog) Requests() int64 { return f.requests }

type fakeCrawlStore struct {
	mu       sync.Mutex
	known    map[string]KnownStory
	imported map[string][]ChapterImport
	stories  map[string]StoryImport
}

var testNow = time.Date(2026, 10, 5, 18, 0, 0, 0, time.UTC)

func newFakeCrawlStore(known ...KnownStory) *fakeCrawlStore {
	store := &fakeCrawlStore{known: map[string]KnownStory{}, imported: map[string][]ChapterImport{}, stories: map[string]StoryImport{}}
	for _, item := range known {
		store.known[item.SourceStoryID] = item
	}
	return store
}

func (f *fakeCrawlStore) KnownStories(_ context.Context, _ string, ids []string) (map[string]KnownStory, error) {
	out := map[string]KnownStory{}
	for _, id := range ids {
		if item, ok := f.known[id]; ok {
			out[id] = item
		}
	}
	return out, nil
}

func (f *fakeCrawlStore) ImportStory(_ context.Context, _ string, _ time.Time, item StoryImport, chapters []ChapterImport) (ImportResult, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	previous, existed := f.imported[item.SourceStoryID]
	before, wasKnown := f.known[item.SourceStoryID]
	f.imported[item.SourceStoryID] = chapters
	f.stories[item.SourceStoryID] = item
	updatedAt := item.UpdatedAt
	f.known[item.SourceStoryID] = KnownStory{SourceStoryID: item.SourceStoryID, Kind: item.Kind, ChapterCount: len(chapters), SourceUpdatedAt: &updatedAt}
	if !existed {
		if !wasKnown {
			return ImportResult{StoryInserted: true, Added: len(chapters)}, nil
		}
		previous = make([]ChapterImport, before.ChapterCount)
	}
	added := max(len(chapters)-len(previous), 0)
	return ImportResult{Added: added, Unchanged: len(chapters) - added}, nil
}

func newTestCache(t *testing.T) (*services.CacheService, *miniredis.Miniredis) {
	t.Helper()
	server := miniredis.RunT(t)
	host, portValue, err := net.SplitHostPort(server.Addr())
	if err != nil {
		t.Fatal(err)
	}
	port, err := strconv.Atoi(portValue)
	if err != nil {
		t.Fatal(err)
	}
	cache, err := services.NewCacheService(&config.Config{RedisHost: host, RedisPort: port}, zap.NewNop().Sugar())
	if err != nil {
		t.Fatalf("create cache service: %v", err)
	}
	t.Cleanup(func() { _ = cache.Close() })
	return cache, server
}

func post(id int64, modified string, categories ...int64) SourcePost {
	return SourcePost{
		ID:          id,
		Slug:        fmt.Sprintf("truyen-%d", id),
		Link:        fmt.Sprintf("https://vnkings.com/truyen-%d.html", id),
		Title:       renderedText{Rendered: fmt.Sprintf("Truyện %d", id)},
		DateGMT:     "2026-01-01T00:00:00",
		ModifiedGMT: modified,
		Categories:  categories,
		Tags:        []int64{7},
		Author:      42,
	}
}

func chapterLinks(count int) []ChapterLink {
	links := make([]ChapterLink, 0, count)
	for i := 1; i <= count; i++ {
		links = append(links, ChapterLink{
			SourceID:  strconv.Itoa(1000 + i),
			URL:       fmt.Sprintf("https://vnkings.com/c-p%d.html", 1000+i),
			Title:     fmt.Sprintf("Chương %d", i),
			DateLabel: "05/10/2026",
		})
	}
	return links
}

func withTestClock(crawler *Crawler) *Crawler {
	crawler.now = func() time.Time { return testNow }
	return crawler
}

func newTestCrawler(t *testing.T, store *fakeCrawlStore, catalog *fakeCatalog, cfg setting.StoryCrawlerConfig) *Crawler {
	cache, _ := newTestCache(t)
	return withTestClock(newCrawler(store, catalog, &fakeCrawlerSettings{cfg: cfg}, cache, zap.NewNop().Sugar()))
}

func lastLog(t *testing.T, crawler *Crawler) CrawlLog {
	t.Helper()
	logs, err := crawler.logs(context.Background())
	if err != nil || len(logs) == 0 {
		t.Fatalf("no crawl log: %v", err)
	}
	return logs[0]
}

func TestCrawlerUpdatesKnownStoriesOnly(t *testing.T) {
	store := newFakeCrawlStore(KnownStory{SourceStoryID: "10", Kind: StoryKindLong, ChapterCount: 2})
	catalog := &fakeCatalog{
		posts: []SourcePost{post(10, "2026-10-05T13:00:00", 126), post(20, "2026-10-05T14:00:00", 126)},
		links: map[int64][]ChapterLink{10: chapterLinks(5), 20: chapterLinks(3)},
	}
	crawler := newTestCrawler(t, store, catalog, setting.StoryCrawlerConfig{Enabled: true, IntervalHours: 1})

	entry, err := crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if err != nil {
		t.Fatal(err)
	}
	if entry.Status != StoryCrawlStatusSuccess {
		t.Fatalf("status %s: %s", entry.Status, entry.Message)
	}
	if entry.StoriesChecked != 1 || entry.StoriesUpdated != 1 || entry.StoriesCreated != 0 || entry.StoriesSkippedNew != 1 || entry.ChaptersAdded != 3 {
		t.Fatalf("unexpected counters %+v", entry)
	}
	if _, ok := store.imported["20"]; ok {
		t.Fatal("new story must not be imported when importNewStories is off")
	}
	if len(catalog.storyPages) != 1 {
		t.Fatalf("skipped story must not be fetched, fetched %v", catalog.storyPages)
	}
	if want := testNow.Add(-StoryCrawlWindow); !catalog.sinceAsked[0].Equal(want) || catalog.limitAsked[0] != StoryCrawlBatch {
		t.Fatalf("run must ask for the latest %d posts since %v, got %v %v", StoryCrawlBatch, want, catalog.sinceAsked, catalog.limitAsked)
	}
	stored := store.stories["10"]
	if stored.Kind != StoryKindLong || len(stored.Genres) != 1 || stored.Genres[0] != "Tiểu Thuyết" || len(stored.Tags) != 1 || stored.SourceAuthorID == nil {
		t.Fatalf("unexpected import %+v", stored)
	}
	if entry.Requests != catalog.requests {
		t.Fatalf("requests %d, want %d", entry.Requests, catalog.requests)
	}

	pagesBefore := len(catalog.storyPages)
	second, err := crawler.Run(context.Background(), StoryCrawlTriggerSchedule)
	if err != nil {
		t.Fatal(err)
	}
	if second.StoriesUnchanged != 1 || second.ChaptersAdded != 0 || len(catalog.storyPages) != pagesBefore {
		t.Fatalf("second run must skip the story already synced, got %+v", second)
	}
	if lastLog(t, crawler).ID != second.ID {
		t.Fatal("latest log must be the second run")
	}
}

func TestCrawlerImportsNewStoriesWhenEnabled(t *testing.T) {
	store := newFakeCrawlStore()
	catalog := &fakeCatalog{
		posts: []SourcePost{post(20, "2026-10-05T14:00:00", 126), post(30, "2026-10-05T15:00:00", 3), post(40, "2026-10-05T16:00:00", 126)},
		links: map[int64][]ChapterLink{20: chapterLinks(3)},
		pages: map[string]StoryPageInfo{"https://vnkings.com/truyen-30.html": {Status: StoryStatusCompleted}},
	}
	crawler := newTestCrawler(t, store, catalog, setting.StoryCrawlerConfig{IntervalHours: 1, ImportNewStories: true})

	entry, err := crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if err != nil {
		t.Fatal(err)
	}
	if entry.StoriesCreated != 2 || entry.StoriesEmpty != 1 || entry.ChaptersAdded != 4 || entry.Status != StoryCrawlStatusSuccess {
		t.Fatalf("unexpected counters %+v", entry)
	}
	short := store.stories["30"]
	chapters := store.imported["30"]
	if short.Kind != StoryKindShort || len(chapters) != 1 || chapters[0].SourceChapterID != "30" || chapters[0].PublishedAt == nil {
		t.Fatalf("short story must become one chapter keyed by post id, got %+v %+v", short, chapters)
	}
}

func TestCrawlerQueuesFailedStoriesForRetry(t *testing.T) {
	store := newFakeCrawlStore(
		KnownStory{SourceStoryID: "10", Kind: StoryKindLong},
		KnownStory{SourceStoryID: "11", Kind: StoryKindLong},
		KnownStory{SourceStoryID: "12", Kind: StoryKindLong},
	)
	catalog := &fakeCatalog{
		posts:      []SourcePost{post(10, "2026-10-05T13:00:00", 126), post(11, "2026-10-05T13:30:00", 126), post(12, "2026-10-05T14:00:00", 126)},
		links:      map[int64][]ChapterLink{10: chapterLinks(2)},
		pageErrors: map[string]error{"https://vnkings.com/truyen-11.html": fmt.Errorf("%w: status 404", errStoryGone)},
	}
	crawler := newTestCrawler(t, store, catalog, setting.StoryCrawlerConfig{IntervalHours: 1})

	entry, _ := crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if entry.Status != StoryCrawlStatusPartial || entry.StoriesFailed != 2 || len(entry.Errors) != 2 || entry.RetryPending != 2 {
		t.Fatalf("unexpected result %+v", entry)
	}
	if entry.Errors[0].Message != "Không lấy được danh sách chương" || entry.Errors[1].Message != "Truyện không còn trên nguồn" {
		t.Fatalf("unexpected errors %+v", entry.Errors)
	}
	if !entry.Errors[0].WillRetry || entry.Errors[0].Attempts != 1 {
		t.Fatalf("failed story must be queued for retry, got %+v", entry.Errors[0])
	}
	if _, ok := store.imported["12"]; ok {
		t.Fatal("known long story without chapter list must not be imported")
	}
	state := crawler.loadState(context.Background())
	if len(state.Retry) != 2 || state.Retry[0].PostID != 11 || state.Retry[1].PostID != 12 {
		t.Fatalf("failed stories must be kept for retry, got %+v", state.Retry)
	}

	delete(catalog.pageErrors, "https://vnkings.com/truyen-11.html")
	catalog.links[11] = chapterLinks(1)
	catalog.links[12] = chapterLinks(3)
	entry, _ = crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if entry.Status != StoryCrawlStatusSuccess || entry.Retried != 2 || entry.RetryPending != 0 {
		t.Fatalf("retry must import the stories once the source recovers, got %+v", entry)
	}
	if len(store.imported["11"]) != 1 || len(store.imported["12"]) != 3 {
		t.Fatalf("retried stories not imported: %v", store.imported)
	}
	if !slices.Equal(catalog.retryAsked[0], []int64{11, 12}) {
		t.Fatalf("retry must fetch the queued posts by id, got %v", catalog.retryAsked)
	}
}

func TestCrawlerGivesUpRetryAfterLimit(t *testing.T) {
	store := newFakeCrawlStore(KnownStory{SourceStoryID: "10", Kind: StoryKindLong})
	catalog := &fakeCatalog{posts: []SourcePost{post(10, "2026-10-05T13:00:00", 126)}}
	crawler := newTestCrawler(t, store, catalog, setting.StoryCrawlerConfig{IntervalHours: 1})

	var entry *CrawlLog
	for attempt := 1; attempt <= StoryCrawlRetryAttempts; attempt++ {
		entry, _ = crawler.Run(context.Background(), StoryCrawlTriggerManual)
		if entry.StoriesFailed != 1 || entry.Errors[0].Attempts != attempt {
			t.Fatalf("attempt %d: unexpected %+v", attempt, entry.Errors)
		}
	}
	if entry.Errors[0].WillRetry || entry.RetryPending != 0 {
		t.Fatalf("story must be dropped after %d attempts, got %+v", StoryCrawlRetryAttempts, entry)
	}
	before := len(catalog.storyPages)
	if entry, _ = crawler.Run(context.Background(), StoryCrawlTriggerManual); entry.Retried != 0 || len(catalog.storyPages) != before {
		t.Fatalf("dropped story must not be retried again, got %+v", entry)
	}
	catalog.posts[0].ModifiedGMT = "2026-10-05T17:00:00"
	entry, _ = crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if len(catalog.storyPages) != before+1 || entry.StoriesFailed != 1 || entry.Errors[0].Attempts != 1 {
		t.Fatalf("story edited at the source must be tried again from attempt 1, got %+v", entry)
	}
}

func TestCrawlerDropsRetryWhenPostIsGone(t *testing.T) {
	store := newFakeCrawlStore(KnownStory{SourceStoryID: "10", Kind: StoryKindLong})
	catalog := &fakeCatalog{posts: []SourcePost{post(10, "2026-10-05T13:00:00", 126)}}
	crawler := newTestCrawler(t, store, catalog, setting.StoryCrawlerConfig{IntervalHours: 1})

	if entry, _ := crawler.Run(context.Background(), StoryCrawlTriggerManual); entry.RetryPending != 1 {
		t.Fatalf("story must be queued, got %+v", entry)
	}
	catalog.posts = nil
	entry, _ := crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if entry.RetryPending != 0 || entry.Retried != 0 {
		t.Fatalf("post missing at source must leave the retry queue, got %+v", entry)
	}
}

func TestCrawlerRefusesIncompleteChapterList(t *testing.T) {
	store := newFakeCrawlStore(KnownStory{SourceStoryID: "10", Kind: StoryKindLong, ChapterCount: 25})
	catalog := &fakeCatalog{
		posts:      []SourcePost{post(10, "2026-10-05T13:00:00", 126)},
		linkErrors: map[int64]error{10: fmt.Errorf("%w: story 10 page 2 failed", errIncompleteChapters)},
	}
	crawler := newTestCrawler(t, store, catalog, setting.StoryCrawlerConfig{IntervalHours: 1})

	entry, _ := crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if entry.StoriesFailed != 1 || len(store.imported) != 0 || entry.RetryPending != 1 {
		t.Fatalf("incomplete chapter list must not be imported, got %+v", entry)
	}
	if entry.Errors[0].Message != "Danh sách chương tải dở dang, bỏ qua để không xoá nhầm chương" {
		t.Fatalf("unexpected message %q", entry.Errors[0].Message)
	}
}

func TestCrawlerStopsWhenBlocked(t *testing.T) {
	store := newFakeCrawlStore(KnownStory{SourceStoryID: "10", Kind: StoryKindLong}, KnownStory{SourceStoryID: "11", Kind: StoryKindLong})
	catalog := &fakeCatalog{
		posts:      []SourcePost{post(10, "2026-10-05T13:00:00", 126), post(11, "2026-10-05T14:00:00", 126)},
		linkErrors: map[int64]error{11: fmt.Errorf("%w: status 429", errSourceBlocked)},
	}
	crawler := newTestCrawler(t, store, catalog, setting.StoryCrawlerConfig{IntervalHours: 1})

	entry, _ := crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if entry.Status != StoryCrawlStatusBlocked || entry.Message == "" {
		t.Fatalf("unexpected result %+v", entry)
	}
	if len(catalog.storyPages) != 1 {
		t.Fatalf("crawl must stop at the first block, fetched %v", catalog.storyPages)
	}
	if exists, _ := crawler.redis.Exists(context.Background(), CacheKeyStoryCrawlProgress).Result(); exists != 0 {
		t.Fatal("progress must be cleared after the run")
	}
}

func TestCrawlerRefusesLongStoryTurningShort(t *testing.T) {
	store := newFakeCrawlStore(KnownStory{SourceStoryID: "10", Kind: StoryKindLong, ChapterCount: 40})
	catalog := &fakeCatalog{posts: []SourcePost{post(10, "2026-10-05T13:00:00", 3)}}
	crawler := newTestCrawler(t, store, catalog, setting.StoryCrawlerConfig{IntervalHours: 1})

	entry, _ := crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if entry.StoriesFailed != 1 || len(store.imported) != 0 {
		t.Fatalf("long story must not be replaced by a single short chapter, got %+v", entry)
	}
}

func shortPosts(total int, modified func(i int) time.Time) ([]SourcePost, []KnownStory) {
	posts := make([]SourcePost, 0, total)
	known := make([]KnownStory, 0, total)
	for i := 0; i < total; i++ {
		id := int64(100 + i)
		posts = append(posts, post(id, modified(i).Format("2006-01-02T15:04:05"), 3))
		known = append(known, KnownStory{SourceStoryID: strconv.FormatInt(id, 10), Kind: StoryKindShort})
	}
	return posts, known
}

func TestCrawlerTakesOnlyTheLatestBatchWithinTheWindow(t *testing.T) {
	posts, known := shortPosts(StoryCrawlBatch+5, func(i int) time.Time { return testNow.Add(-time.Duration(i+1) * time.Minute) })
	old := post(999, testNow.Add(-StoryCrawlWindow-time.Minute).Format("2006-01-02T15:04:05"), 3)
	catalog := &fakeCatalog{posts: append(posts, old)}
	crawler := newTestCrawler(t, newFakeCrawlStore(known...), catalog, setting.StoryCrawlerConfig{IntervalHours: 1})

	entry, _ := crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if !entry.Truncated || entry.PostsFound != StoryCrawlBatch || entry.PostsProcessed != StoryCrawlBatch {
		t.Fatalf("unexpected result %+v", entry)
	}
	want := make([]string, 0, StoryCrawlBatch)
	for _, item := range posts[:StoryCrawlBatch] {
		want = append(want, item.Link)
	}
	if !slices.Equal(catalog.storyPages, want) {
		t.Fatalf("only the %d most recently edited posts must be fetched, got %v", StoryCrawlBatch, catalog.storyPages)
	}
	if !entry.Since.Equal(testNow.Add(-StoryCrawlWindow)) {
		t.Fatalf("scan must start %v before the run, got %v", StoryCrawlWindow, entry.Since)
	}
}

func TestCrawlerSkipsStoriesAlreadySynced(t *testing.T) {
	synced := time.Date(2026, 10, 5, 13, 0, 0, 0, time.UTC)
	store := newFakeCrawlStore(KnownStory{SourceStoryID: "10", Kind: StoryKindLong, ChapterCount: 2, SourceUpdatedAt: &synced})
	catalog := &fakeCatalog{
		posts: []SourcePost{post(10, "2026-10-05T13:00:00", 126)},
		links: map[int64][]ChapterLink{10: chapterLinks(3)},
	}
	crawler := newTestCrawler(t, store, catalog, setting.StoryCrawlerConfig{IntervalHours: 1})

	entry, _ := crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if entry.StoriesUnchanged != 1 || entry.StoriesChecked != 0 || len(catalog.storyPages) != 0 {
		t.Fatalf("story with the same edit time must not be fetched, got %+v", entry)
	}
	catalog.posts[0].ModifiedGMT = "2026-10-05T15:00:00"
	entry, _ = crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if entry.StoriesUpdated != 1 || entry.ChaptersAdded != 1 || len(catalog.storyPages) != 1 {
		t.Fatalf("story edited after the last sync must be fetched, got %+v", entry)
	}
}

func TestCrawlerImportsNewStoriesSkippedWhileDisabled(t *testing.T) {
	store := newFakeCrawlStore()
	catalog := &fakeCatalog{
		posts: []SourcePost{post(20, "2026-10-04T09:00:00", 126)},
		links: map[int64][]ChapterLink{20: chapterLinks(2)},
	}
	settings := &fakeCrawlerSettings{cfg: setting.StoryCrawlerConfig{IntervalHours: 1}}
	cache, _ := newTestCache(t)
	crawler := withTestClock(newCrawler(store, catalog, settings, cache, zap.NewNop().Sugar()))

	entry, _ := crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if entry.StoriesSkippedNew != 1 || entry.StoriesCreated != 0 {
		t.Fatalf("new story must be skipped while disabled, got %+v", entry)
	}
	settings.cfg.ImportNewStories = true
	entry, _ = crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if entry.StoriesCreated != 1 || len(store.imported["20"]) != 2 {
		t.Fatalf("story skipped earlier must be imported once enabled, got %+v", entry)
	}
}

func TestCrawlerPicksUpPostsLeftByABlockedRun(t *testing.T) {
	store := newFakeCrawlStore(KnownStory{SourceStoryID: "10", Kind: StoryKindLong}, KnownStory{SourceStoryID: "11", Kind: StoryKindLong})
	catalog := &fakeCatalog{
		posts:      []SourcePost{post(10, "2026-10-05T13:00:00", 126), post(11, "2026-10-05T14:00:00", 126)},
		links:      map[int64][]ChapterLink{10: chapterLinks(2), 11: chapterLinks(2)},
		linkErrors: map[int64]error{11: fmt.Errorf("%w: status 429", errSourceBlocked)},
	}
	crawler := newTestCrawler(t, store, catalog, setting.StoryCrawlerConfig{IntervalHours: 1})

	if entry, _ := crawler.Run(context.Background(), StoryCrawlTriggerManual); entry.Status != StoryCrawlStatusBlocked {
		t.Fatalf("unexpected %+v", entry)
	}
	delete(catalog.linkErrors, 11)
	entry, _ := crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if _, ok := store.imported["10"]; !ok || entry.Status != StoryCrawlStatusSuccess || entry.StoriesUpdated != 2 {
		t.Fatalf("next run must process the stories left by the blocked run, got %+v", entry)
	}
}

func TestCrawlerLockAndLogLimit(t *testing.T) {
	crawler := newTestCrawler(t, newFakeCrawlStore(), &fakeCatalog{}, setting.StoryCrawlerConfig{IntervalHours: 1})
	token, err := crawler.acquire()
	if err != nil {
		t.Fatal(err)
	}
	if _, err := crawler.Run(context.Background(), StoryCrawlTriggerSchedule); !errors.Is(err, ErrCrawlRunning) {
		t.Fatalf("second run must be refused while locked, got %v", err)
	}
	if err := crawler.RunNow(); !errors.Is(err, ErrCrawlRunning) {
		t.Fatalf("manual run must be refused while locked, got %v", err)
	}
	status, err := crawler.Status(context.Background())
	if err != nil || !status.Running {
		t.Fatalf("status must report running, got %+v %v", status, err)
	}
	crawler.release(token)

	for i := 0; i < StoryCrawlLogLimit+5; i++ {
		if _, err := crawler.Run(context.Background(), StoryCrawlTriggerSchedule); err != nil {
			t.Fatal(err)
		}
	}
	logs, err := crawler.logs(context.Background())
	if err != nil || len(logs) != StoryCrawlLogLimit {
		t.Fatalf("logs must be capped at %d, got %d %v", StoryCrawlLogLimit, len(logs), err)
	}
}

func TestCrawlerSchedule(t *testing.T) {
	settings := &fakeCrawlerSettings{cfg: setting.StoryCrawlerConfig{Enabled: false, IntervalHours: 2}}
	cache, _ := newTestCache(t)
	crawler := newCrawler(newFakeCrawlStore(), &fakeCatalog{}, settings, cache, zap.NewNop().Sugar())
	ctx := context.Background()

	if wait := crawler.untilDue(ctx); wait != StoryCrawlMaxSleep {
		t.Fatalf("disabled crawler must only poll, got %v", wait)
	}
	settings.cfg.Enabled = true
	if wait := crawler.untilDue(ctx); wait > 0 {
		t.Fatalf("never-run crawler must be due, got %v", wait)
	}
	lastRun := time.Now().Add(-90 * time.Minute)
	crawler.saveState(ctx, crawlState{LastRunAt: &lastRun})
	if wait := crawler.untilDue(ctx); wait < 29*time.Minute || wait > 31*time.Minute {
		t.Fatalf("2h interval after 90m must wait about 30m, got %v", wait)
	}
	status, err := crawler.Status(ctx)
	if err != nil || status.NextRunAt == nil || status.Running {
		t.Fatalf("unexpected status %+v %v", status, err)
	}
	if want := lastRun.Add(2 * time.Hour); status.NextRunAt.Sub(want).Abs() > time.Second {
		t.Fatalf("next run %v, want %v", status.NextRunAt, want)
	}
}

func TestUserAgentsFile(t *testing.T) {
	if len(userAgents) < 100 {
		t.Fatalf("expected the embedded list, got %d user agents", len(userAgents))
	}
	seen := map[string]bool{}
	for _, value := range userAgents {
		if seen[value] || !strings.HasPrefix(value, "Mozilla/5.0 (") {
			t.Fatalf("bad or duplicate user agent %q", value)
		}
		seen[value] = true
	}
	if pickUserAgent(false) != StoryFetchUserAgent {
		t.Fatal("fixed mode must use the default user agent")
	}
	if loadUserAgents([]byte("not json")) != nil {
		t.Fatal("broken json must give no list")
	}
}

func TestCrawlerRandomUserAgentPerRun(t *testing.T) {
	catalog := &fakeCatalog{}
	settings := &fakeCrawlerSettings{cfg: setting.StoryCrawlerConfig{IntervalHours: 1}}
	cache, _ := newTestCache(t)
	crawler := withTestClock(newCrawler(newFakeCrawlStore(), catalog, settings, cache, zap.NewNop().Sugar()))

	entry, _ := crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if entry.UserAgent != StoryFetchUserAgent || catalog.userAgent != entry.UserAgent {
		t.Fatalf("fixed mode used %q / %q", entry.UserAgent, catalog.userAgent)
	}
	settings.cfg.RandomUserAgent = true
	used := map[string]bool{}
	for range 30 {
		entry, _ := crawler.Run(context.Background(), StoryCrawlTriggerManual)
		if !slices.Contains(userAgents, entry.UserAgent) || catalog.userAgent != entry.UserAgent {
			t.Fatalf("random mode used %q / %q", entry.UserAgent, catalog.userAgent)
		}
		used[entry.UserAgent] = true
	}
	if len(used) < 2 {
		t.Fatal("random mode must vary the user agent between runs")
	}
}

func storyCookie(name, value, status string) setting.StoryCookie {
	return setting.StoryCookie{Name: name, Cookie: value, Status: status}
}

func TestCrawlerMarksLoggedOutCookiesAndFallsBackToGuest(t *testing.T) {
	store := newFakeCrawlStore(KnownStory{SourceStoryID: "10", Kind: StoryKindLong})
	catalog := &fakeCatalog{
		posts: []SourcePost{post(10, "2026-10-05T13:00:00", 126)},
		links: map[int64][]ChapterLink{10: chapterLinks(2)},
	}
	settings := &fakeCrawlerSettings{cfg: setting.StoryCrawlerConfig{IntervalHours: 1, UseCookies: true, Cookies: []setting.StoryCookie{
		storyCookie("acc1", "a=1", constants.StoryCookieStatusActive),
		storyCookie("", "b=2", constants.StoryCookieStatusActive),
		storyCookie("old", "c=3", constants.StoryCookieStatusDead),
	}}}
	cache, _ := newTestCache(t)
	crawler := withTestClock(newCrawler(store, catalog, settings, cache, zap.NewNop().Sugar()))

	entry, err := crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if err != nil {
		t.Fatal(err)
	}
	if entry.Status != StoryCrawlStatusSuccess || entry.ChaptersAdded != 2 {
		t.Fatalf("run must go on as a guest, got %+v", entry)
	}
	if !entry.UseCookies || entry.Cookie != "" {
		t.Fatalf("no live cookie must leave the run without one, got %+v", entry)
	}
	slices.Sort(entry.CookiesDied)
	if !slices.Equal(entry.CookiesDied, []string{"Cookie 2", "acc1"}) {
		t.Fatalf("unexpected dead labels %v", entry.CookiesDied)
	}
	if slices.Contains(catalog.loginChecks, "c=3") {
		t.Fatal("cookies already dead must not be tried")
	}
	for _, item := range settings.cfg.Cookies[:2] {
		if item.Status != constants.StoryCookieStatusDead || item.DeadAt == nil {
			t.Fatalf("cookie %q must be marked dead, got %+v", item.Name, item)
		}
	}
	if !slices.Equal(catalog.pageCookies, []string{""}) {
		t.Fatalf("story pages must be fetched without a cookie, got %v", catalog.pageCookies)
	}
}

func TestCrawlerSwitchesCookieWhenItDiesMidRun(t *testing.T) {
	catalog := &fakeCatalog{
		liveCookies: map[string]bool{"a=1": true, "b=2": true},
		pageLogout:  map[string]bool{"a=1": true},
	}
	settings := &fakeCrawlerSettings{cfg: setting.StoryCrawlerConfig{Cookies: []setting.StoryCookie{
		storyCookie("acc1", "a=1", constants.StoryCookieStatusActive),
		storyCookie("acc2", "b=2", constants.StoryCookieStatusActive),
	}}}
	cache, _ := newTestCache(t)
	crawler := withTestClock(newCrawler(newFakeCrawlStore(), catalog, settings, cache, zap.NewNop().Sugar()))
	entry := &CrawlLog{}
	session := &cookieSession{candidates: []crawlCookie{{label: "acc1", value: "a=1"}, {label: "acc2", value: "b=2"}}}
	ctx := context.Background()

	if err := crawler.nextCookie(ctx, entry, session); err != nil || entry.Cookie != "acc1" {
		t.Fatalf("first live cookie must be used, got %q %v", entry.Cookie, err)
	}
	info, err := crawler.storyPage(ctx, entry, session, "https://vnkings.com/truyen-10.html")
	if err != nil || !info.LoggedIn {
		t.Fatalf("page must be refetched with the next cookie, got %+v %v", info, err)
	}
	if entry.Cookie != "acc2" || catalog.cookie != "b=2" || !slices.Equal(entry.CookiesDied, []string{"acc1"}) {
		t.Fatalf("unexpected switch %+v cookie=%q", entry, catalog.cookie)
	}
	if !slices.Equal(catalog.pageCookies, []string{"a=1", "b=2"}) || !slices.Equal(settings.dead, []string{"a=1"}) {
		t.Fatalf("pages %v, dead %v", catalog.pageCookies, settings.dead)
	}
}

func TestCrawlerUsesLiveCookieAndResetsWhenDisabled(t *testing.T) {
	store := newFakeCrawlStore(KnownStory{SourceStoryID: "10", Kind: StoryKindLong})
	catalog := &fakeCatalog{
		posts:       []SourcePost{post(10, "2026-10-05T13:00:00", 126)},
		links:       map[int64][]ChapterLink{10: chapterLinks(1)},
		liveCookies: map[string]bool{"a=1": true},
	}
	settings := &fakeCrawlerSettings{cfg: setting.StoryCrawlerConfig{IntervalHours: 1, UseCookies: true, Cookies: []setting.StoryCookie{
		storyCookie("acc1", "a=1", constants.StoryCookieStatusActive),
	}}}
	cache, _ := newTestCache(t)
	crawler := withTestClock(newCrawler(store, catalog, settings, cache, zap.NewNop().Sugar()))

	entry, _ := crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if entry.Cookie != "acc1" || len(entry.CookiesDied) != 0 || !slices.Equal(catalog.pageCookies, []string{"a=1"}) {
		t.Fatalf("live cookie must be used for the whole run, got %+v pages %v", entry, catalog.pageCookies)
	}
	status, err := crawler.Status(context.Background())
	if err != nil || !status.Config.UseCookies || len(status.Config.Cookies) != 1 {
		t.Fatalf("status must expose the cookie config, got %+v %v", status, err)
	}

	settings.cfg.UseCookies = false
	checks := len(catalog.loginChecks)
	entry, _ = crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if entry.UseCookies || entry.Cookie != "" || catalog.cookie != "" || len(catalog.loginChecks) != checks {
		t.Fatalf("disabled cookies must not be sent or checked, got %+v cookie=%q", entry, catalog.cookie)
	}
}
