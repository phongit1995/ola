package setting

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"net/url"
	"regexp"
	"strings"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"
)

var (
	discordWebhookHosts = map[string]bool{
		"discord.com":        true,
		"discordapp.com":     true,
		"ptb.discord.com":    true,
		"canary.discord.com": true,
	}
	telegramBotTokenPattern = regexp.MustCompile(`^\d{5,15}:[A-Za-z0-9_-]{30,64}$`)
	telegramChatIDPattern   = regexp.MustCompile(`^(-?\d{1,20}|@[A-Za-z][A-Za-z0-9_]{4,31})$`)
)

type ReportAlertDiscordInput struct {
	Enabled    bool   `json:"enabled"`
	WebhookURL string `json:"webhookUrl"`
}

type ReportAlertTelegramInput struct {
	Enabled  bool   `json:"enabled"`
	BotToken string `json:"botToken"`
	ChatID   string `json:"chatId"`
}

type ReportAlertInput struct {
	AdminURL string                   `json:"adminUrl"`
	Discord  ReportAlertDiscordInput  `json:"discord"`
	Telegram ReportAlertTelegramInput `json:"telegram"`
}

type reportAlertChannelStored struct {
	Enabled bool   `json:"enabled"`
	Enc     string `json:"enc"`
	Hint    string `json:"hint"`
	ChatID  string `json:"chatId,omitempty"`
}

type reportAlertStored struct {
	AdminURL string                   `json:"adminUrl"`
	Discord  reportAlertChannelStored `json:"discord"`
	Telegram reportAlertChannelStored `json:"telegram"`
}

type ReportAlertCredentials struct {
	AdminURL          string
	DiscordWebhookURL string
	TelegramBotToken  string
	TelegramChatID    string
}

func ValidateReportAlertValue(value models.JSONB) (ReportAlertInput, error) {
	raw, err := json.Marshal(value)
	if err != nil {
		return ReportAlertInput{}, errors.New("invalid report_alert config")
	}
	var input ReportAlertInput
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&input); err != nil {
		return ReportAlertInput{}, errors.New("invalid report_alert config: " + err.Error())
	}
	input.AdminURL = strings.TrimRight(strings.TrimSpace(input.AdminURL), "/")
	input.Discord.WebhookURL = strings.TrimSpace(input.Discord.WebhookURL)
	input.Telegram.BotToken = strings.TrimSpace(input.Telegram.BotToken)
	input.Telegram.ChatID = strings.TrimSpace(input.Telegram.ChatID)

	if input.AdminURL != "" {
		if err := validateReportAlertAdminURL(input.AdminURL); err != nil {
			return ReportAlertInput{}, err
		}
	}
	if input.Discord.WebhookURL != "" {
		if err := validateDiscordWebhookURL(input.Discord.WebhookURL); err != nil {
			return ReportAlertInput{}, err
		}
	}
	if input.Telegram.BotToken != "" && !telegramBotTokenPattern.MatchString(input.Telegram.BotToken) {
		return ReportAlertInput{}, errors.New("bot token Telegram không hợp lệ, dạng đúng: 123456789:AAH...")
	}
	if input.Telegram.ChatID != "" && !telegramChatIDPattern.MatchString(input.Telegram.ChatID) {
		return ReportAlertInput{}, errors.New("chat ID Telegram không hợp lệ, dạng đúng: -1001234567890 hoặc @tenkenh")
	}
	if input.Telegram.Enabled && input.Telegram.ChatID == "" {
		return ReportAlertInput{}, errors.New("cần nhập chat ID Telegram trước khi bật")
	}
	return input, nil
}

func validateReportAlertAdminURL(raw string) error {
	if len(raw) > reportAlertAdminURLMaxLen {
		return fmt.Errorf("link trang admin tối đa %d ký tự", reportAlertAdminURLMaxLen)
	}
	parsed, err := url.Parse(raw)
	if err != nil || (parsed.Scheme != "https" && parsed.Scheme != "http") || parsed.Host == "" {
		return errors.New("link trang admin không hợp lệ")
	}
	return nil
}

func validateDiscordWebhookURL(raw string) error {
	if len(raw) > discordWebhookMaxLength {
		return fmt.Errorf("webhook Discord tối đa %d ký tự", discordWebhookMaxLength)
	}
	parsed, err := url.Parse(raw)
	if err != nil || parsed.Scheme != "https" || !discordWebhookHosts[strings.ToLower(parsed.Host)] ||
		!strings.HasPrefix(parsed.Path, discordWebhookPathPrefix) {
		return errors.New("webhook Discord không hợp lệ, dạng đúng: https://discord.com/api/webhooks/...")
	}
	return nil
}

func (s *Service) BuildReportAlertValue(cfg *config.Config, input ReportAlertInput) (models.JSONB, error) {
	current, err := s.storedReportAlert()
	if err != nil {
		return nil, err
	}
	discord, err := nextReportAlertChannel(cfg, current.Discord, input.Discord.Enabled, input.Discord.WebhookURL, "")
	if err != nil {
		return nil, err
	}
	if discord.Enabled && discord.Enc == "" {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "cần nhập webhook Discord trước khi bật")
	}
	telegram, err := nextReportAlertChannel(cfg, current.Telegram, input.Telegram.Enabled, input.Telegram.BotToken, input.Telegram.ChatID)
	if err != nil {
		return nil, err
	}
	if telegram.Enabled && telegram.Enc == "" {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "cần nhập bot token Telegram trước khi bật")
	}
	return reportAlertJSON(reportAlertStored{AdminURL: input.AdminURL, Discord: discord, Telegram: telegram}), nil
}

func nextReportAlertChannel(cfg *config.Config, current reportAlertChannelStored, enabled bool, secret, chatID string) (reportAlertChannelStored, error) {
	next := reportAlertChannelStored{Enabled: enabled, Enc: current.Enc, Hint: current.Hint, ChatID: chatID}
	if secret == "" {
		return next, nil
	}
	enc, err := encryptSettingSecret(cfg, []byte(secret))
	if err != nil {
		return reportAlertChannelStored{}, err
	}
	next.Enc = enc
	next.Hint = secret[len(secret)-reportAlertSecretHintLen:]
	return next, nil
}

func (s *Service) storedReportAlert() (reportAlertStored, error) {
	var stored reportAlertStored
	item, err := s.repo.Get(KeyReportAlert)
	if err != nil || item == nil {
		return stored, err
	}
	raw, err := json.Marshal(item.Value)
	if err != nil {
		return stored, err
	}
	err = json.Unmarshal(raw, &stored)
	return stored, err
}

func reportAlertChannelJSON(channel reportAlertChannelStored) models.JSONB {
	value := models.JSONB{"enabled": channel.Enabled, "enc": channel.Enc, "hint": channel.Hint}
	if channel.ChatID != "" {
		value["chatId"] = channel.ChatID
	}
	return value
}

func reportAlertJSON(stored reportAlertStored) models.JSONB {
	return models.JSONB{
		"adminUrl": stored.AdminURL,
		"discord":  reportAlertChannelJSON(stored.Discord),
		"telegram": reportAlertChannelJSON(stored.Telegram),
	}
}

func MaskReportAlertValue(value models.JSONB) models.JSONB {
	if value == nil {
		return nil
	}
	raw, err := json.Marshal(value)
	if err != nil {
		return nil
	}
	var stored reportAlertStored
	if err := json.Unmarshal(raw, &stored); err != nil {
		return nil
	}
	mask := func(channel reportAlertChannelStored, configured bool) models.JSONB {
		masked := models.JSONB{
			"enabled":    channel.Enabled,
			"configured": configured,
			"hint":       channel.Hint,
		}
		if channel.ChatID != "" {
			masked["chatId"] = channel.ChatID
		}
		return masked
	}
	return models.JSONB{
		"adminUrl": stored.AdminURL,
		"discord":  mask(stored.Discord, stored.Discord.Enc != ""),
		"telegram": mask(stored.Telegram, stored.Telegram.Enc != "" && stored.Telegram.ChatID != ""),
	}
}

func (s *Service) EnabledReportAlertCredentials(cfg *config.Config) (ReportAlertCredentials, error) {
	var stored reportAlertStored
	if err := s.getInto(KeyReportAlert, &stored); err != nil {
		return ReportAlertCredentials{}, err
	}
	return enabledReportAlertCredentials(cfg, stored)
}

func enabledReportAlertCredentials(cfg *config.Config, stored reportAlertStored) (ReportAlertCredentials, error) {
	creds := ReportAlertCredentials{AdminURL: stored.AdminURL}
	var errs []error
	if stored.Discord.Enabled {
		errs = append(errs, creds.fill(cfg, ReportAlertChannelDiscord, stored))
	}
	if stored.Telegram.Enabled {
		errs = append(errs, creds.fill(cfg, ReportAlertChannelTelegram, stored))
	}
	return creds, errors.Join(errs...)
}

func (s *Service) ReportAlertChannelCredentials(cfg *config.Config, channel string) (ReportAlertCredentials, bool, error) {
	var stored reportAlertStored
	if err := s.getInto(KeyReportAlert, &stored); err != nil {
		return ReportAlertCredentials{}, false, err
	}
	creds := ReportAlertCredentials{AdminURL: stored.AdminURL}
	enabled := stored.Discord.Enabled
	if channel == ReportAlertChannelTelegram {
		enabled = stored.Telegram.Enabled
	}
	err := creds.fill(cfg, channel, stored)
	return creds, enabled, err
}

func (c *ReportAlertCredentials) fill(cfg *config.Config, channel string, stored reportAlertStored) error {
	switch channel {
	case ReportAlertChannelDiscord:
		if stored.Discord.Enc == "" {
			return nil
		}
		plain, err := DecryptSettingSecret(cfg, stored.Discord.Enc)
		if err != nil {
			return fmt.Errorf("decrypt report_alert discord webhook: %w", err)
		}
		c.DiscordWebhookURL = string(plain)
	case ReportAlertChannelTelegram:
		if stored.Telegram.Enc == "" || stored.Telegram.ChatID == "" {
			return nil
		}
		plain, err := DecryptSettingSecret(cfg, stored.Telegram.Enc)
		if err != nil {
			return fmt.Errorf("decrypt report_alert telegram token: %w", err)
		}
		c.TelegramBotToken = string(plain)
		c.TelegramChatID = stored.Telegram.ChatID
	}
	return nil
}
