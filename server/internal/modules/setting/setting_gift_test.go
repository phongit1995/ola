package setting

import (
	"testing"

	"ola-chat-server/internal/models"
)

func validGiftValue() models.JSONB {
	return models.JSONB{
		"enabled":         true,
		"quantityOptions": []interface{}{1, 5, 10, 99},
		"quantityMax":     99,
		"noteMaxLength":   100,
		"confirmOverKen":  1000,
	}
}

func TestValidateGiftValueAcceptsDefault(t *testing.T) {
	if err := ValidateGiftValue(validGiftValue()); err != nil {
		t.Fatalf("expected valid, got %v", err)
	}
	if err := validateGiftConfig(DefaultGiftConfig()); err != nil {
		t.Fatalf("default config must be valid: %v", err)
	}
}

func TestValidateGiftValueRejectsBadConfig(t *testing.T) {
	cases := map[string]func(models.JSONB){
		"missing enabled":       func(v models.JSONB) { delete(v, "enabled") },
		"unknown field":         func(v models.JSONB) { v["ratePerMinute"] = 20 },
		"quantityMax zero":      func(v models.JSONB) { v["quantityMax"] = 0 },
		"quantityMax too big":   func(v models.JSONB) { v["quantityMax"] = GiftQuantityMaxLimit + 1 },
		"note too long":         func(v models.JSONB) { v["noteMaxLength"] = GiftNoteMaxLengthLimit + 1 },
		"negative confirm":      func(v models.JSONB) { v["confirmOverKen"] = -1 },
		"no options":            func(v models.JSONB) { v["quantityOptions"] = []interface{}{} },
		"option above max":      func(v models.JSONB) { v["quantityOptions"] = []interface{}{1, 100} },
		"options not ascending": func(v models.JSONB) { v["quantityOptions"] = []interface{}{5, 1} },
		"duplicate options":     func(v models.JSONB) { v["quantityOptions"] = []interface{}{1, 1} },
		"too many options":      func(v models.JSONB) { v["quantityOptions"] = []interface{}{1, 2, 3, 4, 5, 6, 7} },
		"option zero":           func(v models.JSONB) { v["quantityOptions"] = []interface{}{0, 1} },
	}
	for name, mutate := range cases {
		v := validGiftValue()
		mutate(v)
		if err := ValidateGiftValue(v); err == nil {
			t.Fatalf("%s: expected error", name)
		}
	}
}
