package kafka

import (
	"context"
	"errors"
	"sync"
	"testing"

	kafkago "github.com/segmentio/kafka-go"
	"go.uber.org/zap"
)

func TestOffsetTrackerHoldsCommitUntilEarlierOffsetsFinish(t *testing.T) {
	tracker := newOffsetTracker()
	for _, offset := range []int64{10, 11, 12} {
		tracker.begin(offset)
	}

	if _, advanced := tracker.finish(12); advanced {
		t.Fatal("offset 12 must not commit while 10 and 11 are running")
	}
	if _, advanced := tracker.finish(11); advanced {
		t.Fatal("offset 11 must not commit while 10 is running")
	}
	next, advanced := tracker.finish(10)
	if !advanced || next != 13 {
		t.Fatalf("next = %d, advanced = %v, want 13, true", next, advanced)
	}
}

func TestOffsetTrackerAdvancesInOrder(t *testing.T) {
	tracker := newOffsetTracker()
	tracker.begin(0)
	tracker.begin(1)

	if next, advanced := tracker.finish(0); !advanced || next != 1 {
		t.Fatalf("next = %d, advanced = %v, want 1, true", next, advanced)
	}
	if next, advanced := tracker.finish(1); !advanced || next != 2 {
		t.Fatalf("next = %d, advanced = %v, want 2, true", next, advanced)
	}
}

func TestOffsetTrackerHandlesOffsetGaps(t *testing.T) {
	tracker := newOffsetTracker()
	tracker.begin(5)
	tracker.begin(9)

	tracker.finish(9)
	next, advanced := tracker.finish(5)
	if !advanced || next != 10 {
		t.Fatalf("next = %d, advanced = %v, want 10, true", next, advanced)
	}
}

func TestOffsetTrackerIsSafeForConcurrentFinish(t *testing.T) {
	const total = 500
	tracker := newOffsetTracker()
	for offset := int64(0); offset < total; offset++ {
		tracker.begin(offset)
	}

	var wg sync.WaitGroup
	var mu sync.Mutex
	var highest int64
	for offset := int64(total - 1); offset >= 0; offset-- {
		wg.Add(1)
		go func() {
			defer wg.Done()
			if next, advanced := tracker.finish(offset); advanced {
				mu.Lock()
				highest = max(highest, next)
				mu.Unlock()
			}
		}()
	}
	wg.Wait()
	if highest != total {
		t.Fatalf("highest = %d, want %d", highest, total)
	}
}

func testConsumer(ctx context.Context) *Consumer {
	return &Consumer{logger: zap.NewNop().Sugar(), ctx: ctx, messageTimeout: 1e9, maxRetries: 3}
}

func TestProcessMessageReportsSuccess(t *testing.T) {
	c := testConsumer(context.Background())
	finished := c.processMessage(func(context.Context, []byte) error { return nil }, kafkago.Message{}, 0)
	if !finished {
		t.Fatal("a handled message must be acknowledged")
	}
}

func TestProcessMessageRetriesThenSucceeds(t *testing.T) {
	c := testConsumer(context.Background())
	calls := 0
	finished := c.processMessage(func(context.Context, []byte) error {
		calls++
		if calls < 2 {
			return errors.New("temporary")
		}
		return nil
	}, kafkago.Message{}, 0)
	if !finished || calls != 2 {
		t.Fatalf("finished = %v, calls = %d", finished, calls)
	}
}

func TestProcessMessageDuringShutdownIsNotAcknowledged(t *testing.T) {
	ctx, cancel := context.WithCancel(context.Background())
	cancel()
	c := testConsumer(ctx)
	finished := c.processMessage(func(ctx context.Context, _ []byte) error { return ctx.Err() }, kafkago.Message{}, 0)
	if finished {
		t.Fatal("a message interrupted by shutdown must stay uncommitted")
	}
}

func TestProcessMessageRetriesDLQUntilPublished(t *testing.T) {
	c := testConsumer(context.Background())
	attempts := 0
	c.publishDLQ = func(context.Context, string, string, []byte, string) error {
		attempts++
		if attempts < 2 {
			return errors.New("broker unavailable")
		}
		return nil
	}
	finished := c.processMessage(func(context.Context, []byte) error { return errors.New("failed") }, kafkago.Message{}, 0)
	if !finished || attempts != 2 {
		t.Fatalf("finished = %v, attempts = %d, want true, 2", finished, attempts)
	}
}

func TestProcessMessageStopsRetryingDLQOnShutdown(t *testing.T) {
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	c := testConsumer(ctx)
	c.publishDLQ = func(context.Context, string, string, []byte, string) error {
		cancel()
		return errors.New("broker unavailable")
	}
	finished := c.processMessage(func(context.Context, []byte) error { return errors.New("failed") }, kafkago.Message{}, 0)
	if finished {
		t.Fatal("a message that never reached the DLQ must stay uncommitted")
	}
}

func TestCommitStateIgnoresLowerOffsetAfterFlush(t *testing.T) {
	state := newCommitState()
	state.add(commitRequest{topic: "t", partition: 0, offset: 7})
	state.markCommitted()

	state.add(commitRequest{topic: "t", partition: 0, offset: 6})
	if state.hasPending() {
		t.Fatalf("offset 6 must not be committed after 7, pending = %v", state.pending)
	}

	state.add(commitRequest{topic: "t", partition: 0, offset: 8})
	if got := state.pending["t"][0]; got != 8 {
		t.Fatalf("pending = %d, want 8", got)
	}
}

func TestCommitStateKeepsHighestPendingOffset(t *testing.T) {
	state := newCommitState()
	state.add(commitRequest{topic: "t", partition: 1, offset: 9})
	state.add(commitRequest{topic: "t", partition: 1, offset: 5})
	if got := state.pending["t"][1]; got != 9 {
		t.Fatalf("pending = %d, want 9", got)
	}
}

func TestCommitStateTracksPartitionsSeparately(t *testing.T) {
	state := newCommitState()
	state.add(commitRequest{topic: "t", partition: 0, offset: 50})
	state.markCommitted()

	state.add(commitRequest{topic: "t", partition: 1, offset: 3})
	if got := state.pending["t"][1]; got != 3 {
		t.Fatalf("pending = %d, want 3", got)
	}
}
