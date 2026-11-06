package setting

import (
	"strings"
	"testing"

	"ola-chat-server/internal/models"
)

func validMegaphoneValue() models.JSONB {
	return models.JSONB{
		"enabled":           true,
		"kenPrice":          5000,
		"maxLength":         80,
		"displaySeconds":    12,
		"cooldownSeconds":   60,
		"dailyLimit":        20,
		"liveMinutes":       30,
		"gapSeconds":        3,
		"repeatBaseSeconds": 720,
		"messageWeight":     3,
		"giftTiers": []interface{}{
			map[string]interface{}{"minKen": 0, "weight": 1},
			map[string]interface{}{"minKen": 1000, "weight": 3},
			map[string]interface{}{"minKen": 20000, "weight": 6},
		},
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
		"missing enabled":   func(v models.JSONB) { delete(v, "enabled") },
		"unknown field":     func(v models.JSONB) { v["color"] = "red" },
		"negative price":    func(v models.JSONB) { v["kenPrice"] = -1 },
		"length zero":       func(v models.JSONB) { v["maxLength"] = 0 },
		"length too big":    func(v models.JSONB) { v["maxLength"] = MegaphoneMaxLengthLimit + 1 },
		"display too short": func(v models.JSONB) { v["displaySeconds"] = MegaphoneDisplaySecondsMin - 1 },
		"display too long":  func(v models.JSONB) { v["displaySeconds"] = MegaphoneDisplaySecondsMax + 1 },
		"negative cooldown": func(v models.JSONB) { v["cooldownSeconds"] = -1 },
		"daily zero":        func(v models.JSONB) { v["dailyLimit"] = 0 },
		"old queue field":   func(v models.JSONB) { v["maxQueueSeconds"] = 300 },
		"live zero":         func(v models.JSONB) { v["liveMinutes"] = 0 },
		"negative gap":      func(v models.JSONB) { v["gapSeconds"] = -1 },
		"repeat too short":  func(v models.JSONB) { v["repeatBaseSeconds"] = MegaphoneRepeatBaseMin - 1 },
		"weight zero":       func(v models.JSONB) { v["messageWeight"] = 0 },
		"no tiers":          func(v models.JSONB) { v["giftTiers"] = []interface{}{} },
		"tier not from zero": func(v models.JSONB) {
			v["giftTiers"] = []interface{}{map[string]interface{}{"minKen": 10, "weight": 1}}
		},
		"tiers not ascending": func(v models.JSONB) {
			v["giftTiers"] = []interface{}{
				map[string]interface{}{"minKen": 0, "weight": 1},
				map[string]interface{}{"minKen": 0, "weight": 2},
			}
		},
	}
	cases["slot as long as live time"] = func(v models.JSONB) {
		v["liveMinutes"] = 1
		v["displaySeconds"] = 57
		v["gapSeconds"] = 3
	}
	for name, mutate := range cases {
		v := validMegaphoneValue()
		mutate(v)
		if err := ValidateMegaphoneValue(v); err == nil {
			t.Fatalf("%s: expected error", name)
		}
	}
}

func TestMegaphoneLimitsFollowLiveTime(t *testing.T) {
	cfg := DefaultMegaphoneConfig()
	if cfg.SlotSeconds() != 15 || cfg.MessageQueueLimit() != 40 || cfg.GiftQueueLimit() != 20 {
		t.Fatalf("slot %d message %d gift %d", cfg.SlotSeconds(), cfg.MessageQueueLimit(), cfg.GiftQueueLimit())
	}
	cfg.LiveMinutes = 60
	if cfg.MessageQueueLimit() != 80 || cfg.GiftQueueLimit() != 40 {
		t.Fatalf("message %d gift %d", cfg.MessageQueueLimit(), cfg.GiftQueueLimit())
	}
	cfg.LiveMinutes = 1
	cfg.DisplaySeconds = 50
	if cfg.MessageQueueLimit() != 1 || cfg.GiftQueueLimit() != 1 {
		t.Fatalf("limits must stay positive, got %d and %d", cfg.MessageQueueLimit(), cfg.GiftQueueLimit())
	}
}

func TestMegaphoneGiftWeightUsesTiers(t *testing.T) {
	cfg := DefaultMegaphoneConfig()
	for total, want := range map[int]int{1: 1, 999: 1, 1000: 3, 19999: 3, 20000: 6, 300000: 6} {
		if got := cfg.GiftWeight(total); got != want {
			t.Fatalf("total %d → weight %d, want %d", total, got, want)
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
