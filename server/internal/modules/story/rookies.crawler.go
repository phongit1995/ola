package story

import (
	"cmp"
	"context"
	"errors"
	"slices"
	"strconv"
	"strings"
	"time"
	"unicode/utf8"

	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/services"

	"go.uber.org/zap"
)

var errOtherStory = errors.New("slug now points to another story")

type rookiesCatalog interface {
	cookieClient
	Latest(ctx context.Context) (rookiesListing, error)
	Story(ctx context.Context, slug string) (rookiesStory, error)
	SetUserAgent(userAgent string)
	Requests() int64
}

type RookiesCrawlerSettings interface {
	GetRookiesCrawler() (setting.StoryCrawlerConfig, error)
	GetRookiesCrawlerVersion() (setting.StoryCrawlerConfig, *time.Time, error)
	MarkRookiesCookieDead(cookie string, at time.Time) (bool, error)
}

type rookiesPending struct {
	StoryID  string     `json:"storyId"`
	Slug     string     `json:"slug"`
	Title    string     `json:"title"`
	Attempts int        `json:"attempts,omitempty"`
	At       *time.Time `json:"at,omitempty"`
}

type rookiesState struct {
	LastRunAt  *time.Time       `json:"lastRunAt"`
	LastScanAt *time.Time       `json:"lastScanAt,omitempty"`
	Retry      []rookiesPending `json:"retry,omitempty"`
	Due        []rookiesPending `json:"due,omitempty"`
}

type rookiesRun struct {
	entry          *CrawlLog
	session        *cookieSession
	scanned        bool
	requestsBefore int64
	handled        map[string]bool
	retry          map[string]rookiesPending
	due            map[string]rookiesPending
}

func newRookiesRun(entry *CrawlLog, state rookiesState, requestsBefore int64) *rookiesRun {
	run := &rookiesRun{
		entry:          entry,
		session:        &cookieSession{},
		requestsBefore: requestsBefore,
		handled:        map[string]bool{},
		retry:          make(map[string]rookiesPending, len(state.Retry)),
		due:            make(map[string]rookiesPending, len(state.Due)),
	}
	for _, item := range state.Retry {
		run.retry[item.StoryID] = item
	}
	for _, item := range state.Due {
		run.due[item.StoryID] = item
	}
	return run
}

func sortedPending(items map[string]rookiesPending) []rookiesPending {
	out := make([]rookiesPending, 0, len(items))
	for _, item := range items {
		out = append(out, item)
	}
	slices.SortFunc(out, func(a, b rookiesPending) int { return cmp.Compare(a.StoryID, b.StoryID) })
	return out
}

type RookiesCrawler struct {
	*crawlBase
	store    CrawlStore
	catalog  rookiesCatalog
	settings RookiesCrawlerSettings
}

func NewRookiesCrawler(repo *Repository, settings *setting.Service, cache *services.CacheService, logger *zap.SugaredLogger) *RookiesCrawler {
	return newRookiesCrawler(repo, newRookiesClient(StoryRookiesFetchTimeout, StoryCrawlGap), settings, cache, logger)
}

func newRookiesCrawler(store CrawlStore, catalog rookiesCatalog, settings RookiesCrawlerSettings, cache *services.CacheService, logger *zap.SugaredLogger) *RookiesCrawler {
	keys := crawlKeys{
		lock:     CacheKeyRookiesCrawlLock,
		state:    CacheKeyRookiesCrawlState,
		logs:     CacheKeyRookiesCrawlLogs,
		progress: CacheKeyRookiesCrawlProgress,
	}
	return &RookiesCrawler{
		crawlBase: newCrawlBase(keys, cache, logger.Named("[rookies_crawler]")),
		store:     store,
		catalog:   catalog,
		settings:  settings,
	}
}

func (c *RookiesCrawler) Start(ctx context.Context) {
	c.start(ctx, c.untilDue, func(ctx context.Context) error {
		_, err := c.Run(ctx, StoryCrawlTriggerSchedule)
		return err
	})
}

func (c *RookiesCrawler) untilDue(ctx context.Context) time.Duration {
	cfg, err := c.settings.GetRookiesCrawler()
	if err != nil {
		c.logger.Warnw("Failed to read rookies crawler config", "error", err)
		return StoryCrawlMaxSleep
	}
	if !cfg.Enabled {
		return StoryCrawlMaxSleep
	}
	return untilNext(c.loadState(ctx).LastRunAt, cfg.Interval())
}

func (c *RookiesCrawler) Run(ctx context.Context, trigger string) (*CrawlLog, error) {
	token, err := c.acquire()
	if err != nil {
		return nil, err
	}
	defer c.release(token)
	return c.execute(ctx, trigger), nil
}

func (c *RookiesCrawler) RunNow() error {
	return c.runNow(func(ctx context.Context) { c.execute(ctx, StoryCrawlTriggerManual) })
}

func (c *RookiesCrawler) execute(parent context.Context, trigger string) *CrawlLog {
	ctx, cancel := context.WithTimeout(parent, StoryCrawlRunTimeout)
	defer cancel()
	entry := c.newEntry(trigger)
	requestsBefore := c.catalog.Requests()
	state := c.loadState(ctx)
	startedAt := entry.StartedAt
	state.LastRunAt = &startedAt
	c.saveState(ctx, state)

	run, err := c.crawlWithConfig(ctx, entry, state, requestsBefore)

	entry.Requests = c.catalog.Requests() - requestsBefore
	c.settle(entry, err)
	if run != nil {
		state.Retry = sortedPending(run.retry)
		state.Due = sortedPending(run.due)
		entry.RetryPending = len(state.Retry)
		if run.scanned {
			state.LastScanAt = &startedAt
		}
	}
	c.record(parent, entry, state)
	c.logger.Infow("Rookies crawl finished",
		"trigger", trigger, "status", entry.Status, "since", entry.Since, "truncated", entry.Truncated,
		"stories", entry.PostsProcessed, "retried", entry.Retried, "retryPending", entry.RetryPending,
		"created", entry.StoriesCreated, "updated", entry.StoriesUpdated, "unchanged", entry.StoriesUnchanged,
		"chaptersAdded", entry.ChaptersAdded, "failed", entry.StoriesFailed, "requests", entry.Requests,
		"cookie", entry.Cookie, "cookiesDied", len(entry.CookiesDied),
		"durationMs", entry.DurationMs, "error", entry.Message)
	return entry
}

func (c *RookiesCrawler) crawlWithConfig(ctx context.Context, entry *CrawlLog, state rookiesState, requestsBefore int64) (*rookiesRun, error) {
	cfg, err := c.settings.GetRookiesCrawler()
	if err != nil {
		return nil, err
	}
	entry.ImportNewStories = cfg.ImportNewStories
	entry.UserAgent = pickUserAgent(cfg.RandomUserAgent)
	c.catalog.SetUserAgent(entry.UserAgent)
	run := newRookiesRun(entry, state, requestsBefore)
	if err := c.startCookies(ctx, c.catalog, c.settings.MarkRookiesCookieDead, cfg, entry, run.session); err != nil {
		return run, err
	}
	c.saveProgress(ctx, entry)
	return run, c.crawl(ctx, run, state.LastScanAt)
}

func (c *RookiesCrawler) crawl(ctx context.Context, run *rookiesRun, lastScan *time.Time) error {
	entry := run.entry
	listing, err := c.catalog.Latest(ctx)
	if err != nil {
		return err
	}
	run.scanned = true
	entry.PostsFound = len(listing.Items)
	oldest, ok := oldestPublished(listing.Items)
	if ok {
		entry.Since = oldest
	}
	// Trang 1 đã đầy mà truyện cũ nhất vẫn ra chương sau lần đọc danh sách trước: có thể có truyện bị đẩy sang trang 2.
	entry.Truncated = ok && lastScan != nil && listing.PerPage > 0 && len(listing.Items) >= listing.PerPage && oldest.After(*lastScan)

	queue := c.queued(run)
	queued := make(map[string]bool, len(queue))
	ids := make([]string, 0, len(listing.Items)+len(queue))
	for _, item := range listing.Items {
		ids = append(ids, item.sourceID())
	}
	for _, item := range queue {
		queued[item.StoryID] = true
		ids = append(ids, item.StoryID)
	}
	known, err := c.store.KnownStories(ctx, StorySourceRookies, ids)
	if err != nil {
		return err
	}
	seen := c.seen(ctx, listing.Items)
	c.saveProgress(ctx, entry)

	for _, item := range listing.Items {
		id := item.sourceID()
		if run.handled[id] || item.skipped() {
			entry.PostsProcessed++
			continue
		}
		run.handled[id] = true
		_, isKnown := known[id]
		switch {
		case !isKnown && !entry.ImportNewStories:
			entry.StoriesSkippedNew++
			delete(run.retry, id)
		case isKnown && seen[id] == item.fingerprint() && !queued[id]:
			entry.StoriesUnchanged++
		default:
			if _, retrying := run.retry[id]; retrying {
				entry.Retried++
			}
			pending := rookiesPending{StoryID: id, Slug: item.Slug, Title: strings.TrimSpace(item.Title)}
			if err := c.handle(ctx, run, pending, item.fingerprint(), known); err != nil {
				return err
			}
		}
		entry.PostsProcessed++
		c.reportProgress(ctx, run)
	}

	for _, item := range queue {
		if run.handled[item.StoryID] {
			continue
		}
		run.handled[item.StoryID] = true
		if _, retrying := run.retry[item.StoryID]; retrying {
			entry.Retried++
		}
		if err := c.handle(ctx, run, item, "", known); err != nil {
			return err
		}
		c.reportProgress(ctx, run)
	}
	return nil
}

func (c *RookiesCrawler) queued(run *rookiesRun) []rookiesPending {
	now := c.now()
	queue := sortedPending(run.retry)
	if len(queue) > StoryCrawlRetryBatch {
		queue = queue[:StoryCrawlRetryBatch]
	}
	for _, item := range sortedPending(run.due) {
		if _, retrying := run.retry[item.StoryID]; !retrying && (item.At == nil || !item.At.After(now)) {
			queue = append(queue, item)
		}
	}
	return queue
}

func (c *RookiesCrawler) seen(ctx context.Context, items []rookiesNovel) map[string]string {
	out := make(map[string]string, len(items))
	if len(items) == 0 {
		return out
	}
	ids := make([]string, 0, len(items))
	for _, item := range items {
		ids = append(ids, item.sourceID())
	}
	values, err := c.redis.HMGet(ctx, CacheKeyRookiesCrawlSeen, ids...).Result()
	if err != nil {
		c.logger.Warnw("Failed to read rookies fingerprints", "error", err)
		return out
	}
	for i, value := range values {
		if text, ok := value.(string); ok {
			out[ids[i]] = text
		}
	}
	return out
}

func (c *RookiesCrawler) remember(ctx context.Context, id, fingerprint string) {
	if fingerprint == "" {
		return
	}
	if err := c.redis.HSet(ctx, CacheKeyRookiesCrawlSeen, id, fingerprint).Err(); err != nil {
		c.logger.Warnw("Failed to save rookies fingerprint", "storyId", id, "error", err)
	}
}

func (c *RookiesCrawler) reportProgress(ctx context.Context, run *rookiesRun) {
	run.entry.Requests = c.catalog.Requests() - run.requestsBefore
	c.saveProgress(ctx, run.entry)
}

func (c *RookiesCrawler) handle(ctx context.Context, run *rookiesRun, item rookiesPending, fingerprint string, known map[string]KnownStory) error {
	err := c.process(ctx, run, item, known)
	switch {
	case err == nil:
		delete(run.retry, item.StoryID)
		c.remember(ctx, item.StoryID, fingerprint)
		return nil
	case errors.Is(err, errSourceBlocked) || ctx.Err() != nil:
		return err
	}
	if !c.storyFailed(run, item, err) {
		// Bỏ cuộc: ghi nhớ bản hiện tại để không thử lại đến khi truyện đổi tiếp.
		c.remember(ctx, item.StoryID, fingerprint)
	}
	return nil
}

func (c *RookiesCrawler) process(ctx context.Context, run *rookiesRun, item rookiesPending, known map[string]KnownStory) error {
	entry := run.entry
	entry.StoriesChecked++
	story, err := c.story(ctx, run, item.Slug)
	if err != nil {
		return err
	}
	if story.sourceID() != item.StoryID {
		return errOtherStory
	}
	delete(run.due, item.StoryID)
	if story.hidden() || story.translated() {
		return nil
	}
	_, isKnown := known[item.StoryID]
	if !isKnown && !entry.ImportNewStories {
		entry.StoriesSkippedNew++
		return nil
	}
	built, ok := buildRookiesImport(story, c.now())
	if built.nextAt != nil {
		title := strings.TrimSpace(story.Title)
		run.due[item.StoryID] = rookiesPending{StoryID: item.StoryID, Slug: story.Slug, Title: title, At: built.nextAt}
	}
	switch {
	case !ok && isKnown:
		return errNoChapters
	case !ok:
		entry.StoriesEmpty++
		return nil
	}
	result, err := c.store.ImportStory(ctx, StorySourceRookies, entry.StartedAt, built.item, built.chapters)
	if err != nil {
		return err
	}
	switch {
	case result.StoryInserted:
		entry.StoriesCreated++
	case result.Changed():
		entry.StoriesUpdated++
	}
	entry.ChaptersAdded += result.Added
	entry.ChaptersUpdated += result.Updated
	entry.ChaptersRemoved += result.Removed
	return nil
}

func (c *RookiesCrawler) story(ctx context.Context, run *rookiesRun, slug string) (rookiesStory, error) {
	for {
		story, err := c.catalog.Story(ctx, slug)
		if err != nil || run.session.current == nil || story.LoggedIn {
			return story, err
		}
		c.dropCookie(c.settings.MarkRookiesCookieDead, run.entry, *run.session.current)
		if err := c.useNextCookie(ctx, c.catalog, c.settings.MarkRookiesCookieDead, run.entry, run.session); err != nil {
			return rookiesStory{}, err
		}
	}
}

func (c *RookiesCrawler) storyFailed(run *rookiesRun, item rookiesPending, err error) (willRetry bool) {
	entry := run.entry
	entry.StoriesFailed++
	delete(run.due, item.StoryID)
	previous, queued := run.retry[item.StoryID]
	item.Attempts = previous.Attempts + 1
	item.At = nil
	willRetry = true
	switch {
	case item.Attempts >= StoryCrawlRetryAttempts:
		delete(run.retry, item.StoryID)
		willRetry = false
	case !queued && len(run.retry) >= StoryCrawlRetryMax:
		willRetry = false
	default:
		run.retry[item.StoryID] = item
	}
	if len(entry.Errors) < StoryCrawlErrorLimit {
		entry.Errors = append(entry.Errors, CrawlError{
			SourceStoryID: item.StoryID,
			Title:         item.Title,
			Message:       rookiesErrorMessage(err),
			Attempts:      item.Attempts,
			WillRetry:     willRetry,
		})
	}
	c.logger.Warnw("Rookies crawl skipped a story", "sourceStoryId", item.StoryID, "title", item.Title, "attempts", item.Attempts, "willRetry", willRetry, "error", err)
	return willRetry
}

func rookiesErrorMessage(err error) string {
	if errors.Is(err, errOtherStory) {
		return "Đường dẫn truyện giờ trỏ sang truyện khác"
	}
	if errors.Is(err, errNoChapters) {
		return "Truyện không còn chương đọc miễn phí, giữ nguyên bản đã lưu"
	}
	return crawlErrorMessage(err)
}

func oldestPublished(items []rookiesNovel) (time.Time, bool) {
	var oldest time.Time
	found := false
	for _, item := range items {
		if moment, ok := rookiesTime(item.PublishedAt); ok && (!found || moment.Before(oldest)) {
			oldest, found = moment, true
		}
	}
	return oldest, found
}

func (c *RookiesCrawler) loadState(ctx context.Context) rookiesState {
	var state rookiesState
	c.readState(ctx, &state)
	return state
}

func (c *RookiesCrawler) saveState(ctx context.Context, state rookiesState) {
	c.writeState(ctx, state)
}

func (c *RookiesCrawler) Status(ctx context.Context) (*CrawlerStatusResponse, error) {
	cfg, updatedAt, err := c.settings.GetRookiesCrawlerVersion()
	if err != nil {
		return nil, err
	}
	snap, err := c.snapshot(ctx)
	if err != nil {
		return nil, err
	}
	state := c.loadState(ctx)
	return &CrawlerStatusResponse{
		Config:          crawlerConfigResponse(cfg),
		ConfigUpdatedAt: updatedAt,
		UserAgents:      len(userAgents),
		Running:         snap.running,
		Progress:        snap.progress,
		LastRunAt:       state.LastRunAt,
		NextRunAt:       c.nextRunAt(cfg.Enabled, state.LastRunAt, cfg.Interval()),
		ScanPages:       StoryRookiesScanPages,
		RetryPending:    len(state.Retry),
		Logs:            snap.logs,
	}, nil
}

type rookiesImport struct {
	item     StoryImport
	chapters []ChapterImport
	nextAt   *time.Time
}

func truncateRunes(text string, limit int) string {
	if utf8.RuneCountInString(text) <= limit {
		return text
	}
	return string([]rune(text)[:limit])
}

func rookiesCover(picture string) *string {
	picture = strings.TrimSpace(picture)
	if picture == "" {
		return nil
	}
	if !strings.HasPrefix(picture, "https://") && !strings.HasPrefix(picture, "http://") {
		picture = StoryRookiesCoverBase + strings.TrimLeft(picture, "/")
	}
	return &picture
}

func rookiesIntro(story rookiesStory) string {
	for _, text := range []string{story.Content, story.Short} {
		if paragraphs, err := rookiesParagraphs(text); err == nil && len(paragraphs) > 0 {
			return strings.Join(paragraphs, "\n\n")
		}
	}
	return ""
}

// buildRookiesImport giữ đúng quy tắc của scripts/rookies/export_stories.py: bỏ chương bị khoá
// và chương hẹn giờ, dừng ở chương trả phí đầu tiên để không bao giờ lưu chương VIP.
func buildRookiesImport(story rookiesStory, now time.Time) (rookiesImport, bool) {
	var built rookiesImport
	ordered := slices.Clone(story.Chapters)
	slices.SortStableFunc(ordered, func(a, b rookiesChapter) int {
		if order := cmp.Compare(a.ShowOrder, b.ShowOrder); order != 0 {
			return order
		}
		return cmp.Compare(a.ID, b.ID)
	})
	sourceURL := StoryRookiesSite + "/truyen/" + story.Slug
	var latest *time.Time
	for _, chapter := range ordered {
		if chapter.IsBan > 0 {
			continue
		}
		var publishedAt *time.Time
		if moment, ok := rookiesTime(chapter.PublishedAt); ok {
			if moment.After(now) {
				if built.nextAt == nil || moment.Before(*built.nextAt) {
					built.nextAt = &moment
				}
				continue
			}
			publishedAt = &moment
		}
		if chapter.paid() {
			break
		}
		if publishedAt != nil && (latest == nil || publishedAt.After(*latest)) {
			latest = publishedAt
		}
		position := len(built.chapters) + 1
		title := strings.TrimSpace(string(chapter.Title))
		if title == "" {
			title = "Chương " + strconv.Itoa(position)
		}
		id := strconv.FormatInt(chapter.ID, 10)
		built.chapters = append(built.chapters, ChapterImport{
			SourceChapterID: id,
			Position:        position,
			Title:           truncateRunes(title, StoryRookiesTitleMaxRunes),
			URL:             sourceURL + "/" + id,
			PublishedAt:     publishedAt,
		})
	}
	if len(built.chapters) == 0 {
		return built, false
	}

	publishedAt, ok := firstTime(built.chapters[0].PublishedAt, story.CreatedAt, story.PublishedAt)
	if !ok {
		return built, false
	}
	updatedAt := publishedAt
	if latest != nil && latest.After(updatedAt) {
		updatedAt = *latest
	}
	kind := StoryKindLong
	if len(built.chapters) == 1 && slices.ContainsFunc(story.labels(StoryRookiesGroupForm), func(label string) bool {
		return slices.Contains(rookiesShortForms, label)
	}) {
		kind = StoryKindShort
	}
	status := StoryStatusOngoing
	if story.IsComplete > 0 {
		status = StoryStatusCompleted
	}
	ageRating := ""
	if story.IsMature > 0 {
		ageRating = StoryRookiesMatureRating
	}
	author := strings.TrimSpace(story.Author.FullName)
	if author == "" {
		author = strings.TrimSpace(story.Author.Username)
	}
	built.item = StoryImport{
		SourceStoryID: story.sourceID(),
		Slug:          story.Slug,
		Title:         truncateRunes(strings.TrimSpace(story.Title), StoryRookiesTitleMaxRunes),
		AuthorName:    truncateRunes(author, StoryRookiesAuthorMaxRunes),
		Kind:          kind,
		Genres:        story.labels(StoryRookiesGroupForm, StoryRookiesGroupGenre),
		Tags:          story.otherLabels(StoryRookiesGroupKind, StoryRookiesGroupForm, StoryRookiesGroupGenre),
		Intro:         rookiesIntro(story),
		CoverURL:      rookiesCover(story.Picture),
		Status:        status,
		AgeRating:     ageRating,
		LikeCount:     int(story.LikeCount),
		SourceURL:     sourceURL,
		PublishedAt:   publishedAt,
		UpdatedAt:     updatedAt,
	}
	if story.UserID > 0 {
		authorID := strconv.FormatInt(story.UserID, 10)
		built.item.SourceAuthorID = &authorID
	}
	return built, true
}

// firstTime lấy giờ đăng truyện: chương đầu tiên, rồi created_at, rồi published_at
// (published_at của truyện rookies là giờ ra chương mới nhất nên để sau cùng).
func firstTime(first *time.Time, fallbacks ...string) (time.Time, bool) {
	if first != nil {
		return *first, true
	}
	for _, value := range fallbacks {
		if moment, ok := rookiesTime(value); ok {
			return moment, true
		}
	}
	return time.Time{}, false
}
