package wordchain

import "ola-chat-server/internal/modules/setting"

type Settings interface {
	GetWordChain() (setting.WordChainConfig, error)
}

func (s *Service) config() setting.WordChainConfig {
	cfg, err := s.settings.GetWordChain()
	if err != nil {
		s.logger.Warnw("Failed to load word chain settings, using defaults", "error", err)
		return setting.DefaultWordChainConfig()
	}
	return cfg
}

func (s *Service) enabledConfig() (setting.WordChainConfig, error) {
	cfg := s.config()
	if !cfg.Enabled {
		return cfg, ErrDisabled
	}
	return cfg, nil
}
