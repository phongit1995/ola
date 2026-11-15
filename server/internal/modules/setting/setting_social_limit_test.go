package setting

import (
	"testing"

	"ola-chat-server/internal/models"
)

func socialTier(newChats, requests, friends, pending int) map[string]interface{} {
	return map[string]interface{}{
		"newChatsPerDay":       newChats,
		"friendRequestsPerDay": requests,
		"maxFriends":           friends,
		"maxPendingRequests":   pending,
	}
}

func TestValidateSocialLimitValue(t *testing.T) {
	valid := models.JSONB{"enabled": true, "normal": socialTier(5, 5, 100, 200), "vip": socialTier(20, 20, 200, 200)}
	if err := ValidateSocialLimitValue(valid); err != nil {
		t.Fatalf("valid config rejected: %v", err)
	}

	cases := map[string]models.JSONB{
		"missing vip":     {"enabled": true, "normal": socialTier(5, 5, 100, 200)},
		"missing field":   {"enabled": true, "normal": map[string]interface{}{"newChatsPerDay": 5}, "vip": socialTier(20, 20, 200, 200)},
		"negative daily":  {"enabled": true, "normal": socialTier(-1, 5, 100, 200), "vip": socialTier(20, 20, 200, 200)},
		"zero friends":    {"enabled": true, "normal": socialTier(5, 5, 0, 200), "vip": socialTier(20, 20, 200, 200)},
		"unknown field":   {"enabled": true, "normal": socialTier(5, 5, 100, 200), "vip": socialTier(20, 20, 200, 200), "extra": 1},
		"missing enabled": {"normal": socialTier(5, 5, 100, 200), "vip": socialTier(20, 20, 200, 200)},
	}
	for name, value := range cases {
		if err := ValidateSocialLimitValue(value); err == nil {
			t.Errorf("%s: expected error", name)
		}
	}
}

func TestDefaultSocialLimitConfigIsValid(t *testing.T) {
	cfg := DefaultSocialLimitConfig()
	if !cfg.Enabled || cfg.Normal.NewChatsPerDay != 5 || cfg.Normal.FriendRequestsPerDay != 5 {
		t.Fatalf("unexpected defaults %+v", cfg)
	}
	if err := cfg.Normal.validate(); err != nil {
		t.Fatal(err)
	}
	if err := cfg.Vip.validate(); err != nil {
		t.Fatal(err)
	}
}
