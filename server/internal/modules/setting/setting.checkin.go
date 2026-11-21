package setting

import (
	"bytes"
	"encoding/json"
	"errors"

	"ola-chat-server/internal/models"
)

const KeyCheckin = "checkin"

type CheckinConfig struct {
	Enabled              bool          `json:"enabled"`
	Platforms            PlatformRules `json:"platforms"`
	Popup                bool          `json:"popup"`
	RequireEmailVerified bool          `json:"requireEmailVerified"`
	RandomTasks          []string      `json:"randomTasks"`
}

func DefaultCheckinConfig() CheckinConfig {
	return CheckinConfig{
		Enabled:              false,
		Platforms:            OpenPlatformRules(),
		Popup:                true,
		RequireEmailVerified: true,
	}
}

type CheckinPublicConfig struct {
	Enabled bool `json:"enabled" example:"true"`
}

func (c CheckinConfig) EnabledFor(client Client) bool {
	return c.Enabled && c.Platforms.EnabledForClient(client)
}

func (s *Service) GetCheckin() (CheckinConfig, error) {
	cfg := DefaultCheckinConfig()
	err := s.getInto(KeyCheckin, &cfg)
	cfg.Platforms = cfg.Platforms.normalized()
	return cfg, err
}

func ValidateCheckinValue(value models.JSONB, isTask func(string) bool) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return errors.New("invalid checkin config")
	}
	var cfg struct {
		Enabled              *bool               `json:"enabled"`
		Platforms            *platformRulesInput `json:"platforms"`
		Popup                *bool               `json:"popup"`
		RequireEmailVerified *bool               `json:"requireEmailVerified"`
		RandomTasks          []string            `json:"randomTasks"`
	}
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&cfg); err != nil {
		return errors.New("invalid checkin config: " + err.Error())
	}
	if cfg.Enabled == nil || cfg.Popup == nil || cfg.RequireEmailVerified == nil {
		return errors.New("cấu hình điểm danh cần đủ enabled, popup, requireEmailVerified")
	}
	if len(cfg.RandomTasks) == 0 {
		return errors.New("chọn ít nhất một nhiệm vụ cho danh sách ngẫu nhiên")
	}
	seen := make(map[string]bool, len(cfg.RandomTasks))
	for _, task := range cfg.RandomTasks {
		if !isTask(task) {
			return errors.New("nhiệm vụ không hợp lệ: " + task)
		}
		if seen[task] {
			return errors.New("nhiệm vụ bị trùng: " + task)
		}
		seen[task] = true
	}
	if cfg.Platforms != nil {
		return cfg.Platforms.validate()
	}
	return nil
}
