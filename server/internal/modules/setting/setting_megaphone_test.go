package setting

import (
	"strings"
	"testing"

	"ola-chat-server/internal/models"
)

func validMegaphoneValue() models.JSONB {
	return models.JSONB{
		"enabled":         true,
		"kenPrice":        2000,
		"maxLength":       80,
		"displaySeconds":  10,
		"cooldownSeconds": 60,
		"dailyLimit":      20,
		"maxQueueSeconds": 300,
	}
}

func TestValidateMegaphoneValueAcceptsDefault(t *testing.T) {
	if err := ValidateMegaphoneValue(validMegaphoneValue()); err != nil {
		t.Fatalf("expected valid, got %v", err)
	}
	if err := validateMegaphoneConfig(DefaultMegaphoneConfig()); err != nil {
		t.Fatalf("default config must be valid: %v", err)
	}
}

func TestValidateMegaphoneValueRejectsBadConfig(t *testing.T) {
	cases := map[string]func(models.JSONB){
		"missing enabled":     func(v models.JSONB) { delete(v, "enabled") },
		"unknown field":       func(v models.JSONB) { v["color"] = "red" },
		"negative price":      func(v models.JSONB) { v["kenPrice"] = -1 },
		"length zero":         func(v models.JSONB) { v["maxLength"] = 0 },
		"length too big":      func(v models.JSONB) { v["maxLength"] = MegaphoneMaxLengthLimit + 1 },
		"display too short":   func(v models.JSONB) { v["displaySeconds"] = MegaphoneDisplaySecondsMin - 1 },
		"display too long":    func(v models.JSONB) { v["displaySeconds"] = MegaphoneDisplaySecondsMax + 1 },
		"negative cooldown":   func(v models.JSONB) { v["cooldownSeconds"] = -1 },
		"daily zero":          func(v models.JSONB) { v["dailyLimit"] = 0 },
		"queue below display": func(v models.JSONB) { v["maxQueueSeconds"] = 5 },
		"queue too long":      func(v models.JSONB) { v["maxQueueSeconds"] = MegaphoneMaxQueueSecondsMax + 1 },
	}
	for name, mutate := range cases {
		v := validMegaphoneValue()
		mutate(v)
		if err := ValidateMegaphoneValue(v); err == nil {
			t.Fatalf("%s: expected error", name)
		}
	}
}

func TestValidateContentFilterValue(t *testing.T) {
	if err := ValidateContentFilterValue(models.JSONB{"bannedWords": []interface{}{"lừa đảo", "nạp ken giá rẻ"}}); err != nil {
		t.Fatalf("expected valid, got %v", err)
	}
	if err := ValidateContentFilterValue(models.JSONB{"bannedWords": []interface{}{}}); err != nil {
		t.Fatalf("empty list must be valid, got %v", err)
	}
	bad := map[string]models.JSONB{
		"missing words": {},
		"unknown field": {"bannedWords": []interface{}{}, "regex": true},
		"blank word":    {"bannedWords": []interface{}{"  "}},
		"long word":     {"bannedWords": []interface{}{strings.Repeat("a", ContentFilterWordRunesMax+1)}},
	}
	for name, value := range bad {
		if err := ValidateContentFilterValue(value); err == nil {
			t.Fatalf("%s: expected error", name)
		}
	}
}
