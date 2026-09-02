package utils

import (
	"strings"
	"testing"
)

func TestEncryptDecryptRoundTrip(t *testing.T) {
	secret := strings.Repeat("s", 32)
	plaintext := []byte(`{"type":"service_account","private_key":"abc"}`)

	encoded, err := EncryptWithSecret(secret, plaintext)
	if err != nil {
		t.Fatalf("encrypt: %v", err)
	}
	if strings.Contains(encoded, "service_account") {
		t.Fatal("ciphertext must not contain plaintext")
	}

	decoded, err := DecryptWithSecret(secret, encoded)
	if err != nil {
		t.Fatalf("decrypt: %v", err)
	}
	if string(decoded) != string(plaintext) {
		t.Fatal("round trip mismatch")
	}

	if _, err := DecryptWithSecret("wrong-secret-wrong-secret-wrong!", encoded); err == nil {
		t.Fatal("wrong secret must fail")
	}
	if _, err := DecryptWithSecret(secret, "not-base64!!"); err == nil {
		t.Fatal("garbage input must fail")
	}
	if _, err := EncryptWithSecret("", plaintext); err == nil {
		t.Fatal("empty secret must fail")
	}
}
