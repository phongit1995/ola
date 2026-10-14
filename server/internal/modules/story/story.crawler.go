package story

import (
	"context"
	"errors"
	"net/http"
	"slices"
	"strconv"
	"strings"
	"time"
	"unicode/utf8"

	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"go.uber.org/zap"
)

var ErrCrawlRunning = utils.NewHTTPErrorWithCode(http.StatusConflict, "story crawl already running", ErrorCodeStoryCrawlRunning)

var (
	errNoChapters  = errors.New("no chapter list")
	errKindChanged = errors.New("long story turned short")
)

const crawlStateWriteTimeout = 5 * time.Second

type CrawlStore interface {
	KnownStories(ctx context.Context, source string, sourceIDs []string) (map[string]KnownStory, error)
	ImportStory(ctx context.Context, source string, crawledAt time.Time, item StoryImport, chapters []ChapterImport) (ImportResult, error)
}

type CrawlerSettings interface {
	GetStoryCrawler() (setting.StoryCrawlerConfig, error)
	GetStoryCrawlerVersion() (setting.StoryCrawlerConfig, *time.Time, error)
	MarkStoryCookieDead(cookie string, at time.Time) (bool, error)
}

type Crawler struct {
	*crawlBase
	store    CrawlStore
	catalog  Catalog
	settings CrawlerSettings
}

func NewCrawler(repo *Repository, settings *setting.Service, cache *services.CacheService, logger *zap.SugaredLogger) *Crawler {
	return newCrawler(repo, NewVnkingsCatalog(), settings, cache, logger)
}

func newCrawler(store CrawlStore, catalog Catalog, settings CrawlerSettings, cache *services.CacheService, logger *zap.SugaredLogger) *Crawler {
	keys := crawlKeys{
		lock:     CacheKeyStoryCrawlLock,
		state:    CacheKeyStoryCrawlState,
		logs:     CacheKeyStoryCrawlLogs,
		progress: CacheKeyStoryCrawlProgress,
	}
	return &Crawler{
		crawlBase: newCrawlBase(keys, cache, logger.Named("[story_crawler]")),
		store:     store,
		catalog:   catalog,
		settings:  settings,
	}
}

func (c *Crawler) Start(ctx context.Context) {
	c.start(ctx, c.untilDue, func(ctx context.Context) error {
		_, err := c.Run(ctx, StoryCrawlTriggerSchedule)
		return err
	})
}

func (c *Crawler) untilDue(ctx context.Context) time.Duration {
	cfg, err := c.settings.GetStoryCrawler()
	if err != nil {
		c.logger.Warnw("Failed to read story crawler config", "error", err)
		return StoryCrawlMaxSleep
	}
	if !cfg.Enabled {
		return StoryCrawlMaxSleep
	}
	return untilNext(c.loadState(ctx).LastRunAt, cfg.Interval())
}

func (c *Crawler) Run(ctx context.Context, trigger string) (*CrawlLog, error) {
	token, err := c.acquire()
	if err != nil {
		return nil, err
	}
	defer c.release(token)
	return c.execute(ctx, trigger), nil
}

func (c *Crawler) RunNow() error {
	return c.runNow(func(ctx context.Context) { c.execute(ctx, StoryCrawlTriggerManual) })
}

func (c *Crawler) execute(parent context.Context, trigger string) *CrawlLog {
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
		state.Retry = run.retryList()
		state.GaveUp = run.gaveUpList(entry.Since)
		entry.RetryPending = len(state.Retry)
	}
	c.record(parent, entry, state)
	c.logger.Infow("Story crawl finished",
		"trigger", trigger, "status", entry.Status, "since", entry.Since,
		"posts", entry.PostsProcessed, "retried", entry.Retried, "retryPending", entry.RetryPending,
		"created", entry.StoriesCreated, "updated", entry.StoriesUpdated, "unchanged", entry.StoriesUnchanged,
		"chaptersAdded", entry.ChaptersAdded, "failed", entry.StoriesFailed, "requests", entry.Requests,
		"cookie", entry.Cookie, "cookiesDied", len(entry.CookiesDied),
		"durationMs", entry.DurationMs, "error", entry.Message)
	return entry
}

func (c *Crawler) crawlWithConfig(ctx context.Context, entry *CrawlLog, state crawlState, requestsBefore int64) (*crawlRun, error) {
	cfg, err := c.settings.GetStoryCrawler()
	if err != nil {
		return nil, err
	}
	entry.ImportNewStories = cfg.ImportNewStories
	entry.UserAgent = pickUserAgent(cfg.RandomUserAgent)
	c.catalog.SetUserAgent(entry.UserAgent)
	entry.Since = entry.StartedAt.Add(-StoryCrawlWindow)
	run := newCrawlRun(entry, state, requestsBefore)
	if err := c.startCookies(ctx, c.catalog, c.settings.MarkStoryCookieDead, cfg, entry, run.session); err != nil {
		return run, err
	}
	c.saveProgress(ctx, entry)
	return run, c.crawl(ctx, run)
}

func (c *Crawler) nextCookie(ctx context.Context, entry *CrawlLog, session *cookieSession) error {
	return c.useNextCookie(ctx, c.catalog, c.settings.MarkStoryCookieDead, entry, session)
}

func (c *Crawler) cookieDied(entry *CrawlLog, cookie crawlCookie) {
	c.dropCookie(c.settings.MarkStoryCookieDead, entry, cookie)
}

func (c *Crawler) storyPage(ctx context.Context, entry *CrawlLog, session *cookieSession, link string) (StoryPageInfo, error) {
	for {
		info, err := c.catalog.StoryPage(ctx, link)
		if err != nil || session.current == nil || info.LoggedIn {
			return info, err
		}
		c.cookieDied(entry, *session.current)
		if err := c.nextCookie(ctx, entry, session); err != nil {
			return StoryPageInfo{}, err
		}
	}
}

func (c *Crawler) crawl(ctx context.Context, run *crawlRun) error {
	entry := run.entry
	categories, err := c.catalog.Categories(ctx)
	if err != nil {
		return err
	}
	run.categories = categories
	if err := c.retryFailed(ctx, run); err != nil {
		return err
	}
	result, err := c.catalog.RecentPosts(ctx, entry.Since, StoryCrawlBatch)
	if err != nil {
		return err
	}
	entry.PostsFound = len(result.Posts)
	entry.Truncated = result.Total > len(result.Posts)
	posts := make([]SourcePost, 0, len(result.Posts))
	for _, post := range result.Posts {
		if run.pending(post) {
			posts = append(posts, post)
		} else {
			entry.PostsProcessed++
		}
	}
	known, tags, err := c.lookup(ctx, run, posts)
	if err != nil {
		return err
	}
	for _, post := range posts {
		if err := c.handlePost(ctx, run, post, known, tags); err != nil {
			return err
		}
		entry.PostsProcessed++
		c.reportProgress(ctx, run)
	}
	return nil
}

func (c *Crawler) retryFailed(ctx context.Context, run *crawlRun) error {
	ids := run.retryBatch()
	if len(ids) == 0 {
		return nil
	}
	posts, err := c.catalog.PostsByID(ctx, ids)
	if err != nil {
		return err
	}
	found := make(map[int64]bool, len(posts))
	for _, post := range posts {
		found[post.ID] = true
	}
	for _, id := range ids {
		if !found[id] {
			delete(run.retry, id)
		}
	}
	known, tags, err := c.lookup(ctx, run, posts)
	if err != nil {
		return err
	}
	for _, post := range posts {
		if _, queued := run.retry[post.ID]; !queued || run.handled[post.ID] {
			continue
		}
		run.entry.Retried++
		if err := c.handlePost(ctx, run, post, known, tags); err != nil {
			return err
		}
		c.reportProgress(ctx, run)
	}
	return nil
}

func (c *Crawler) lookup(ctx context.Context, run *crawlRun, posts []SourcePost) (map[string]KnownStory, map[int64]string, error) {
	known, err := c.store.KnownStories(ctx, StorySourceVnkings, postSourceIDs(posts))
	if err != nil {
		return nil, nil, err
	}
	tags, err := c.catalog.TagNames(ctx, wantedTagIDs(posts, known, run.entry.ImportNewStories))
	if err != nil {
		return nil, nil, err
	}
	return known, tags, nil
}

func (c *Crawler) reportProgress(ctx context.Context, run *crawlRun) {
	run.entry.Requests = c.catalog.Requests() - run.requestsBefore
	c.saveProgress(ctx, run.entry)
}

func (c *Crawler) handlePost(ctx context.Context, run *crawlRun, post SourcePost, known map[string]KnownStory, tags map[int64]string) error {
	run.handled[post.ID] = true
	err := c.processPost(ctx, run, post, known, tags)
	switch {
	case err == nil:
		delete(run.retry, post.ID)
		return nil
	case errors.Is(err, errSourceBlocked) || ctx.Err() != nil:
		return err
	}
	c.storyFailed(run, post, err)
	return nil
}

func (c *Crawler) processPost(ctx context.Context, run *crawlRun, post SourcePost, known map[string]KnownStory, tags map[int64]string) error {
	entry := run.entry
	existing, isKnown := known[strconv.FormatInt(post.ID, 10)]
	switch {
	case !isKnown && !entry.ImportNewStories:
		entry.StoriesSkippedNew++
		return nil
	case isKnown && existing.UpToDate(post):
		entry.StoriesUnchanged++
		return nil
	}
	entry.StoriesChecked++
	info, err := c.storyPage(ctx, entry, run.session, post.Link)
	if err != nil {
		return err
	}
	var links []ChapterLink
	if info.Nonce != "" {
		if links, err = c.catalog.ChapterLinks(ctx, post.ID, info.Nonce); err != nil {
			return err
		}
	}
	item, chapters, ok := buildImport(post, info, links, run.categories, tags, c.now())
	switch {
	case !ok && isKnown:
		return errNoChapters
	case !ok:
		entry.StoriesEmpty++
		return nil
	case isKnown && existing.Kind == StoryKindLong && item.Kind != StoryKindLong:
		return errKindChanged
	}
	result, err := c.store.ImportStory(ctx, StorySourceVnkings, entry.StartedAt, item, chapters)
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

func (c *Crawler) storyFailed(run *crawlRun, post SourcePost, err error) {
	entry := run.entry
	sourceID := strconv.FormatInt(post.ID, 10)
	title := plainText(post.Title.Rendered)
	entry.StoriesFailed++
	attempts, willRetry := run.queueRetry(post, title)
	if len(entry.Errors) < StoryCrawlErrorLimit {
		entry.Errors = append(entry.Errors, CrawlError{
			SourceStoryID: sourceID,
			Title:         title,
			Message:       crawlErrorMessage(err),
			Attempts:      attempts,
			WillRetry:     willRetry,
		})
	}
	c.logger.Warnw("Story crawl skipped a story", "sourceStoryId", sourceID, "title", title, "attempts", attempts, "willRetry", willRetry, "error", err)
}

func crawlErrorMessage(err error) string {
	switch {
	case errors.Is(err, errStoryGone):
		return "Truyện không còn trên nguồn"
	case errors.Is(err, errNoChapters):
		return "Không lấy được danh sách chương"
	case errors.Is(err, errKindChanged):
		return "Nguồn trả về truyện ngắn cho truyện dài, bỏ qua để không mất chương"
	case errors.Is(err, errIncompleteChapters):
		return "Danh sách chương tải dở dang, bỏ qua để không xoá nhầm chương"
	default:
		return err.Error()
	}
}

func postSourceIDs(posts []SourcePost) []string {
	ids := make([]string, 0, len(posts))
	for _, post := range posts {
		ids = append(ids, strconv.FormatInt(post.ID, 10))
	}
	return ids
}

func wantedTagIDs(posts []SourcePost, known map[string]KnownStory, importNew bool) []int64 {
	seen := map[int64]bool{}
	var ids []int64
	for _, post := range posts {
		existing, ok := known[strconv.FormatInt(post.ID, 10)]
		if (!ok && !importNew) || (ok && existing.UpToDate(post)) {
			continue
		}
		for _, id := range post.Tags {
			if !seen[id] {
				seen[id] = true
				ids = append(ids, id)
			}
		}
	}
	slices.Sort(ids)
	return ids
}

func namesOf(ids []int64, names map[int64]string, skip int64) []string {
	out := make([]string, 0, len(ids))
	for _, id := range ids {
		if name, ok := names[id]; ok && id != skip {
			out = append(out, name)
		}
	}
	return out
}

func charCount(paragraphs []string) int {
	total := 0
	for _, paragraph := range paragraphs {
		total += utf8.RuneCountInString(paragraph)
	}
	return total
}

func buildImport(post SourcePost, info StoryPageInfo, links []ChapterLink, categories, tags map[int64]string, now time.Time) (StoryImport, []ChapterImport, bool) {
	sourceID := strconv.FormatInt(post.ID, 10)
	title := plainText(post.Title.Rendered)
	publishedAt, err := gmtTime(post.DateGMT)
	if err != nil {
		return StoryImport{}, nil, false
	}
	updatedAt, err := gmtTime(post.ModifiedGMT)
	if err != nil {
		return StoryImport{}, nil, false
	}
	paragraphs, err := fragmentParagraphs(post.Content.Rendered)
	if err != nil {
		return StoryImport{}, nil, false
	}
	item := StoryImport{
		SourceStoryID: sourceID,
		Slug:          post.Slug,
		Title:         title,
		AuthorName:    info.AuthorName,
		Genres:        namesOf(post.Categories, categories, StoryVnkingsRootCategoryID),
		Tags:          namesOf(post.Tags, tags, 0),
		CoverURL:      info.CoverURL,
		Status:        info.Status,
		AgeRating:     info.AgeRating,
		LikeCount:     info.LikeCount,
		SourceURL:     post.Link,
		PublishedAt:   publishedAt,
		UpdatedAt:     updatedAt,
	}
	if post.Author > 0 {
		authorID := strconv.FormatInt(post.Author, 10)
		item.SourceAuthorID = &authorID
	}
	switch {
	case len(links) > 0:
		item.Kind = StoryKindLong
		item.Intro = strings.Join(paragraphs, "\n\n")
		labels := make([]string, 0, len(links))
		for _, link := range links {
			labels = append(labels, link.DateLabel)
		}
		times := chapterTimes(labels, now, publishedAt, updatedAt)
		chapters := make([]ChapterImport, 0, len(links))
		for index, link := range links {
			chapters = append(chapters, ChapterImport{
				SourceChapterID: link.SourceID,
				Position:        index + 1,
				Title:           link.Title,
				URL:             link.URL,
				PublishedAt:     times[index],
			})
		}
		return item, chapters, true
	case slices.Contains(post.Categories, int64(StoryVnkingsShortCategoryID)) || charCount(paragraphs) >= StoryShortMinChars:
		item.Kind = StoryKindShort
		item.Intro = strings.ReplaceAll(plainText(post.Excerpt.Rendered), "[…]", "…")
		storyParagraphs := dropRepeatedTitle(paragraphs, title)
		return item, []ChapterImport{{
			SourceChapterID: sourceID,
			Position:        1,
			Title:           title,
			URL:             post.Link,
			WordCount:       len(strings.Fields(strings.Join(storyParagraphs, " "))),
			PublishedAt:     &publishedAt,
		}}, true
	default:
		return item, nil, false
	}
}

func (c *Crawler) loadState(ctx context.Context) crawlState {
	var state crawlState
	c.readState(ctx, &state)
	return state
}

func (c *Crawler) saveState(ctx context.Context, state crawlState) {
	c.writeState(ctx, state)
}

func (c *Crawler) Status(ctx context.Context) (*CrawlerStatusResponse, error) {
	cfg, updatedAt, err := c.settings.GetStoryCrawlerVersion()
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
		ScanDays:        StoryCrawlWindowDays,
		ScanLimit:       StoryCrawlBatch,
		RetryPending:    len(state.Retry),
		Logs:            snap.logs,
	}, nil
}
