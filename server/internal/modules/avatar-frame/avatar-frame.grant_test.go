package avatarframe

import (
	"testing"
	"time"

	"ola-chat-server/internal/models"
)

func TestTimedFrameGrantFields(t *testing.T) {
	now := time.Date(2026, 11, 18, 10, 0, 0, 0, time.UTC)
	week := 7 * 24 * time.Hour
	future := now.Add(3 * 24 * time.Hour)
	past := now.Add(-time.Hour)

	t.Run("expired row restarts from now", func(t *testing.T) {
		fields := timedFrameGrantFields(&models.UserAvatarFrame{ExpiresAt: &past, Locked: true}, "admin", now, week)
		if !fields["expires_at"].(time.Time).Equal(now.Add(week)) || fields["locked"] != true || fields["source"] != "admin" {
			t.Fatalf("unexpected %v", fields)
		}
	})
	t.Run("active row extends its expiry", func(t *testing.T) {
		fields := timedFrameGrantFields(&models.UserAvatarFrame{ExpiresAt: &future, Locked: true}, "gift_code", now, week)
		if !fields["expires_at"].(time.Time).Equal(future.Add(week)) || fields["locked"] != true {
			t.Fatalf("unexpected %v", fields)
		}
		if _, ok := fields["source"]; ok {
			t.Fatal("extending must keep the original source")
		}
	})
}

func TestWearsFrameRow(t *testing.T) {
	frameID := "004"
	expiry := time.Date(2026, 11, 25, 0, 0, 0, 0, time.UTC)
	permanent := &models.UserAvatarFrame{FrameID: frameID}
	timed := &models.UserAvatarFrame{FrameID: frameID, ExpiresAt: &expiry}
	wearingPermanent := &models.User{AvatarFrameID: &frameID}
	wearingTimed := &models.User{AvatarFrameID: &frameID, AvatarFrameExpiresAt: &expiry}

	if !wearsFrameRow(wearingPermanent, permanent) || wearsFrameRow(wearingPermanent, timed) {
		t.Fatal("permanent copy must be matched only by permanent wear")
	}
	if !wearsFrameRow(wearingTimed, timed) || wearsFrameRow(wearingTimed, permanent) {
		t.Fatal("timed copy must be matched only by timed wear")
	}
	if wearsFrameRow(&models.User{}, permanent) {
		t.Fatal("no frame worn")
	}
}
