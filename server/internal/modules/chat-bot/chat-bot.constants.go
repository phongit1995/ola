package chatbot

import "time"

const (
	CacheKeyChatBotDaily       = "CHAT_BOT:DAILY:%s:%s"
	ChatBotDailyResetTZ        = "Asia/Ho_Chi_Minh"
	ErrorCodeChatBotDisabled   = "CHAT_BOT_DISABLED"
	ErrorCodeChatBotDailyLimit = "CHAT_BOT_DAILY_LIMIT"

	ChatBotModelMode                = 1
	ChatBotModelThink               = 4
	ChatBotGeminiOrigin             = "https://gemini.google.com"
	ChatBotGeminiStreamPath         = "/_/BardChatUi/data/assistant.lamda.BardFrontendService/StreamGenerate"
	ChatBotGeminiAppPath            = "/app"
	ChatBotGeminiBL                 = "boq_assistant-bard-web-server_20260716.08_p0"
	ChatBotUserAgent                = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
	ChatBotTimeout                  = 180 * time.Second
	ChatBotRetryAttempts            = 3
	ChatBotRetryDelay               = 2 * time.Second
	ChatBotRoleUser                 = "user"
	ChatBotRoleAssistant            = "assistant"
	ChatBotRoleSystem               = "system"
	ChatBotFinishReasonStop         = "stop"
	ChatBotSSEDoneMarker            = "[DONE]"
	ChatBotMaxRequestBytes          = 2 * 1024 * 1024
	ChatBotMaxUserContentRunes      = 4000
	ChatBotMaxAssistantContentRunes = 32000
	ChatBotSSEHeartbeat             = ": ping\n\n"
	ChatBotSSEHeartbeatEvery        = 15 * time.Second
)
