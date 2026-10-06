package story

import (
	"context"
	"encoding/json"
	"errors"
	"math/rand/v2"
	"net/http"
	"slices"
	"strconv"
	"strings"
	"sync"
	"time"
	"unicode/utf8"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"github.com/redis/go-redis/v9"
	"go.uber.org/zap"
)

var ErrCrawlRunning = utils.NewHTTPErrorWithCode(http.StatusConflict, "story crawl already running", constants.ErrorCodeStoryCrawlRunning)

var (
	errNoChapters  = errors.New("no chapter list")
	errKindChanged = errors.New("long story turned short")
)

const crawlStateWriteTimeout = 5 * time.Second

type CrawlStore interface {
	KnownStories(ctx context.Context, source string, sourceIDs []string) (map[string]KnownStory, error)
	LatestSourceUpdate(ctx context.Context, source string) (*time.Time, error)
	ImportStory(ctx context.Context, source string, crawledAt time.Time, item StoryImport, chapters []ChapterImport) (ImportResult, error)
}

type CrawlerSettings interface {
	GetStoryCrawler() (setting.StoryCrawlerConfig, error)
	GetStoryCrawlerVersion() (setting.StoryCrawlerConfig, *time.Time, error)
	MarkStoryCookieDead(cookie string, at time.Time) (bool, error)
}

type crawlCookie struct {
	label string
	value string
}

type cookieSession struct {
	candidates []crawlCookie
	current    *crawlCookie
}

type Crawler struct {
	store    CrawlStore
	catalog  Catalog
	settings CrawlerSettings
	cache    *services.CacheService
	redis    *redis.Client
	logger   *zap.SugaredLogger
	baseMu   sync.Mutex
	base     context.Context
}

func NewCrawler(repo *Repository, settings *setting.Service, cache *services.CacheService, logger *zap.SugaredLogger) *Crawler {
	return newCrawler(repo, NewVnkingsCatalog(), settings, cache, logger)
}

func newCrawler(store CrawlStore, catalog Catalog, settings CrawlerSettings, cache *services.CacheService, logger *zap.SugaredLogger) *Crawler {
	return &Crawler{
		store:    store,
		catalog:  catalog,
		settings: settings,
		cache:    cache,
		redis:    cache.GetClient(),
		logger:   logger.Named("[story_crawler]"),
		base:     context.Background(),
	}
}

func (c *Crawler) Start(ctx context.Context) {
	c.baseMu.Lock()
	c.base = ctx
	c.baseMu.Unlock()
	utils.SafeGo(c.logger, func() { c.loop(ctx) })
}

func (c *Crawler) baseContext() context.Context {
	c.baseMu.Lock()
	defer c.baseMu.Unlock()
	return c.base
}

func (c *Crawler) loop(ctx context.Context) {
	for {
		wait := c.untilDue(ctx)
		if wait <= 0 {
			if _, err := c.Run(ctx, constants.StoryCrawlTriggerSchedule); err != nil {
				if !errors.Is(err, ErrCrawlRunning) {
					c.logger.Warnw("Scheduled story crawl failed to start", "error", err)
				}
				wait = constants.StoryCrawlMaxSleep
			}
		}
		if wait > constants.StoryCrawlMaxSleep {
			wait = constants.StoryCrawlMaxSleep
		}
		if wait < time.Second {
			wait = time.Second
		}
		select {
		case <-ctx.Done():
			return
		case <-time.After(wait):
		}
	}
}

func (c *Crawler) untilDue(ctx context.Context) time.Duration {
	cfg, err := c.settings.GetStoryCrawler()
	if err != nil {
		c.logger.Warnw("Failed to read story crawler config", "error", err)
		return constants.StoryCrawlMaxSleep
	}
	if !cfg.Enabled {
		return constants.StoryCrawlMaxSleep
	}
	state := c.loadState(ctx)
	if state.LastRunAt == nil {
		return 0
	}
	return time.Until(state.LastRunAt.Add(cfg.Interval()))
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
	token, err := c.acquire()
	if err != nil {
		return err
	}
	ctx := c.baseContext()
	utils.SafeGo(c.logger, func() {
		defer c.release(token)
		c.execute(ctx, constants.StoryCrawlTriggerManual)
	})
	return nil
}

func (c *Crawler) acquire() (string, error) {
	token := uuid.NewString()
	acquired, err := c.cache.SetNX(constants.CacheKeyStoryCrawlLock, token, constants.StoryCrawlLockTTL)
	if err != nil {
		return "", err
	}
	if !acquired {
		return "", ErrCrawlRunning
	}
	return token, nil
}

func (c *Crawler) release(token string) {
	if _, err := c.cache.DeleteIfValue(constants.CacheKeyStoryCrawlLock, token); err != nil {
		c.logger.Warnw("Failed to release story crawl lock", "error", err)
	}
}

func (c *Crawler) execute(parent context.Context, trigger string) *CrawlLog {
	ctx, cancel := context.WithTimeout(parent, constants.StoryCrawlRunTimeout)
	defer cancel()
	startedAt := time.Now().UTC()
	entry := &CrawlLog{
		ID:        uuid.NewString(),
		Trigger:   trigger,
		Status:    constants.StoryCrawlStatusRunning,
		StartedAt: startedAt,
		Errors:    []CrawlError{},
	}
	requestsBefore := c.catalog.Requests()
	state := c.loadState(ctx)
	state.LastRunAt = &startedAt
	c.saveState(ctx, state)

	run, err := c.crawlWithConfig(ctx, entry, state, requestsBefore)

	finishedAt := time.Now().UTC()
	entry.FinishedAt = &finishedAt
	entry.DurationMs = finishedAt.Sub(startedAt).Milliseconds()
	entry.Requests = c.catalog.Requests() - requestsBefore
	switch {
	case errors.Is(err, errSourceBlocked):
		entry.Status = constants.StoryCrawlStatusBlocked
		entry.Message = err.Error()
	case err != nil:
		entry.Status = constants.StoryCrawlStatusFailed
		entry.Message = err.Error()
	case entry.StoriesFailed > 0:
		entry.Status = constants.StoryCrawlStatusPartial
	default:
		entry.Status = constants.StoryCrawlStatusSuccess
	}
	if run != nil {
		since := run.cursor.since
		state.NextSince = &since
		state.SeenAtSince = run.cursor.seen
		state.Retry = run.retryList()
		entry.RetryPending = len(state.Retry)
	}

	writeCtx, cancelWrite := context.WithTimeout(context.WithoutCancel(parent), crawlStateWriteTimeout)
	defer cancelWrite()
	c.saveState(writeCtx, state)
	c.pushLog(writeCtx, entry)
	if err := c.redis.Del(writeCtx, constants.CacheKeyStoryCrawlProgress).Err(); err != nil {
		c.logger.Warnw("Failed to clear story crawl progress", "error", err)
	}
	c.logger.Infow("Story crawl finished",
		"trigger", trigger, "status", entry.Status, "since", entry.Since,
		"posts", entry.PostsProcessed, "retried", entry.Retried, "retryPending", entry.RetryPending,
		"created", entry.StoriesCreated, "updated", entry.StoriesUpdated,
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
	c.catalog.SetCookie("")
	entry.Since = c.since(ctx, state, entry.StartedAt)
	entry.UseCookies = cfg.UseCookies
	run := newCrawlRun(entry, state, requestsBefore)
	if cfg.UseCookies {
		run.session.candidates = activeCookies(cfg.Cookies)
		if err := c.nextCookie(ctx, entry, run.session); err != nil {
			return run, err
		}
	}
	c.saveProgress(ctx, entry)
	return run, c.crawl(ctx, run)
}

func activeCookies(cookies []setting.StoryCookie) []crawlCookie {
	active := make([]crawlCookie, 0, len(cookies))
	for index, item := range cookies {
		if !item.Active() {
			continue
		}
		label := strings.TrimSpace(item.Name)
		if label == "" {
			label = "Cookie " + strconv.Itoa(index+1)
		}
		active = append(active, crawlCookie{label: label, value: item.Cookie})
	}
	rand.Shuffle(len(active), func(i, j int) { active[i], active[j] = active[j], active[i] })
	return active
}

func (c *Crawler) nextCookie(ctx context.Context, entry *CrawlLog, session *cookieSession) error {
	for len(session.candidates) > 0 {
		candidate := session.candidates[0]
		session.candidates = session.candidates[1:]
		c.catalog.SetCookie(candidate.value)
		loggedIn, err := c.catalog.CheckLogin(ctx)
		if err != nil {
			return err
		}
		if loggedIn {
			session.current = &candidate
			entry.Cookie = candidate.label
			return nil
		}
		c.cookieDied(entry, candidate)
	}
	session.current = nil
	entry.Cookie = ""
	c.catalog.SetCookie("")
	return nil
}

func (c *Crawler) cookieDied(entry *CrawlLog, cookie crawlCookie) {
	entry.CookiesDied = append(entry.CookiesDied, cookie.label)
	c.logger.Warnw("Story crawl cookie is logged out", "cookie", cookie.label)
	if _, err := c.settings.MarkStoryCookieDead(cookie.value, time.Now()); err != nil {
		c.logger.Warnw("Failed to mark story crawl cookie dead", "cookie", cookie.label, "error", err)
	}
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

func (c *Crawler) since(ctx context.Context, state crawlState, startedAt time.Time) time.Time {
	if state.NextSince != nil {
		return state.NextSince.UTC()
	}
	latest, err := c.store.LatestSourceUpdate(ctx, constants.StorySourceVnkings)
	if err != nil {
		c.logger.Warnw("Failed to read latest story update", "error", err)
	}
	if latest != nil {
		return latest.UTC().Add(-constants.StoryCrawlWatermarkMargin)
	}
	return startedAt.Add(-constants.StoryCrawlInitialLookback)
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
	for page := 1; ; page++ {
		result, err := c.catalog.ModifiedPosts(ctx, run.querySince(), page)
		if err != nil {
			return err
		}
		if page == 1 {
			entry.PostsFound = result.Total
		}
		posts := make([]SourcePost, 0, len(result.Posts))
		for _, post := range result.Posts {
			if run.fresh(post) {
				posts = append(posts, post)
			}
		}
		known, tags, err := c.lookup(ctx, run, posts)
		if err != nil {
			return err
		}
		for _, post := range posts {
			if entry.PostsProcessed >= constants.StoryCrawlMaxPosts {
				entry.Truncated = true
				return nil
			}
			if err := c.handlePost(ctx, run, post, known, tags); err != nil {
				return err
			}
			entry.PostsProcessed++
			run.advance(post)
			c.reportProgress(ctx, run)
		}
		if len(result.Posts) == 0 || page >= result.TotalPages {
			run.cursor = crawlCursor{since: entry.StartedAt.Add(-constants.StoryCrawlWatermarkMargin)}
			return nil
		}
	}
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
	known, err := c.store.KnownStories(ctx, constants.StorySourceVnkings, postSourceIDs(posts))
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
	if !isKnown && !entry.ImportNewStories {
		entry.StoriesSkippedNew++
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
	item, chapters, ok := buildImport(post, info, links, run.categories, tags)
	switch {
	case !ok && isKnown:
		return errNoChapters
	case !ok:
		entry.StoriesEmpty++
		return nil
	case isKnown && existing.Kind == constants.StoryKindLong && item.Kind != constants.StoryKindLong:
		return errKindChanged
	}
	result, err := c.store.ImportStory(ctx, constants.StorySourceVnkings, entry.StartedAt, item, chapters)
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
	attempts, willRetry := run.queueRetry(post.ID, title)
	if len(entry.Errors) < constants.StoryCrawlErrorLimit {
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
		if _, ok := known[strconv.FormatInt(post.ID, 10)]; !ok && !importNew {
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

func buildImport(post SourcePost, info StoryPageInfo, links []ChapterLink, categories, tags map[int64]string) (StoryImport, []ChapterImport, bool) {
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
		Genres:        namesOf(post.Categories, categories, constants.StoryVnkingsRootCategoryID),
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
		item.Kind = constants.StoryKindLong
		item.Intro = strings.Join(paragraphs, "\n\n")
		chapters := make([]ChapterImport, 0, len(links))
		for index, link := range links {
			chapters = append(chapters, ChapterImport{
				SourceChapterID: link.SourceID,
				Position:        index + 1,
				Title:           link.Title,
				URL:             link.URL,
				PublishedAt:     chapterDate(link.DateLabel),
			})
		}
		return item, chapters, true
	case slices.Contains(post.Categories, int64(constants.StoryVnkingsShortCategoryID)) || charCount(paragraphs) >= constants.StoryShortMinChars:
		item.Kind = constants.StoryKindShort
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
	raw, err := c.redis.Get(ctx, constants.CacheKeyStoryCrawlState).Bytes()
	if err != nil {
		if !errors.Is(err, redis.Nil) {
			c.logger.Warnw("Failed to read story crawl state", "error", err)
		}
		return state
	}
	if err := json.Unmarshal(raw, &state); err != nil {
		c.logger.Warnw("Failed to decode story crawl state", "error", err)
	}
	return state
}

func (c *Crawler) saveState(ctx context.Context, state crawlState) {
	data, err := json.Marshal(state)
	if err != nil {
		return
	}
	if err := c.redis.Set(ctx, constants.CacheKeyStoryCrawlState, data, 0).Err(); err != nil {
		c.logger.Warnw("Failed to save story crawl state", "error", err)
	}
}

func (c *Crawler) saveProgress(ctx context.Context, entry *CrawlLog) {
	data, err := json.Marshal(entry)
	if err != nil {
		return
	}
	if err := c.redis.Set(ctx, constants.CacheKeyStoryCrawlProgress, data, constants.StoryCrawlLockTTL).Err(); err != nil {
		c.logger.Warnw("Failed to save story crawl progress", "error", err)
	}
}

func (c *Crawler) pushLog(ctx context.Context, entry *CrawlLog) {
	data, err := json.Marshal(entry)
	if err != nil {
		return
	}
	_, err = c.redis.TxPipelined(ctx, func(pipe redis.Pipeliner) error {
		pipe.LPush(ctx, constants.CacheKeyStoryCrawlLogs, data)
		pipe.LTrim(ctx, constants.CacheKeyStoryCrawlLogs, 0, constants.StoryCrawlLogLimit-1)
		return nil
	})
	if err != nil {
		c.logger.Warnw("Failed to save story crawl log", "error", err)
	}
}

func (c *Crawler) logs(ctx context.Context) ([]CrawlLog, error) {
	raw, err := c.redis.LRange(ctx, constants.CacheKeyStoryCrawlLogs, 0, constants.StoryCrawlLogLimit-1).Result()
	if err != nil {
		return nil, err
	}
	logs := make([]CrawlLog, 0, len(raw))
	for _, item := range raw {
		var entry CrawlLog
		if err := json.Unmarshal([]byte(item), &entry); err == nil {
			logs = append(logs, entry)
		}
	}
	return logs, nil
}

func (c *Crawler) progress(ctx context.Context) *CrawlLog {
	raw, err := c.redis.Get(ctx, constants.CacheKeyStoryCrawlProgress).Bytes()
	if err != nil {
		return nil
	}
	var entry CrawlLog
	if err := json.Unmarshal(raw, &entry); err != nil {
		return nil
	}
	return &entry
}

func (c *Crawler) Status(ctx context.Context) (*CrawlerStatusResponse, error) {
	cfg, updatedAt, err := c.settings.GetStoryCrawlerVersion()
	if err != nil {
		return nil, err
	}
	running, err := c.redis.Exists(ctx, constants.CacheKeyStoryCrawlLock).Result()
	if err != nil {
		return nil, err
	}
	logs, err := c.logs(ctx)
	if err != nil {
		return nil, err
	}
	state := c.loadState(ctx)
	resp := &CrawlerStatusResponse{
		Config: CrawlerConfigResponse{
			Enabled:          cfg.Enabled,
			IntervalHours:    cfg.IntervalHours,
			ImportNewStories: cfg.ImportNewStories,
			RandomUserAgent:  cfg.RandomUserAgent,
			UseCookies:       cfg.UseCookies,
			Cookies:          cfg.Cookies,
		},
		ConfigUpdatedAt: updatedAt,
		UserAgents:      len(userAgents),
		Running:         running > 0,
		LastRunAt:       state.LastRunAt,
		NextSince:       state.NextSince,
		RetryPending:    len(state.Retry),
		Logs:            logs,
	}
	if resp.Running {
		resp.Progress = c.progress(ctx)
	}
	if cfg.Enabled {
		next := time.Now().UTC()
		if state.LastRunAt != nil && state.LastRunAt.Add(cfg.Interval()).After(next) {
			next = state.LastRunAt.Add(cfg.Interval())
		}
		resp.NextRunAt = &next
	}
	return resp, nil
}
