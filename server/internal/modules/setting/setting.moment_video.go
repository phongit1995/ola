package setting

import (
	"bytes"
	"encoding/json"
	"errors"

	"ola-chat-server/internal/models"
)

const KeyMomentVideo = "moment_video"

type MomentVideoConfig struct {
	VipRequired bool `json:"vipRequired"`
}

func DefaultMomentVideoConfig() MomentVideoConfig {
	return MomentVideoConfig{VipRequired: false}
}

func (s *Service) GetMomentVideo() (MomentVideoConfig, error) {
	cfg := DefaultMomentVideoConfig()
	err := s.getInto(KeyMomentVideo, &cfg)
	return cfg, err
}

func ValidateMomentVideoValue(value models.JSONB) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return errors.New("invalid moment_video config")
	}
	var cfg struct {
		VipRequired *bool `json:"vipRequired"`
	}
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&cfg); err != nil {
		return errors.New("invalid moment_video config: " + err.Error())
	}
	if cfg.VipRequired == nil {
		return errors.New("cấu hình đăng video khoảnh khắc cần có vipRequired")
	}
	return nil
}
