package chatbot

import "ola-chat-server/internal/constants"

type persona struct {
	systemPrompt     string
	identityReminder string
}

var personas = map[string]persona{
	constants.ChatBotTypeOlala: {constants.ChatBotSystemPrompt, constants.ChatBotIdentityReminder},
	constants.ChatBotTypeOlavi: {constants.ChatBotOlaviSystemPrompt, constants.ChatBotOlaviIdentityReminder},
}

func personaOf(botType string) persona {
	if found, ok := personas[botType]; ok {
		return found
	}
	return personas[constants.ChatBotTypeOlala]
}
