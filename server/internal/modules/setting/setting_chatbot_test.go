package setting

import (
	"strings"
	"testing"

	"ola-chat-server/internal/constants"
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
					constants.ChatBotTypeOlala: map[string]interface{}{"enabled": true, "systemPrompt": "Bạn là Olala", "identityReminder": ""},
					constants.ChatBotTypeOlavi: map[string]interface{}{"enabled": false},
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
				"bots":       map[string]interface{}{constants.ChatBotTypeOlala: map[string]interface{}{"systemPrompt": "x"}},
			},
			wantErr: true,
		},
		{
			name: "prompt too long",
			value: models.JSONB{
				"dailyLimit": 10,
				"bots": map[string]interface{}{
					constants.ChatBotTypeOlala: map[string]interface{}{"enabled": true, "systemPrompt": strings.Repeat("a", chatBotPromptMaxRunes+1)},
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
	cfg := ChatBotConfig{Bots: map[string]ChatBotBotConfig{constants.ChatBotTypeOlavi: {Enabled: false}}}
	if !cfg.Bot(constants.ChatBotTypeOlala).Enabled {
		t.Fatal("bot missing from config should be enabled")
	}
	if cfg.Bot(constants.ChatBotTypeOlavi).Enabled {
		t.Fatal("explicitly disabled bot should stay disabled")
	}
}
