package setting

import (
	"bytes"
	"crypto/x509"
	"encoding/json"
	"encoding/pem"
	"errors"
	"fmt"
	"sort"
	"strings"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"go.uber.org/zap"
)

const (
	KeyTopupBank        = "topup_bank"
	KeyTopup            = "topup"
	KeyUsernameChange   = "username_change"
	KeyPushFirebase     = "push_firebase"
	KeyPushNotification = "push_notification"

	usernameChangeMinLength = 2
	usernameChangeMaxLength = 20
	topupBonusPercentMax    = 500
)

type PushNotificationConfig struct {
	Enabled bool `json:"enabled"`
}

type PushFirebaseStored struct {
	Enc         string `json:"enc"`
	ProjectID   string `json:"projectId"`
	ClientEmail string `json:"clientEmail"`
}

type TopupBankConfig struct {
	BankName          string `json:"bankName"`
	BankBin           string `json:"bankBin"`
	AccountNumber     string `json:"accountNumber"`
	AccountName       string `json:"accountName"`
	MemoTemplate      string `json:"memoTemplate"`
	SieuthicodeSecret string `json:"sieuthicodeSecret"`
	DiscordWebhookURL string `json:"discordWebhookUrl"`
}

type TopupBonusTier struct {
	MinAmount int `json:"minAmount"`
	Percent   int `json:"percent"`
}

type TopupConfig struct {
	Enabled       bool             `json:"enabled"`
	EnabledMobile bool             `json:"enabledMobile"`
	MinAmount     int              `json:"minAmount"`
	StepAmount    int              `json:"stepAmount"`
	PresetAmounts []int            `json:"presetAmounts"`
	BonusTiers    []TopupBonusTier `json:"bonusTiers"`
}

type TopupQuote struct {
	Base         int64
	BonusPercent int
	Bonus        int64
	Total        int64
}

func DefaultTopupConfig() TopupConfig {
	return TopupConfig{
		Enabled:       true,
		EnabledMobile: true,
		MinAmount:     10_000,
		StepAmount:    1_000,
		PresetAmounts: []int{10_000, 20_000, 50_000, 100_000, 200_000, 500_000},
		BonusTiers:    []TopupBonusTier{},
	}
}

func (c TopupConfig) BonusPercentFor(amountVnd int64) int {
	percent := 0
	bestMin := int64(-1)
	for _, tier := range c.BonusTiers {
		minAmount := int64(tier.MinAmount)
		if amountVnd >= minAmount && minAmount > bestMin {
			bestMin = minAmount
			percent = tier.Percent
		}
	}
	return percent
}

func (c TopupConfig) QuoteKen(amountVnd int64) TopupQuote {
	percent := c.BonusPercentFor(amountVnd)
	bonus := amountVnd * int64(percent) / 100
	return TopupQuote{Base: amountVnd, BonusPercent: percent, Bonus: bonus, Total: amountVnd + bonus}
}

func normalizeBonusTiers(tiers []TopupBonusTier) []TopupBonusTier {
	out := make([]TopupBonusTier, 0, len(tiers))
	seen := make(map[int]bool, len(tiers))
	for _, tier := range tiers {
		if tier.MinAmount < 0 || tier.Percent < 0 || tier.Percent > topupBonusPercentMax || seen[tier.MinAmount] {
			continue
		}
		seen[tier.MinAmount] = true
		out = append(out, tier)
	}
	sort.Slice(out, func(i, j int) bool { return out[i].MinAmount < out[j].MinAmount })
	return out
}

func DefaultTopupBankConfig() TopupBankConfig {
	return TopupBankConfig{MemoTemplate: "@{username}"}
}

type UsernameChangeTier struct {
	MinLength int `json:"minLength"`
	Cost      int `json:"cost"`
}

type UsernameChangeConfig struct {
	Enabled       bool                 `json:"enabled"`
	EnabledMobile bool                 `json:"enabledMobile"`
	Tiers         []UsernameChangeTier `json:"tiers"`
}

func DefaultUsernameChangeConfig() UsernameChangeConfig {
	return UsernameChangeConfig{
		Enabled:       true,
		EnabledMobile: true,
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

func (s *Service) PutMany(items []models.AppSetting) ([]models.AppSetting, error) {
	for i := range items {
		items[i].Key = strings.TrimSpace(items[i].Key)
	}
	if err := s.repo.UpsertMany(items); err != nil {
		return nil, err
	}
	saved := make([]models.AppSetting, 0, len(items))
	for _, item := range items {
		current, err := s.repo.Get(item.Key)
		if err != nil {
			return nil, err
		}
		if current != nil {
			saved = append(saved, *current)
		}
	}
	return saved, nil
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
	cfg.BonusTiers = normalizeBonusTiers(cfg.BonusTiers)
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

func ValidatePushFirebaseValue(value models.JSONB) error {
	accountType, _ := value["type"].(string)
	projectID, _ := value["project_id"].(string)
	privateKey, _ := value["private_key"].(string)
	clientEmail, _ := value["client_email"].(string)
	if accountType != "service_account" {
		return errors.New("file phải là service account JSON (type = service_account)")
	}
	if projectID == "" || privateKey == "" || clientEmail == "" {
		return errors.New("service account JSON thiếu project_id, private_key hoặc client_email")
	}
	block, _ := pem.Decode([]byte(privateKey))
	if block == nil {
		return errors.New("private_key không đúng định dạng PEM")
	}
	if _, err := x509.ParsePKCS8PrivateKey(block.Bytes); err != nil {
		if _, err := x509.ParsePKCS1PrivateKey(block.Bytes); err != nil {
			return errors.New("private_key không phải khoá RSA hợp lệ")
		}
	}
	return nil
}

func ValidatePushNotificationValue(value models.JSONB) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return errors.New("invalid push_notification config")
	}
	var cfg PushNotificationConfig
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&cfg); err != nil {
		return errors.New("invalid push_notification config: " + err.Error())
	}
	return nil
}

const pushCredentialEncVersion = "v1:"

func PushCredentialSecrets(cfg *config.Config) []string {
	secrets := make([]string, 0, 2)
	if cfg.SettingsEncKey != "" {
		secrets = append(secrets, cfg.SettingsEncKey)
	}
	if cfg.JWTSecret != "" {
		secrets = append(secrets, cfg.JWTSecret)
	}
	return secrets
}

func EncryptPushFirebaseValue(cfg *config.Config, value models.JSONB) (models.JSONB, error) {
	secrets := PushCredentialSecrets(cfg)
	if len(secrets) == 0 {
		return nil, errors.New("no encryption secret configured")
	}
	raw, err := json.Marshal(value)
	if err != nil {
		return nil, errors.New("invalid service account JSON")
	}
	enc, err := utils.EncryptWithSecret(secrets[0], raw)
	if err != nil {
		return nil, err
	}
	projectID, _ := value["project_id"].(string)
	clientEmail, _ := value["client_email"].(string)
	return models.JSONB{
		"enc":         pushCredentialEncVersion + enc,
		"projectId":   projectID,
		"clientEmail": clientEmail,
	}, nil
}

func DecryptPushCredential(cfg *config.Config, enc string) ([]byte, error) {
	enc = strings.TrimPrefix(enc, pushCredentialEncVersion)
	var lastErr error
	for _, secret := range PushCredentialSecrets(cfg) {
		plain, err := utils.DecryptWithSecret(secret, enc)
		if err == nil {
			return plain, nil
		}
		lastErr = err
	}
	if lastErr == nil {
		lastErr = errors.New("no encryption secret configured")
	}
	return nil, lastErr
}

func MaskPushFirebaseValue(value models.JSONB) models.JSONB {
	if value == nil {
		return nil
	}
	projectID, _ := value["projectId"].(string)
	clientEmail, _ := value["clientEmail"].(string)
	return models.JSONB{
		"configured":  true,
		"projectId":   projectID,
		"clientEmail": clientEmail,
	}
}

func ValidateTopupValue(value models.JSONB) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return errors.New("invalid topup config")
	}
	var cfg TopupConfig
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&cfg); err != nil {
		return errors.New("invalid topup config: " + err.Error())
	}
	if cfg.MinAmount <= 0 {
		return errors.New("số tiền tối thiểu phải lớn hơn 0")
	}
	if cfg.StepAmount <= 0 {
		return errors.New("bội số phải lớn hơn 0")
	}
	if cfg.MinAmount%cfg.StepAmount != 0 {
		return fmt.Errorf("số tiền tối thiểu phải là bội số của %d", cfg.StepAmount)
	}
	if len(cfg.PresetAmounts) == 0 {
		return errors.New("cần ít nhất một mệnh giá gợi ý")
	}
	for _, preset := range cfg.PresetAmounts {
		if preset < cfg.MinAmount || preset%cfg.StepAmount != 0 {
			return fmt.Errorf("mệnh giá %d phải từ mức tối thiểu và là bội số của %d", preset, cfg.StepAmount)
		}
	}
	seen := make(map[int]bool, len(cfg.BonusTiers))
	for _, tier := range cfg.BonusTiers {
		if tier.MinAmount < 0 {
			return errors.New("mốc thưởng không được âm")
		}
		if tier.Percent < 0 || tier.Percent > topupBonusPercentMax {
			return fmt.Errorf("phần trăm thưởng phải từ 0 đến %d", topupBonusPercentMax)
		}
		if seen[tier.MinAmount] {
			return fmt.Errorf("mốc thưởng %d bị khai báo hai lần", tier.MinAmount)
		}
		seen[tier.MinAmount] = true
	}
	return nil
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
