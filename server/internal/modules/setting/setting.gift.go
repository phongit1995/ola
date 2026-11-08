package setting

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"sort"

	"ola-chat-server/internal/models"
)

const (
	KeyGift = "gift"

	GiftQuantityMaxLimit       = 999
	GiftNoteMaxLengthLimit     = 100
	GiftQuantityOptionsMaxSize = 6
	giftQuantityMaxDefault     = 99
	giftNoteMaxLengthDefault   = 100
	giftConfirmOverDefault     = 1000
)

type GiftConfig struct {
	Enabled         bool          `json:"enabled"`
	Platforms       PlatformRules `json:"platforms"`
	QuantityOptions []int         `json:"quantityOptions"`
	QuantityMax     int           `json:"quantityMax"`
	NoteMaxLength   int           `json:"noteMaxLength"`
	ConfirmOverKen  int           `json:"confirmOverKen"`
}

type GiftPublicConfig struct {
	Enabled         bool  `json:"enabled" example:"true"`
	QuantityOptions []int `json:"quantityOptions"`
	QuantityMax     int   `json:"quantityMax" example:"99"`
	NoteMaxLength   int   `json:"noteMaxLength" example:"100"`
	ConfirmOverKen  int   `json:"confirmOverKen" example:"1000"`
}

func DefaultGiftConfig() GiftConfig {
	return GiftConfig{
		Enabled:         true,
		Platforms:       OpenPlatformRules(),
		QuantityOptions: []int{1, 5, 10, 99},
		QuantityMax:     giftQuantityMaxDefault,
		NoteMaxLength:   giftNoteMaxLengthDefault,
		ConfirmOverKen:  giftConfirmOverDefault,
	}
}

func (c GiftConfig) EnabledFor(client Client) bool {
	return c.Enabled && c.Platforms.EnabledForClient(client)
}

func (c GiftConfig) PublicFor(client Client) GiftPublicConfig {
	return GiftPublicConfig{
		Enabled:         c.EnabledFor(client),
		QuantityOptions: c.QuantityOptions,
		QuantityMax:     c.QuantityMax,
		NoteMaxLength:   c.NoteMaxLength,
		ConfirmOverKen:  c.ConfirmOverKen,
	}
}

func (s *Service) GetGift() (GiftConfig, error) {
	cfg := DefaultGiftConfig()
	err := s.getInto(KeyGift, &cfg)
	if validateGiftConfig(cfg) != nil {
		s.logger.Warnw("Invalid gift config in app_settings, using default", "value", cfg)
		return DefaultGiftConfig(), err
	}
	cfg.Platforms = cfg.Platforms.normalized()
	return cfg, err
}

func validateGiftConfig(cfg GiftConfig) error {
	if cfg.QuantityMax < 1 || cfg.QuantityMax > GiftQuantityMaxLimit {
		return fmt.Errorf("số lượng tối đa phải từ 1 đến %d", GiftQuantityMaxLimit)
	}
	if cfg.NoteMaxLength < 0 || cfg.NoteMaxLength > GiftNoteMaxLengthLimit {
		return fmt.Errorf("độ dài lời nhắn phải từ 0 đến %d ký tự", GiftNoteMaxLengthLimit)
	}
	if cfg.ConfirmOverKen < 0 {
		return errors.New("ngưỡng xác nhận không được âm")
	}
	if len(cfg.QuantityOptions) == 0 || len(cfg.QuantityOptions) > GiftQuantityOptionsMaxSize {
		return fmt.Errorf("cần 1 đến %d lựa chọn số lượng", GiftQuantityOptionsMaxSize)
	}
	if !sort.IntsAreSorted(cfg.QuantityOptions) {
		return errors.New("lựa chọn số lượng phải tăng dần")
	}
	for i, q := range cfg.QuantityOptions {
		if q < 1 || q > cfg.QuantityMax {
			return fmt.Errorf("lựa chọn số lượng phải từ 1 đến %d", cfg.QuantityMax)
		}
		if i > 0 && q == cfg.QuantityOptions[i-1] {
			return errors.New("lựa chọn số lượng bị trùng")
		}
	}
	return nil
}

func ValidateGiftValue(value models.JSONB) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return errors.New("invalid gift config")
	}
	var cfg struct {
		Enabled         *bool               `json:"enabled"`
		Platforms       *platformRulesInput `json:"platforms"`
		QuantityOptions []int               `json:"quantityOptions"`
		QuantityMax     *int                `json:"quantityMax"`
		NoteMaxLength   *int                `json:"noteMaxLength"`
		ConfirmOverKen  *int                `json:"confirmOverKen"`
	}
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&cfg); err != nil {
		return errors.New("invalid gift config: " + err.Error())
	}
	if cfg.Enabled == nil || cfg.QuantityMax == nil || cfg.NoteMaxLength == nil || cfg.ConfirmOverKen == nil {
		return errors.New("cấu hình quà tặng cần đủ enabled, quantityOptions, quantityMax, noteMaxLength, confirmOverKen")
	}
	if cfg.Platforms != nil {
		if err := cfg.Platforms.validate(); err != nil {
			return err
		}
	}
	return validateGiftConfig(GiftConfig{
		Enabled:         *cfg.Enabled,
		QuantityOptions: cfg.QuantityOptions,
		QuantityMax:     *cfg.QuantityMax,
		NoteMaxLength:   *cfg.NoteMaxLength,
		ConfirmOverKen:  *cfg.ConfirmOverKen,
	})
}
