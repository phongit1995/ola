package setting

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"

	"ola-chat-server/internal/models"
)

const (
	KeyMePostLimit     = "me_post_limit"
	KeyMomentPostLimit = "moment_post_limit"

	postLimitDailyMax = 1000
)

type PostLimitConfig struct {
	NormalPerDay int `json:"normalPerDay"`
	VipPerDay    int `json:"vipPerDay"`
}

func DefaultMePostLimitConfig() PostLimitConfig {
	return PostLimitConfig{NormalPerDay: 3, VipPerDay: 5}
}

func DefaultMomentPostLimitConfig() PostLimitConfig {
	return PostLimitConfig{NormalPerDay: 1, VipPerDay: 5}
}

func (c PostLimitConfig) PerDay(vip bool) int {
	if vip {
		return c.VipPerDay
	}
	return c.NormalPerDay
}

func (c PostLimitConfig) VipRaisesLimit() bool {
	return c.NormalPerDay > 0 && (c.VipPerDay <= 0 || c.VipPerDay > c.NormalPerDay)
}

func validPostLimit(n int) bool {
	return n >= 0 && n <= postLimitDailyMax
}

func (s *Service) GetMePostLimit() (PostLimitConfig, error) {
	return s.getPostLimit(KeyMePostLimit, DefaultMePostLimitConfig())
}

func (s *Service) GetMomentPostLimit() (PostLimitConfig, error) {
	return s.getPostLimit(KeyMomentPostLimit, DefaultMomentPostLimitConfig())
}

func (s *Service) getPostLimit(key string, defaults PostLimitConfig) (PostLimitConfig, error) {
	cfg := defaults
	err := s.getInto(key, &cfg)
	if !validPostLimit(cfg.NormalPerDay) || !validPostLimit(cfg.VipPerDay) {
		s.logger.Warnw("Invalid post limit in app_settings, using default", "key", key, "value", cfg)
		cfg = defaults
	}
	return cfg, err
}

func ValidatePostLimitValue(value models.JSONB) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return errors.New("invalid post limit config")
	}
	var cfg struct {
		NormalPerDay *int `json:"normalPerDay"`
		VipPerDay    *int `json:"vipPerDay"`
	}
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&cfg); err != nil {
		return errors.New("invalid post limit config: " + err.Error())
	}
	if cfg.NormalPerDay == nil || cfg.VipPerDay == nil {
		return errors.New("giới hạn đăng cần đủ normalPerDay và vipPerDay")
	}
	if !validPostLimit(*cfg.NormalPerDay) || !validPostLimit(*cfg.VipPerDay) {
		return fmt.Errorf("số lần đăng mỗi ngày phải từ 0 đến %d (0 là không giới hạn)", postLimitDailyMax)
	}
	return nil
}
