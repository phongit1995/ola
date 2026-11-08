package setting

import (
	"encoding/json"
	"testing"

	"ola-chat-server/internal/models"
)

func validGiftValue() models.JSONB {
	return models.JSONB{
		"enabled":         true,
		"quantityOptions": []interface{}{1, 5, 10, 99},
		"quantityMax":     99,
		"noteMaxLength":   100,
		"confirmOverKen":  1000,
	}
}

func TestValidateGiftValueAcceptsDefault(t *testing.T) {
	if err := ValidateGiftValue(validGiftValue()); err != nil {
		t.Fatalf("expected valid, got %v", err)
	}
	if err := validateGiftConfig(DefaultGiftConfig()); err != nil {
		t.Fatalf("default config must be valid: %v", err)
	}
}

func TestValidateGiftValueRejectsBadConfig(t *testing.T) {
	cases := map[string]func(models.JSONB){
		"missing enabled":       func(v models.JSONB) { delete(v, "enabled") },
		"unknown field":         func(v models.JSONB) { v["ratePerMinute"] = 20 },
		"quantityMax zero":      func(v models.JSONB) { v["quantityMax"] = 0 },
		"quantityMax too big":   func(v models.JSONB) { v["quantityMax"] = GiftQuantityMaxLimit + 1 },
		"note too long":         func(v models.JSONB) { v["noteMaxLength"] = GiftNoteMaxLengthLimit + 1 },
		"negative confirm":      func(v models.JSONB) { v["confirmOverKen"] = -1 },
		"no options":            func(v models.JSONB) { v["quantityOptions"] = []interface{}{} },
		"option above max":      func(v models.JSONB) { v["quantityOptions"] = []interface{}{1, 100} },
		"options not ascending": func(v models.JSONB) { v["quantityOptions"] = []interface{}{5, 1} },
		"duplicate options":     func(v models.JSONB) { v["quantityOptions"] = []interface{}{1, 1} },
		"too many options":      func(v models.JSONB) { v["quantityOptions"] = []interface{}{1, 2, 3, 4, 5, 6, 7} },
		"option zero":           func(v models.JSONB) { v["quantityOptions"] = []interface{}{0, 1} },
	}
	for name, mutate := range cases {
		v := validGiftValue()
		mutate(v)
		if err := ValidateGiftValue(v); err == nil {
			t.Fatalf("%s: expected error", name)
		}
	}
}

func platformsValue(iosEnabled bool, iosVersions ...interface{}) map[string]interface{} {
	return map[string]interface{}{
		"web":     map[string]interface{}{"enabled": true, "disableVersions": []interface{}{}},
		"android": map[string]interface{}{"enabled": true, "disableVersions": []interface{}{}},
		"ios":     map[string]interface{}{"enabled": iosEnabled, "disableVersions": iosVersions},
	}
}

func TestValidateGiftValuePlatforms(t *testing.T) {
	value := validGiftValue()
	value["platforms"] = platformsValue(false)
	if err := ValidateGiftValue(value); err != nil {
		t.Fatalf("expected valid, got %v", err)
	}

	value["platforms"] = map[string]interface{}{"web": map[string]interface{}{"enabled": true}}
	if err := ValidateGiftValue(value); err == nil {
		t.Fatal("expected incomplete platforms to be rejected")
	}

	value["platforms"] = platformsValue(true, "not-a-version")
	if err := ValidateGiftValue(value); err == nil {
		t.Fatal("expected a bad version to be rejected")
	}
}

func TestGiftEnabledForFollowsPlatformAndMasterSwitch(t *testing.T) {
	cfg := DefaultGiftConfig()
	cfg.Platforms.IOS.Enabled = false
	cfg.Platforms.Android.DisableVersions = []string{"1.2.0"}

	cases := []struct {
		name   string
		client Client
		want   bool
	}{
		{"web", Client{Platform: "web"}, true},
		{"ios off", Client{Platform: PlatformIOS, AppVersion: "1.2.0"}, false},
		{"android other build", Client{Platform: PlatformAndroid, AppVersion: "1.3.0"}, true},
		{"android disabled build", Client{Platform: PlatformAndroid, AppVersion: "1.2.0 (45)"}, false},
	}
	for _, tc := range cases {
		if got := cfg.EnabledFor(tc.client); got != tc.want {
			t.Fatalf("%s: enabled = %v, want %v", tc.name, got, tc.want)
		}
		if got := cfg.PublicFor(tc.client).Enabled; got != tc.want {
			t.Fatalf("%s: public enabled = %v, want %v", tc.name, got, tc.want)
		}
	}

	cfg.Enabled = false
	if cfg.EnabledFor(Client{Platform: "web"}) {
		t.Fatal("master switch off must win over an open platform")
	}
}

func TestStoredGiftWithoutPlatformsStaysOpen(t *testing.T) {
	cfg := DefaultGiftConfig()
	if err := json.Unmarshal([]byte(`{"enabled":true,"quantityOptions":[1],"quantityMax":9,"noteMaxLength":10,"confirmOverKen":5}`), &cfg); err != nil {
		t.Fatal(err)
	}
	for _, platform := range []string{"web", PlatformAndroid, PlatformIOS} {
		if !cfg.EnabledFor(Client{Platform: platform, AppVersion: "1.0.0"}) {
			t.Fatalf("%s must stay enabled for a row saved before platforms existed", platform)
		}
	}
}
