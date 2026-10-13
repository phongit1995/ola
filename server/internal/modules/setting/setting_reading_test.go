package setting

import (
	"testing"

	"ola-chat-server/internal/models"
)

func TestStoryReadingDefaultsToTenFreeChapters(t *testing.T) {
	cfg := DefaultStoryReadingConfig()
	if !cfg.Enabled || cfg.FreeChaptersPerDay != 10 {
		t.Fatalf("default config: %+v", cfg)
	}
}

func TestValidateStoryReadingValue(t *testing.T) {
	valid := models.JSONB{"enabled": true, "freeChaptersPerDay": 0, "commentUnlockMinChars": 20}
	if err := ValidateStoryReadingValue(valid); err != nil {
		t.Fatalf("valid config rejected: %v", err)
	}
	invalid := []models.JSONB{
		{"enabled": true, "freeChaptersPerDay": 10},
		{"enabled": true, "freeChaptersPerDay": -1, "commentUnlockMinChars": 20},
		{"enabled": true, "freeChaptersPerDay": storyFreeChaptersMax + 1, "commentUnlockMinChars": 20},
		{"enabled": true, "freeChaptersPerDay": 10, "commentUnlockMinChars": 0},
		{"enabled": true, "freeChaptersPerDay": 10, "commentUnlockMinChars": storyUnlockCharsMax + 1},
		{"enabled": true, "freeChaptersPerDay": 10, "commentUnlockMinChars": 20, "price": 5},
	}
	for _, value := range invalid {
		if err := ValidateStoryReadingValue(value); err == nil {
			t.Fatalf("invalid config accepted: %v", value)
		}
	}
}
