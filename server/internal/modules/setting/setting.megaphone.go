package setting

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"

	"ola-chat-server/internal/models"
)

const (
	KeyMegaphone = "megaphone"

	MegaphoneKenPriceMax        = 1000000
	MegaphoneMaxLengthLimit     = 200
	MegaphoneDisplaySecondsMin  = 3
	MegaphoneDisplaySecondsMax  = 60
	MegaphoneCooldownSecondsMax = 24 * 60 * 60
	MegaphoneDailyLimitMax      = 1000
	MegaphoneMaxQueueSecondsMax = 60 * 60

	megaphoneKenPriceDefault        = 2000
	megaphoneMaxLengthDefault       = 80
	megaphoneDisplaySecondsDefault  = 10
	megaphoneCooldownSecondsDefault = 60
	megaphoneDailyLimitDefault      = 20
	megaphoneMaxQueueSecondsDefault = 300
)

type MegaphoneConfig struct {
	Enabled         bool `json:"enabled"`
	KenPrice        int  `json:"kenPrice"`
	MaxLength       int  `json:"maxLength"`
	DisplaySeconds  int  `json:"displaySeconds"`
	CooldownSeconds int  `json:"cooldownSeconds"`
	DailyLimit      int  `json:"dailyLimit"`
	MaxQueueSeconds int  `json:"maxQueueSeconds"`
}

func DefaultMegaphoneConfig() MegaphoneConfig {
	return MegaphoneConfig{
		Enabled:         true,
		KenPrice:        megaphoneKenPriceDefault,
		MaxLength:       megaphoneMaxLengthDefault,
		DisplaySeconds:  megaphoneDisplaySecondsDefault,
		CooldownSeconds: megaphoneCooldownSecondsDefault,
		DailyLimit:      megaphoneDailyLimitDefault,
		MaxQueueSeconds: megaphoneMaxQueueSecondsDefault,
	}
}

func (s *Service) GetMegaphone() (MegaphoneConfig, error) {
	cfg := DefaultMegaphoneConfig()
	err := s.getInto(KeyMegaphone, &cfg)
	if validateMegaphoneConfig(cfg) != nil {
		s.logger.Warnw("Invalid megaphone config in app_settings, using default", "value", cfg)
		return DefaultMegaphoneConfig(), err
	}
	return cfg, err
}

func validateMegaphoneConfig(cfg MegaphoneConfig) error {
	if cfg.KenPrice < 0 || cfg.KenPrice > MegaphoneKenPriceMax {
		return fmt.Errorf("giá phát loa phải từ 0 đến %d KEN", MegaphoneKenPriceMax)
	}
	if cfg.MaxLength < 1 || cfg.MaxLength > MegaphoneMaxLengthLimit {
		return fmt.Errorf("số ký tự tối đa phải từ 1 đến %d", MegaphoneMaxLengthLimit)
	}
	if cfg.DisplaySeconds < MegaphoneDisplaySecondsMin || cfg.DisplaySeconds > MegaphoneDisplaySecondsMax {
		return fmt.Errorf("thời gian hiện mỗi loa phải từ %d đến %d giây", MegaphoneDisplaySecondsMin, MegaphoneDisplaySecondsMax)
	}
	if cfg.CooldownSeconds < 0 || cfg.CooldownSeconds > MegaphoneCooldownSecondsMax {
		return fmt.Errorf("thời gian chờ giữa 2 lần phát phải từ 0 đến %d giây", MegaphoneCooldownSecondsMax)
	}
	if cfg.DailyLimit < 1 || cfg.DailyLimit > MegaphoneDailyLimitMax {
		return fmt.Errorf("số loa mỗi ngày phải từ 1 đến %d", MegaphoneDailyLimitMax)
	}
	if cfg.MaxQueueSeconds < cfg.DisplaySeconds || cfg.MaxQueueSeconds > MegaphoneMaxQueueSecondsMax {
		return fmt.Errorf("hàng chờ tối đa phải từ %d đến %d giây", cfg.DisplaySeconds, MegaphoneMaxQueueSecondsMax)
	}
	return nil
}

func ValidateMegaphoneValue(value models.JSONB) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return errors.New("invalid megaphone config")
	}
	var cfg struct {
		Enabled         *bool `json:"enabled"`
		KenPrice        *int  `json:"kenPrice"`
		MaxLength       *int  `json:"maxLength"`
		DisplaySeconds  *int  `json:"displaySeconds"`
		CooldownSeconds *int  `json:"cooldownSeconds"`
		DailyLimit      *int  `json:"dailyLimit"`
		MaxQueueSeconds *int  `json:"maxQueueSeconds"`
	}
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&cfg); err != nil {
		return errors.New("invalid megaphone config: " + err.Error())
	}
	if cfg.Enabled == nil || cfg.KenPrice == nil || cfg.MaxLength == nil || cfg.DisplaySeconds == nil ||
		cfg.CooldownSeconds == nil || cfg.DailyLimit == nil || cfg.MaxQueueSeconds == nil {
		return errors.New("cấu hình loa cần đủ enabled, kenPrice, maxLength, displaySeconds, cooldownSeconds, dailyLimit, maxQueueSeconds")
	}
	return validateMegaphoneConfig(MegaphoneConfig{
		Enabled:         *cfg.Enabled,
		KenPrice:        *cfg.KenPrice,
		MaxLength:       *cfg.MaxLength,
		DisplaySeconds:  *cfg.DisplaySeconds,
		CooldownSeconds: *cfg.CooldownSeconds,
		DailyLimit:      *cfg.DailyLimit,
		MaxQueueSeconds: *cfg.MaxQueueSeconds,
	})
}
