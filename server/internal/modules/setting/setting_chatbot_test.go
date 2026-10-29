package setting

import (
	"strings"
	"testing"

	"ola-chat-server/internal/models"
)

func TestValidateChatBotValue(t *testing.T) {
	cases := []struct {
		name    string
		value   models.JSONB
		wantErr bool
	}{
		{
			name: "valid config",
			value: models.JSONB{
				"dailyLimit": 50,
				"bots": map[string]interface{}{
					ChatBotTypeOlala: map[string]interface{}{"enabled": true, "systemPrompt": "Bạn là Olala", "identityReminder": ""},
					ChatBotTypeOlavi: map[string]interface{}{"enabled": false},
				},
			},
		},
		{name: "unlimited without bots", value: models.JSONB{"dailyLimit": 0}},
		{name: "missing dailyLimit", value: models.JSONB{"bots": map[string]interface{}{}}, wantErr: true},
		{name: "negative dailyLimit", value: models.JSONB{"dailyLimit": -1}, wantErr: true},
		{name: "dailyLimit too large", value: models.JSONB{"dailyLimit": chatBotDailyLimitMax + 1}, wantErr: true},
		{
			name: "unknown bot",
			value: models.JSONB{
				"dailyLimit": 10,
				"bots":       map[string]interface{}{"OTHER": map[string]interface{}{"enabled": true}},
			},
			wantErr: true,
		},
		{
			name: "bot without enabled",
			value: models.JSONB{
				"dailyLimit": 10,
				"bots":       map[string]interface{}{ChatBotTypeOlala: map[string]interface{}{"systemPrompt": "x"}},
			},
			wantErr: true,
		},
		{
			name: "prompt too long",
			value: models.JSONB{
				"dailyLimit": 10,
				"bots": map[string]interface{}{
					ChatBotTypeOlala: map[string]interface{}{"enabled": true, "systemPrompt": strings.Repeat("a", chatBotPromptMaxRunes+1)},
				},
			},
			wantErr: true,
		},
		{name: "unknown field", value: models.JSONB{"dailyLimit": 10, "extra": true}, wantErr: true},
	}

	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			err := ValidateChatBotValue(tc.value)
			if (err != nil) != tc.wantErr {
				t.Fatalf("ValidateChatBotValue() error = %v, wantErr %v", err, tc.wantErr)
			}
		})
	}
}

func TestChatBotConfigBotDefaultsToEnabled(t *testing.T) {
	cfg := ChatBotConfig{Bots: map[string]ChatBotBotConfig{ChatBotTypeOlavi: {Enabled: false}}}
	if !cfg.Bot(ChatBotTypeOlala).Enabled {
		t.Fatal("bot missing from config should be enabled")
	}
	if cfg.Bot(ChatBotTypeOlavi).Enabled {
		t.Fatal("explicitly disabled bot should stay disabled")
	}
}

const (
	androidAppUA = "okhttp/4.12.0"
	iosAppUA     = "OlaMobile/1 CFNetwork/1494.0.7 Darwin/23.4.0"
	browserUA    = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Mobile/15E148 Safari/604.1"
)

func TestChatBotEnabledForPlatforms(t *testing.T) {
	bot := ChatBotBotConfig{
		Enabled: true,
		Platforms: &PlatformRules{
			Web:     PlatformRule{Enabled: true},
			Android: PlatformRule{Enabled: true, DisableVersions: []string{"1.0.5"}},
			IOS:     PlatformRule{Enabled: false},
		},
	}
	cases := []struct {
		name   string
		client Client
		want   bool
	}{
		{"web", Client{Platform: "web", UserAgent: browserUA}, true},
		{"android", Client{Platform: "android", AppVersion: "1.0.4 (40)", UserAgent: androidAppUA}, true},
		{"android blocked version", Client{Platform: "android", AppVersion: "1.0.5 (41)", UserAgent: androidAppUA}, false},
		{"ios off", Client{Platform: "ios", AppVersion: "1.0.4 (40)", UserAgent: iosAppUA}, false},
		{"old android build without header", Client{UserAgent: androidAppUA}, true},
		{"old ios build without header", Client{UserAgent: iosAppUA}, false},
		{"browser without header", Client{UserAgent: browserUA}, true},
	}
	for _, tc := range cases {
		if got := bot.EnabledFor(tc.client); got != tc.want {
			t.Fatalf("%s: EnabledFor = %v, want %v", tc.name, got, tc.want)
		}
	}

	if (ChatBotBotConfig{Enabled: false, Platforms: bot.Platforms}).EnabledFor(Client{Platform: "web"}) {
		t.Fatal("master switch off must win over platform rules")
	}
	if !(ChatBotBotConfig{Enabled: true}).EnabledFor(Client{Platform: "ios", AppVersion: "1.0.0"}) {
		t.Fatal("bot without platform rules stays on everywhere")
	}
}

func TestValidateChatBotPlatforms(t *testing.T) {
	withPlatforms := func(platforms interface{}) models.JSONB {
		return models.JSONB{
			"dailyLimit": 0,
			"bots": map[string]interface{}{
				ChatBotTypeOlala: map[string]interface{}{"enabled": true, "platforms": platforms},
			},
		}
	}
	valid := map[string]interface{}{
		"web":     map[string]interface{}{"enabled": true, "disableVersions": []string{}},
		"android": map[string]interface{}{"enabled": true, "disableVersions": []string{"1.0.5"}},
		"ios":     map[string]interface{}{"enabled": false, "disableVersions": []string{}},
	}
	if err := ValidateChatBotValue(withPlatforms(valid)); err != nil {
		t.Fatalf("valid platforms rejected: %v", err)
	}
	if err := ValidateChatBotValue(withPlatforms(map[string]interface{}{"web": valid["web"]})); err == nil {
		t.Fatal("platforms missing android and ios must be rejected")
	}
	if err := ValidateChatBotValue(withPlatforms(map[string]interface{}{"web": valid["web"], "android": valid["android"], "ios": valid["ios"], "tv": valid["web"]})); err == nil {
		t.Fatal("unknown platform must be rejected")
	}
}
