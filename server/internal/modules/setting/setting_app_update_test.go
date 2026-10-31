package setting

import (
	"strconv"
	"testing"

	"ola-chat-server/internal/models"
)

func TestAppUpdateRequiredFor(t *testing.T) {
	cfg := AppUpdateConfig{
		Android: []string{"1.0.3", "1.0.4", "1.1"},
		IOS:     []string{"1.0.2"},
	}
	cases := []struct {
		name, platform, version string
		want                    bool
	}{
		{"listed", "android", "1.0.3 (40)", true},
		{"listed without build", "Android", "1.0.4", true},
		{"trailing zero matches", "android", "1.1.0 (60)", true},
		{"not listed", "android", "1.0.5 (45)", false},
		{"older but not listed", "android", "1.0.0 (1)", false},
		{"ios listed", "ios", "1.0.2 (12)", true},
		{"ios uses its own list", "ios", "1.0.3 (13)", false},
		{"web", "web", "1.0.3", false},
		{"no platform", "", "1.0.3", false},
		{"no version", "android", "", false},
		{"unreadable version", "android", "v1.0.3", false},
	}
	for _, tc := range cases {
		if got := cfg.RequiredFor(Client{Platform: tc.platform, AppVersion: tc.version}); got != tc.want {
			t.Fatalf("%s: RequiredFor(%q, %q) = %v, want %v", tc.name, tc.platform, tc.version, got, tc.want)
		}
	}
	if (AppUpdateConfig{}).RequiredFor(Client{Platform: "android", AppVersion: "0.0.1"}) {
		t.Fatal("empty config must never require an update")
	}
}

func TestValidateAppUpdateValue(t *testing.T) {
	valid := []models.JSONB{
		{"android": []string{}, "ios": []string{}},
		{"android": []string{"1.0.3", "1.0.4"}, "ios": []string{"1.0.2"}},
		{"ios": []string{"2"}},
		{},
	}
	for i, value := range valid {
		if err := ValidateAppUpdateValue(value); err != nil {
			t.Fatalf("valid[%d]: %v", i, err)
		}
	}

	tooMany := make([]string, disableVersionsMax+1)
	for i := range tooMany {
		tooMany[i] = "1.0." + strconv.Itoa(i)
	}
	invalid := []struct {
		name  string
		value models.JSONB
	}{
		{"bad version", models.JSONB{"android": []string{"1.0.x"}}},
		{"untrimmed version", models.JSONB{"ios": []string{" 1.0.0"}}},
		{"duplicate", models.JSONB{"android": []string{"1.1", "1.1.0"}}},
		{"too many", models.JSONB{"android": tooMany}},
		{"not a list", models.JSONB{"android": map[string]interface{}{"minVersion": "1.0.0"}}},
		{"unknown field", models.JSONB{"android": []string{}, "message": "x"}},
	}
	for _, tc := range invalid {
		if err := ValidateAppUpdateValue(tc.value); err == nil {
			t.Fatalf("%s: expected an error", tc.name)
		}
	}
}
