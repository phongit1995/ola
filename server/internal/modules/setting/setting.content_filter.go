package setting

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"strings"
	"unicode/utf8"

	"ola-chat-server/internal/models"
)

const (
	KeyContentFilter = "content_filter"

	ContentFilterWordsMax     = 5000
	ContentFilterWordRunesMax = 60
)

type ContentFilterConfig struct {
	BannedWords []string `json:"bannedWords"`
}

func DefaultContentFilterConfig() ContentFilterConfig {
	return ContentFilterConfig{BannedWords: []string{}}
}

func (s *Service) GetContentFilter() (ContentFilterConfig, error) {
	cfg := DefaultContentFilterConfig()
	err := s.getInto(KeyContentFilter, &cfg)
	if validateContentFilterConfig(cfg) != nil {
		s.logger.Warnw("Invalid content filter config in app_settings, using default")
		return DefaultContentFilterConfig(), err
	}
	return cfg, err
}

func validateContentFilterConfig(cfg ContentFilterConfig) error {
	if len(cfg.BannedWords) > ContentFilterWordsMax {
		return fmt.Errorf("tối đa %d từ cấm", ContentFilterWordsMax)
	}
	for _, word := range cfg.BannedWords {
		trimmed := strings.TrimSpace(word)
		if trimmed == "" {
			return errors.New("từ cấm không được để trống")
		}
		if utf8.RuneCountInString(trimmed) > ContentFilterWordRunesMax {
			return fmt.Errorf("mỗi từ cấm tối đa %d ký tự: %s", ContentFilterWordRunesMax, trimmed)
		}
	}
	return nil
}

func ValidateContentFilterValue(value models.JSONB) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return errors.New("invalid content filter config")
	}
	var cfg struct {
		BannedWords *[]string `json:"bannedWords"`
	}
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&cfg); err != nil {
		return errors.New("invalid content filter config: " + err.Error())
	}
	if cfg.BannedWords == nil {
		return errors.New("cấu hình lọc nội dung cần bannedWords")
	}
	return validateContentFilterConfig(ContentFilterConfig{BannedWords: *cfg.BannedWords})
}
