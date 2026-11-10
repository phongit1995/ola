package setting

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"

	"ola-chat-server/internal/models"
)

const (
	KeyVipDayTransfer = "vip_day_transfer"

	VipDayTransferMaxSenderDays = 36500

	vipDayTransferDefaultRate          = 3
	vipDayTransferDefaultMinSenderDays = 10
	vipDayTransferRateMax              = 1000
)

type VipDayTransferConfig struct {
	Platforms     PlatformRules `json:"platforms"`
	Rate          int           `json:"rate"`
	MinSenderDays int           `json:"minSenderDays"`
}

type VipDayTransferPublicConfig struct {
	Enabled       bool `json:"enabled" example:"true"`
	Rate          int  `json:"rate" example:"3"`
	MinSenderDays int  `json:"minSenderDays" example:"10"`
}

func DefaultVipDayTransferConfig() VipDayTransferConfig {
	return VipDayTransferConfig{Platforms: PlatformRules{}, Rate: vipDayTransferDefaultRate, MinSenderDays: vipDayTransferDefaultMinSenderDays}
}

func (c VipDayTransferConfig) EnabledFor(client Client) bool {
	return c.Platforms.EnabledForClient(client)
}

func (c VipDayTransferConfig) PublicFor(client Client) VipDayTransferPublicConfig {
	return VipDayTransferPublicConfig{Enabled: c.EnabledFor(client), Rate: c.Rate, MinSenderDays: c.MinSenderDays}
}

func (c VipDayTransferConfig) ReceiverDaysFor(senderDays int) (int, bool) {
	if senderDays < c.MinSenderDays || senderDays > VipDayTransferMaxSenderDays {
		return 0, false
	}
	return (senderDays + c.Rate - 1) / c.Rate, true
}

func validVipDayTransferRate(rate int) bool {
	return rate >= 1 && rate <= vipDayTransferRateMax
}

func validVipDayTransferMinSenderDays(days int) bool {
	return days >= 1 && days <= VipDayTransferMaxSenderDays
}

func (s *Service) GetVipDayTransfer() (VipDayTransferConfig, error) {
	cfg := DefaultVipDayTransferConfig()
	err := s.getInto(KeyVipDayTransfer, &cfg)
	cfg.Platforms = cfg.Platforms.normalized()
	if !validVipDayTransferRate(cfg.Rate) {
		s.logger.Warnw("Invalid vip_day_transfer rate in app_settings, using default", "rate", cfg.Rate)
		cfg.Rate = vipDayTransferDefaultRate
	}
	if !validVipDayTransferMinSenderDays(cfg.MinSenderDays) {
		s.logger.Warnw("Invalid vip_day_transfer minSenderDays in app_settings, using default", "minSenderDays", cfg.MinSenderDays)
		cfg.MinSenderDays = vipDayTransferDefaultMinSenderDays
	}
	return cfg, err
}

func ValidateVipDayTransferValue(value models.JSONB) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return errors.New("invalid vip_day_transfer config")
	}
	var cfg struct {
		Platforms     *platformRulesInput `json:"platforms"`
		Rate          *int                `json:"rate"`
		MinSenderDays *int                `json:"minSenderDays"`
	}
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&cfg); err != nil {
		return errors.New("invalid vip_day_transfer config: " + err.Error())
	}
	if cfg.Platforms == nil || cfg.Rate == nil || cfg.MinSenderDays == nil {
		return errors.New("cấu hình chuyển NSD cần đủ platforms, rate và minSenderDays")
	}
	if !validVipDayTransferRate(*cfg.Rate) {
		return fmt.Errorf("hệ số phải từ 1 đến %d", vipDayTransferRateMax)
	}
	if !validVipDayTransferMinSenderDays(*cfg.MinSenderDays) {
		return fmt.Errorf("số ngày tối thiểu phải từ 1 đến %d", VipDayTransferMaxSenderDays)
	}
	return cfg.Platforms.validate()
}
