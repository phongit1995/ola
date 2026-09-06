package setting

import (
	"crypto/rand"
	"crypto/rsa"
	"crypto/x509"
	"encoding/pem"
	"strings"
	"testing"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/models"
)

func testPEMKey(t *testing.T) string {
	t.Helper()
	key, err := rsa.GenerateKey(rand.Reader, 2048)
	if err != nil {
		t.Fatalf("generate key: %v", err)
	}
	der, err := x509.MarshalPKCS8PrivateKey(key)
	if err != nil {
		t.Fatalf("marshal key: %v", err)
	}
	return string(pem.EncodeToMemory(&pem.Block{Type: "PRIVATE KEY", Bytes: der}))
}

func testCfg() *config.Config {
	return &config.Config{JWTSecret: strings.Repeat("s", 32)}
}

func validServiceAccount(t *testing.T) models.JSONB {
	return models.JSONB{
		"type":         "service_account",
		"project_id":   "ola-chat-net",
		"private_key":  testPEMKey(t),
		"client_email": "firebase-adminsdk@ola-chat-net.iam.gserviceaccount.com",
	}
}

func TestValidatePushFirebaseValue(t *testing.T) {
	if err := ValidatePushFirebaseValue(validServiceAccount(t)); err != nil {
		t.Fatalf("expected valid, got %v", err)
	}

	cases := map[string]func(models.JSONB){
		"wrong type":      func(v models.JSONB) { v["type"] = "authorized_user" },
		"missing project": func(v models.JSONB) { delete(v, "project_id") },
		"missing key":     func(v models.JSONB) { delete(v, "private_key") },
		"missing email":   func(v models.JSONB) { delete(v, "client_email") },
		"bad pem":         func(v models.JSONB) { v["private_key"] = "not-a-pem" },
		"fake pem": func(v models.JSONB) {
			v["private_key"] = "-----BEGIN PRIVATE KEY-----\nabc\n-----END PRIVATE KEY-----\n"
		},
	}
	for name, mutate := range cases {
		value := validServiceAccount(t)
		mutate(value)
		if err := ValidatePushFirebaseValue(value); err == nil {
			t.Fatalf("%s: expected error", name)
		}
	}
}

func TestValidatePushNotificationValue(t *testing.T) {
	if err := ValidatePushNotificationValue(models.JSONB{"enabled": true}); err != nil {
		t.Fatalf("expected valid, got %v", err)
	}
	if err := ValidatePushNotificationValue(models.JSONB{"enabled": true, "extra": 1}); err == nil {
		t.Fatal("unknown field must be rejected")
	}
	if err := ValidatePushNotificationValue(models.JSONB{"enabled": "yes"}); err == nil {
		t.Fatal("non-bool enabled must be rejected")
	}
}

func TestEncryptPushFirebaseValue(t *testing.T) {
	cfg := testCfg()
	stored, err := EncryptPushFirebaseValue(cfg, validServiceAccount(t))
	if err != nil {
		t.Fatalf("encrypt: %v", err)
	}
	if stored["projectId"] != "ola-chat-net" {
		t.Fatalf("unexpected projectId: %v", stored["projectId"])
	}
	if _, leaked := stored["private_key"]; leaked {
		t.Fatal("plaintext private_key must not be stored")
	}
	enc, _ := stored["enc"].(string)
	if !strings.HasPrefix(enc, "v1:") || strings.Contains(enc, "PRIVATE KEY") {
		t.Fatal("enc must be versioned ciphertext")
	}
	plain, err := DecryptPushCredential(cfg, enc)
	if err != nil {
		t.Fatalf("decrypt: %v", err)
	}
	if !strings.Contains(string(plain), "firebase-adminsdk@ola-chat-net.iam.gserviceaccount.com") {
		t.Fatal("decrypted payload must be the original service account")
	}

	cfgWithKey := &config.Config{SettingsEncKey: strings.Repeat("k", 32), JWTSecret: cfg.JWTSecret}
	if _, err := DecryptPushCredential(cfgWithKey, enc); err != nil {
		t.Fatalf("decrypt must fall back to JWT secret: %v", err)
	}
	stored2, err := EncryptPushFirebaseValue(cfgWithKey, validServiceAccount(t))
	if err != nil {
		t.Fatalf("encrypt with dedicated key: %v", err)
	}
	if _, err := DecryptPushCredential(cfg, stored2["enc"].(string)); err == nil {
		t.Fatal("credential encrypted with dedicated key must not decrypt with JWT-only config")
	}
}

func TestMaskPushFirebaseValue(t *testing.T) {
	stored, err := EncryptPushFirebaseValue(testCfg(), validServiceAccount(t))
	if err != nil {
		t.Fatalf("encrypt: %v", err)
	}
	masked := MaskPushFirebaseValue(stored)
	if masked["configured"] != true || masked["projectId"] != "ola-chat-net" {
		t.Fatalf("unexpected masked value: %v", masked)
	}
	if _, leaked := masked["enc"]; leaked {
		t.Fatal("enc must not appear in masked value")
	}
	if len(masked) != 3 {
		t.Fatalf("masked value must only contain status fields, got %v", masked)
	}
	if MaskPushFirebaseValue(nil) != nil {
		t.Fatal("nil value should stay nil")
	}
}
