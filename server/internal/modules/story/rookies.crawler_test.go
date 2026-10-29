package story

import (
	"context"
	"errors"
	"fmt"
	"slices"
	"testing"
	"time"

	"ola-chat-server/internal/modules/setting"

	"go.uber.org/zap"
)

type fakeRookiesSettings struct {
	cfg  setting.StoryCrawlerConfig
	dead []string
}

func (f *fakeRookiesSettings) MarkRookiesCookieDead(cookie string, at time.Time) (bool, error) {
	f.dead = append(f.dead, cookie)
	for i := range f.cfg.Cookies {
		if f.cfg.Cookies[i].Cookie == cookie && f.cfg.Cookies[i].Status == setting.StoryCookieStatusActive {
			f.cfg.Cookies[i].Status = setting.StoryCookieStatusDead
			f.cfg.Cookies[i].DeadAt = &at
			return true, nil
		}
	}
	return false, nil
}

func (f *fakeRookiesSettings) GetRookiesCrawler() (setting.StoryCrawlerConfig, error) {
	return f.cfg, nil
}

func (f *fakeRookiesSettings) GetRookiesCrawlerVersion() (setting.StoryCrawlerConfig, *time.Time, error) {
	return f.cfg, nil, nil
}

type fakeRookiesCatalog struct {
	listing     rookiesListing
	listErr     error
	stories     map[string]rookiesStory
	storyErrors map[string]error
	storyCalls  []string
	listCalls   int
	requests    int64
	userAgent   string
	cookie      string
	liveCookies map[string]bool
	storyLogout map[string]bool
	loginChecks []string
	storyCookie []string
}

func (f *fakeRookiesCatalog) SetCookie(cookie string) { f.cookie = cookie }

func (f *fakeRookiesCatalog) CheckLogin(context.Context) (bool, error) {
	f.requests++
	f.loginChecks = append(f.loginChecks, f.cookie)
	return f.liveCookies[f.cookie], nil
}

func (f *fakeRookiesCatalog) Latest(context.Context) (rookiesListing, error) {
	f.requests++
	f.listCalls++
	return f.listing, f.listErr
}

func (f *fakeRookiesCatalog) Story(_ context.Context, slug string) (rookiesStory, error) {
	f.requests++
	f.storyCalls = append(f.storyCalls, slug)
	f.storyCookie = append(f.storyCookie, f.cookie)
	if err := f.storyErrors[slug]; err != nil {
		return rookiesStory{}, err
	}
	story, ok := f.stories[slug]
	if !ok {
		return rookiesStory{}, errStoryGone
	}
	story.LoggedIn = f.liveCookies[f.cookie] && !f.storyLogout[f.cookie]
	return story, nil
}

func (f *fakeRookiesCatalog) SetUserAgent(userAgent string) { f.userAgent = userAgent }

func (f *fakeRookiesCatalog) Requests() int64 { return f.requests }

func (f *fakeRookiesCatalog) add(stories ...rookiesStory) {
	for _, story := range stories {
		f.listing.Items = append(f.listing.Items, story.rookiesNovel)
		f.stories[story.Slug] = story
	}
}

// Giờ VN, trước testNow (2026-10-06 01:00 giờ VN).
func vnTime(day, clock string) string {
	return "2026-10-" + day + " " + clock
}

func rookiesStoryFixture(id int64, chapters ...rookiesChapter) rookiesStory {
	return rookiesStory{
		rookiesNovel: rookiesNovel{
			ID:           id,
			Slug:         fmt.Sprintf("truyen-%d", id),
			Title:        fmt.Sprintf("Truyện %d", id),
			Picture:      "user/1/novels/bia.jpg",
			PublishedAt:  vnTime("05", "23:00:00"),
			ChapterCount: rookiesNumber(len(chapters)),
			CreatedAt:    "2026-09-01T00:00:00.000000Z",
			UserID:       42,
			Filters: []rookiesFilter{
				{GroupID: StoryRookiesGroupKind, Title: "Truyện sáng tác"},
				{GroupID: StoryRookiesGroupForm, Title: "Truyện dài"},
				{GroupID: StoryRookiesGroupGenre, Title: "Ngôn tình"},
				{GroupID: 6, Title: "Học đường"},
			},
		},
		Author:   rookiesAuthor{Username: "tacgia", FullName: "Tác Giả"},
		Chapters: chapters,
	}
}

func freeChapter(id int64, order int, at string) rookiesChapter {
	return rookiesChapter{ID: id, Title: rookiesText(fmt.Sprintf("Chương %d", order)), ShowOrder: rookiesNumber(order), PublishedAt: at}
}

func newTestRookiesCrawler(t *testing.T, store *fakeCrawlStore, catalog *fakeRookiesCatalog, cfg setting.StoryCrawlerConfig) *RookiesCrawler {
	t.Helper()
	cache, _ := newTestCache(t)
	crawler := newRookiesCrawler(store, catalog, &fakeRookiesSettings{cfg: cfg}, cache, zap.NewNop().Sugar())
	crawler.now = func() time.Time { return testNow }
	return crawler
}

func newFakeRookiesCatalog(stories ...rookiesStory) *fakeRookiesCatalog {
	catalog := &fakeRookiesCatalog{stories: map[string]rookiesStory{}, storyErrors: map[string]error{}}
	catalog.listing.PerPage = 10
	catalog.add(stories...)
	return catalog
}

func runRookies(t *testing.T, crawler *RookiesCrawler) *CrawlLog {
	t.Helper()
	entry, err := crawler.Run(context.Background(), StoryCrawlTriggerManual)
	if err != nil {
		t.Fatal(err)
	}
	return entry
}

func TestRookiesCrawlerImportsChangedStoriesOnly(t *testing.T) {
	known := rookiesStoryFixture(10, freeChapter(101, 1, vnTime("04", "10:00:00")), freeChapter(102, 2, vnTime("05", "23:00:00")))
	fresh := rookiesStoryFixture(20, freeChapter(201, 1, vnTime("05", "22:00:00")))
	translated := rookiesStoryFixture(30, freeChapter(301, 1, vnTime("05", "21:00:00")))
	translated.Filters[0].Title = StoryRookiesTranslatedLabel
	store := newFakeCrawlStore(KnownStory{SourceStoryID: "10", Kind: StoryKindLong, ChapterCount: 1})
	catalog := newFakeRookiesCatalog(known, fresh, translated)
	crawler := newTestRookiesCrawler(t, store, catalog, setting.StoryCrawlerConfig{Enabled: true, IntervalHours: 1, ImportNewStories: true})

	entry := runRookies(t, crawler)
	if entry.Status != StoryCrawlStatusSuccess {
		t.Fatalf("status %s: %s", entry.Status, entry.Message)
	}
	if catalog.listCalls != 1 || entry.PostsFound != 3 || entry.PostsProcessed != 3 {
		t.Fatalf("must read exactly one page, list calls %d, entry %+v", catalog.listCalls, entry)
	}
	if entry.StoriesChecked != 2 || entry.StoriesUpdated != 1 || entry.StoriesCreated != 1 || entry.ChaptersAdded != 2 {
		t.Fatalf("unexpected counters %+v", entry)
	}
	if _, ok := store.imported["30"]; ok {
		t.Fatal("translated story must be skipped")
	}
	if entry.Requests != catalog.requests || entry.Requests != 3 {
		t.Fatalf("requests %d, catalog %d", entry.Requests, catalog.requests)
	}

	second := runRookies(t, crawler)
	if second.StoriesUnchanged != 2 || second.StoriesChecked != 0 || len(catalog.storyCalls) != 2 {
		t.Fatalf("unchanged stories must not be opened again, got %+v calls %v", second, catalog.storyCalls)
	}

	catalog.listing.Items[0].ChapterCount = 3
	third := runRookies(t, crawler)
	if third.StoriesChecked != 1 || catalog.storyCalls[len(catalog.storyCalls)-1] != "truyen-10" {
		t.Fatalf("changed story must be opened again, got %+v calls %v", third, catalog.storyCalls)
	}
}

func TestRookiesCrawlerReimportsStoryMissingFromDB(t *testing.T) {
	store := newFakeCrawlStore()
	catalog := newFakeRookiesCatalog(rookiesStoryFixture(20, freeChapter(201, 1, vnTime("05", "22:00:00"))))
	crawler := newTestRookiesCrawler(t, store, catalog, setting.StoryCrawlerConfig{Enabled: true, IntervalHours: 1, ImportNewStories: true})
	runRookies(t, crawler)

	delete(store.known, "20")
	delete(store.imported, "20")
	entry := runRookies(t, crawler)
	if entry.StoriesCreated != 1 || entry.StoriesUnchanged != 0 {
		t.Fatalf("story missing from the DB must be imported again even with the same fingerprint, got %+v", entry)
	}
}

func TestRookiesCrawlerSkipsNewStoriesWhenImportOff(t *testing.T) {
	store := newFakeCrawlStore()
	catalog := newFakeRookiesCatalog(rookiesStoryFixture(20, freeChapter(201, 1, vnTime("05", "22:00:00"))))
	cfg := setting.StoryCrawlerConfig{Enabled: true, IntervalHours: 1}
	crawler := newTestRookiesCrawler(t, store, catalog, cfg)

	entry := runRookies(t, crawler)
	if entry.StoriesSkippedNew != 1 || len(catalog.storyCalls) != 0 || len(store.imported) != 0 {
		t.Fatalf("new story must be skipped without opening it, got %+v calls %v", entry, catalog.storyCalls)
	}

	crawler.settings = &fakeRookiesSettings{cfg: setting.StoryCrawlerConfig{Enabled: true, IntervalHours: 1, ImportNewStories: true}}
	again := runRookies(t, crawler)
	if again.StoriesCreated != 1 {
		t.Fatalf("story skipped earlier must be imported once importing is on, got %+v", again)
	}
}

func TestRookiesCrawlerRetriesFailedStory(t *testing.T) {
	story := rookiesStoryFixture(10, freeChapter(101, 1, vnTime("05", "22:00:00")))
	store := newFakeCrawlStore(KnownStory{SourceStoryID: "10", Kind: StoryKindLong, ChapterCount: 1})
	catalog := newFakeRookiesCatalog(story)
	catalog.storyErrors["truyen-10"] = errors.New("timeout")
	crawler := newTestRookiesCrawler(t, store, catalog, setting.StoryCrawlerConfig{Enabled: true, IntervalHours: 1})

	first := runRookies(t, crawler)
	if first.Status != StoryCrawlStatusPartial || first.StoriesFailed != 1 || first.RetryPending != 1 || !first.Errors[0].WillRetry {
		t.Fatalf("failed story must be queued, got %+v", first)
	}

	delete(catalog.storyErrors, "truyen-10")
	catalog.listing.Items = nil
	second := runRookies(t, crawler)
	if _, imported := store.imported["10"]; second.Retried != 1 || !imported || second.RetryPending != 0 {
		t.Fatalf("queued story must be retried even after leaving page 1, got %+v", second)
	}
}

func TestRookiesCrawlerRechecksScheduledChapter(t *testing.T) {
	story := rookiesStoryFixture(10, freeChapter(101, 1, vnTime("05", "22:00:00")), freeChapter(102, 2, vnTime("06", "08:00:00")))
	store := newFakeCrawlStore(KnownStory{SourceStoryID: "10", Kind: StoryKindLong, ChapterCount: 1})
	catalog := newFakeRookiesCatalog(story)
	crawler := newTestRookiesCrawler(t, store, catalog, setting.StoryCrawlerConfig{Enabled: true, IntervalHours: 1})

	runRookies(t, crawler)
	if len(store.imported["10"]) != 1 {
		t.Fatalf("scheduled chapter must wait, imported %+v", store.imported["10"])
	}
	if state := crawler.loadState(context.Background()); len(state.Due) != 1 || state.Due[0].StoryID != "10" {
		t.Fatalf("story with a scheduled chapter must be remembered, state %+v", state)
	}

	// Truyện vẫn nằm trên trang 1 với dấu vân tay cũ (chương hẹn giờ không làm truyện đổi) nhưng tới giờ thì phải mở lại.
	crawler.now = func() time.Time { return testNow.Add(8 * time.Hour) }
	entry := runRookies(t, crawler)
	if entry.StoriesChecked != 1 || entry.StoriesUnchanged != 0 || len(store.imported["10"]) != 2 {
		t.Fatalf("scheduled chapter must be added once due, got %+v chapters %+v", entry, store.imported["10"])
	}
	if state := crawler.loadState(context.Background()); len(state.Due) != 0 {
		t.Fatalf("due list must be cleared, state %+v", state)
	}
}

func TestRookiesCrawlerWarnsWhenPageMayMissStories(t *testing.T) {
	catalog := newFakeRookiesCatalog(
		rookiesStoryFixture(10, freeChapter(101, 1, vnTime("05", "22:00:00"))),
		rookiesStoryFixture(20, freeChapter(201, 1, vnTime("05", "22:00:00"))),
	)
	catalog.listing.PerPage = 2
	crawler := newTestRookiesCrawler(t, newFakeCrawlStore(), catalog, setting.StoryCrawlerConfig{Enabled: true, IntervalHours: 3})

	if first := runRookies(t, crawler); first.Truncated {
		t.Fatal("first run has nothing to compare with")
	}
	// Lượt 1 giờ trước lỗi trước khi đọc được danh sách, nên mốc so sánh vẫn là lần đọc danh sách 3 giờ trước.
	lastScan, failedRun := testNow.Add(-3*time.Hour), testNow.Add(-time.Hour)
	crawler.saveState(context.Background(), rookiesState{LastRunAt: &failedRun, LastScanAt: &lastScan})
	entry := runRookies(t, crawler)
	if !entry.Truncated || !entry.Since.Equal(time.Date(2026, 10, 5, 16, 0, 0, 0, time.UTC)) {
		t.Fatalf("full page newer than the last scan must warn, got truncated=%v since=%v", entry.Truncated, entry.Since)
	}

	catalog.listErr = errors.New("timeout")
	crawler.now = func() time.Time { return testNow.Add(time.Hour) }
	runRookies(t, crawler)
	if state := crawler.loadState(context.Background()); state.LastScanAt == nil || !state.LastScanAt.Equal(testNow) {
		t.Fatalf("failed run must not move the last scan, state %+v", state)
	}
}

func TestRookiesCrawlerStopsWhenBlocked(t *testing.T) {
	catalog := newFakeRookiesCatalog()
	catalog.listErr = fmt.Errorf("%w: status 403", errSourceBlocked)
	crawler := newTestRookiesCrawler(t, newFakeCrawlStore(), catalog, setting.StoryCrawlerConfig{Enabled: true, IntervalHours: 1})
	if entry := runRookies(t, crawler); entry.Status != StoryCrawlStatusBlocked {
		t.Fatalf("status %s", entry.Status)
	}
}

func TestRookiesCrawlerHasItsOwnLock(t *testing.T) {
	cache, _ := newTestCache(t)
	if ok, err := cache.SetNX(CacheKeyStoryCrawlLock, "vnkings", time.Minute); err != nil || !ok {
		t.Fatalf("hold vnkings lock: %v", err)
	}
	crawler := newRookiesCrawler(newFakeCrawlStore(), newFakeRookiesCatalog(), &fakeRookiesSettings{}, cache, zap.NewNop().Sugar())
	if _, err := crawler.Run(context.Background(), StoryCrawlTriggerManual); err != nil {
		t.Fatalf("rookies must run while vnkings is running: %v", err)
	}
	token, err := crawler.acquire()
	if err != nil {
		t.Fatal(err)
	}
	defer crawler.release(token)
	if err := crawler.RunNow(); !errors.Is(err, ErrCrawlRunning) {
		t.Fatalf("second rookies run must be refused, got %v", err)
	}
}

func rookiesCookies(values ...string) []setting.StoryCookie {
	cookies := make([]setting.StoryCookie, 0, len(values))
	for i, value := range values {
		cookies = append(cookies, setting.StoryCookie{Name: fmt.Sprintf("acc%d", i+1), Cookie: value, Status: setting.StoryCookieStatusActive})
	}
	return cookies
}

func TestRookiesCrawlerSkipsDeadCookies(t *testing.T) {
	catalog := newFakeRookiesCatalog(rookiesStoryFixture(10, freeChapter(101, 1, vnTime("05", "22:00:00"))))
	cfg := setting.StoryCrawlerConfig{
		Enabled: true, IntervalHours: 1, ImportNewStories: true,
		UseCookies: true, Cookies: rookiesCookies("rookies_session=a", "rookies_session=b"),
	}
	crawler := newTestRookiesCrawler(t, newFakeCrawlStore(), catalog, cfg)
	settings := crawler.settings.(*fakeRookiesSettings)

	entry := runRookies(t, crawler)
	slices.Sort(settings.dead)
	if !entry.UseCookies || entry.Cookie != "" || len(entry.CookiesDied) != 2 || !slices.Equal(settings.dead, []string{"rookies_session=a", "rookies_session=b"}) {
		t.Fatalf("logged out cookies must be marked dead, dead %v entry %+v", settings.dead, entry)
	}
	if entry.StoriesCreated != 1 || catalog.storyCookie[0] != "" {
		t.Fatalf("run must go on without a cookie, got %+v cookies %v", entry, catalog.storyCookie)
	}

	settings.cfg.Cookies = append(settings.cfg.Cookies, rookiesCookies("", "", "rookies_session=c")[2])
	catalog.liveCookies = map[string]bool{"rookies_session=c": true}
	catalog.listing.Items[0].ChapterCount = 2
	again := runRookies(t, crawler)
	if again.Cookie != "acc3" || catalog.storyCookie[len(catalog.storyCookie)-1] != "rookies_session=c" || slices.Contains(catalog.loginChecks[2:], "rookies_session=a") {
		t.Fatalf("next run must skip dead cookies and use the live one, got %+v checks %v", again, catalog.loginChecks)
	}
}

func TestRookiesCrawlerSwitchesCookieWhenLoggedOutMidRun(t *testing.T) {
	catalog := newFakeRookiesCatalog(rookiesStoryFixture(10, freeChapter(101, 1, vnTime("05", "22:00:00"))))
	catalog.liveCookies = map[string]bool{"rookies_session=a": true}
	catalog.storyLogout = map[string]bool{"rookies_session=a": true}
	cfg := setting.StoryCrawlerConfig{
		Enabled: true, IntervalHours: 1, ImportNewStories: true,
		UseCookies: true, Cookies: rookiesCookies("rookies_session=a"),
	}
	store := newFakeCrawlStore()
	crawler := newTestRookiesCrawler(t, store, catalog, cfg)
	settings := crawler.settings.(*fakeRookiesSettings)

	entry := runRookies(t, crawler)
	if len(settings.dead) != 1 || entry.Cookie != "" || len(entry.CookiesDied) != 1 {
		t.Fatalf("cookie logged out mid-run must be marked dead, dead %v entry %+v", settings.dead, entry)
	}
	if catalog.storyCookie[len(catalog.storyCookie)-1] != "" || len(store.imported["10"]) != 1 {
		t.Fatalf("story must be read again without a cookie and imported, cookies %v", catalog.storyCookie)
	}
}

func TestBuildRookiesImport(t *testing.T) {
	vip := freeChapter(104, 4, vnTime("05", "20:00:00"))
	vip.IsVip = 1
	banned := freeChapter(102, 2, vnTime("05", "18:00:00"))
	banned.IsBan = 1
	story := rookiesStoryFixture(10,
		freeChapter(105, 5, vnTime("05", "21:00:00")),
		vip,
		freeChapter(103, 3, vnTime("05", "19:00:00")),
		banned,
		freeChapter(101, 1, vnTime("04", "10:00:00")),
	)
	story.Author.FullName = ""
	story.IsComplete = 1
	story.IsMature = 1
	built, ok := buildRookiesImport(story, testNow)
	if !ok {
		t.Fatal("story with free chapters must build")
	}
	if len(built.chapters) != 2 || built.chapters[0].SourceChapterID != "101" || built.chapters[1].SourceChapterID != "103" || built.chapters[1].Position != 2 {
		t.Fatalf("must skip banned chapters and stop at the first paid one, got %+v", built.chapters)
	}
	if built.chapters[1].URL != "https://rookies.vn/truyen/truyen-10/103" {
		t.Fatalf("unexpected chapter url %s", built.chapters[1].URL)
	}
	item := built.item
	if !item.PublishedAt.Equal(time.Date(2026, 10, 4, 3, 0, 0, 0, time.UTC)) || !item.UpdatedAt.Equal(time.Date(2026, 10, 5, 12, 0, 0, 0, time.UTC)) {
		t.Fatalf("published must be the first chapter and updated the newest free chapter, got %v %v", item.PublishedAt, item.UpdatedAt)
	}
	if item.Kind != StoryKindLong || item.Status != StoryStatusCompleted || item.AgeRating != StoryRookiesMatureRating || item.AuthorName != "tacgia" {
		t.Fatalf("unexpected story %+v", item)
	}
	if len(item.Genres) != 2 || item.Genres[0] != "Truyện dài" || len(item.Tags) != 1 || item.Tags[0] != "Học đường" {
		t.Fatalf("unexpected genres %v tags %v", item.Genres, item.Tags)
	}
	if item.CoverURL == nil || *item.CoverURL != "https://rookies.vn/uploads/user/1/novels/bia.jpg" || item.SourceAuthorID == nil || *item.SourceAuthorID != "42" {
		t.Fatalf("unexpected cover %v author %v", item.CoverURL, item.SourceAuthorID)
	}

	short := rookiesStoryFixture(20, freeChapter(201, 1, vnTime("05", "21:00:00")), freeChapter(202, 2, vnTime("06", "09:00:00")))
	short.Filters[1].Title = "Truyện ngắn"
	built, ok = buildRookiesImport(short, testNow)
	if !ok || built.item.Kind != StoryKindShort || built.nextAt == nil || !built.nextAt.Equal(time.Date(2026, 10, 6, 2, 0, 0, 0, time.UTC)) {
		t.Fatalf("one free chapter with a short form is short and the scheduled chapter is due later, got %+v %v", built.item, built.nextAt)
	}

	onlyPaid := rookiesStoryFixture(30, vip)
	if _, ok := buildRookiesImport(onlyPaid, testNow); ok {
		t.Fatal("story without free chapters must not build")
	}
}
