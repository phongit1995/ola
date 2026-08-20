package setting

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"sort"
	"strings"

	"ola-chat-server/internal/models"

	"go.uber.org/zap"
)

const (
	KeyTopupBank      = "topup_bank"
	KeyTopup          = "topup"
	KeyUsernameChange = "username_change"

	usernameChangeMinLength = 2
	usernameChangeMaxLength = 20
)

type TopupBankConfig struct {
	BankName      string `json:"bankName"`
	BankBin       string `json:"bankBin"`
	AccountNumber string `json:"accountNumber"`
	AccountName   string `json:"accountName"`
	MemoTemplate  string `json:"memoTemplate"`
}

type TopupConfig struct {
	Enabled       bool  `json:"enabled"`
	MinAmount     int   `json:"minAmount"`
	StepAmount    int   `json:"stepAmount"`
	PresetAmounts []int `json:"presetAmounts"`
	KenPerVnd     int   `json:"kenPerVnd"`
}

func DefaultTopupConfig() TopupConfig {
	return TopupConfig{
		Enabled:       true,
		MinAmount:     10_000,
		StepAmount:    1_000,
		PresetAmounts: []int{10_000, 20_000, 50_000, 100_000, 200_000, 500_000},
		KenPerVnd:     1,
	}
}

func DefaultTopupBankConfig() TopupBankConfig {
	return TopupBankConfig{MemoTemplate: "@{username}"}
}

type UsernameChangeTier struct {
	MinLength int `json:"minLength"`
	Cost      int `json:"cost"`
}

type UsernameChangeConfig struct {
	Enabled bool                 `json:"enabled"`
	Tiers   []UsernameChangeTier `json:"tiers"`
}

func DefaultUsernameChangeConfig() UsernameChangeConfig {
	return UsernameChangeConfig{
		Enabled: true,
		Tiers: []UsernameChangeTier{
			{MinLength: 2, Cost: 2_000_000},
			{MinLength: 3, Cost: 1_000_000},
			{MinLength: 4, Cost: 500_000},
			{MinLength: 6, Cost: 100_000},
		},
	}
}

func (c UsernameChangeConfig) CostFor(length int) int {
	cost := -1
	bestMin := -1
	for _, tier := range c.Tiers {
		if length >= tier.MinLength && tier.MinLength > bestMin {
			bestMin = tier.MinLength
			cost = tier.Cost
		}
	}
	return cost
}

type Service struct {
	repo   *Repository
	logger *zap.SugaredLogger
}

func NewService(repo *Repository, logger *zap.SugaredLogger) *Service {
	return &Service{repo: repo, logger: logger.Named("[setting_service]")}
}

func (s *Service) List() ([]models.AppSetting, error) {
	return s.repo.List()
}

func (s *Service) Put(key string, value models.JSONB) (*models.AppSetting, error) {
	return s.repo.Upsert(strings.TrimSpace(key), value)
}

func (s *Service) getInto(key string, out interface{}) error {
	item, err := s.repo.Get(key)
	if err != nil {
		return err
	}
	if item == nil || item.Value == nil {
		return nil
	}
	raw, err := json.Marshal(item.Value)
	if err != nil {
		s.logger.Warnw("Failed to encode app setting, using defaults", "key", key, "error", err.Error())
		return nil
	}
	if err := json.Unmarshal(raw, out); err != nil {
		s.logger.Warnw("Failed to decode app setting, using defaults", "key", key, "error", err.Error())
		return nil
	}
	return nil
}

func (s *Service) GetTopupBank() (TopupBankConfig, error) {
	cfg := DefaultTopupBankConfig()
	err := s.getInto(KeyTopupBank, &cfg)
	return cfg, err
}

func (s *Service) GetTopup() (TopupConfig, error) {
	cfg := DefaultTopupConfig()
	err := s.getInto(KeyTopup, &cfg)
	if cfg.MinAmount <= 0 {
		cfg.MinAmount = 10_000
	}
	if cfg.StepAmount <= 0 {
		cfg.StepAmount = 1_000
	}
	if cfg.KenPerVnd <= 0 {
		cfg.KenPerVnd = 1
	}
	if cfg.MinAmount%cfg.StepAmount != 0 {
		cfg.MinAmount = (cfg.MinAmount/cfg.StepAmount + 1) * cfg.StepAmount
	}

	presets := make([]int, 0, len(cfg.PresetAmounts))
	for _, value := range cfg.PresetAmounts {
		if value >= cfg.MinAmount && value%cfg.StepAmount == 0 {
			presets = append(presets, value)
		}
	}
	if len(presets) == 0 {
		presets = []int{cfg.MinAmount, cfg.MinAmount * 2, cfg.MinAmount * 5}
	}
	cfg.PresetAmounts = presets
	return cfg, err
}

func (s *Service) GetUsernameChange() (UsernameChangeConfig, error) {
	cfg := DefaultUsernameChangeConfig()
	err := s.getInto(KeyUsernameChange, &cfg)

	tiers := make([]UsernameChangeTier, 0, len(cfg.Tiers))
	for _, tier := range cfg.Tiers {
		if tier.MinLength >= usernameChangeMinLength && tier.MinLength <= usernameChangeMaxLength && tier.Cost >= 0 {
			tiers = append(tiers, tier)
		}
	}
	sort.Slice(tiers, func(i, j int) bool { return tiers[i].MinLength < tiers[j].MinLength })
	if len(tiers) == 0 || tiers[0].MinLength != usernameChangeMinLength {
		s.logger.Warnw("Invalid username_change tiers in app_settings, using defaults", "tiers", cfg.Tiers)
		tiers = DefaultUsernameChangeConfig().Tiers
	}
	cfg.Tiers = tiers
	return cfg, err
}

func ValidateUsernameChangeValue(value models.JSONB) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return errors.New("invalid username_change config")
	}
	var cfg UsernameChangeConfig
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&cfg); err != nil {
		return errors.New("invalid username_change config: " + err.Error())
	}
	if len(cfg.Tiers) == 0 {
		return errors.New("username_change config needs at least one tier")
	}
	seen := make(map[int]bool, len(cfg.Tiers))
	hasBaseTier := false
	for _, tier := range cfg.Tiers {
		if tier.MinLength < usernameChangeMinLength || tier.MinLength > usernameChangeMaxLength {
			return fmt.Errorf("tier minLength must be between %d and %d", usernameChangeMinLength, usernameChangeMaxLength)
		}
		if tier.Cost < 0 {
			return errors.New("tier cost must not be negative")
		}
		if seen[tier.MinLength] {
			return fmt.Errorf("duplicate tier minLength %d", tier.MinLength)
		}
		seen[tier.MinLength] = true
		if tier.MinLength == usernameChangeMinLength {
			hasBaseTier = true
		}
	}
	if !hasBaseTier {
		return fmt.Errorf("tiers must include minLength %d so every username length has a price", usernameChangeMinLength)
	}
	return nil
}
