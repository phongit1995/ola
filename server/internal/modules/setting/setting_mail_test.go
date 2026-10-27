package setting

import (
	"strings"
	"testing"

	"ola-chat-server/internal/models"
)

const testResendKey = "re_testKey_1234abcd"

func TestValidateMailResendValue(t *testing.T) {
	input, err := ValidateMailResendValue(models.JSONB{"apiKey": " " + testResendKey + " ", "from": " Ola Chat <noreply@olachat.net> "})
	if err != nil {
		t.Fatalf("expected valid, got %v", err)
	}
	if input.APIKey != testResendKey || input.From != "Ola Chat <noreply@olachat.net>" {
		t.Fatalf("values must be trimmed, got %+v", input)
	}
	if _, err := ValidateMailResendValue(models.JSONB{"from": "noreply@olachat.net"}); err != nil {
		t.Fatalf("empty apiKey keeps the stored key, got %v", err)
	}

	cases := map[string]models.JSONB{
		"missing from":  {"apiKey": testResendKey},
		"bad from":      {"apiKey": testResendKey, "from": "not an email"},
		"wrong prefix":  {"apiKey": "sk_testKey_1234abcd", "from": "noreply@olachat.net"},
		"inner space":   {"apiKey": "re_test Key_1234", "from": "noreply@olachat.net"},
		"too short":     {"apiKey": "re_abc", "from": "noreply@olachat.net"},
		"unknown field": {"apiKey": testResendKey, "from": "noreply@olachat.net", "extra": true},
		"non-string":    {"apiKey": 123, "from": "noreply@olachat.net"},
	}
	for name, value := range cases {
		if _, err := ValidateMailResendValue(value); err == nil {
			t.Fatalf("%s: expected error", name)
		}
	}
}

func TestBuildMailResendValueEncryptsKey(t *testing.T) {
	cfg := testCfg()
	stored, err := (&Service{}).BuildMailResendValue(cfg, MailResendInput{APIKey: testResendKey, From: "noreply@olachat.net"})
	if err != nil {
		t.Fatalf("build: %v", err)
	}
	enc, _ := stored["enc"].(string)
	if !strings.HasPrefix(enc, settingSecretEncVersion) || strings.Contains(enc, testResendKey) {
		t.Fatal("enc must be versioned ciphertext")
	}
	if stored["keyHint"] != "abcd" || stored["from"] != "noreply@olachat.net" {
		t.Fatalf("unexpected stored value: %v", stored)
	}
	plain, err := DecryptSettingSecret(cfg, enc)
	if err != nil || string(plain) != testResendKey {
		t.Fatalf("decrypt must return the original key, got %q, %v", plain, err)
	}
}

func TestMaskMailResendValue(t *testing.T) {
	masked := MaskMailResendValue(models.JSONB{"enc": "v1:cipher", "keyHint": "abcd", "from": "noreply@olachat.net"})
	if masked["configured"] != true || masked["keyHint"] != "abcd" || masked["from"] != "noreply@olachat.net" {
		t.Fatalf("unexpected masked value: %v", masked)
	}
	if _, leaked := masked["enc"]; leaked {
		t.Fatal("enc must not appear in masked value")
	}
	if MaskMailResendValue(nil) != nil {
		t.Fatal("nil value should stay nil")
	}
}
