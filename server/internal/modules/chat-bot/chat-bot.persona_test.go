package chatbot

import (
	"testing"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/modules/setting"
)

func TestPersonaOfUsesDefaultsWhenOverrideBlank(t *testing.T) {
	got := personaOf(constants.ChatBotTypeOlavi, setting.ChatBotBotConfig{Enabled: true, SystemPrompt: "   "})
	if got.systemPrompt != constants.ChatBotOlaviSystemPrompt {
		t.Fatal("blank override should keep the default system prompt")
	}
	if got.identityReminder != constants.ChatBotOlaviIdentityReminder {
		t.Fatal("missing override should keep the default identity reminder")
	}
}

func TestPersonaOfAppliesOverride(t *testing.T) {
	got := personaOf(constants.ChatBotTypeOlala, setting.ChatBotBotConfig{SystemPrompt: "custom", IdentityReminder: "remind"})
	if got.systemPrompt != "custom" || got.identityReminder != "remind" {
		t.Fatalf("override not applied: %+v", got)
	}
}

func TestPersonaOfUnknownTypeFallsBackToOlala(t *testing.T) {
	got := personaOf("UNKNOWN", setting.ChatBotBotConfig{})
	if got.systemPrompt != constants.ChatBotSystemPrompt {
		t.Fatal("unknown bot type should fall back to Olala")
	}
}

func TestBuildPromptWrapsPersona(t *testing.T) {
	req := &CompletionRequest{Messages: []Message{{Role: constants.ChatBotRoleUser, Content: "xin chào"}}}
	prompt, err := buildPrompt(req, persona{systemPrompt: "SYS", identityReminder: "REM"})
	if err != nil {
		t.Fatal(err)
	}
	want := "[System instruction]: SYS\n\n[User]: xin chào\n\n[System instruction]: REM"
	if prompt != want {
		t.Fatalf("prompt = %q, want %q", prompt, want)
	}
}
