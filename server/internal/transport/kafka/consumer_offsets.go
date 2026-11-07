package kafka

import "sync"

type offsetTracker struct {
	mu      sync.Mutex
	pending []int64
	done    map[int64]struct{}
}

func newOffsetTracker() *offsetTracker {
	return &offsetTracker{done: make(map[int64]struct{})}
}

func (t *offsetTracker) begin(offset int64) {
	t.mu.Lock()
	defer t.mu.Unlock()
	t.pending = append(t.pending, offset)
}

func (t *offsetTracker) finish(offset int64) (int64, bool) {
	t.mu.Lock()
	defer t.mu.Unlock()
	t.done[offset] = struct{}{}

	var next int64
	advanced := false
	for len(t.pending) > 0 {
		head := t.pending[0]
		if _, finished := t.done[head]; !finished {
			break
		}
		delete(t.done, head)
		t.pending = t.pending[1:]
		next = head + 1
		advanced = true
	}
	return next, advanced
}
