package chatbot

import (
	"fmt"
	"strings"

	"ola-chat-server/internal/constants"
)

const (
	promptSystemLabel    = "[System instruction]: %s"
	promptAssistantLabel = "[Assistant]: %s"
	promptUserLabel      = "[User]: %s"
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
			// Có nhãn người nói thì model mới phân biệt được "tớ" của người dùng với "tớ" của bot.
			sections = append(sections, fmt.Sprintf(promptUserLabel, text))
		}
	}

	if len(sections) == 0 {
		return "", errEmptyPrompt
	}

	bot := personaOf(req.Type)
	head := fmt.Sprintf(promptSystemLabel, bot.systemPrompt)
	// Model bám chỉ dẫn ở cuối prompt mạnh hơn ở đầu, nhắc lại để nó không rơi về giọng mặc định.
	reminder := fmt.Sprintf(promptSystemLabel, bot.identityReminder)

	ordered := make([]string, 0, len(sections)+2)
	ordered = append(ordered, head)
	ordered = append(ordered, sections...)
	ordered = append(ordered, reminder)
	return strings.Join(ordered, "\n\n"), nil
}
