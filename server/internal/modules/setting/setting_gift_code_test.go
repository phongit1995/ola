package setting

import (
	"testing"

	"ola-chat-server/internal/models"
)

func TestGiftCodeDefaults(t *testing.T) {
	cfg := DefaultGiftCodeConfig()
	if !cfg.Enabled || !cfg.RequireEmailVerified {
		t.Fatalf("default config: %+v", cfg)
	}
	for _, platform := range []string{PlatformWeb, PlatformAndroid, PlatformIOS} {
		if !cfg.EnabledFor(Client{Platform: platform, AppVersion: "1.0.0"}) {
			t.Fatalf("default config should be open on %s", platform)
		}
	}
}

func TestGiftCodeEnabledForPlatform(t *testing.T) {
	cfg := DefaultGiftCodeConfig()
	cfg.Platforms.IOS.Enabled = false
	if cfg.EnabledFor(Client{Platform: PlatformIOS, AppVersion: "1.0.0"}) {
		t.Fatal("ios should be hidden")
	}
	if !cfg.EnabledFor(Client{Platform: PlatformAndroid, AppVersion: "1.0.0"}) {
		t.Fatal("android should stay open")
	}
	cfg.Enabled = false
	if cfg.EnabledFor(Client{Platform: PlatformWeb}) {
		t.Fatal("master switch off should hide every platform")
	}
}

func TestValidateGiftCodeValue(t *testing.T) {
	for _, value := range []models.JSONB{
		{"enabled": true, "requireEmailVerified": true},
		{"enabled": false, "requireEmailVerified": false, "platforms": map[string]interface{}{
			"web":     map[string]interface{}{"enabled": true, "disableVersions": []string{}},
			"android": map[string]interface{}{"enabled": true, "disableVersions": []string{"1.0.0"}},
			"ios":     map[string]interface{}{"enabled": false, "disableVersions": []string{}},
		}},
	} {
		if err := ValidateGiftCodeValue(value); err != nil {
			t.Fatalf("valid config rejected: %v (%v)", value, err)
		}
	}
	for _, value := range []models.JSONB{
		{},
		{"enabled": true},
		{"requireEmailVerified": true},
		{"enabled": true, "requireEmailVerified": "yes"},
		{"enabled": true, "requireEmailVerified": true, "extra": 1},
		{"enabled": true, "requireEmailVerified": true, "platforms": map[string]interface{}{
			"ios": map[string]interface{}{"enabled": false, "disableVersions": []string{}},
		}},
	} {
		if err := ValidateGiftCodeValue(value); err == nil {
			t.Fatalf("invalid config accepted: %v", value)
		}
	}
}
