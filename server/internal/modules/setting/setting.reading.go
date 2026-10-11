package setting

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"

	"ola-chat-server/internal/models"
)

const (
	KeyStoryReading = "story_reading"

	storyFreeChaptersDefault = 10
	storyFreeChaptersMax     = 1000
	storyUnlockCharsDefault  = 20
	storyUnlockCharsMax      = 500
)

type StoryReadingConfig struct {
	Enabled               bool `json:"enabled"`
	FreeChaptersPerDay    int  `json:"freeChaptersPerDay"`
	CommentUnlockMinChars int  `json:"commentUnlockMinChars"`
}

func DefaultStoryReadingConfig() StoryReadingConfig {
	return StoryReadingConfig{Enabled: true, FreeChaptersPerDay: storyFreeChaptersDefault, CommentUnlockMinChars: storyUnlockCharsDefault}
}

func validFreeChapters(n int) bool {
	return n >= 0 && n <= storyFreeChaptersMax
}

func validUnlockChars(n int) bool {
	return n >= 1 && n <= storyUnlockCharsMax
}

func (s *Service) GetStoryReading() (StoryReadingConfig, error) {
	cfg := DefaultStoryReadingConfig()
	err := s.getInto(KeyStoryReading, &cfg)
	if !validFreeChapters(cfg.FreeChaptersPerDay) {
		s.logger.Warnw("Invalid story_reading freeChaptersPerDay in app_settings, using default", "value", cfg.FreeChaptersPerDay)
		cfg.FreeChaptersPerDay = storyFreeChaptersDefault
	}
	if !validUnlockChars(cfg.CommentUnlockMinChars) {
		s.logger.Warnw("Invalid story_reading commentUnlockMinChars in app_settings, using default", "value", cfg.CommentUnlockMinChars)
		cfg.CommentUnlockMinChars = storyUnlockCharsDefault
	}
	return cfg, err
}

func ValidateStoryReadingValue(value models.JSONB) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return errors.New("invalid story_reading config")
	}
	var cfg struct {
		Enabled               *bool `json:"enabled"`
		FreeChaptersPerDay    *int  `json:"freeChaptersPerDay"`
		CommentUnlockMinChars *int  `json:"commentUnlockMinChars"`
	}
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&cfg); err != nil {
		return errors.New("invalid story_reading config: " + err.Error())
	}
	if cfg.Enabled == nil || cfg.FreeChaptersPerDay == nil || cfg.CommentUnlockMinChars == nil {
		return errors.New("cấu hình giới hạn đọc cần đủ enabled, freeChaptersPerDay và commentUnlockMinChars")
	}
	if !validFreeChapters(*cfg.FreeChaptersPerDay) {
		return fmt.Errorf("số chương miễn phí mỗi ngày phải từ 0 đến %d", storyFreeChaptersMax)
	}
	if !validUnlockChars(*cfg.CommentUnlockMinChars) {
		return fmt.Errorf("số ký tự tối thiểu để mở khoá phải từ 1 đến %d", storyUnlockCharsMax)
	}
	return nil
}
