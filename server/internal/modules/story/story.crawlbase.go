package story

import (
	"context"
	"encoding/json"
	"errors"
	"math/rand/v2"
	"strconv"
	"strings"
	"sync"
	"time"

	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"github.com/redis/go-redis/v9"
	"go.uber.org/zap"
)

// Key Redis riêng của mỗi nguồn, để các nguồn chạy song song mà không giẫm lên nhau.
type crawlKeys struct {
	lock     string
	state    string
	logs     string
	progress string
}

type crawlBase struct {
	keys   crawlKeys
	cache  *services.CacheService
	redis  *redis.Client
	logger *zap.SugaredLogger
	now    func() time.Time
	baseMu sync.Mutex
	base   context.Context
}

func newCrawlBase(keys crawlKeys, cache *services.CacheService, logger *zap.SugaredLogger) *crawlBase {
	return &crawlBase{
		keys:   keys,
		cache:  cache,
		redis:  cache.GetClient(),
		logger: logger,
		now:    time.Now,
		base:   context.Background(),
	}
}

func (b *crawlBase) start(ctx context.Context, untilDue func(context.Context) time.Duration, run func(context.Context) error) {
	b.baseMu.Lock()
	b.base = ctx
	b.baseMu.Unlock()
	utils.SafeGo(b.logger, func() { b.loop(ctx, untilDue, run) })
}

func (b *crawlBase) baseContext() context.Context {
	b.baseMu.Lock()
	defer b.baseMu.Unlock()
	return b.base
}

func (b *crawlBase) loop(ctx context.Context, untilDue func(context.Context) time.Duration, run func(context.Context) error) {
	for {
		wait := untilDue(ctx)
		if wait <= 0 {
			if err := run(ctx); err != nil {
				if !errors.Is(err, ErrCrawlRunning) {
					b.logger.Warnw("Scheduled story crawl failed to start", "error", err)
				}
				wait = StoryCrawlMaxSleep
			}
		}
		if wait > StoryCrawlMaxSleep {
			wait = StoryCrawlMaxSleep
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

func untilNext(lastRunAt *time.Time, interval time.Duration) time.Duration {
	if lastRunAt == nil {
		return 0
	}
	return time.Until(lastRunAt.Add(interval))
}

func (b *crawlBase) runNow(execute func(context.Context)) error {
	token, err := b.acquire()
	if err != nil {
		return err
	}
	ctx := b.baseContext()
	utils.SafeGo(b.logger, func() {
		defer b.release(token)
		execute(ctx)
	})
	return nil
}

func (b *crawlBase) acquire() (string, error) {
	token := uuid.NewString()
	acquired, err := b.cache.SetNX(b.keys.lock, token, StoryCrawlLockTTL)
	if err != nil {
		return "", err
	}
	if !acquired {
		return "", ErrCrawlRunning
	}
	return token, nil
}

func (b *crawlBase) release(token string) {
	if _, err := b.cache.DeleteIfValue(b.keys.lock, token); err != nil {
		b.logger.Warnw("Failed to release story crawl lock", "error", err)
	}
}

func (b *crawlBase) newEntry(trigger string) *CrawlLog {
	return &CrawlLog{
		ID:        uuid.NewString(),
		Trigger:   trigger,
		Status:    StoryCrawlStatusRunning,
		StartedAt: b.now().UTC(),
		Errors:    []CrawlError{},
	}
}

func (b *crawlBase) settle(entry *CrawlLog, err error) {
	finishedAt := b.now().UTC()
	entry.FinishedAt = &finishedAt
	entry.DurationMs = finishedAt.Sub(entry.StartedAt).Milliseconds()
	switch {
	case errors.Is(err, errSourceBlocked):
		entry.Status = StoryCrawlStatusBlocked
		entry.Message = err.Error()
	case err != nil:
		entry.Status = StoryCrawlStatusFailed
		entry.Message = err.Error()
	case entry.StoriesFailed > 0:
		entry.Status = StoryCrawlStatusPartial
	default:
		entry.Status = StoryCrawlStatusSuccess
	}
}

// Ghi bằng context riêng để vẫn lưu được log khi lượt chạy đã hết giờ.
func (b *crawlBase) record(parent context.Context, entry *CrawlLog, state any) {
	ctx, cancel := context.WithTimeout(context.WithoutCancel(parent), crawlStateWriteTimeout)
	defer cancel()
	b.writeState(ctx, state)
	b.pushLog(ctx, entry)
	if err := b.redis.Del(ctx, b.keys.progress).Err(); err != nil {
		b.logger.Warnw("Failed to clear story crawl progress", "error", err)
	}
}

func (b *crawlBase) readState(ctx context.Context, state any) {
	raw, err := b.redis.Get(ctx, b.keys.state).Bytes()
	if err != nil {
		if !errors.Is(err, redis.Nil) {
			b.logger.Warnw("Failed to read story crawl state", "error", err)
		}
		return
	}
	if err := json.Unmarshal(raw, state); err != nil {
		b.logger.Warnw("Failed to decode story crawl state", "error", err)
	}
}

func (b *crawlBase) writeState(ctx context.Context, state any) {
	data, err := json.Marshal(state)
	if err != nil {
		return
	}
	if err := b.redis.Set(ctx, b.keys.state, data, 0).Err(); err != nil {
		b.logger.Warnw("Failed to save story crawl state", "error", err)
	}
}

func (b *crawlBase) saveProgress(ctx context.Context, entry *CrawlLog) {
	data, err := json.Marshal(entry)
	if err != nil {
		return
	}
	if err := b.redis.Set(ctx, b.keys.progress, data, StoryCrawlLockTTL).Err(); err != nil {
		b.logger.Warnw("Failed to save story crawl progress", "error", err)
	}
}

func (b *crawlBase) pushLog(ctx context.Context, entry *CrawlLog) {
	data, err := json.Marshal(entry)
	if err != nil {
		return
	}
	_, err = b.redis.TxPipelined(ctx, func(pipe redis.Pipeliner) error {
		pipe.LPush(ctx, b.keys.logs, data)
		pipe.LTrim(ctx, b.keys.logs, 0, StoryCrawlLogLimit-1)
		return nil
	})
	if err != nil {
		b.logger.Warnw("Failed to save story crawl log", "error", err)
	}
}

func (b *crawlBase) logs(ctx context.Context) ([]CrawlLog, error) {
	raw, err := b.redis.LRange(ctx, b.keys.logs, 0, StoryCrawlLogLimit-1).Result()
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

func (b *crawlBase) progress(ctx context.Context) *CrawlLog {
	raw, err := b.redis.Get(ctx, b.keys.progress).Bytes()
	if err != nil {
		return nil
	}
	var entry CrawlLog
	if err := json.Unmarshal(raw, &entry); err != nil {
		return nil
	}
	return &entry
}

type crawlCookie struct {
	label string
	value string
}

type cookieSession struct {
	candidates []crawlCookie
	current    *crawlCookie
}

type cookieClient interface {
	SetCookie(cookie string)
	CheckLogin(ctx context.Context) (bool, error)
}

type cookieMarker func(cookie string, at time.Time) (bool, error)

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

func (b *crawlBase) startCookies(ctx context.Context, client cookieClient, markDead cookieMarker, cfg setting.StoryCrawlerConfig, entry *CrawlLog, session *cookieSession) error {
	client.SetCookie("")
	entry.UseCookies = cfg.UseCookies
	if !cfg.UseCookies {
		return nil
	}
	session.candidates = activeCookies(cfg.Cookies)
	return b.useNextCookie(ctx, client, markDead, entry, session)
}

func (b *crawlBase) useNextCookie(ctx context.Context, client cookieClient, markDead cookieMarker, entry *CrawlLog, session *cookieSession) error {
	for len(session.candidates) > 0 {
		candidate := session.candidates[0]
		session.candidates = session.candidates[1:]
		client.SetCookie(candidate.value)
		loggedIn, err := client.CheckLogin(ctx)
		if err != nil {
			return err
		}
		if loggedIn {
			session.current = &candidate
			entry.Cookie = candidate.label
			return nil
		}
		b.dropCookie(markDead, entry, candidate)
	}
	session.current = nil
	entry.Cookie = ""
	client.SetCookie("")
	return nil
}

func (b *crawlBase) dropCookie(markDead cookieMarker, entry *CrawlLog, cookie crawlCookie) {
	entry.CookiesDied = append(entry.CookiesDied, cookie.label)
	b.logger.Warnw("Story crawl cookie is logged out", "cookie", cookie.label)
	if _, err := markDead(cookie.value, time.Now()); err != nil {
		b.logger.Warnw("Failed to mark story crawl cookie dead", "cookie", cookie.label, "error", err)
	}
}

type crawlSnapshot struct {
	running  bool
	progress *CrawlLog
	logs     []CrawlLog
}

func (b *crawlBase) snapshot(ctx context.Context) (crawlSnapshot, error) {
	running, err := b.redis.Exists(ctx, b.keys.lock).Result()
	if err != nil {
		return crawlSnapshot{}, err
	}
	logs, err := b.logs(ctx)
	if err != nil {
		return crawlSnapshot{}, err
	}
	snap := crawlSnapshot{running: running > 0, logs: logs}
	if snap.running {
		snap.progress = b.progress(ctx)
	}
	return snap, nil
}

func (b *crawlBase) nextRunAt(enabled bool, lastRunAt *time.Time, interval time.Duration) *time.Time {
	if !enabled {
		return nil
	}
	next := b.now().UTC()
	if lastRunAt != nil && lastRunAt.Add(interval).After(next) {
		next = lastRunAt.Add(interval)
	}
	return &next
}
