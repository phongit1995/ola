package chatbot

import (
	"strings"

	"ola-chat-server/internal/modules/setting"
)

type persona struct {
	systemPrompt     string
	identityReminder string
}

func normalizeBotType(botType string) string {
	if _, ok := setting.ChatBotDefaultPrompts[botType]; ok {
		return botType
	}
	return setting.ChatBotTypeOlala
}

func personaOf(botType string, override setting.ChatBotBotConfig) persona {
	defaults := setting.ChatBotDefaultPrompts[normalizeBotType(botType)]
	result := persona{systemPrompt: defaults.SystemPrompt, identityReminder: defaults.IdentityReminder}
	if strings.TrimSpace(override.SystemPrompt) != "" {
		result.systemPrompt = override.SystemPrompt
	}
	if strings.TrimSpace(override.IdentityReminder) != "" {
		result.identityReminder = override.IdentityReminder
	}
	return result
}
