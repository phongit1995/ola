package moment

import (
	"context"
	"errors"
	"reflect"
	"testing"
	"time"

	"github.com/google/uuid"
)

func TestMediaPurgeLogStatus(t *testing.T) {
	started := time.Date(2026, 10, 26, 10, 0, 0, 0, time.UTC)
	finished := started.Add(1500 * time.Millisecond)
	boom := errors.New("db down")

	cases := []struct {
		name    string
		purged  int
		failed  int
		err     error
		status  string
		message string
	}{
		{"nothing to do", 0, 0, nil, MomentPurgeStatusSuccess, ""},
		{"all purged", 5, 0, nil, MomentPurgeStatusSuccess, ""},
		{"some objects failed", 5, 2, nil, MomentPurgeStatusPartial, ""},
		{"every object failed", 0, 3, nil, MomentPurgeStatusFailed, ""},
		{"error before any purge", 0, 0, boom, MomentPurgeStatusFailed, "db down"},
		{"error after some purges", 4, 0, boom, MomentPurgeStatusPartial, "db down"},
	}
	for _, tc := range cases {
		entry := &MediaPurgeLog{StartedAt: started, Purged: tc.purged, Failed: tc.failed}
		entry.settle(tc.err, finished)
		if entry.Status != tc.status || entry.Message != tc.message {
			t.Errorf("%s: got %q %q, want %q %q", tc.name, entry.Status, entry.Message, tc.status, tc.message)
		}
		if entry.DurationMs != 1500 || !entry.FinishedAt.Equal(finished) {
			t.Errorf("%s: duration %d, finished %v", tc.name, entry.DurationMs, entry.FinishedAt)
		}
	}
}

func TestMediaPurgeLogKeepsOnlyRunsWorthReading(t *testing.T) {
	cases := []struct {
		name  string
		entry MediaPurgeLog
		want  bool
	}{
		{"idle auto run", MediaPurgeLog{Trigger: MomentPurgeTriggerAuto, Status: MomentPurgeStatusSuccess}, false},
		{"auto run that purged", MediaPurgeLog{Trigger: MomentPurgeTriggerAuto, Status: MomentPurgeStatusSuccess, Purged: 1}, true},
		{"auto run with failures", MediaPurgeLog{Trigger: MomentPurgeTriggerAuto, Status: MomentPurgeStatusFailed, Failed: 1}, true},
		{"auto run that errored", MediaPurgeLog{Trigger: MomentPurgeTriggerAuto, Status: MomentPurgeStatusFailed}, true},
		{"idle manual run", MediaPurgeLog{Trigger: MomentPurgeTriggerManual, Status: MomentPurgeStatusSuccess}, true},
	}
	for _, tc := range cases {
		if got := tc.entry.worthKeeping(); got != tc.want {
			t.Errorf("%s: got %v, want %v", tc.name, got, tc.want)
		}
	}
}

func TestPurgeCursorMovesForwardOnly(t *testing.T) {
	at := time.Date(2026, 10, 26, 10, 0, 0, 123456000, time.UTC)
	low := uuid.MustParse("00000000-0000-0000-0000-0000000000aa")
	high := uuid.MustParse("00000000-0000-0000-0000-0000000000bb")
	cursor := purgeCursor{CreatedAt: at, ID: low}

	if !cursor.after(cleanupCandidate{CreatedAt: at, ID: high}) {
		t.Fatal("same time with a higher id must move the cursor")
	}
	if cursor.after(cleanupCandidate{CreatedAt: at, ID: low}) {
		t.Fatal("the same row must not move the cursor")
	}
	if !cursor.after(cleanupCandidate{CreatedAt: at.Add(time.Microsecond), ID: low}) {
		t.Fatal("a later time must move the cursor")
	}
	if cursor.after(cleanupCandidate{CreatedAt: at.Add(-time.Microsecond), ID: high}) {
		t.Fatal("an earlier time must not move the cursor")
	}
	if !(purgeCursor{}).after(cleanupCandidate{CreatedAt: at, ID: low}) {
		t.Fatal("the zero cursor must accept any row")
	}
}

func TestMediaPurgeTotalsDelta(t *testing.T) {
	cases := []struct {
		name  string
		entry MediaPurgeLog
		want  map[string]int64
	}{
		{"idle run", MediaPurgeLog{}, map[string]int64{}},
		{"purged with files", MediaPurgeLog{Purged: 2, Files: 3, Bytes: 4096}, map[string]int64{
			MomentPurgeTotalMoments: 2, MomentPurgeTotalFiles: 3, MomentPurgeTotalBytes: 4096,
		}},
		{"files already gone", MediaPurgeLog{Purged: 1}, map[string]int64{MomentPurgeTotalMoments: 1}},
		{"failed after deleting a file", MediaPurgeLog{Failed: 1, Files: 1, Bytes: 10}, map[string]int64{
			MomentPurgeTotalFiles: 1, MomentPurgeTotalBytes: 10,
		}},
	}
	for _, tc := range cases {
		if got := tc.entry.totalsDelta(); !reflect.DeepEqual(got, tc.want) {
			t.Errorf("%s: got %v, want %v", tc.name, got, tc.want)
		}
	}
}

func TestParsePurgeTotals(t *testing.T) {
	got := parsePurgeTotals(map[string]string{
		MomentPurgeTotalMoments: "12",
		MomentPurgeTotalFiles:   "30",
		MomentPurgeTotalBytes:   "52428800",
		"unknown":               "7",
	})
	want := MediaPurgeTotals{Moments: 12, Files: 30, Bytes: 52428800}
	if got != want {
		t.Fatalf("got %+v, want %+v", got, want)
	}
	if empty := parsePurgeTotals(nil); empty != (MediaPurgeTotals{}) {
		t.Fatalf("missing hash must read as zero, got %+v", empty)
	}
}

func TestStopPurgeTreatsRunBudgetAsMoreWork(t *testing.T) {
	expired, cancel := context.WithDeadline(context.Background(), time.Now().Add(-time.Second))
	defer cancel()
	entry := &MediaPurgeLog{}
	if err := stopPurge(expired, entry); err != nil || !entry.HasMore {
		t.Fatalf("deadline: err %v, hasMore %v", err, entry.HasMore)
	}

	stopped, stop := context.WithCancel(context.Background())
	stop()
	entry = &MediaPurgeLog{}
	if err := stopPurge(stopped, entry); !errors.Is(err, context.Canceled) || entry.HasMore {
		t.Fatalf("shutdown: err %v, hasMore %v", err, entry.HasMore)
	}
}

func TestPurgeLogWindowKeepsThirtyVietnamDays(t *testing.T) {
	cases := []struct {
		name string
		now  time.Time
		want time.Time
	}{
		{"afternoon in Vietnam", time.Date(2026, 10, 26, 10, 0, 0, 0, time.UTC), time.Date(2026, 9, 26, 17, 0, 0, 0, time.UTC)},
		{"just after midnight in Vietnam", time.Date(2026, 10, 26, 17, 30, 0, 0, time.UTC), time.Date(2026, 9, 27, 17, 0, 0, 0, time.UTC)},
	}
	for _, tc := range cases {
		if got := purgeLogWindowStart(tc.now); !got.Equal(tc.want) {
			t.Errorf("%s: got %v, want %v", tc.name, got, tc.want)
		}
	}
}

func TestPurgeTotalsKeysCoverThirtyDays(t *testing.T) {
	keys := purgeTotalsKeys(time.Date(2026, 10, 26, 17, 30, 0, 0, time.UTC))
	if len(keys) != MomentPurgeLogRetentionDays {
		t.Fatalf("got %d keys", len(keys))
	}
	if keys[0] != "MOMENT:PURGE:TOTALS:20261027" || keys[len(keys)-1] != "MOMENT:PURGE:TOTALS:20260928" {
		t.Fatalf("got %s .. %s", keys[0], keys[len(keys)-1])
	}
}

func TestMediaPurgeTotalsAdd(t *testing.T) {
	total := MediaPurgeTotals{Moments: 1, Files: 2, Bytes: 300}
	total.add(MediaPurgeTotals{Moments: 4, Files: 5, Bytes: 600})
	if total != (MediaPurgeTotals{Moments: 5, Files: 7, Bytes: 900}) {
		t.Fatalf("got %+v", total)
	}
}
