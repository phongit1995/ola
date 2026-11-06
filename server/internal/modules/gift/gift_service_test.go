package gift

import (
	"testing"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

func TestSameRequestComparesGiftReceiverAndQuantity(t *testing.T) {
	giftID, receiverID := uuid.New(), uuid.New()
	existing := &models.GiftTransaction{GiftID: giftID, ReceiverID: receiverID, Quantity: 3}
	if !sameRequest(existing, giftID, receiverID, 3) {
		t.Fatal("identical request must match")
	}
	if sameRequest(existing, uuid.New(), receiverID, 3) || sameRequest(existing, giftID, uuid.New(), 3) || sameRequest(existing, giftID, receiverID, 4) {
		t.Fatal("different gift, receiver or quantity must not match")
	}
}

func TestNormalizeLeaderboardParams(t *testing.T) {
	if NormalizeLeaderboardType("sender") != LeaderboardTypeSender || NormalizeLeaderboardType("x") != LeaderboardTypeReceiver {
		t.Fatal("unexpected leaderboard type normalization")
	}
	for in, want := range map[string]string{"week": utils.PeriodWeek, "month": utils.PeriodMonth, "all": utils.PeriodAll, "day": utils.PeriodWeek, "": utils.PeriodWeek} {
		if got := NormalizeLeaderboardPeriod(in); got != want {
			t.Fatalf("period %q → %q, want %q", in, got, want)
		}
	}
}

func TestCounterpartyOf(t *testing.T) {
	sender, receiver := uuid.New(), uuid.New()
	tx := &models.GiftTransaction{SenderID: sender, ReceiverID: receiver}
	if counterpartyOf(tx, HistoryDirectionReceived) != sender || counterpartyOf(tx, HistoryDirectionSent) != receiver {
		t.Fatal("counterparty must be the other side of the gift")
	}
}
