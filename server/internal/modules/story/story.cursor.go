package story

import (
	"cmp"
	"slices"
	"time"

	"ola-chat-server/internal/constants"
)

type crawlRetry struct {
	PostID   int64  `json:"postId"`
	Title    string `json:"title"`
	Attempts int    `json:"attempts"`
}

type crawlState struct {
	LastRunAt   *time.Time   `json:"lastRunAt"`
	NextSince   *time.Time   `json:"nextSince"`
	SeenAtSince []int64      `json:"seenAtSince,omitempty"`
	Retry       []crawlRetry `json:"retry,omitempty"`
}

type crawlCursor struct {
	since time.Time
	seen  []int64
}

type crawlRun struct {
	entry          *CrawlLog
	session        *cookieSession
	requestsBefore int64
	categories     map[int64]string
	start          crawlCursor
	startSeen      map[int64]bool
	cursor         crawlCursor
	handled        map[int64]bool
	retry          map[int64]crawlRetry
}

func newCrawlRun(entry *CrawlLog, state crawlState, requestsBefore int64) *crawlRun {
	start := crawlCursor{since: entry.Since}
	if state.NextSince != nil && state.NextSince.Equal(entry.Since) {
		start.seen = slices.Clone(state.SeenAtSince)
	}
	run := &crawlRun{
		entry:          entry,
		session:        &cookieSession{},
		requestsBefore: requestsBefore,
		start:          start,
		startSeen:      make(map[int64]bool, len(start.seen)),
		cursor:         crawlCursor{since: start.since, seen: slices.Clone(start.seen)},
		handled:        map[int64]bool{},
		retry:          make(map[int64]crawlRetry, len(state.Retry)),
	}
	for _, id := range start.seen {
		run.startSeen[id] = true
	}
	for _, item := range state.Retry {
		run.retry[item.PostID] = item
	}
	return run
}

func (r *crawlRun) querySince() time.Time {
	if len(r.start.seen) > 0 {
		return r.start.since.Add(-time.Second)
	}
	return r.start.since
}

func (r *crawlRun) fresh(post SourcePost) bool {
	if r.handled[post.ID] {
		return false
	}
	if !r.startSeen[post.ID] {
		return true
	}
	modified, err := gmtTime(post.ModifiedGMT)
	return err != nil || modified.After(r.start.since)
}

func (r *crawlRun) advance(post SourcePost) {
	modified, err := gmtTime(post.ModifiedGMT)
	if err != nil {
		return
	}
	switch {
	case modified.Equal(r.cursor.since):
		if !slices.Contains(r.cursor.seen, post.ID) {
			r.cursor.seen = append(r.cursor.seen, post.ID)
		}
	case modified.After(r.cursor.since):
		r.cursor = crawlCursor{since: modified, seen: []int64{post.ID}}
	}
}

func (r *crawlRun) retryBatch() []int64 {
	ids := make([]int64, 0, len(r.retry))
	for id := range r.retry {
		ids = append(ids, id)
	}
	slices.Sort(ids)
	if len(ids) > constants.StoryCrawlRetryBatch {
		ids = ids[:constants.StoryCrawlRetryBatch]
	}
	return ids
}

func (r *crawlRun) queueRetry(postID int64, title string) (int, bool) {
	previous, queued := r.retry[postID]
	attempts := previous.Attempts + 1
	switch {
	case attempts >= constants.StoryCrawlRetryAttempts:
		delete(r.retry, postID)
		return attempts, false
	case !queued && len(r.retry) >= constants.StoryCrawlRetryMax:
		return attempts, false
	}
	r.retry[postID] = crawlRetry{PostID: postID, Title: title, Attempts: attempts}
	return attempts, true
}

func (r *crawlRun) retryList() []crawlRetry {
	items := make([]crawlRetry, 0, len(r.retry))
	for _, item := range r.retry {
		items = append(items, item)
	}
	slices.SortFunc(items, func(a, b crawlRetry) int { return cmp.Compare(a.PostID, b.PostID) })
	return items
}
