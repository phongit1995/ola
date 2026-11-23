package models

import (
	"testing"
	"time"
)

func ptrTime(t time.Time) *time.Time { return &t }

func ptrString(s string) *string { return &s }

func TestItemGrantNormalizedLocksTimedItems(t *testing.T) {
	g := ItemGrant{Locked: false, Duration: time.Hour}.Normalized()
	if !g.Locked {
		t.Fatal("timed grant must be locked")
	}
	if p := (ItemGrant{Locked: false}).Normalized(); p.Locked {
		t.Fatal("permanent grant keeps its lock flag")
	}
	if n := (ItemGrant{Duration: -time.Hour}).Normalized(); n.Duration != 0 || n.Locked {
		t.Fatal("negative duration becomes permanent")
	}
}

func TestLockedGrantForDays(t *testing.T) {
	now := time.Date(2026, 11, 18, 10, 0, 0, 0, time.UTC)
	if g := LockedGrantForDays(0); !g.Locked || g.ExpiresAt(now) != nil {
		t.Fatal("0 days is permanent and locked")
	}
	g := LockedGrantForDays(7)
	if got := g.ExpiresAt(now); got == nil || !got.Equal(now.Add(7*24*time.Hour)) {
		t.Fatalf("unexpected expiry %v", got)
	}
}

func TestActiveVipUsed(t *testing.T) {
	now := time.Date(2026, 11, 18, 10, 0, 0, 0, time.UTC)
	cases := []struct {
		name    string
		user    *User
		wantNil bool
	}{
		{"nil user", nil, true},
		{"no vip", &User{}, true},
		{"permanent", &User{VipUsed: ptrString("4")}, false},
		{"not expired", &User{VipUsed: ptrString("4"), VipUsedExpiresAt: ptrTime(now.Add(time.Minute))}, false},
		{"expired", &User{VipUsed: ptrString("4"), VipUsedExpiresAt: ptrTime(now.Add(-time.Minute))}, true},
		{"expires exactly now", &User{VipUsed: ptrString("4"), VipUsedExpiresAt: ptrTime(now)}, true},
	}
	for _, c := range cases {
		got := c.user.ActiveVipUsed(now)
		if (got == nil) != c.wantNil {
			t.Errorf("%s: got %v", c.name, got)
		}
	}
}

func TestActiveAvatarFrameID(t *testing.T) {
	now := time.Date(2026, 11, 18, 10, 0, 0, 0, time.UTC)
	vip := ptrTime(now.Add(24 * time.Hour))
	cases := []struct {
		name    string
		user    *User
		wantNil bool
	}{
		{"no vip", &User{AvatarFrameID: ptrString("001")}, true},
		{"vip permanent frame", &User{AvatarFrameID: ptrString("001"), VipEndTime: vip}, false},
		{"vip frame not expired", &User{AvatarFrameID: ptrString("001"), VipEndTime: vip, AvatarFrameExpiresAt: ptrTime(now.Add(time.Hour))}, false},
		{"vip frame expired", &User{AvatarFrameID: ptrString("001"), VipEndTime: vip, AvatarFrameExpiresAt: ptrTime(now.Add(-time.Hour))}, true},
	}
	for _, c := range cases {
		got := c.user.ActiveAvatarFrameID(now)
		if (got == nil) != c.wantNil {
			t.Errorf("%s: got %v", c.name, got)
		}
	}
}
