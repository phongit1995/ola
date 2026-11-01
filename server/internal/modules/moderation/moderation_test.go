package moderation

import (
	"strings"
	"testing"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
)

func TestPointsForSeverity(t *testing.T) {
	cfg := setting.ModerationConfig{DeliberatePoints: 5}
	cases := map[string]int{SeverityNone: 0, SeverityViolation: 1, SeverityDeliberate: 5, "unknown": 0}
	for severity, want := range cases {
		if got := pointsFor(severity, cfg); got != want {
			t.Errorf("%s: got %d, want %d", severity, got, want)
		}
	}
}

func TestViolationMessage(t *testing.T) {
	cfg := setting.DefaultModerationConfig()
	until := time.Date(2026, 11, 2, 7, 30, 0, 0, time.UTC)
	cases := []struct {
		name   string
		in     PenaltyInput
		points int
		result recordResult
		want   []string
	}{
		{
			name:   "first violation warns about the twelve hour lock",
			in:     PenaltyInput{TargetType: constants.ReportTargetPost, Reason: "sensitive", ContentRemoved: true},
			points: 1,
			result: recordResult{counted: true, total: 1},
			want:   []string{"Bài viết của bạn đã bị ẩn do nội dung nhạy cảm.", "hiện có 1 điểm.", "Đủ 2 điểm tài khoản sẽ bị khoá 12 giờ."},
		},
		{
			name:   "deleted comment not counted",
			in:     PenaltyInput{TargetType: constants.ReportTargetComment, Reason: "spam", ContentRemoved: true},
			points: 0,
			result: recordResult{counted: true, total: 1},
			want:   []string{"Bình luận của bạn đã bị xoá do spam / quảng cáo.", "không bị tính điểm"},
		},
		{
			name:   "second violation locks until a time and warns about the permanent lock",
			in:     PenaltyInput{TargetType: constants.ReportTargetMessage, Reason: "scam"},
			points: 1,
			result: recordResult{counted: true, total: 2, locked: true, lockedUntil: &until},
			want:   []string{"Tin nhắn của bạn vi phạm tiêu chuẩn cộng đồng do lừa đảo.", "bị khoá đến 14:30 02/11/2026.", "Đủ 3 điểm tài khoản sẽ bị khoá vĩnh viễn."},
		},
		{
			name:   "locked forever with unknown reason",
			in:     PenaltyInput{TargetType: "unknown", Reason: "weird", ContentRemoved: true},
			points: 1,
			result: recordResult{counted: true, total: 3, locked: true},
			want:   []string{"Nội dung của bạn đã bị xoá do vi phạm tiêu chuẩn cộng đồng.", "có 3 điểm vi phạm nên tài khoản bị khoá vĩnh viễn."},
		},
	}
	for _, tc := range cases {
		got := violationMessage(tc.in, tc.points, &tc.result, cfg)
		for _, part := range tc.want {
			if !strings.Contains(got, part) {
				t.Errorf("%s: %q does not contain %q", tc.name, got, part)
			}
		}
	}
}

func TestLockDuration(t *testing.T) {
	cases := map[setting.ModerationLockStep]string{
		{Points: 2, Hours: 12}: "12 giờ",
		{Points: 2, Hours: 48}: "2 ngày",
		{Points: 3, Hours: 0}:  "vĩnh viễn",
	}
	for step, want := range cases {
		if got := lockDuration(step); got != want {
			t.Errorf("%+v: got %q, want %q", step, got, want)
		}
	}
}

func TestLockExtendsOnlyHarsherViolationLocks(t *testing.T) {
	soon := time.Now().Add(time.Hour)
	later := soon.Add(time.Hour)
	earlier := soon.Add(-30 * time.Minute)
	locked := func(reason string, until *time.Time) *models.User {
		return &models.User{IsActive: false, LockReason: reason, LockedUntil: until}
	}
	cases := []struct {
		name  string
		user  *models.User
		until *time.Time
		want  bool
	}{
		{"active user", &models.User{IsActive: true}, &soon, true},
		{"manual admin lock", locked("", nil), nil, false},
		{"permanent violation lock", locked(constants.LockReasonViolations, nil), nil, false},
		{"timed lock upgraded to permanent", locked(constants.LockReasonViolations, &soon), nil, true},
		{"timed lock extended", locked(constants.LockReasonViolations, &soon), &later, true},
		{"timed lock not shortened", locked(constants.LockReasonViolations, &soon), &earlier, false},
	}
	for _, tc := range cases {
		if got := lockExtends(tc.user, tc.until); got != tc.want {
			t.Errorf("%s: got %v, want %v", tc.name, got, tc.want)
		}
	}
}

func TestReporterMessageNamesTheContent(t *testing.T) {
	got := reporterMessage(constants.ReportTargetMoment)
	if !strings.Contains(got, "về khoảnh khắc đã được xử lý") {
		t.Fatalf("unexpected reporter message: %q", got)
	}
}
