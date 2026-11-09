package setting

import (
	"testing"

	"ola-chat-server/internal/models"
)

func openVipDayTransferValue() models.JSONB {
	return models.JSONB{"platforms": OpenPlatformRules(), "rate": 3, "minSenderDays": 10}
}

func TestVipDayTransferDefaults(t *testing.T) {
	cfg := DefaultVipDayTransferConfig()
	if cfg.Rate != 3 || cfg.MinSenderDays != 10 {
		t.Fatalf("default config: %+v", cfg)
	}
	for _, platform := range []string{PlatformWeb, PlatformAndroid, PlatformIOS} {
		if cfg.EnabledFor(Client{Platform: platform, AppVersion: "1.0.0"}) {
			t.Fatalf("%s must ship hidden", platform)
		}
	}
}

func TestVipDayTransferEnabledPerPlatform(t *testing.T) {
	cfg := DefaultVipDayTransferConfig()
	cfg.Platforms = OpenPlatformRules()
	cfg.Platforms.IOS.Enabled = false
	if cfg.EnabledFor(Client{Platform: PlatformIOS, AppVersion: "1.0.0"}) {
		t.Fatal("ios should be hidden")
	}
	public := cfg.PublicFor(Client{Platform: PlatformAndroid, AppVersion: "1.0.0"})
	if !public.Enabled || public.MinSenderDays != 10 || public.Rate != 3 {
		t.Fatalf("android public config: %+v", public)
	}
}

func TestVipDayTransferReceiverDaysRoundsUp(t *testing.T) {
	cfg := VipDayTransferConfig{Rate: 3, MinSenderDays: 10}
	for senderDays, want := range map[int]int{10: 4, 11: 4, 12: 4, 13: 5, 30: 10} {
		if got, ok := cfg.ReceiverDaysFor(senderDays); !ok || got != want {
			t.Fatalf("%d days at rate 3 = %d, %v, want %d", senderDays, got, ok, want)
		}
	}
	if got, ok := (VipDayTransferConfig{Rate: 1, MinSenderDays: 10}).ReceiverDaysFor(10); !ok || got != 10 {
		t.Fatalf("rate 1 = %d, %v", got, ok)
	}
	for _, invalid := range []int{-1, 0, 9, VipDayTransferMaxSenderDays + 1} {
		if _, ok := cfg.ReceiverDaysFor(invalid); ok {
			t.Fatalf("%d should be rejected", invalid)
		}
	}
	if got, ok := (VipDayTransferConfig{Rate: 3, MinSenderDays: 5}).ReceiverDaysFor(5); !ok || got != 2 {
		t.Fatalf("configured minimum 5 = %d, %v", got, ok)
	}
}

func TestValidateVipDayTransferValue(t *testing.T) {
	if err := ValidateVipDayTransferValue(openVipDayTransferValue()); err != nil {
		t.Fatal(err)
	}
	for name, change := range map[string]func(models.JSONB){
		"missing platforms": func(v models.JSONB) { delete(v, "platforms") },
		"missing rate":      func(v models.JSONB) { delete(v, "rate") },
		"missing minimum":   func(v models.JSONB) { delete(v, "minSenderDays") },
		"unknown field":     func(v models.JSONB) { v["minRemainingDays"] = 1 },
		"zero rate":         func(v models.JSONB) { v["rate"] = 0 },
		"rate too large":    func(v models.JSONB) { v["rate"] = vipDayTransferRateMax + 1 },
		"zero minimum":      func(v models.JSONB) { v["minSenderDays"] = 0 },
		"minimum too big":   func(v models.JSONB) { v["minSenderDays"] = VipDayTransferMaxSenderDays + 1 },
	} {
		value := openVipDayTransferValue()
		change(value)
		if err := ValidateVipDayTransferValue(value); err == nil {
			t.Fatalf("%s should fail", name)
		}
	}
}
