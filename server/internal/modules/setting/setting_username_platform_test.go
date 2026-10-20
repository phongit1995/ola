package setting

import "testing"

func TestUsernameChangeEnabledForPlatformRules(t *testing.T) {
	cfg := UsernameChangeConfig{
		Enabled:       true,
		EnabledMobile: true,
		Platforms: &PlatformRules{
			Web:     PlatformRule{Enabled: true},
			Android: PlatformRule{Enabled: false},
			IOS:     PlatformRule{Enabled: true, DisableVersions: []string{"1.0.3"}},
		},
	}
	cases := []struct {
		platform, version string
		want              bool
	}{
		{"web", "", true},
		{"android", "1.0.0 (45)", false},
		{"ios", "1.0.2 (12)", true},
		{"ios", "1.0.3 (13)", false},
	}
	for _, tc := range cases {
		if got := cfg.EnabledFor(Client{Platform: tc.platform, AppVersion: tc.version, UserAgent: iosAppUA}); got != tc.want {
			t.Fatalf("EnabledFor(%q, %q) = %v, want %v", tc.platform, tc.version, got, tc.want)
		}
	}

	cfg.Enabled = false
	if cfg.EnabledFor(Client{Platform: "web", UserAgent: browserUA}) {
		t.Fatal("master switch off must block username change everywhere")
	}
}

func TestUsernameChangeEnabledForLegacyClients(t *testing.T) {
	cfg := UsernameChangeConfig{Enabled: true, EnabledMobile: false}
	if cfg.EnabledFor(Client{UserAgent: androidAppUA}) {
		t.Fatal("old android build must follow the mobile switch")
	}
	if cfg.EnabledFor(Client{UserAgent: iosAppUA}) {
		t.Fatal("old ios build must follow the mobile switch")
	}
	if !cfg.EnabledFor(Client{UserAgent: browserUA}) {
		t.Fatal("browser without X-Platform stays on when only mobile is off")
	}
	webOff := cfg
	webOff.EnabledMobile = true
	webOff.Platforms = &PlatformRules{Web: PlatformRule{Enabled: false}, Android: PlatformRule{Enabled: true}, IOS: PlatformRule{Enabled: true}}
	if webOff.EnabledFor(Client{UserAgent: browserUA}) {
		t.Fatal("request without X-Platform from a non-app client must follow the web rule")
	}
	if !webOff.EnabledFor(Client{UserAgent: androidAppUA}) {
		t.Fatal("old app build must follow the legacy switch, not the web rule")
	}
	for _, platform := range []string{"android", "ios"} {
		if cfg.EnabledFor(Client{Platform: platform, AppVersion: "1.0.0 (1)", UserAgent: androidAppUA}) {
			t.Fatalf("%s without stored platforms must follow the mobile switch", platform)
		}
	}
}

func TestValidateUsernameChangePlatforms(t *testing.T) {
	base := func(platforms interface{}) map[string]interface{} {
		value := map[string]interface{}{
			"enabled":       true,
			"enabledMobile": true,
			"tiers":         []interface{}{map[string]interface{}{"minLength": 2, "cost": 100}},
		}
		if platforms != nil {
			value["platforms"] = platforms
		}
		return value
	}
	open := map[string]interface{}{
		"web":     map[string]interface{}{"enabled": true, "disableVersions": []string{}},
		"android": map[string]interface{}{"enabled": false, "disableVersions": []string{"1.0.1"}},
		"ios":     map[string]interface{}{"enabled": true, "disableVersions": []string{}},
	}
	if err := ValidateUsernameChangeValue(base(nil)); err != nil {
		t.Fatalf("config without platforms must stay valid: %v", err)
	}
	if err := ValidateUsernameChangeValue(base(open)); err != nil {
		t.Fatalf("valid platforms rejected: %v", err)
	}
	missingIOS := map[string]interface{}{"web": open["web"], "android": open["android"]}
	if err := ValidateUsernameChangeValue(base(missingIOS)); err == nil {
		t.Fatal("platforms without ios must be rejected")
	}
	badVersion := map[string]interface{}{"web": open["web"], "android": map[string]interface{}{"enabled": true, "disableVersions": []string{"abc"}}, "ios": open["ios"]}
	if err := ValidateUsernameChangeValue(base(badVersion)); err == nil {
		t.Fatal("invalid disable version must be rejected")
	}
}
