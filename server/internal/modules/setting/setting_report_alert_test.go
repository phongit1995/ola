package setting

import (
	"strings"
	"testing"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/models"
)

const testTelegramToken = "123456789:AAHdqTcvCH1vGWJxfSeofSAs0K5PALDsawQ"

func TestValidateReportAlertAcceptsValidConfig(t *testing.T) {
	input, err := ValidateReportAlertValue(models.JSONB{
		"adminUrl": " https://admin.olachat.net/ ",
		"discord":  map[string]interface{}{"enabled": true, "webhookUrl": "https://discord.com/api/webhooks/123/abc"},
		"telegram": map[string]interface{}{"enabled": true, "botToken": testTelegramToken, "chatId": "-1001234567890"},
	})
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if input.AdminURL != "https://admin.olachat.net" {
		t.Fatalf("admin url not normalized: %q", input.AdminURL)
	}
}

func TestValidateReportAlertRejectsBadValues(t *testing.T) {
	cases := map[string]models.JSONB{
		"non discord webhook": {"discord": map[string]interface{}{"webhookUrl": "https://evil.example/api/webhooks/1/x"}},
		"http webhook":        {"discord": map[string]interface{}{"webhookUrl": "http://discord.com/api/webhooks/1/x"}},
		"bad token":           {"telegram": map[string]interface{}{"botToken": "abc"}},
		"bad chat id":         {"telegram": map[string]interface{}{"chatId": "chat 1"}},
		"enabled no chat id":  {"telegram": map[string]interface{}{"enabled": true, "botToken": testTelegramToken}},
		"bad admin url":       {"adminUrl": "javascript:alert(1)"},
		"unknown field":       {"slack": true},
	}
	for name, value := range cases {
		if _, err := ValidateReportAlertValue(value); err == nil {
			t.Fatalf("%s: expected error", name)
		}
	}
}

func TestReportAlertChannelKeepsSecretWhenEmpty(t *testing.T) {
	cfg := &config.Config{JWTSecret: strings.Repeat("s", 32)}
	first, err := nextReportAlertChannel(cfg, reportAlertChannelStored{}, true, testTelegramToken, "-100")
	if err != nil {
		t.Fatal(err)
	}
	if first.Enc == "" || first.Hint != "sawQ" || first.ChatID != "-100" {
		t.Fatalf("unexpected stored channel: %+v", first)
	}
	kept, err := nextReportAlertChannel(cfg, first, false, "", "-200")
	if err != nil {
		t.Fatal(err)
	}
	if kept.Enc != first.Enc || kept.Hint != first.Hint || kept.Enabled || kept.ChatID != "-200" {
		t.Fatalf("secret not kept: %+v", kept)
	}
	plain, err := DecryptSettingSecret(cfg, kept.Enc)
	if err != nil || string(plain) != testTelegramToken {
		t.Fatalf("decrypt mismatch: %q %v", plain, err)
	}
}

func TestMaskReportAlertHidesSecrets(t *testing.T) {
	masked := MaskReportAlertValue(reportAlertJSON(reportAlertStored{
		AdminURL: "https://admin.olachat.net",
		Discord:  reportAlertChannelStored{Enabled: true, Enc: "v1:secret", Hint: "abcd"},
		Telegram: reportAlertChannelStored{ChatID: "-100"},
	}))
	discord := masked["discord"].(models.JSONB)
	telegram := masked["telegram"].(models.JSONB)
	if _, leaked := discord["enc"]; leaked {
		t.Fatal("enc leaked")
	}
	if discord["configured"] != true || discord["hint"] != "abcd" || discord["enabled"] != true {
		t.Fatalf("discord mask wrong: %v", discord)
	}
	if telegram["configured"] != false || telegram["chatId"] != "-100" {
		t.Fatalf("telegram mask wrong: %v", telegram)
	}
}

func TestMaskReportAlertTelegramNeedsChatID(t *testing.T) {
	masked := MaskReportAlertValue(reportAlertJSON(reportAlertStored{
		Telegram: reportAlertChannelStored{Enc: "v1:secret", Hint: "sawQ"},
	}))
	if masked["telegram"].(models.JSONB)["configured"] != false {
		t.Fatalf("telegram without chat id must not look configured: %v", masked["telegram"])
	}
}

func TestEnabledCredentialsSkipDisabledChannelSecret(t *testing.T) {
	cfg := &config.Config{JWTSecret: strings.Repeat("s", 32)}
	telegram, err := nextReportAlertChannel(cfg, reportAlertChannelStored{}, true, testTelegramToken, "-100")
	if err != nil {
		t.Fatal(err)
	}
	stored := reportAlertStored{
		Discord:  reportAlertChannelStored{Enabled: false, Enc: "v1:not-decryptable"},
		Telegram: telegram,
	}
	creds, err := enabledReportAlertCredentials(cfg, stored)
	if err != nil {
		t.Fatalf("disabled channel secret must not be decrypted: %v", err)
	}
	if creds.TelegramBotToken != testTelegramToken || creds.TelegramChatID != "-100" || creds.DiscordWebhookURL != "" {
		t.Fatalf("unexpected credentials: %+v", creds)
	}

	stored.Discord.Enabled = true
	creds, err = enabledReportAlertCredentials(cfg, stored)
	if err == nil {
		t.Fatal("expected decrypt error for enabled broken channel")
	}
	if creds.TelegramBotToken != testTelegramToken {
		t.Fatal("a broken channel must not block the healthy one")
	}
}
