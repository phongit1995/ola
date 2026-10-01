package wordchain

import "ola-chat-server/internal/modules/setting"

type Settings interface {
	GetWordChain() (setting.WordChainConfig, error)
}

func (s *Service) enabledConfig() (setting.WordChainConfig, error) {
	cfg, err := s.settings.GetWordChain()
	if err != nil {
		s.logger.Warnw("Failed to load word chain settings, keeping the room closed", "error", err)
		return cfg, ErrUnavailable
	}
	if !cfg.Enabled {
		return cfg, ErrDisabled
	}
	return cfg, nil
}
