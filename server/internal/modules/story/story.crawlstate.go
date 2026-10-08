package story

import (
	"cmp"
	"slices"
	"time"
)

type crawlRetry struct {
	PostID   int64  `json:"postId"`
	Title    string `json:"title"`
	Attempts int    `json:"attempts"`
	Modified string `json:"modified,omitempty"`
}

type crawlState struct {
	LastRunAt *time.Time   `json:"lastRunAt"`
	Retry     []crawlRetry `json:"retry,omitempty"`
	GaveUp    []crawlRetry `json:"gaveUp,omitempty"`
}

type crawlRun struct {
	entry          *CrawlLog
	session        *cookieSession
	requestsBefore int64
	categories     map[int64]string
	handled        map[int64]bool
	retry          map[int64]crawlRetry
	gaveUp         map[int64]crawlRetry
}

func newCrawlRun(entry *CrawlLog, state crawlState, requestsBefore int64) *crawlRun {
	run := &crawlRun{
		entry:          entry,
		session:        &cookieSession{},
		requestsBefore: requestsBefore,
		handled:        map[int64]bool{},
		retry:          make(map[int64]crawlRetry, len(state.Retry)),
		gaveUp:         make(map[int64]crawlRetry, len(state.GaveUp)),
	}
	for _, item := range state.Retry {
		run.retry[item.PostID] = item
	}
	for _, item := range state.GaveUp {
		run.gaveUp[item.PostID] = item
	}
	return run
}

func (r *crawlRun) pending(post SourcePost) bool {
	if r.handled[post.ID] {
		return false
	}
	gaveUp, ok := r.gaveUp[post.ID]
	if !ok {
		return true
	}
	if gaveUp.Modified == post.ModifiedGMT {
		return false
	}
	delete(r.gaveUp, post.ID)
	return true
}

func (r *crawlRun) retryBatch() []int64 {
	ids := make([]int64, 0, len(r.retry))
	for id := range r.retry {
		ids = append(ids, id)
	}
	slices.Sort(ids)
	if len(ids) > StoryCrawlRetryBatch {
		ids = ids[:StoryCrawlRetryBatch]
	}
	return ids
}

func (r *crawlRun) queueRetry(post SourcePost, title string) (int, bool) {
	previous, queued := r.retry[post.ID]
	attempts := previous.Attempts + 1
	item := crawlRetry{PostID: post.ID, Title: title, Attempts: attempts, Modified: post.ModifiedGMT}
	switch {
	case attempts >= StoryCrawlRetryAttempts:
		delete(r.retry, post.ID)
		r.gaveUp[post.ID] = item
		return attempts, false
	case !queued && len(r.retry) >= StoryCrawlRetryMax:
		return attempts, false
	}
	r.retry[post.ID] = item
	return attempts, true
}

func (r *crawlRun) retryList() []crawlRetry {
	return sortedRetries(r.retry, time.Time{})
}

func (r *crawlRun) gaveUpList(since time.Time) []crawlRetry {
	return sortedRetries(r.gaveUp, since)
}

func sortedRetries(items map[int64]crawlRetry, since time.Time) []crawlRetry {
	out := make([]crawlRetry, 0, len(items))
	for _, item := range items {
		if modified, err := gmtTime(item.Modified); err == nil && modified.Before(since) {
			continue
		}
		out = append(out, item)
	}
	slices.SortFunc(out, func(a, b crawlRetry) int { return cmp.Compare(a.PostID, b.PostID) })
	return out
}
