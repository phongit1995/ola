package checkin

import (
	"testing"
	"time"

	"ola-chat-server/internal/models"
)

func TestReplayOutcomeReason(t *testing.T) {
	done := time.Date(2026, 11, 21, 3, 0, 0, 0, time.UTC)
	pending := func(requireVip bool, taskDoneAt *time.Time) *models.UserCheckin {
		return &models.UserCheckin{
			Slot:           4,
			RewardStatus:   models.CheckinRewardStatusPending,
			RewardSnapshot: models.CheckinSnapshot{RequireVip: requireVip},
			TaskDoneAt:     taskDoneAt,
		}
	}
	cases := []struct {
		name   string
		row    *models.UserCheckin
		hasVip bool
		want   string
	}{
		{"task not done", pending(false, nil), false, OpenReasonTaskPending},
		{"normal box ready to open", pending(false, &done), false, ""},
		{"vip box without vip", pending(true, &done), false, OpenReasonVipRequired},
		{"vip box with vip", pending(true, &done), true, ""},
		{"no box", &models.UserCheckin{Slot: 4, RewardStatus: models.CheckinRewardStatusNone}, false, ""},
	}
	for _, tc := range cases {
		got := replayOutcome(tc.row, tc.hasVip)
		if got.reason != tc.want || got.slot != 4 || !got.replayed {
			t.Errorf("%s: got reason=%q slot=%d replayed=%v, want reason=%q", tc.name, got.reason, got.slot, got.replayed, tc.want)
		}
	}
}
