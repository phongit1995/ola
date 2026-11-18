package utils

import (
	"testing"
	"time"
)

func TestVietnamPeriodStart(t *testing.T) {
	now := time.Date(2026, 11, 4, 18, 30, 0, 0, time.UTC)
	cases := map[string]time.Time{
		PeriodDay:   time.Date(2026, 11, 4, 17, 0, 0, 0, time.UTC),
		PeriodWeek:  time.Date(2026, 11, 1, 17, 0, 0, 0, time.UTC),
		PeriodMonth: time.Date(2026, 10, 31, 17, 0, 0, 0, time.UTC),
	}
	for period, want := range cases {
		got, ok := VietnamPeriodStart(now, period)
		if !ok || !got.Equal(want) {
			t.Fatalf("%s: got %v ok=%v, want %v", period, got, ok, want)
		}
	}
	if _, ok := VietnamPeriodStart(now, PeriodAll); ok {
		t.Fatal("all period must not have a start")
	}
}

func TestPageAsOf(t *testing.T) {
	now := time.Date(2026, 11, 18, 10, 0, 0, 0, time.UTC)
	recent := now.Add(-time.Minute)
	cases := []struct {
		name string
		raw  string
		want time.Time
	}{
		{"empty", "", now},
		{"invalid", "abc", now},
		{"future", now.Add(time.Minute).Format(time.RFC3339Nano), now},
		{"too old", now.Add(-PageAsOfMaxAge - time.Second).Format(time.RFC3339Nano), now},
		{"recent", recent.Format(time.RFC3339Nano), recent},
	}
	for _, tc := range cases {
		if got := PageAsOf(tc.raw, now); !got.Equal(tc.want) {
			t.Errorf("%s: got %v want %v", tc.name, got, tc.want)
		}
	}
}
