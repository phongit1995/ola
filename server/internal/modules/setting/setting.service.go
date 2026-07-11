package setting

import (
	"encoding/json"
	"strings"

	"ola-chat-server/internal/models"

	"go.uber.org/zap"
)

const (
	KeyTopupBank = "topup_bank"
	KeyTopup     = "topup"
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
