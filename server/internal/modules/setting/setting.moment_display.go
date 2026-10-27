package setting

import (
	"errors"

	"ola-chat-server/internal/models"
)

const KeyMoment = "moment"

type MomentConfig = PlatformRules

func DefaultMomentConfig() MomentConfig {
	return OpenPlatformRules()
}

func (s *Service) GetMoment() (MomentConfig, error) {
	cfg := DefaultMomentConfig()
	err := s.getInto(KeyMoment, &cfg)
	return cfg.normalized(), err
}

func ValidateMomentValue(value models.JSONB) error {
	in, err := decodePlatformRules(value)
	if err != nil {
		return errors.New("invalid moment config: " + err.Error())
	}
	return in.validate()
}
