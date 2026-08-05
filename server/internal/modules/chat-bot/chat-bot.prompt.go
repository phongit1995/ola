package chatbot

import (
	"fmt"
	"strings"

	"ola-chat-server/internal/constants"
)

const (
	promptSystemLabel    = "[System instruction]: %s"
	promptAssistantLabel = "[Assistant]: %s"
)

func buildPrompt(req *CompletionRequest) (string, error) {
	var sections []string
	for _, msg := range req.Messages {
		text := strings.TrimSpace(msg.Content)
		if text == "" {
			continue
		}

		switch msg.Role {
		case constants.ChatBotRoleSystem:
			sections = append(sections, fmt.Sprintf(promptSystemLabel, text))
		case constants.ChatBotRoleAssistant:
			sections = append(sections, fmt.Sprintf(promptAssistantLabel, text))
		default:
			sections = append(sections, text)
		}
	}

	if len(sections) == 0 {
		return "", errEmptyPrompt
	}

	persona := fmt.Sprintf(promptSystemLabel, constants.ChatBotSystemPrompt)
	return strings.Join(append([]string{persona}, sections...), "\n\n"), nil
}
