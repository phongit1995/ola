package adminmoment

import (
	"testing"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/moment"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

func TestMomentStatePrecedence(t *testing.T) {
	now := time.Date(2026, 10, 24, 12, 0, 0, 0, time.UTC)
	live := now.Add(time.Hour)
	expired := now.Add(-time.Hour)
	deleted := gorm.DeletedAt{Time: now, Valid: true}

	cases := []struct {
		name   string
		moment models.Moment
		want   string
	}{
		{"ready and live", models.Moment{Status: moment.MomentStatusReady, ExpiresAt: live}, moment.AdminMomentStateLive},
		{"processing", models.Moment{Status: moment.MomentStatusProcessing, ExpiresAt: live}, moment.AdminMomentStateProcessing},
		{"processing past expiry", models.Moment{Status: moment.MomentStatusProcessing, ExpiresAt: expired}, moment.AdminMomentStateExpired},
		{"failed before expiry", models.Moment{Status: moment.MomentStatusFailed, ExpiresAt: live}, moment.AdminMomentStateFailed},
		{"expiry boundary", models.Moment{Status: moment.MomentStatusReady, ExpiresAt: now}, moment.AdminMomentStateExpired},
		{"purged after expiry", models.Moment{Status: moment.MomentStatusPurged, ExpiresAt: expired}, moment.AdminMomentStateExpired},
		{"failed moments are soft-deleted by the processor", models.Moment{Status: moment.MomentStatusFailed, ExpiresAt: live, DeletedAt: deleted}, moment.AdminMomentStateFailed},
		{"deleted by author", models.Moment{Status: moment.MomentStatusReady, ExpiresAt: live, DeletedAt: deleted}, moment.AdminMomentStateDeleted},
		{"deleted and purged", models.Moment{Status: moment.MomentStatusPurged, ExpiresAt: expired, DeletedAt: deleted}, moment.AdminMomentStateDeleted},
	}
	for _, tc := range cases {
		if got := momentState(&tc.moment, now); got != tc.want {
			t.Errorf("%s: got %q, want %q", tc.name, got, tc.want)
		}
	}
}

func TestToMomentItemHidesUnplayableMedia(t *testing.T) {
	now := time.Date(2026, 10, 24, 12, 0, 0, 0, time.UTC)
	base := models.Moment{
		ID:        uuid.New(),
		Type:      moment.MomentTypeVideo,
		MediaURL:  "https://cdn/video.mp4",
		ThumbURL:  "https://cdn/poster.jpg",
		ExpiresAt: now.Add(time.Hour),
		Enabled:   true,
	}

	ready := base
	ready.Status = moment.MomentStatusReady
	if item := toMomentItem(&ready, now); item.MediaURL == "" || item.ThumbURL == "" || item.MediaPurged {
		t.Fatalf("ready moment should expose media: %+v", item)
	}

	processing := base
	processing.Status = moment.MomentStatusProcessing
	if item := toMomentItem(&processing, now); item.MediaURL != "" || item.ThumbURL == "" {
		t.Fatalf("processing moment should hide source but keep poster: %+v", item)
	}

	purged := base
	purged.Status = moment.MomentStatusPurged
	purged.ExpiresAt = now.Add(-time.Hour)
	item := toMomentItem(&purged, now)
	if item.MediaURL != "" || item.ThumbURL != "" || !item.MediaPurged {
		t.Fatalf("purged moment should drop media: %+v", item)
	}
	if item.Overlays == nil {
		t.Fatal("overlays should serialize as an empty list")
	}

	text := models.Moment{ID: uuid.New(), Type: moment.MomentTypeText, Status: moment.MomentStatusPurged, ExpiresAt: now.Add(-time.Hour)}
	if toMomentItem(&text, now).MediaPurged {
		t.Fatal("text moments never had media to purge")
	}
}

func TestViewerDataOnlyForLiveUndeletedMoments(t *testing.T) {
	now := time.Date(2026, 10, 24, 12, 0, 0, 0, time.UTC)
	deleted := gorm.DeletedAt{Time: now, Valid: true}
	cases := []struct {
		name   string
		moment models.Moment
		want   bool
	}{
		{"live", models.Moment{ExpiresAt: now.Add(time.Hour)}, true},
		{"expired", models.Moment{ExpiresAt: now.Add(-time.Hour)}, false},
		{"deleted before expiry", models.Moment{ExpiresAt: now.Add(time.Hour), DeletedAt: deleted}, false},
	}
	for _, tc := range cases {
		if got := hasViewerData(&tc.moment, now); got != tc.want {
			t.Errorf("%s: got %v, want %v", tc.name, got, tc.want)
		}
	}
}

func TestParseStateAcceptsKnownValuesOnly(t *testing.T) {
	for _, state := range []string{
		moment.AdminMomentStateLive,
		moment.AdminMomentStateProcessing,
		moment.AdminMomentStateFailed,
		moment.AdminMomentStateExpired,
		moment.AdminMomentStateDeleted,
	} {
		if got := parseState(state); got != state {
			t.Errorf("parseState(%q) = %q", state, got)
		}
	}
	for _, raw := range []string{"", "LIVE", "purged", "hidden"} {
		if got := parseState(raw); got != "" {
			t.Errorf("parseState(%q) = %q, want empty", raw, got)
		}
	}
	if got := oneOf("video", moment.MomentTypeText, moment.MomentTypeImage, moment.MomentTypeVideo); got != "video" {
		t.Errorf("oneOf kept %q", got)
	}
	if got := oneOf("gif", moment.MomentTypeText, moment.MomentTypeImage, moment.MomentTypeVideo); got != "" {
		t.Errorf("oneOf accepted %q", got)
	}
}

func TestPageKeyGroupsPagesOfOnePost(t *testing.T) {
	author := uuid.New()
	createdAt := time.Date(2026, 10, 26, 9, 30, 0, 123456000, time.UTC)
	sameInstant := createdAt.In(time.FixedZone("ICT", 7*60*60))

	if pageKey(author, createdAt) != pageKey(author, sameInstant) {
		t.Fatal("pages created in the same instant must share a key regardless of time zone")
	}
	if pageKey(author, createdAt) == pageKey(author, createdAt.Add(time.Microsecond)) {
		t.Fatal("posts created a microsecond apart must not share a key")
	}
	if pageKey(author, createdAt) == pageKey(uuid.New(), createdAt) {
		t.Fatal("posts by different authors must not share a key")
	}
}

func TestWithPageKeepsTheRequestedMoment(t *testing.T) {
	first := &models.Moment{ID: uuid.New(), Position: 0}
	second := &models.Moment{ID: uuid.New(), Position: 1}

	if got := withPage([]*models.Moment{first, second}, second); len(got) != 2 {
		t.Fatalf("got %d pages, want 2", len(got))
	}
	got := withPage([]*models.Moment{first}, second)
	if len(got) != 2 || got[1] != second {
		t.Fatal("the requested moment must be added when the sibling query missed it")
	}
}

func TestToMomentItemCarriesPagePosition(t *testing.T) {
	now := time.Date(2026, 10, 26, 12, 0, 0, 0, time.UTC)
	item := toMomentItem(&models.Moment{ID: uuid.New(), Position: 2, Status: moment.MomentStatusReady, ExpiresAt: now.Add(time.Hour)}, now)
	if item.Position != 2 {
		t.Fatalf("got position %d, want 2", item.Position)
	}
}
