package setting

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"unicode/utf8"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
)

const (
	KeyChatBot = "chat_bot"

	chatBotDailyLimitMax    = 100_000
	chatBotPromptMaxRunes   = 20_000
	chatBotReminderMaxRunes = 5_000
)

type ChatBotPrompt struct {
	SystemPrompt     string `json:"systemPrompt"`
	IdentityReminder string `json:"identityReminder"`
}

var ChatBotDefaultPrompts = map[string]ChatBotPrompt{
	constants.ChatBotTypeOlala: {
		SystemPrompt:     constants.ChatBotSystemPrompt,
		IdentityReminder: constants.ChatBotIdentityReminder,
	},
	constants.ChatBotTypeOlavi: {
		SystemPrompt:     constants.ChatBotOlaviSystemPrompt,
		IdentityReminder: constants.ChatBotOlaviIdentityReminder,
	},
}

func ChatBotTypes() []string {
	return []string{constants.ChatBotTypeOlala, constants.ChatBotTypeOlavi}
}

type ChatBotBotConfig struct {
	Enabled          bool           `json:"enabled"`
	Platforms        *PlatformRules `json:"platforms,omitempty"`
	SystemPrompt     string         `json:"systemPrompt"`
	IdentityReminder string         `json:"identityReminder"`
}

func (b ChatBotBotConfig) EnabledFor(client Client) bool {
	if !b.Enabled {
		return false
	}
	return b.Platforms == nil || b.Platforms.EnabledForClient(client)
}

type ChatBotConfig struct {
	DailyLimit int                         `json:"dailyLimit"`
	Bots       map[string]ChatBotBotConfig `json:"bots"`
}

func DefaultChatBotConfig() ChatBotConfig {
	bots := make(map[string]ChatBotBotConfig, len(ChatBotDefaultPrompts))
	for _, botType := range ChatBotTypes() {
		bots[botType] = ChatBotBotConfig{Enabled: true}
	}
	return ChatBotConfig{Bots: bots}
}

func (c ChatBotConfig) Bot(botType string) ChatBotBotConfig {
	if bot, ok := c.Bots[botType]; ok {
		return bot
	}
	return ChatBotBotConfig{Enabled: true}
}

func (s *Service) GetChatBot() (ChatBotConfig, error) {
	cfg := DefaultChatBotConfig()
	err := s.getInto(KeyChatBot, &cfg)
	if cfg.DailyLimit < 0 || cfg.DailyLimit > chatBotDailyLimitMax {
		s.logger.Warnw("Invalid chat_bot dailyLimit, falling back to unlimited", "dailyLimit", cfg.DailyLimit)
		cfg.DailyLimit = 0
	}
	for botType, bot := range cfg.Bots {
		if bot.Platforms != nil {
			platforms := bot.Platforms.normalized()
			bot.Platforms = &platforms
			cfg.Bots[botType] = bot
		}
	}
	return cfg, err
}

func ValidateChatBotValue(value models.JSONB) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return errors.New("invalid chat_bot config")
	}
	var cfg struct {
		DailyLimit *int `json:"dailyLimit"`
		Bots       map[string]struct {
			Enabled          *bool       `json:"enabled"`
			Platforms        interface{} `json:"platforms"`
			SystemPrompt     *string     `json:"systemPrompt"`
			IdentityReminder *string     `json:"identityReminder"`
		} `json:"bots"`
	}
	decoder := json.NewDecoder(bytes.NewReader(raw))
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&cfg); err != nil {
		return errors.New("invalid chat_bot config: " + err.Error())
	}
	if cfg.DailyLimit == nil {
		return errors.New("cấu hình chat-bot cần dailyLimit")
	}
	if *cfg.DailyLimit < 0 || *cfg.DailyLimit > chatBotDailyLimitMax {
		return fmt.Errorf("giới hạn lượt chat mỗi ngày phải từ 0 đến %d", chatBotDailyLimitMax)
	}
	for botType, bot := range cfg.Bots {
		if _, known := ChatBotDefaultPrompts[botType]; !known {
			return fmt.Errorf("không có bot %q", botType)
		}
		if bot.Enabled == nil {
			return fmt.Errorf("bot %s cần enabled", botType)
		}
		if bot.Platforms != nil {
			platforms, err := decodePlatformRules(bot.Platforms)
			if err != nil {
				return fmt.Errorf("nền tảng của bot %s không hợp lệ: %s", botType, err.Error())
			}
			if err := platforms.validate(); err != nil {
				return fmt.Errorf("bot %s: %w", botType, err)
			}
		}
		if bot.SystemPrompt != nil && utf8.RuneCountInString(*bot.SystemPrompt) > chatBotPromptMaxRunes {
			return fmt.Errorf("câu lệnh hướng dẫn của %s tối đa %d ký tự", botType, chatBotPromptMaxRunes)
		}
		if bot.IdentityReminder != nil && utf8.RuneCountInString(*bot.IdentityReminder) > chatBotReminderMaxRunes {
			return fmt.Errorf("câu nhắc danh tính của %s tối đa %d ký tự", botType, chatBotReminderMaxRunes)
		}
	}
	return nil
}
