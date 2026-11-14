package setting

import (
	"testing"

	"ola-chat-server/internal/models"
)

func oddsRules(web, android, ios bool) models.JSONB {
	return models.JSONB{
		"web":     map[string]interface{}{"enabled": web, "disableVersions": []interface{}{}},
		"android": map[string]interface{}{"enabled": android, "disableVersions": []interface{}{}},
		"ios":     map[string]interface{}{"enabled": ios, "disableVersions": []interface{}{}},
	}
}

func TestDefaultOddsRulesKeepCurrentBehavior(t *testing.T) {
	for _, rules := range []PlatformRules{DefaultOddsRules(), OddsRulesFrom(nil)} {
		cases := []struct {
			name   string
			client Client
			want   bool
		}{
			{"web", Client{Platform: PlatformWeb}, false},
			{"android", Client{Platform: PlatformAndroid, AppVersion: "1.2.0"}, true},
			{"ios", Client{Platform: PlatformIOS, AppVersion: "1.2.0"}, true},
			{"old app without header", Client{UserAgent: "okhttp/4.12.0"}, true},
		}
		for _, tc := range cases {
			if got := rules.EnabledForClient(tc.client); got != tc.want {
				t.Errorf("%s: got %v, want %v", tc.name, got, tc.want)
			}
		}
	}
}

func TestOddsRulesFromStoredValue(t *testing.T) {
	stored := models.JSONB{
		"web":     map[string]interface{}{"enabled": true},
		"android": map[string]interface{}{"enabled": false},
		"ios":     map[string]interface{}{"enabled": true, "disableVersions": []interface{}{"1.5.0", "abc"}},
	}
	rules := OddsRulesFrom(stored)
	if !rules.EnabledForClient(Client{Platform: PlatformWeb}) {
		t.Error("web should be visible")
	}
	if rules.EnabledForClient(Client{Platform: PlatformAndroid, AppVersion: "1.5.0"}) {
		t.Error("android should be hidden")
	}
	if rules.EnabledForClient(Client{Platform: PlatformIOS, AppVersion: "1.5.0 (12)"}) {
		t.Error("ios 1.5.0 should be hidden by disableVersions")
	}
	if !rules.EnabledForClient(Client{Platform: PlatformIOS, AppVersion: "1.6.0"}) {
		t.Error("ios 1.6.0 should be visible")
	}
	if got := rules.IOS.DisableVersions; len(got) != 1 || got[0] != "1.5.0" {
		t.Errorf("invalid versions should be dropped, got %v", got)
	}
}

func TestOddsRulesJSONBRoundTrip(t *testing.T) {
	rules := OddsRulesFrom(oddsRules(true, false, true))
	again := OddsRulesFrom(rules.JSONB())
	if again.Web.Enabled != true || again.Android.Enabled != false || again.IOS.Enabled != true {
		t.Errorf("round trip changed rules: %+v", again)
	}
}

func TestValidateOddsRules(t *testing.T) {
	if err := ValidateOddsRules(oddsRules(false, true, true)); err != nil {
		t.Fatalf("expected valid, got %v", err)
	}
	cases := map[string]models.JSONB{
		"missing platform": {"web": map[string]interface{}{"enabled": true}},
		"unknown field":    func() models.JSONB { v := oddsRules(true, true, true); v["pen"] = true; return v }(),
		"missing enabled":  {"web": map[string]interface{}{}, "android": map[string]interface{}{"enabled": true}, "ios": map[string]interface{}{"enabled": true}},
		"web versions": {
			"web":     map[string]interface{}{"enabled": true, "disableVersions": []interface{}{"1.0.0"}},
			"android": map[string]interface{}{"enabled": true},
			"ios":     map[string]interface{}{"enabled": true},
		},
		"bad version": {
			"web":     map[string]interface{}{"enabled": true},
			"android": map[string]interface{}{"enabled": true, "disableVersions": []interface{}{"abc"}},
			"ios":     map[string]interface{}{"enabled": true},
		},
	}
	for name, value := range cases {
		if err := ValidateOddsRules(value); err == nil {
			t.Errorf("%s: expected error", name)
		}
	}
}

func TestOddsRulesValue(t *testing.T) {
	value, err := OddsRulesValue(nil)
	if err != nil {
		t.Fatal(err)
	}
	if rules := OddsRulesFrom(value); rules.Web.Enabled || !rules.Android.Enabled || !rules.IOS.Enabled {
		t.Errorf("nil should give defaults, got %+v", rules)
	}
	if _, err := OddsRulesValue(models.JSONB{"web": map[string]interface{}{"enabled": true}}); err == nil {
		t.Error("incomplete rules should be rejected")
	}
}
