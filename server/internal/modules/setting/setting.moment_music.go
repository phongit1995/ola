package setting

import (
	"errors"

	"ola-chat-server/internal/models"
)

const KeyMomentMusic = "moment_music"

type MomentMusicConfig = PlatformRules

func DefaultMomentMusicConfig() MomentMusicConfig {
	return OpenPlatformRules()
}

func (s *Service) GetMomentMusic() (MomentMusicConfig, error) {
	cfg := DefaultMomentMusicConfig()
	err := s.getInto(KeyMomentMusic, &cfg)
	return cfg.normalized(), err
}

func ValidateMomentMusicValue(value models.JSONB) error {
	in, err := decodePlatformRules(value)
	if err != nil {
		return errors.New("invalid moment_music config: " + err.Error())
	}
	return in.validate()
}
