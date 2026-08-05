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

	prompt := strings.Join(sections, "\n\n")
	if strings.TrimSpace(prompt) == "" {
		return "", errEmptyPrompt
	}

	return prompt, nil
}
