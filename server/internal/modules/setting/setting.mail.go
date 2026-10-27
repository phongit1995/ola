package setting

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"net/mail"
	"strings"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"
)

const (
	KeyMailResend = "mail_resend"

	resendAPIKeyPrefix    = "re_"
	resendAPIKeyMinLength = 10
	resendAPIKeyMaxLength = 200
	mailFromMaxLength     = 200
	mailKeyHintLength     = 4
)

type MailResendInput struct {
	APIKey string `json:"apiKey"`
	From   string `json:"from"`
}

type MailResendStored struct {
	Enc     string `json:"enc"`
	KeyHint string `json:"keyHint"`
	From    string `json:"from"`
}

func ValidateMailResendValue(value models.JSONB) (MailResendInput, error) {
	raw, err := json.Marshal(value)
	if err != nil {
		return MailResendInput{}, errors.New("invalid mail_resend config")
	}
	var input MailResendInput
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&input); err != nil {
		return MailResendInput{}, errors.New("invalid mail_resend config: " + err.Error())
	}
	input.APIKey = strings.TrimSpace(input.APIKey)
	input.From = strings.TrimSpace(input.From)
	if input.From == "" {
		return MailResendInput{}, errors.New("cần nhập địa chỉ người gửi")
	}
	if len(input.From) > mailFromMaxLength {
		return MailResendInput{}, fmt.Errorf("địa chỉ người gửi tối đa %d ký tự", mailFromMaxLength)
	}
	if _, err := mail.ParseAddress(input.From); err != nil {
		return MailResendInput{}, errors.New("địa chỉ người gửi không hợp lệ, ví dụ: Ola Chat <noreply@olachat.net>")
	}
	if input.APIKey == "" {
		return input, nil
	}
	if !strings.HasPrefix(input.APIKey, resendAPIKeyPrefix) || strings.ContainsAny(input.APIKey, " \t\r\n") {
		return MailResendInput{}, errors.New("API key Resend phải bắt đầu bằng re_ và không có khoảng trắng")
	}
	if len(input.APIKey) < resendAPIKeyMinLength || len(input.APIKey) > resendAPIKeyMaxLength {
		return MailResendInput{}, fmt.Errorf("API key Resend phải dài từ %d đến %d ký tự", resendAPIKeyMinLength, resendAPIKeyMaxLength)
	}
	return input, nil
}

func (s *Service) BuildMailResendValue(cfg *config.Config, input MailResendInput) (models.JSONB, error) {
	if input.APIKey == "" {
		current, err := s.storedMailResend()
		if err != nil {
			return nil, err
		}
		if current.Enc == "" {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "cần nhập API key Resend")
		}
		return mailResendJSON(MailResendStored{Enc: current.Enc, KeyHint: current.KeyHint, From: input.From}), nil
	}
	enc, err := encryptSettingSecret(cfg, []byte(input.APIKey))
	if err != nil {
		return nil, err
	}
	hint := input.APIKey[len(input.APIKey)-mailKeyHintLength:]
	return mailResendJSON(MailResendStored{Enc: enc, KeyHint: hint, From: input.From}), nil
}

func (s *Service) storedMailResend() (MailResendStored, error) {
	var stored MailResendStored
	item, err := s.repo.Get(KeyMailResend)
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

func mailResendJSON(stored MailResendStored) models.JSONB {
	return models.JSONB{"enc": stored.Enc, "keyHint": stored.KeyHint, "from": stored.From}
}

func MaskMailResendValue(value models.JSONB) models.JSONB {
	if value == nil {
		return nil
	}
	enc, _ := value["enc"].(string)
	keyHint, _ := value["keyHint"].(string)
	from, _ := value["from"].(string)
	return models.JSONB{
		"configured": enc != "",
		"keyHint":    keyHint,
		"from":       from,
	}
}

type mailCredentialSource struct {
	service *Service
	cfg     *config.Config
}

func NewMailCredentialSource(service *Service, cfg *config.Config) services.MailCredentialSource {
	return &mailCredentialSource{service: service, cfg: cfg}
}

func (m *mailCredentialSource) MailCredential() (services.MailCredential, bool, error) {
	var stored MailResendStored
	if err := m.service.getInto(KeyMailResend, &stored); err != nil {
		return services.MailCredential{}, false, err
	}
	if stored.Enc == "" {
		return services.MailCredential{}, false, nil
	}
	apiKey, err := DecryptSettingSecret(m.cfg, stored.Enc)
	if err != nil {
		return services.MailCredential{}, false, fmt.Errorf("decrypt mail_resend api key: %w", err)
	}
	return services.MailCredential{APIKey: string(apiKey), From: stored.From}, true, nil
}
