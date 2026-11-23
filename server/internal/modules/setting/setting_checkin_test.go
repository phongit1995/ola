package setting

import (
	"testing"

	"ola-chat-server/internal/models"
)

func isKnownTask(code string) bool { return code == "me_post" || code == "play_game" }

func TestValidateCheckinValue(t *testing.T) {
	valid := models.JSONB{"enabled": true, "popup": true, "requireEmailVerified": true, "randomTasks": []interface{}{"me_post", "play_game"}}
	if err := ValidateCheckinValue(valid, isKnownTask); err != nil {
		t.Fatalf("valid config rejected: %v", err)
	}
	cases := map[string]models.JSONB{
		"empty random tasks": {"enabled": true, "popup": true, "requireEmailVerified": true, "randomTasks": []interface{}{}},
		"unknown task":       {"enabled": true, "popup": true, "requireEmailVerified": true, "randomTasks": []interface{}{"chat"}},
		"duplicate task":     {"enabled": true, "popup": true, "requireEmailVerified": true, "randomTasks": []interface{}{"me_post", "me_post"}},
		"missing popup":      {"enabled": true, "requireEmailVerified": true, "randomTasks": []interface{}{"me_post"}},
		"unknown field":      {"enabled": true, "popup": true, "requireEmailVerified": true, "randomTasks": []interface{}{"me_post"}, "foo": 1},
	}
	for name, value := range cases {
		if err := ValidateCheckinValue(value, isKnownTask); err == nil {
			t.Errorf("%s: expected error", name)
		}
	}
}

func TestDefaultCheckinConfigIsOff(t *testing.T) {
	cfg := DefaultCheckinConfig()
	if cfg.Enabled || !cfg.Popup || !cfg.RequireEmailVerified {
		t.Fatalf("unexpected defaults %+v", cfg)
	}
}
