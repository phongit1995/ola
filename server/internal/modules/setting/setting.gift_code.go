package setting

import (
	"bytes"
	"encoding/json"
	"errors"

	"ola-chat-server/internal/models"
)

const KeyGiftCode = "gift_code"

type GiftCodeConfig struct {
	Enabled              bool          `json:"enabled"`
	Platforms            PlatformRules `json:"platforms"`
	RequireEmailVerified bool          `json:"requireEmailVerified"`
}

type GiftCodePublicConfig struct {
	Enabled              bool `json:"enabled" example:"true"`
	RequireEmailVerified bool `json:"requireEmailVerified" example:"true"`
}

type GiftCodeActivity interface {
	HasRunningCampaign(platform string) (bool, error)
}

func DefaultGiftCodeConfig() GiftCodeConfig {
	return GiftCodeConfig{
		Enabled:              true,
		Platforms:            OpenPlatformRules(),
		RequireEmailVerified: true,
	}
}

func (c GiftCodeConfig) EnabledFor(client Client) bool {
	return c.Enabled && c.Platforms.EnabledForClient(client)
}

func (s *Service) GetGiftCode() (GiftCodeConfig, error) {
	cfg := DefaultGiftCodeConfig()
	err := s.getInto(KeyGiftCode, &cfg)
	cfg.Platforms = cfg.Platforms.normalized()
	return cfg, err
}

func ValidateGiftCodeValue(value models.JSONB) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return errors.New("invalid gift_code config")
	}
	var cfg struct {
		Enabled              *bool               `json:"enabled"`
		Platforms            *platformRulesInput `json:"platforms"`
		RequireEmailVerified *bool               `json:"requireEmailVerified"`
	}
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&cfg); err != nil {
		return errors.New("invalid gift_code config: " + err.Error())
	}
	if cfg.Enabled == nil || cfg.RequireEmailVerified == nil {
		return errors.New("cấu hình mã quà tặng cần đủ enabled, requireEmailVerified")
	}
	if cfg.Platforms != nil {
		return cfg.Platforms.validate()
	}
	return nil
}
