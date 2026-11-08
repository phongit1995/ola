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

type commitState struct {
	pending   map[string]map[int]int64
	committed map[string]map[int]int64
}

func newCommitState() *commitState {
	return &commitState{
		pending:   make(map[string]map[int]int64),
		committed: make(map[string]map[int]int64),
	}
}

func (s *commitState) add(req commitRequest) {
	if last, has := s.committed[req.topic][req.partition]; has && req.offset <= last {
		return
	}
	if s.pending[req.topic] == nil {
		s.pending[req.topic] = make(map[int]int64)
	}
	if existing, has := s.pending[req.topic][req.partition]; !has || req.offset > existing {
		s.pending[req.topic][req.partition] = req.offset
	}
}

func (s *commitState) hasPending() bool {
	return len(s.pending) > 0
}

func (s *commitState) markCommitted() {
	for topic, partitions := range s.pending {
		if s.committed[topic] == nil {
			s.committed[topic] = make(map[int]int64, len(partitions))
		}
		for partition, offset := range partitions {
			s.committed[topic][partition] = offset
		}
	}
	s.pending = make(map[string]map[int]int64)
}
