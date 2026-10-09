package setting

import (
	"testing"

	"ola-chat-server/internal/models"
)

func tieredTopupConfig() TopupConfig {
	return TopupConfig{BonusTiers: []TopupBonusTier{
		{MinAmount: 500_000, Percent: 20},
		{MinAmount: 100_000, Percent: 10},
	}}
}

func TestTopupConfigQuoteKen(t *testing.T) {
	cfg := tieredTopupConfig()
	cases := []struct {
		amount  int64
		percent int
		bonus   int64
		total   int64
	}{
		{50_000, 0, 0, 50_000},
		{99_999, 0, 0, 99_999},
		{100_000, 10, 10_000, 110_000},
		{123_456, 10, 12_345, 135_801},
		{499_999, 10, 49_999, 549_998},
		{500_000, 20, 100_000, 600_000},
		{1_000_000_000, 20, 200_000_000, 1_200_000_000},
	}
	for _, tc := range cases {
		quote := cfg.QuoteKen(tc.amount)
		if quote.Base != tc.amount || quote.BonusPercent != tc.percent || quote.Bonus != tc.bonus || quote.Total != tc.total {
			t.Fatalf("amount %d: got %+v, want percent=%d bonus=%d total=%d", tc.amount, quote, tc.percent, tc.bonus, tc.total)
		}
	}
}

func TestTopupConfigQuoteKenWithoutTiers(t *testing.T) {
	quote := DefaultTopupConfig().QuoteKen(70_000)
	if quote.Total != 70_000 || quote.Bonus != 0 || quote.BonusPercent != 0 {
		t.Fatalf("expected 1:1 without tiers, got %+v", quote)
	}
}

func TestNormalizeBonusTiers(t *testing.T) {
	tiers := normalizeBonusTiers([]TopupBonusTier{
		{MinAmount: 500_000, Percent: 20},
		{MinAmount: -1, Percent: 5},
		{MinAmount: 100_000, Percent: 10},
		{MinAmount: 100_000, Percent: 99},
		{MinAmount: 200_000, Percent: 501},
		{MinAmount: 300_000, Percent: -1},
	})
	want := []TopupBonusTier{{MinAmount: 100_000, Percent: 10}, {MinAmount: 500_000, Percent: 20}}
	if len(tiers) != len(want) {
		t.Fatalf("got %+v, want %+v", tiers, want)
	}
	for i := range want {
		if tiers[i] != want[i] {
			t.Fatalf("got %+v, want %+v", tiers, want)
		}
	}
	if normalizeBonusTiers(nil) == nil {
		t.Fatal("nil tiers must normalize to an empty slice")
	}
}

func validTopupValue() models.JSONB {
	return models.JSONB{
		"enabled":       true,
		"enabledMobile": true,
		"platforms":     map[string]interface{}{"web": rule(true), "android": rule(true), "ios": rule(false, "1.0.3")},
		"minAmount":     10_000,
		"stepAmount":    1_000,
		"presetAmounts": []interface{}{10_000, 50_000},
		"bonusTiers": []interface{}{
			map[string]interface{}{"minAmount": 100_000, "percent": 10},
		},
	}
}

func TestValidateTopupValue(t *testing.T) {
	if err := ValidateTopupValue(validTopupValue()); err != nil {
		t.Fatalf("expected valid, got %v", err)
	}
	noTiers := validTopupValue()
	noTiers["bonusTiers"] = []interface{}{}
	if err := ValidateTopupValue(noTiers); err != nil {
		t.Fatalf("empty tiers must be valid, got %v", err)
	}
	oldAdmin := validTopupValue()
	delete(oldAdmin, "platforms")
	if err := ValidateTopupValue(oldAdmin); err != nil {
		t.Fatalf("payload from an admin page without platforms must stay valid, got %v", err)
	}

	cases := map[string]func(models.JSONB){
		"unknown field":    func(v models.JSONB) { v["kenPerVnd"] = 2 },
		"zero min":         func(v models.JSONB) { v["minAmount"] = 0 },
		"zero step":        func(v models.JSONB) { v["stepAmount"] = 0 },
		"min not multiple": func(v models.JSONB) { v["minAmount"] = 10_500 },
		"no presets":       func(v models.JSONB) { v["presetAmounts"] = []interface{}{} },
		"preset below min": func(v models.JSONB) { v["presetAmounts"] = []interface{}{5_000} },
		"preset not step":  func(v models.JSONB) { v["presetAmounts"] = []interface{}{10_500} },
		"negative percent": func(v models.JSONB) {
			v["bonusTiers"] = []interface{}{map[string]interface{}{"minAmount": 0, "percent": -1}}
		},
		"percent too high": func(v models.JSONB) {
			v["bonusTiers"] = []interface{}{map[string]interface{}{"minAmount": 0, "percent": 501}}
		},
		"negative tier min": func(v models.JSONB) {
			v["bonusTiers"] = []interface{}{map[string]interface{}{"minAmount": -5, "percent": 1}}
		},
		"duplicate tier": func(v models.JSONB) {
			v["bonusTiers"] = []interface{}{
				map[string]interface{}{"minAmount": 100_000, "percent": 10},
				map[string]interface{}{"minAmount": 100_000, "percent": 20},
			}
		},
		"tier unknown field": func(v models.JSONB) {
			v["bonusTiers"] = []interface{}{map[string]interface{}{"minAmount": 0, "percent": 1, "label": "x"}}
		},
		"null platforms": func(v models.JSONB) { v["platforms"] = nil },
		"missing ios": func(v models.JSONB) {
			v["platforms"] = map[string]interface{}{"web": rule(true), "android": rule(true)}
		},
		"platform without enabled": func(v models.JSONB) {
			v["platforms"] = map[string]interface{}{
				"web": rule(true), "android": rule(true), "ios": map[string]interface{}{"disableVersions": []string{}},
			}
		},
		"platform unknown field": func(v models.JSONB) {
			v["platforms"] = map[string]interface{}{
				"web": rule(true), "android": rule(true), "ios": map[string]interface{}{"enabled": true, "minVersion": "1.0"},
			}
		},
		"bad version": func(v models.JSONB) {
			v["platforms"] = map[string]interface{}{"web": rule(true), "android": rule(true, "1.0.0 (45)"), "ios": rule(true)}
		},
		"web versions": func(v models.JSONB) {
			v["platforms"] = map[string]interface{}{"web": rule(true, "1.0.0"), "android": rule(true), "ios": rule(true)}
		},
	}
	for name, mutate := range cases {
		value := validTopupValue()
		mutate(value)
		if err := ValidateTopupValue(value); err == nil {
			t.Fatalf("%s: expected error", name)
		}
	}
}

const (
	androidAppUA = "okhttp/4.12.0"
	iosAppUA     = "OlaMobile/1 CFNetwork/1494.0.7 Darwin/23.4.0"
	browserUA    = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Mobile/15E148 Safari/604.1"
)

func TestTopupAccessForPlatformRules(t *testing.T) {
	cfg := TopupConfig{
		Enabled:       true,
		EnabledMobile: false,
		Platforms: &PlatformRules{
			Web:     PlatformRule{Enabled: true},
			Android: PlatformRule{Enabled: false, DisableVersions: []string{"1.0.1"}},
			IOS:     PlatformRule{Enabled: true, DisableVersions: []string{"1.0.3"}},
		},
	}
	cases := []struct {
		platform, version string
		want              bool
	}{
		{"web", "15240093", true},
		{"android", "1.0.0 (45)", false},
		{"ios", "1.0.2 (12)", true},
		{"ios", "1.0.3 (13)", false},
		{"IOS", "1.0.3", false},
		{"ios", "", false},
	}
	for _, tc := range cases {
		got := cfg.AccessFor(tc.platform, tc.version, iosAppUA)
		want := TopupAccess{Enabled: tc.want, EnabledMobile: tc.want, ShowBank: tc.want}
		if got != want {
			t.Fatalf("AccessFor(%q, %q) = %+v, want %+v", tc.platform, tc.version, got, want)
		}
	}

	cfg.Enabled = false
	if got := cfg.AccessFor("web", "", browserUA); got != (TopupAccess{}) {
		t.Fatalf("master switch off must hide topup everywhere, got %+v", got)
	}
}

func TestTopupAccessForLegacyClients(t *testing.T) {
	cfg := TopupConfig{
		Enabled:       true,
		EnabledMobile: false,
		Platforms:     &PlatformRules{Web: PlatformRule{Enabled: false}, Android: PlatformRule{Enabled: true}, IOS: PlatformRule{Enabled: true}},
	}
	cases := []struct {
		name      string
		mobile    bool
		userAgent string
		want      TopupAccess
	}{
		{"android app, mobile off", false, androidAppUA, TopupAccess{Enabled: true, EnabledMobile: false, ShowBank: false}},
		{"ios app, mobile off", false, iosAppUA, TopupAccess{Enabled: true, EnabledMobile: false, ShowBank: false}},
		{"browser, mobile off", false, browserUA, TopupAccess{Enabled: true, EnabledMobile: false, ShowBank: true}},
		{"android app, mobile on", true, androidAppUA, TopupAccess{Enabled: true, EnabledMobile: true, ShowBank: true}},
	}
	for _, tc := range cases {
		cfg.EnabledMobile = tc.mobile
		if got := cfg.AccessFor("", "", tc.userAgent); got != tc.want {
			t.Fatalf("%s: got %+v, want %+v", tc.name, got, tc.want)
		}
	}
}

func TestTopupAccessForStoredWithoutPlatforms(t *testing.T) {
	cfg := TopupConfig{Enabled: true, EnabledMobile: false}
	if got := cfg.AccessFor("web", "", browserUA); !got.Enabled || !got.ShowBank {
		t.Fatalf("web must stay visible when only mobile was off, got %+v", got)
	}
	for _, platform := range []string{"android", "ios"} {
		if got := cfg.AccessFor(platform, "1.0.0 (1)", androidAppUA); got.Enabled || got.ShowBank {
			t.Fatalf("%s must follow the old mobile switch, got %+v", platform, got)
		}
	}
	cfg.EnabledMobile = true
	if got := cfg.AccessFor("ios", "1.0.0 (1)", iosAppUA); !got.Enabled {
		t.Fatalf("ios must be visible when the old mobile switch is on, got %+v", got)
	}
}
