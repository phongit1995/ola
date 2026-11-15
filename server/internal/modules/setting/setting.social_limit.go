package setting

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"

	"ola-chat-server/internal/models"
)

const (
	KeySocialLimit = "social_limit"

	socialDailyMax   = 1000
	socialFriendsMax = 10000
)

type SocialLimitTier struct {
	NewChatsPerDay       int `json:"newChatsPerDay"`
	FriendRequestsPerDay int `json:"friendRequestsPerDay"`
	MaxFriends           int `json:"maxFriends"`
	MaxPendingRequests   int `json:"maxPendingRequests"`
}

type SocialLimitConfig struct {
	Enabled bool            `json:"enabled"`
	Normal  SocialLimitTier `json:"normal"`
	Vip     SocialLimitTier `json:"vip"`
}

func DefaultSocialLimitConfig() SocialLimitConfig {
	return SocialLimitConfig{
		Enabled: true,
		Normal:  SocialLimitTier{NewChatsPerDay: 5, FriendRequestsPerDay: 5, MaxFriends: 100, MaxPendingRequests: 200},
		Vip:     SocialLimitTier{NewChatsPerDay: 20, FriendRequestsPerDay: 20, MaxFriends: 200, MaxPendingRequests: 200},
	}
}

func (t SocialLimitTier) validate() error {
	if t.NewChatsPerDay < 0 || t.NewChatsPerDay > socialDailyMax {
		return fmt.Errorf("số người mới nhắn mỗi ngày phải từ 0 đến %d", socialDailyMax)
	}
	if t.FriendRequestsPerDay < 0 || t.FriendRequestsPerDay > socialDailyMax {
		return fmt.Errorf("số lời mời kết bạn mỗi ngày phải từ 0 đến %d", socialDailyMax)
	}
	if t.MaxFriends < 1 || t.MaxFriends > socialFriendsMax {
		return fmt.Errorf("số bạn bè tối đa phải từ 1 đến %d", socialFriendsMax)
	}
	if t.MaxPendingRequests < 1 || t.MaxPendingRequests > socialFriendsMax {
		return fmt.Errorf("số lời mời đang chờ tối đa phải từ 1 đến %d", socialFriendsMax)
	}
	return nil
}

func (s *Service) GetSocialLimit() (SocialLimitConfig, error) {
	cfg := DefaultSocialLimitConfig()
	err := s.getInto(KeySocialLimit, &cfg)
	defaults := DefaultSocialLimitConfig()
	if cfg.Normal.validate() != nil {
		s.logger.Warnw("Invalid social_limit normal tier in app_settings, using default", "value", cfg.Normal)
		cfg.Normal = defaults.Normal
	}
	if cfg.Vip.validate() != nil {
		s.logger.Warnw("Invalid social_limit vip tier in app_settings, using default", "value", cfg.Vip)
		cfg.Vip = defaults.Vip
	}
	return cfg, err
}

func ValidateSocialLimitValue(value models.JSONB) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return errors.New("invalid social_limit config")
	}
	type tier struct {
		NewChatsPerDay       *int `json:"newChatsPerDay"`
		FriendRequestsPerDay *int `json:"friendRequestsPerDay"`
		MaxFriends           *int `json:"maxFriends"`
		MaxPendingRequests   *int `json:"maxPendingRequests"`
	}
	var cfg struct {
		Enabled *bool `json:"enabled"`
		Normal  *tier `json:"normal"`
		Vip     *tier `json:"vip"`
	}
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&cfg); err != nil {
		return errors.New("invalid social_limit config: " + err.Error())
	}
	if cfg.Enabled == nil || cfg.Normal == nil || cfg.Vip == nil {
		return errors.New("cấu hình giới hạn cần đủ enabled, normal và vip")
	}
	tiers := []struct {
		label string
		t     *tier
	}{{"người thường", cfg.Normal}, {"VIP", cfg.Vip}}
	for _, item := range tiers {
		label, t := item.label, item.t
		if t.NewChatsPerDay == nil || t.FriendRequestsPerDay == nil || t.MaxFriends == nil || t.MaxPendingRequests == nil {
			return fmt.Errorf("giới hạn %s cần đủ 4 con số", label)
		}
		full := SocialLimitTier{
			NewChatsPerDay:       *t.NewChatsPerDay,
			FriendRequestsPerDay: *t.FriendRequestsPerDay,
			MaxFriends:           *t.MaxFriends,
			MaxPendingRequests:   *t.MaxPendingRequests,
		}
		if err := full.validate(); err != nil {
			return fmt.Errorf("giới hạn %s: %w", label, err)
		}
	}
	return nil
}
