package setting

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"strings"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/models"
)

const (
	KeyAnalytics = "analytics"

	analyticsPropertyIDMaxLength = 20
)

type AnalyticsConfig struct {
	MobilePropertyID string `json:"mobilePropertyId"`
	WebPropertyID    string `json:"webPropertyId"`
}

type GoogleServiceAccount struct {
	JSON        []byte
	ClientEmail string
}

func (s *Service) GetAnalytics() (AnalyticsConfig, error) {
	var cfg AnalyticsConfig
	err := s.getInto(KeyAnalytics, &cfg)
	return cfg, err
}

func (s *Service) GetGoogleServiceAccount(cfg *config.Config) (GoogleServiceAccount, bool, error) {
	var stored PushFirebaseStored
	if err := s.getInto(KeyPushFirebase, &stored); err != nil {
		return GoogleServiceAccount{}, false, err
	}
	if stored.Enc == "" {
		return GoogleServiceAccount{}, false, nil
	}
	creds, err := DecryptSettingSecret(cfg, stored.Enc)
	if err != nil {
		return GoogleServiceAccount{}, false, fmt.Errorf("decrypt push_firebase credential: %w", err)
	}
	return GoogleServiceAccount{JSON: creds, ClientEmail: stored.ClientEmail}, true, nil
}

func ValidateAnalyticsValue(value models.JSONB) (models.JSONB, error) {
	raw, err := json.Marshal(value)
	if err != nil {
		return nil, errors.New("invalid analytics config")
	}
	var cfg AnalyticsConfig
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&cfg); err != nil {
		return nil, errors.New("invalid analytics config: " + err.Error())
	}
	cfg.MobilePropertyID = strings.TrimSpace(cfg.MobilePropertyID)
	cfg.WebPropertyID = strings.TrimSpace(cfg.WebPropertyID)
	if !validAnalyticsPropertyID(cfg.MobilePropertyID) || !validAnalyticsPropertyID(cfg.WebPropertyID) {
		return nil, errors.New("Property ID chỉ gồm chữ số, ví dụ 412345678 (không phải mã G-XXXX)")
	}
	return models.JSONB{"mobilePropertyId": cfg.MobilePropertyID, "webPropertyId": cfg.WebPropertyID}, nil
}

func validAnalyticsPropertyID(id string) bool {
	if len(id) > analyticsPropertyIDMaxLength {
		return false
	}
	for _, r := range id {
		if r < '0' || r > '9' {
			return false
		}
	}
	return true
}
