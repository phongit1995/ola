package vip

import (
	"testing"
	"time"
)

func TestExtendEnd(t *testing.T) {
	now := time.Date(2026, 11, 13, 12, 0, 0, 0, time.UTC)
	future := now.Add(48 * time.Hour)
	past := now.Add(-48 * time.Hour)

	cases := []struct {
		name    string
		current *time.Time
		want    time.Time
	}{
		{"no vip", nil, now.Add(72 * time.Hour)},
		{"expired vip", &past, now.Add(72 * time.Hour)},
		{"active vip", &future, future.Add(72 * time.Hour)},
		{"ends now", &now, now.Add(72 * time.Hour)},
	}
	for _, tc := range cases {
		if got := ExtendEnd(now, tc.current, 3); !got.Equal(tc.want) {
			t.Fatalf("%s: got %v want %v", tc.name, got, tc.want)
		}
	}
}
