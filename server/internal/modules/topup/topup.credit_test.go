package topup

import (
	"testing"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
)

func TestStoredQuoteUsesIntakeBonus(t *testing.T) {
	row := &models.TopupTransaction{Amount: 100_000, BonusKen: 10_000, BonusPercent: 10}
	quote := StoredQuote(row)
	if quote.Base != 100_000 || quote.Bonus != 10_000 || quote.BonusPercent != 10 || quote.Total != 110_000 {
		t.Fatalf("unexpected stored quote %+v", quote)
	}
	legacy := StoredQuote(&models.TopupTransaction{Amount: 50_000})
	if legacy.Total != 50_000 || legacy.Bonus != 0 {
		t.Fatalf("rows without stored bonus must stay 1:1, got %+v", legacy)
	}
}

func TestCreditDescription(t *testing.T) {
	base := "Nạp KEN qua chuyển khoản"
	if got := CreditDescription(base, setting.TopupQuote{Base: 50_000, Total: 50_000}); got != base {
		t.Fatalf("no bonus must keep base description, got %q", got)
	}
	withBonus := setting.TopupQuote{Base: 100_000, BonusPercent: 10, Bonus: 10_000, Total: 110_000}
	if got := CreditDescription(base, withBonus); got != base+" (thưởng 10%)" {
		t.Fatalf("unexpected description %q", got)
	}
}
