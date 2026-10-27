package setting

import (
	"testing"

	"ola-chat-server/internal/models"
)

func TestMomentMediaPurgeDefaultsToDisabled(t *testing.T) {
	cfg := DefaultMomentMediaPurgeConfig()
	if cfg.Enabled || cfg.AfterHours != 72 {
		t.Fatalf("default config: %+v", cfg)
	}
}

func TestValidateMomentMediaPurgeValue(t *testing.T) {
	valid := []models.JSONB{
		{"enabled": true, "afterHours": MomentPurgeAfterHoursMin},
		{"enabled": false, "afterHours": MomentPurgeAfterHoursMax},
	}
	for _, value := range valid {
		if err := ValidateMomentMediaPurgeValue(value); err != nil {
			t.Fatalf("valid config rejected: %v (%v)", value, err)
		}
	}
	invalid := []models.JSONB{
		{"enabled": true, "afterHours": MomentPurgeAfterHoursMin - 1},
		{"enabled": true, "afterHours": MomentPurgeAfterHoursMax + 1},
		{"enabled": true, "afterHours": 24.5},
		{"enabled": true},
		{"afterHours": 48},
		{"enabled": true, "afterHours": 48, "batch": 10},
	}
	for _, value := range invalid {
		if err := ValidateMomentMediaPurgeValue(value); err == nil {
			t.Fatalf("invalid config accepted: %v", value)
		}
	}
}

func TestMomentDisplayDefaultsToEnabledEverywhere(t *testing.T) {
	cfg := DefaultMomentConfig()
	for _, platform := range []string{"web", "android", "ios"} {
		if !cfg.EnabledFor(platform, "1.0.0 (1)") {
			t.Fatalf("default moment config disabled on %s", platform)
		}
	}
}

func TestMomentDisplayEnabledFor(t *testing.T) {
	cfg := MomentConfig{
		Web:     PlatformRule{Enabled: true},
		Android: PlatformRule{Enabled: true, DisableVersions: []string{"1.0.1"}},
		IOS:     PlatformRule{Enabled: false},
	}
	cases := []struct {
		platform, version string
		want              bool
	}{
		{"web", "", true},
		{"android", "1.0.0 (45)", true},
		{"android", "1.0.1 (46)", false},
		{"ios", "1.0.0 (45)", false},
	}
	for _, tc := range cases {
		if got := cfg.EnabledFor(tc.platform, tc.version); got != tc.want {
			t.Fatalf("EnabledFor(%q, %q) = %v, want %v", tc.platform, tc.version, got, tc.want)
		}
	}
}

func TestMomentVideoDefaultsToOpen(t *testing.T) {
	if DefaultMomentVideoConfig().VipRequired {
		t.Fatal("moment video should not require VIP by default")
	}
}

func TestValidateMomentVideoValue(t *testing.T) {
	for _, value := range []models.JSONB{{"vipRequired": true}, {"vipRequired": false}} {
		if err := ValidateMomentVideoValue(value); err != nil {
			t.Fatalf("valid moment_video config rejected: %v (%v)", value, err)
		}
	}
	for _, value := range []models.JSONB{{}, {"vipRequired": "yes"}, {"vipRequired": true, "extra": 1}} {
		if err := ValidateMomentVideoValue(value); err == nil {
			t.Fatalf("invalid moment_video config accepted: %v", value)
		}
	}
}

func TestValidateMomentValue(t *testing.T) {
	valid := models.JSONB{"web": rule(true), "android": rule(true, "1.0.1"), "ios": rule(false)}
	if err := ValidateMomentValue(valid); err != nil {
		t.Fatalf("valid moment config rejected: %v", err)
	}
	invalid := []models.JSONB{
		{"web": rule(true), "android": rule(true, "abc"), "ios": rule(true)},
		{"web": "on"},
	}
	for _, value := range invalid {
		if err := ValidateMomentValue(value); err == nil {
			t.Fatalf("invalid moment config accepted: %v", value)
		}
	}
}
