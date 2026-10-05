package setting

import (
	"strconv"
	"strings"
	"testing"

	"ola-chat-server/internal/models"
)

func rule(enabled bool, disableVersions ...string) map[string]interface{} {
	if disableVersions == nil {
		disableVersions = []string{}
	}
	return map[string]interface{}{"enabled": enabled, "disableVersions": disableVersions}
}

func storyValue(android, ios map[string]interface{}) models.JSONB {
	return models.JSONB{"web": rule(true), "android": android, "ios": ios}
}

func TestStoryEnabledFor(t *testing.T) {
	cfg := StoryConfig{
		Web:     PlatformRule{Enabled: true},
		Android: PlatformRule{Enabled: true, DisableVersions: []string{"1.0.1", "1.2"}},
		IOS:     PlatformRule{Enabled: false, DisableVersions: []string{}},
	}
	cases := []struct {
		platform, version string
		want              bool
	}{
		{"web", "15240093", true},
		{"", "", true},
		{"windows", "1.0.1", true},
		{"android", "1.0.0 (45)", true},
		{"android", "1.0.1 (46)", false},
		{"Android", "1.0.1", false},
		{"android", "1.2.0 (60)", false},
		{"android", "1.2.1 (61)", true},
		{"android", "", true},
		{"ios", "1.0.0 (12)", false},
	}
	for _, tc := range cases {
		if got := cfg.EnabledFor(tc.platform, tc.version); got != tc.want {
			t.Fatalf("EnabledFor(%q, %q) = %v, want %v", tc.platform, tc.version, got, tc.want)
		}
	}
	cfg.Web.Enabled = false
	if cfg.EnabledFor("", "") || cfg.EnabledFor("web", "") {
		t.Fatal("web disabled must hide story for requests without platform")
	}
}

func TestAppVersionName(t *testing.T) {
	cases := map[string]string{
		"1.0.0 (45)": "1.0.0",
		"2.1":        "2.1",
		" 1.0.3":     "1.0.3",
		"v1.0.0":     "",
		"":           "",
	}
	for in, want := range cases {
		if got := appVersionName(in); got != want {
			t.Fatalf("appVersionName(%q) = %q, want %q", in, got, want)
		}
	}
}

func TestValidateStoryValue(t *testing.T) {
	valid := []models.JSONB{
		storyValue(rule(true), rule(false)),
		storyValue(rule(true, "1.0.1", "1.0.2"), rule(true, "2.0")),
	}
	for i, value := range valid {
		if err := ValidateStoryValue(value); err != nil {
			t.Fatalf("valid case %d: %v", i, err)
		}
	}

	webWithVersions := storyValue(rule(true), rule(true))
	webWithVersions["web"] = rule(true, "1.0.0")
	missingIOS := storyValue(rule(true), rule(true))
	delete(missingIOS, "ios")
	oldShape := storyValue(rule(true), map[string]interface{}{"enabled": true, "minVersion": "1.0.0"})
	tooMany := make([]string, disableVersionsMax+1)
	for i := range tooMany {
		tooMany[i] = "1.0." + strconv.Itoa(i)
	}

	invalid := []struct {
		name  string
		value models.JSONB
		want  string
	}{
		{"bad version", storyValue(rule(true, "1.0.0 (45)"), rule(true)), "Android"},
		{"duplicate version", storyValue(rule(true), rule(true, "1.0", "1.0.0")), "hai lần"},
		{"too many", storyValue(rule(true, tooMany...), rule(true)), "tối đa"},
		{"web versions", webWithVersions, "web"},
		{"missing platform", missingIOS, "android và ios"},
		{"old min/max fields", oldShape, "unknown field"},
	}
	for _, tc := range invalid {
		err := ValidateStoryValue(tc.value)
		if err == nil || !strings.Contains(err.Error(), tc.want) {
			t.Fatalf("%s: got %v, want error containing %q", tc.name, err, tc.want)
		}
	}
}

func TestValidDisableVersionsDropsBadEntries(t *testing.T) {
	got := validDisableVersions([]string{"1.0.1", "x", "1.0.0 (3)", "2"})
	if strings.Join(got, ",") != "1.0.1,2" {
		t.Fatalf("got %v", got)
	}
	if got := validDisableVersions(nil); got == nil || len(got) != 0 {
		t.Fatalf("nil must become empty slice, got %#v", got)
	}
}
