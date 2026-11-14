package setting

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"time"

	"ola-chat-server/internal/models"
)

const (
	KeyMegaphone = "megaphone"

	MegaphoneSenderDisplayVip    = "vip"
	MegaphoneSenderDisplayAvatar = "avatar"

	MegaphoneKenPriceMax        = 1000000
	MegaphoneMaxLengthLimit     = 200
	MegaphoneDisplaySecondsMin  = 3
	MegaphoneDisplaySecondsMax  = 60
	MegaphoneCooldownSecondsMax = 24 * 60 * 60
	MegaphoneDailyLimitMax      = 1000
	MegaphoneLiveMinutesMax     = 24 * 60
	MegaphoneGapSecondsMax      = 60
	MegaphoneRepeatBaseMin      = 10
	MegaphoneRepeatBaseMax      = 24 * 60 * 60
	MegaphoneWeightMax          = 20
	MegaphoneGiftTiersMax       = 10

	megaphoneKenPriceDefault        = 5000
	megaphoneMaxLengthDefault       = 80
	megaphoneDisplaySecondsDefault  = 12
	megaphoneCooldownSecondsDefault = 60
	megaphoneDailyLimitDefault      = 20
	megaphoneLiveMinutesDefault     = 30
	megaphoneGapSecondsDefault      = 3
	megaphoneRepeatBaseDefault      = 720
	megaphoneMessageWeightDefault   = 3

	secondsPerMinute         = 60
	megaphoneWaitShareOfLive = 3
	megaphoneGiftWaitShare   = 2
)

type MegaphoneGiftTier struct {
	MinKen int `json:"minKen"`
	Weight int `json:"weight"`
}

type MegaphoneConfig struct {
	Enabled           bool                `json:"enabled"`
	Platforms         PlatformRules       `json:"platforms"`
	KenPrice          int                 `json:"kenPrice"`
	MaxLength         int                 `json:"maxLength"`
	DisplaySeconds    int                 `json:"displaySeconds"`
	CooldownSeconds   int                 `json:"cooldownSeconds"`
	DailyLimit        int                 `json:"dailyLimit"`
	LiveMinutes       int                 `json:"liveMinutes"`
	GapSeconds        int                 `json:"gapSeconds"`
	RepeatBaseSeconds int                 `json:"repeatBaseSeconds"`
	MessageWeight     int                 `json:"messageWeight"`
	GiftTiers         []MegaphoneGiftTier `json:"giftTiers"`
	SenderDisplay     string              `json:"senderDisplay"`
}

type MegaphonePublicConfig struct {
	Enabled         bool   `json:"enabled"`
	KenPrice        int    `json:"kenPrice"`
	MaxLength       int    `json:"maxLength"`
	DisplaySeconds  int    `json:"displaySeconds"`
	LiveMinutes     int    `json:"liveMinutes"`
	CooldownSeconds int    `json:"cooldownSeconds"`
	DailyLimit      int    `json:"dailyLimit"`
	SenderDisplay   string `json:"senderDisplay"`
}

func DefaultMegaphoneConfig() MegaphoneConfig {
	return MegaphoneConfig{
		Enabled:           true,
		Platforms:         OpenPlatformRules(),
		KenPrice:          megaphoneKenPriceDefault,
		MaxLength:         megaphoneMaxLengthDefault,
		DisplaySeconds:    megaphoneDisplaySecondsDefault,
		CooldownSeconds:   megaphoneCooldownSecondsDefault,
		DailyLimit:        megaphoneDailyLimitDefault,
		LiveMinutes:       megaphoneLiveMinutesDefault,
		GapSeconds:        megaphoneGapSecondsDefault,
		RepeatBaseSeconds: megaphoneRepeatBaseDefault,
		MessageWeight:     megaphoneMessageWeightDefault,
		GiftTiers: []MegaphoneGiftTier{
			{MinKen: 0, Weight: 1},
			{MinKen: 1000, Weight: 3},
			{MinKen: 20000, Weight: 6},
		},
		SenderDisplay: MegaphoneSenderDisplayVip,
	}
}

func (c MegaphoneConfig) EnabledFor(client Client) bool {
	return c.Enabled && c.Platforms.EnabledForClient(client)
}

func (c MegaphoneConfig) PublicFor(client Client) MegaphonePublicConfig {
	return MegaphonePublicConfig{
		Enabled:         c.EnabledFor(client),
		KenPrice:        c.KenPrice,
		MaxLength:       c.MaxLength,
		DisplaySeconds:  c.DisplaySeconds,
		LiveMinutes:     c.LiveMinutes,
		CooldownSeconds: c.CooldownSeconds,
		DailyLimit:      c.DailyLimit,
		SenderDisplay:   c.SenderDisplay,
	}
}

func (c MegaphoneConfig) SlotSeconds() int {
	return c.DisplaySeconds + c.GapSeconds
}

func (c MegaphoneConfig) LiveDuration() time.Duration {
	return time.Duration(c.LiveMinutes) * time.Minute
}

func (c MegaphoneConfig) MessageQueueLimit() int {
	limit := c.LiveMinutes * secondsPerMinute / megaphoneWaitShareOfLive / c.SlotSeconds()
	if limit < 1 {
		return 1
	}
	return limit
}

func (c MegaphoneConfig) GiftQueueLimit() int {
	limit := c.MessageQueueLimit() / megaphoneGiftWaitShare
	if limit < 1 {
		return 1
	}
	return limit
}

func (c MegaphoneConfig) GiftWeight(totalKen int) int {
	weight := 1
	for _, tier := range c.GiftTiers {
		if totalKen >= tier.MinKen {
			weight = tier.Weight
		}
	}
	return weight
}

func (s *Service) GetMegaphone() (MegaphoneConfig, error) {
	cfg := DefaultMegaphoneConfig()
	err := s.getInto(KeyMegaphone, &cfg)
	if validateMegaphoneConfig(cfg) != nil {
		s.logger.Warnw("Invalid megaphone config in app_settings, using default", "value", cfg)
		return DefaultMegaphoneConfig(), err
	}
	cfg.Platforms = cfg.Platforms.normalized()
	return cfg, err
}

func validateMegaphoneConfig(cfg MegaphoneConfig) error {
	if cfg.KenPrice < 0 || cfg.KenPrice > MegaphoneKenPriceMax {
		return fmt.Errorf("giá phát loa phải từ 0 đến %d KEN", MegaphoneKenPriceMax)
	}
	if cfg.MaxLength < 1 || cfg.MaxLength > MegaphoneMaxLengthLimit {
		return fmt.Errorf("số ký tự tối đa phải từ 1 đến %d", MegaphoneMaxLengthLimit)
	}
	if cfg.DisplaySeconds < MegaphoneDisplaySecondsMin || cfg.DisplaySeconds > MegaphoneDisplaySecondsMax {
		return fmt.Errorf("thời gian hiện mỗi loa phải từ %d đến %d giây", MegaphoneDisplaySecondsMin, MegaphoneDisplaySecondsMax)
	}
	if cfg.CooldownSeconds < 0 || cfg.CooldownSeconds > MegaphoneCooldownSecondsMax {
		return fmt.Errorf("thời gian chờ giữa 2 lần phát phải từ 0 đến %d giây", MegaphoneCooldownSecondsMax)
	}
	if cfg.DailyLimit < 1 || cfg.DailyLimit > MegaphoneDailyLimitMax {
		return fmt.Errorf("số loa mỗi ngày phải từ 1 đến %d", MegaphoneDailyLimitMax)
	}
	if cfg.LiveMinutes < 1 || cfg.LiveMinutes > MegaphoneLiveMinutesMax {
		return fmt.Errorf("thời gian sống phải từ 1 đến %d phút", MegaphoneLiveMinutesMax)
	}
	if cfg.GapSeconds < 0 || cfg.GapSeconds > MegaphoneGapSecondsMax {
		return fmt.Errorf("thời gian nghỉ giữa 2 lượt phải từ 0 đến %d giây", MegaphoneGapSecondsMax)
	}
	if cfg.SlotSeconds() >= cfg.LiveMinutes*secondsPerMinute {
		return errors.New("thời gian chạy cộng thời gian nghỉ phải ngắn hơn thời gian sống")
	}
	if cfg.RepeatBaseSeconds < MegaphoneRepeatBaseMin || cfg.RepeatBaseSeconds > MegaphoneRepeatBaseMax {
		return fmt.Errorf("nhịp lặp phải từ %d đến %d giây", MegaphoneRepeatBaseMin, MegaphoneRepeatBaseMax)
	}
	if cfg.MessageWeight < 1 || cfg.MessageWeight > MegaphoneWeightMax {
		return fmt.Errorf("trọng số loa phải từ 1 đến %d", MegaphoneWeightMax)
	}
	if cfg.SenderDisplay != MegaphoneSenderDisplayVip && cfg.SenderDisplay != MegaphoneSenderDisplayAvatar {
		return errors.New("hiển thị người gửi phải là vip hoặc avatar")
	}
	return validateMegaphoneGiftTiers(cfg.GiftTiers)
}

func validateMegaphoneGiftTiers(tiers []MegaphoneGiftTier) error {
	if len(tiers) == 0 || len(tiers) > MegaphoneGiftTiersMax {
		return fmt.Errorf("mốc quà phải có từ 1 đến %d dòng", MegaphoneGiftTiersMax)
	}
	if tiers[0].MinKen != 0 {
		return errors.New("mốc quà đầu tiên phải bắt đầu từ 0 KEN")
	}
	for i, tier := range tiers {
		if tier.Weight < 1 || tier.Weight > MegaphoneWeightMax {
			return fmt.Errorf("trọng số quà phải từ 1 đến %d", MegaphoneWeightMax)
		}
		if i > 0 && tier.MinKen <= tiers[i-1].MinKen {
			return errors.New("các mốc quà phải tăng dần")
		}
	}
	return nil
}

func ValidateMegaphoneValue(value models.JSONB) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return errors.New("invalid megaphone config")
	}
	var cfg struct {
		Enabled           *bool               `json:"enabled"`
		Platforms         *platformRulesInput `json:"platforms"`
		KenPrice          *int                `json:"kenPrice"`
		MaxLength         *int                `json:"maxLength"`
		DisplaySeconds    *int                `json:"displaySeconds"`
		CooldownSeconds   *int                `json:"cooldownSeconds"`
		DailyLimit        *int                `json:"dailyLimit"`
		LiveMinutes       *int                `json:"liveMinutes"`
		GapSeconds        *int                `json:"gapSeconds"`
		RepeatBaseSeconds *int                `json:"repeatBaseSeconds"`
		MessageWeight     *int                `json:"messageWeight"`
		GiftTiers         []MegaphoneGiftTier `json:"giftTiers"`
		SenderDisplay     *string             `json:"senderDisplay"`
	}
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&cfg); err != nil {
		return errors.New("invalid megaphone config: " + err.Error())
	}
	if cfg.Enabled == nil || cfg.KenPrice == nil || cfg.MaxLength == nil || cfg.DisplaySeconds == nil ||
		cfg.CooldownSeconds == nil || cfg.DailyLimit == nil || cfg.LiveMinutes == nil || cfg.GapSeconds == nil ||
		cfg.RepeatBaseSeconds == nil || cfg.MessageWeight == nil || cfg.GiftTiers == nil {
		return errors.New("cấu hình loa cần đủ enabled, kenPrice, maxLength, displaySeconds, cooldownSeconds, dailyLimit, liveMinutes, gapSeconds, repeatBaseSeconds, messageWeight, giftTiers")
	}
	if cfg.Platforms != nil {
		if err := cfg.Platforms.validate(); err != nil {
			return err
		}
	}
	return validateMegaphoneConfig(MegaphoneConfig{
		Enabled:           *cfg.Enabled,
		KenPrice:          *cfg.KenPrice,
		MaxLength:         *cfg.MaxLength,
		DisplaySeconds:    *cfg.DisplaySeconds,
		CooldownSeconds:   *cfg.CooldownSeconds,
		DailyLimit:        *cfg.DailyLimit,
		LiveMinutes:       *cfg.LiveMinutes,
		GapSeconds:        *cfg.GapSeconds,
		RepeatBaseSeconds: *cfg.RepeatBaseSeconds,
		MessageWeight:     *cfg.MessageWeight,
		GiftTiers:         cfg.GiftTiers,
		SenderDisplay:     senderDisplayOrDefault(cfg.SenderDisplay),
	})
}

func senderDisplayOrDefault(value *string) string {
	if value == nil {
		return MegaphoneSenderDisplayVip
	}
	return *value
}
