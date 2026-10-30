package report

import (
	"context"
	"errors"
	"strings"
	"sync"
	"testing"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

func TestAlertExcerptHidesDirectMessageContent(t *testing.T) {
	report := &models.Report{
		TargetType: constants.ReportTargetMessage,
		Note:       "nó nhắn: số tài khoản 123",
		Snapshot:   models.JSONB{"text": "bí mật"},
	}
	msg := buildAlertMessage(report, "@a", "@b", 1, "")
	if strings.Contains(msg.Excerpt, "bí mật") || msg.Note != "" {
		t.Fatalf("direct message content leaked: %+v", msg)
	}
}

func TestAlertExcerptByTarget(t *testing.T) {
	long := strings.Repeat("á", AlertExcerptMaxRunes+5)
	cases := []struct {
		report *models.Report
		want   string
	}{
		{&models.Report{TargetType: constants.ReportTargetAccount, Snapshot: models.JSONB{"username": "test1", "fullName": "Brenda"}}, "Brenda (@test1)"},
		{&models.Report{TargetType: constants.ReportTargetPost, Snapshot: models.JSONB{"imageUrls": []string{"x"}}}, "[Ảnh]"},
		{&models.Report{TargetType: constants.ReportTargetMoment, Snapshot: models.JSONB{"videoUrl": "v", "imageUrls": []interface{}{"t"}}}, "[Video]"},
		{&models.Report{TargetType: constants.ReportTargetRoomMessage, Snapshot: models.JSONB{"text": long}}, strings.Repeat("á", AlertExcerptMaxRunes) + "…"},
	}
	for _, tc := range cases {
		if got := alertExcerpt(tc.report); got != tc.want {
			t.Fatalf("%s: got %q want %q", tc.report.TargetType, got, tc.want)
		}
	}
}

func TestAlertRenderersEscapeUserContent(t *testing.T) {
	report := &models.Report{
		TargetType: constants.ReportTargetPost,
		Reason:     ReportReasonScam,
		Snapshot:   models.JSONB{"text": "<b>@everyone</b> **mua** ngay"},
	}
	msg := buildAlertMessage(report, "@test4", "@test1", 3, "https://admin.olachat.net")

	text := telegramTextFor(msg)
	if strings.Contains(text, "<b>@everyone</b>") || !strings.Contains(text, "&lt;b&gt;@"+AlertTelegramMentionBreaker+"everyone&lt;/b&gt;") {
		t.Fatalf("telegram text not escaped: %s", text)
	}
	if !strings.Contains(text, "3 báo cáo") || !strings.Contains(text, "https://admin.olachat.net/reports") {
		t.Fatalf("telegram text missing pending or link: %s", text)
	}

	payload := discordPayloadFor(msg, time.Unix(0, 0))
	description := payload.Embeds[0].Description
	if !strings.Contains(description, `\*\*mua\*\*`) || len(payload.AllowedMentions.Parse) != 0 {
		t.Fatalf("discord payload not safe: %s %+v", description, payload.AllowedMentions)
	}
	if payload.Embeds[0].Title != "🚩 Báo cáo mới: Bài đăng Me" || !strings.Contains(description, "Lừa đảo") {
		t.Fatalf("discord payload wrong: %+v", payload.Embeds[0])
	}
}

type fakeThrottle struct {
	mu   sync.Mutex
	keys map[string]string
}

func (f *fakeThrottle) SetNX(key string, value interface{}, _ time.Duration) (bool, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	if _, ok := f.keys[key]; ok {
		return false, nil
	}
	f.keys[key] = value.(string)
	return true, nil
}

func (f *fakeThrottle) DeleteIfValue(key string, value interface{}) (bool, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	if f.keys[key] != value.(string) {
		return false, nil
	}
	delete(f.keys, key)
	return true, nil
}

func testAlerter(throttle alertThrottle, timeout time.Duration) *Alerter {
	return &Alerter{throttle: throttle, sendTimeout: timeout, logger: zap.NewNop().Sugar()}
}

func testReport() *models.Report {
	return &models.Report{BaseModel: models.BaseModel{ID: uuid.New()}, TargetType: constants.ReportTargetPost, TargetID: "post-1"}
}

func TestAlertSlowChannelDoesNotStarveOther(t *testing.T) {
	alerter := testAlerter(&fakeThrottle{keys: map[string]string{}}, 200*time.Millisecond)
	var telegramErr error
	channels := []alertChannel{
		{name: "discord", send: func(ctx context.Context, _ alertMessage) error {
			<-ctx.Done()
			return ctx.Err()
		}},
		{name: "telegram", send: func(ctx context.Context, _ alertMessage) error {
			time.Sleep(50 * time.Millisecond)
			telegramErr = ctx.Err()
			return nil
		}},
	}
	started := time.Now()
	alerter.dispatch(testReport(), alertMessage{}, channels)
	if telegramErr != nil {
		t.Fatalf("telegram got an expired context: %v", telegramErr)
	}
	if elapsed := time.Since(started); elapsed > 400*time.Millisecond {
		t.Fatalf("channels did not run in parallel, took %v", elapsed)
	}
}

func TestAlertFailedChannelIsRetriedNextReport(t *testing.T) {
	throttle := &fakeThrottle{keys: map[string]string{}}
	alerter := testAlerter(throttle, time.Second)
	sends := map[string]int{}
	var mu sync.Mutex
	discordFails := true
	channels := []alertChannel{
		{name: "discord", send: func(context.Context, alertMessage) error {
			mu.Lock()
			defer mu.Unlock()
			sends["discord"]++
			if discordFails {
				return errors.New("network down")
			}
			return nil
		}},
		{name: "telegram", send: func(context.Context, alertMessage) error {
			mu.Lock()
			defer mu.Unlock()
			sends["telegram"]++
			return nil
		}},
	}

	first := testReport()
	alerter.dispatch(first, alertMessage{}, alerter.claimChannels(first, channels))
	discordFails = false
	second := testReport()
	alerter.dispatch(second, alertMessage{}, alerter.claimChannels(second, channels))
	third := testReport()
	alerter.dispatch(third, alertMessage{}, alerter.claimChannels(third, channels))

	if sends["discord"] != 2 || sends["telegram"] != 1 {
		t.Fatalf("expected discord retried once then throttled and telegram sent once, got %v", sends)
	}
}

func TestTelegramTextDoesNotMentionTelegramUsers(t *testing.T) {
	report := &models.Report{
		TargetType: constants.ReportTargetPost,
		Reason:     ReportReasonSpam,
		Snapshot:   models.JSONB{"text": "liên hệ @shopabc nhé"},
	}
	text := telegramTextFor(buildAlertMessage(report, "@minh", AlertUnknownUserLabel, 1, ""))
	for _, mention := range []string{"@minh", "@shopabc"} {
		if strings.Contains(text, mention) {
			t.Fatalf("telegram text would auto-link %s: %q", mention, text)
		}
	}
	if !strings.Contains(text, "@"+AlertTelegramMentionBreaker+"minh") || !strings.Contains(text, AlertUnknownUserLabel) {
		t.Fatalf("telegram text lost user labels: %q", text)
	}
}

func TestTestAlertMessageWarnsWhenDisabled(t *testing.T) {
	if msg := testAlertMessage(false, ""); !strings.Contains(msg.Body, "TẮT") {
		t.Fatalf("disabled test message must say the channel is off: %q", msg.Body)
	}
	if msg := testAlertMessage(true, "https://admin.olachat.net"); strings.Contains(msg.Body, "TẮT") || msg.Link != "https://admin.olachat.net/reports" {
		t.Fatalf("enabled test message wrong: %+v", msg)
	}
}
