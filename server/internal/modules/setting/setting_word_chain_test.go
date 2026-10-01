package setting

import (
	"testing"

	"ola-chat-server/internal/models"
)

func TestDefaultWordChainConfigShowsRoomAt500Ken(t *testing.T) {
	cfg := DefaultWordChainConfig()
	if !cfg.Enabled || cfg.HintPrice != 500 {
		t.Fatalf("default = %+v, want enabled with 500 KEN hints", cfg)
	}
}

func TestValidateWordChainValue(t *testing.T) {
	cases := []struct {
		name  string
		value models.JSONB
		ok    bool
	}{
		{"valid", models.JSONB{"enabled": false, "hintPrice": 1000}, true},
		{"min price", models.JSONB{"enabled": true, "hintPrice": 1}, true},
		{"max price", models.JSONB{"enabled": true, "hintPrice": wordChainHintPriceMax}, true},
		{"zero price", models.JSONB{"enabled": true, "hintPrice": 0}, false},
		{"negative price", models.JSONB{"enabled": true, "hintPrice": -5}, false},
		{"too expensive", models.JSONB{"enabled": true, "hintPrice": wordChainHintPriceMax + 1}, false},
		{"fraction", models.JSONB{"enabled": true, "hintPrice": 1.5}, false},
		{"missing enabled", models.JSONB{"hintPrice": 500}, false},
		{"missing price", models.JSONB{"enabled": true}, false},
		{"unknown field", models.JSONB{"enabled": true, "hintPrice": 500, "extra": 1}, false},
	}
	for _, tc := range cases {
		err := ValidateWordChainValue(tc.value)
		if (err == nil) != tc.ok {
			t.Fatalf("%s: err = %v, want ok = %v", tc.name, err, tc.ok)
		}
	}
}
