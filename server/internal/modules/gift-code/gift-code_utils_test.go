package giftcode

import (
	"strings"
	"testing"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
)

func TestNormalizeCode(t *testing.T) {
	cases := map[string]string{
		" tet2027 ":        "TET2027",
		"kol11- k7qm x2pd": "KOL11-K7QMX2PD",
		"\tabc\n":          "ABC",
	}
	for in, want := range cases {
		if got := NormalizeCode(in); got != want {
			t.Errorf("NormalizeCode(%q) = %q, want %q", in, got, want)
		}
	}
}

func TestIsCodeInput(t *testing.T) {
	valid := []string{"TET2027", "KOL11-K7QMX2PD", "A"}
	invalid := []string{"", "TET 2027", "MÃ123", "A?B", strings.Repeat("A", CodeMaxLength+1)}
	for _, c := range valid {
		if !IsCodeInput(c) {
			t.Errorf("IsCodeInput(%q) = false, want true", c)
		}
	}
	for _, c := range invalid {
		if IsCodeInput(c) {
			t.Errorf("IsCodeInput(%q) = true, want false", c)
		}
	}
}

func TestGenerateCodeUsesSafeAlphabet(t *testing.T) {
	for i := 0; i < 500; i++ {
		code, err := GenerateCode("TET27-", 10)
		if err != nil {
			t.Fatal(err)
		}
		if !strings.HasPrefix(code, "TET27-") || len(code) != 16 {
			t.Fatalf("unexpected code %q", code)
		}
		for _, r := range strings.TrimPrefix(code, "TET27-") {
			if !strings.ContainsRune(CodeAlphabet, r) || strings.ContainsRune("0O1IL", r) {
				t.Fatalf("code %q has confusing rune %q", code, r)
			}
		}
	}
}

func TestCampaignStatus(t *testing.T) {
	now := time.Date(2026, 11, 8, 12, 0, 0, 0, time.UTC)
	later := now.Add(time.Hour)
	earlier := now.Add(-time.Hour)
	base := func() *models.GiftCodeCampaign {
		return &models.GiftCodeCampaign{Enabled: true, EndsAt: later, TotalUses: 10, UsedCount: 3}
	}

	c := base()
	if got := CampaignStatus(c, now); got != StatusRunning {
		t.Errorf("running: got %s", got)
	}
	c = base()
	c.Enabled = false
	if got := CampaignStatus(c, now); got != StatusOff {
		t.Errorf("off: got %s", got)
	}
	c = base()
	c.StartsAt = &later
	c.EndsAt = later.Add(time.Hour)
	if got := CampaignStatus(c, now); got != StatusScheduled {
		t.Errorf("scheduled: got %s", got)
	}
	c = base()
	c.EndsAt = earlier
	if got := CampaignStatus(c, now); got != StatusExpired {
		t.Errorf("expired: got %s", got)
	}
	c = base()
	c.UsedCount = 10
	if got := CampaignStatus(c, now); got != StatusSoldOut {
		t.Errorf("soldout: got %s", got)
	}
}

func TestPlatformAllowed(t *testing.T) {
	c := &models.GiftCodeCampaign{AllowWeb: true, AllowAndroid: true}
	if !PlatformAllowed(c, setting.PlatformWeb) || !PlatformAllowed(c, setting.PlatformAndroid) {
		t.Error("web and android should be allowed")
	}
	if PlatformAllowed(c, setting.PlatformIOS) {
		t.Error("ios should be blocked")
	}
}

func TestSuccessMessage(t *testing.T) {
	rewards := models.GiftCodeRewards{
		{Type: models.GiftCodeRewardVipDays, Days: 7},
		{Type: models.GiftCodeRewardVipIcon, VipIconID: 15},
	}
	if got := SuccessMessage("Chúc mừng năm mới! Bạn nhận được {quà}.", rewards); got != "Chúc mừng năm mới! Bạn nhận được 7 ngày VIP và icon VIP." {
		t.Errorf("custom message: %q", got)
	}
	if got := SuccessMessage("  ", rewards[:1]); got != "Bạn nhận được 7 ngày VIP." {
		t.Errorf("default message: %q", got)
	}
	two := append(models.GiftCodeRewards{}, rewards[1], rewards[1])
	if got := RewardsText(two); got != "2 icon VIP" {
		t.Errorf("two icons: %q", got)
	}
}

func TestResolvedPlatform(t *testing.T) {
	cases := []struct {
		client setting.Client
		want   string
	}{
		{setting.Client{Platform: "Android"}, setting.PlatformAndroid},
		{setting.Client{Platform: "ios"}, setting.PlatformIOS},
		{setting.Client{Platform: "web"}, setting.PlatformWeb},
		{setting.Client{UserAgent: "okhttp/4.12.0"}, setting.PlatformAndroid},
		{setting.Client{UserAgent: "Mozilla/5.0 (iPhone)"}, setting.PlatformWeb},
		{setting.Client{Platform: "desktop"}, setting.PlatformWeb},
	}
	for _, tc := range cases {
		if got := tc.client.ResolvedPlatform(); got != tc.want {
			t.Errorf("ResolvedPlatform(%+v) = %s, want %s", tc.client, got, tc.want)
		}
	}
}
