package setting

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"

	"ola-chat-server/internal/models"
)

const (
	KeyMomentMediaPurge = "moment_media_purge"

	MomentPurgeAfterHoursMin     = 24
	MomentPurgeAfterHoursMax     = 24 * 365
	momentPurgeAfterHoursDefault = 72
)

type MomentMediaPurgeConfig struct {
	Enabled    bool `json:"enabled"`
	AfterHours int  `json:"afterHours"`
}

func DefaultMomentMediaPurgeConfig() MomentMediaPurgeConfig {
	return MomentMediaPurgeConfig{Enabled: false, AfterHours: momentPurgeAfterHoursDefault}
}

func validMomentPurgeAfterHours(hours int) bool {
	return hours >= MomentPurgeAfterHoursMin && hours <= MomentPurgeAfterHoursMax
}

func (s *Service) GetMomentMediaPurge() (MomentMediaPurgeConfig, error) {
	cfg := DefaultMomentMediaPurgeConfig()
	err := s.getInto(KeyMomentMediaPurge, &cfg)
	if !validMomentPurgeAfterHours(cfg.AfterHours) {
		s.logger.Warnw("Invalid moment_media_purge afterHours in app_settings, using default", "value", cfg.AfterHours)
		cfg.AfterHours = momentPurgeAfterHoursDefault
	}
	return cfg, err
}

func ValidateMomentMediaPurgeValue(value models.JSONB) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return errors.New("invalid moment_media_purge config")
	}
	var cfg struct {
		Enabled    *bool `json:"enabled"`
		AfterHours *int  `json:"afterHours"`
	}
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&cfg); err != nil {
		return errors.New("invalid moment_media_purge config: " + err.Error())
	}
	if cfg.Enabled == nil || cfg.AfterHours == nil {
		return errors.New("cấu hình tự xoá file khoảnh khắc cần đủ enabled và afterHours")
	}
	if !validMomentPurgeAfterHours(*cfg.AfterHours) {
		return fmt.Errorf("thời gian xoá file phải từ %d đến %d giờ", MomentPurgeAfterHoursMin, MomentPurgeAfterHoursMax)
	}
	return nil
}
