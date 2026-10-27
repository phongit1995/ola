package adminwordchain

import (
	"encoding/json"
	"testing"
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
)

func metadataFromJSON(t *testing.T, raw string) models.JSONB {
	t.Helper()
	var m models.JSONB
	if err := json.Unmarshal([]byte(raw), &m); err != nil {
		t.Fatal(err)
	}
	return m
}

func TestToPurchaseItemHint(t *testing.T) {
	item := toPurchaseItem(purchaseRow{
		ID:        uuid.New(),
		Type:      models.KenTxTypeWordChainHint,
		Amount:    500,
		Metadata:  metadataFromJSON(t, `{"word":"bàn ghế","turn":3,"hints":["ghế đá","ghế gỗ"]}`),
		CreatedAt: time.Date(2026, 10, 20, 10, 0, 0, 0, time.UTC),
		Username:  "minhanh",
	})
	if item.Type != PurchaseTypeHint || item.Word != "bàn ghế" || len(item.Hints) != 2 || item.Guesses != 0 {
		t.Fatalf("unexpected hint item: %+v", item)
	}
	if item.CreatedAt != "2026-10-20T10:00:00Z" || item.User.Username != "minhanh" {
		t.Fatalf("unexpected time or user: %+v", item)
	}
}

func TestToPurchaseItemGuessAndBadMetadata(t *testing.T) {
	guess := toPurchaseItem(purchaseRow{
		Type:     models.KenTxTypeWordChainGuess,
		Metadata: metadataFromJSON(t, `{"word":"mèo","guesses":3}`),
	})
	if guess.Type != PurchaseTypeGuess || guess.Guesses != 3 || guess.Word != "mèo" {
		t.Fatalf("unexpected guess item: %+v", guess)
	}

	broken := toPurchaseItem(purchaseRow{
		Type:     models.KenTxTypeWordChainHint,
		Metadata: metadataFromJSON(t, `{"word":12,"hints":"x","guesses":"2"}`),
	})
	if broken.Word != "" || broken.Hints != nil || broken.Guesses != 0 {
		t.Fatalf("wrong-typed metadata must be ignored: %+v", broken)
	}

	if empty := toPurchaseItem(purchaseRow{Type: models.KenTxTypeWordChainGuess}); empty.Word != "" {
		t.Fatalf("nil metadata must not panic or set fields: %+v", empty)
	}
}
