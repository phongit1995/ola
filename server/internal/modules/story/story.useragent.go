package story

import (
	_ "embed"
	"encoding/json"
	"math/rand/v2"
	"strings"
)

//go:embed user-agents.json
var userAgentsJSON []byte

var userAgents = loadUserAgents(userAgentsJSON)

func loadUserAgents(raw []byte) []string {
	var items []string
	if err := json.Unmarshal(raw, &items); err != nil {
		return nil
	}
	out := make([]string, 0, len(items))
	for _, item := range items {
		if value := strings.TrimSpace(item); value != "" {
			out = append(out, value)
		}
	}
	return out
}

func pickUserAgent(random bool) string {
	if !random || len(userAgents) == 0 {
		return StoryFetchUserAgent
	}
	return userAgents[rand.IntN(len(userAgents))]
}
