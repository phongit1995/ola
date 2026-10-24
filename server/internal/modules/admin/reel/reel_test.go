package adminreel

import (
	"testing"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

func TestReelStatePrecedence(t *testing.T) {
	now := time.Date(2026, 10, 24, 12, 0, 0, 0, time.UTC)
	live := now.Add(time.Hour)
	expired := now.Add(-time.Hour)
	deleted := gorm.DeletedAt{Time: now, Valid: true}

	cases := []struct {
		name string
		reel models.Reel
		want string
	}{
		{"ready and live", models.Reel{Status: constants.ReelStatusReady, ExpiresAt: live}, constants.AdminReelStateLive},
		{"processing", models.Reel{Status: constants.ReelStatusProcessing, ExpiresAt: live}, constants.AdminReelStateProcessing},
		{"processing past expiry", models.Reel{Status: constants.ReelStatusProcessing, ExpiresAt: expired}, constants.AdminReelStateExpired},
		{"failed before expiry", models.Reel{Status: constants.ReelStatusFailed, ExpiresAt: live}, constants.AdminReelStateFailed},
		{"expiry boundary", models.Reel{Status: constants.ReelStatusReady, ExpiresAt: now}, constants.AdminReelStateExpired},
		{"purged after expiry", models.Reel{Status: constants.ReelStatusPurged, ExpiresAt: expired}, constants.AdminReelStateExpired},
		{"failed reels are soft-deleted by the processor", models.Reel{Status: constants.ReelStatusFailed, ExpiresAt: live, DeletedAt: deleted}, constants.AdminReelStateFailed},
		{"deleted by author", models.Reel{Status: constants.ReelStatusReady, ExpiresAt: live, DeletedAt: deleted}, constants.AdminReelStateDeleted},
		{"deleted and purged", models.Reel{Status: constants.ReelStatusPurged, ExpiresAt: expired, DeletedAt: deleted}, constants.AdminReelStateDeleted},
	}
	for _, tc := range cases {
		if got := reelState(&tc.reel, now); got != tc.want {
			t.Errorf("%s: got %q, want %q", tc.name, got, tc.want)
		}
	}
}

func TestToReelItemHidesUnplayableMedia(t *testing.T) {
	now := time.Date(2026, 10, 24, 12, 0, 0, 0, time.UTC)
	base := models.Reel{
		ID:        uuid.New(),
		Type:      constants.ReelTypeVideo,
		MediaURL:  "https://cdn/video.mp4",
		ThumbURL:  "https://cdn/poster.jpg",
		ExpiresAt: now.Add(time.Hour),
		Enabled:   true,
	}

	ready := base
	ready.Status = constants.ReelStatusReady
	if item := toReelItem(&ready, now); item.MediaURL == "" || item.ThumbURL == "" || item.MediaPurged {
		t.Fatalf("ready reel should expose media: %+v", item)
	}

	processing := base
	processing.Status = constants.ReelStatusProcessing
	if item := toReelItem(&processing, now); item.MediaURL != "" || item.ThumbURL == "" {
		t.Fatalf("processing reel should hide source but keep poster: %+v", item)
	}

	purged := base
	purged.Status = constants.ReelStatusPurged
	purged.ExpiresAt = now.Add(-time.Hour)
	item := toReelItem(&purged, now)
	if item.MediaURL != "" || item.ThumbURL != "" || !item.MediaPurged {
		t.Fatalf("purged reel should drop media: %+v", item)
	}
	if item.Overlays == nil {
		t.Fatal("overlays should serialize as an empty list")
	}

	text := models.Reel{ID: uuid.New(), Type: constants.ReelTypeText, Status: constants.ReelStatusPurged, ExpiresAt: now.Add(-time.Hour)}
	if toReelItem(&text, now).MediaPurged {
		t.Fatal("text reels never had media to purge")
	}
}

func TestViewerDataOnlyForLiveUndeletedReels(t *testing.T) {
	now := time.Date(2026, 10, 24, 12, 0, 0, 0, time.UTC)
	deleted := gorm.DeletedAt{Time: now, Valid: true}
	cases := []struct {
		name string
		reel models.Reel
		want bool
	}{
		{"live", models.Reel{ExpiresAt: now.Add(time.Hour)}, true},
		{"expired", models.Reel{ExpiresAt: now.Add(-time.Hour)}, false},
		{"deleted before expiry", models.Reel{ExpiresAt: now.Add(time.Hour), DeletedAt: deleted}, false},
	}
	for _, tc := range cases {
		if got := hasViewerData(&tc.reel, now); got != tc.want {
			t.Errorf("%s: got %v, want %v", tc.name, got, tc.want)
		}
	}
}

func TestParseStateAcceptsKnownValuesOnly(t *testing.T) {
	for _, state := range []string{
		constants.AdminReelStateLive,
		constants.AdminReelStateProcessing,
		constants.AdminReelStateFailed,
		constants.AdminReelStateExpired,
		constants.AdminReelStateDeleted,
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
	if got := oneOf("video", constants.ReelTypeText, constants.ReelTypeImage, constants.ReelTypeVideo); got != "video" {
		t.Errorf("oneOf kept %q", got)
	}
	if got := oneOf("gif", constants.ReelTypeText, constants.ReelTypeImage, constants.ReelTypeVideo); got != "" {
		t.Errorf("oneOf accepted %q", got)
	}
}
