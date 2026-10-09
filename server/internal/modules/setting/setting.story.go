package setting

import (
	"errors"

	"ola-chat-server/internal/models"
)

const KeyStory = "story"

type StoryConfig = PlatformRules

func DefaultStoryConfig() StoryConfig {
	return OpenPlatformRules()
}

func (s *Service) GetStory() (StoryConfig, error) {
	cfg := DefaultStoryConfig()
	err := s.getInto(KeyStory, &cfg)
	return cfg.normalized(), err
}

func ValidateStoryValue(value models.JSONB) error {
	in, err := decodePlatformRules(value)
	if err != nil {
		return errors.New("invalid story config: " + err.Error())
	}
	return in.validate()
}
