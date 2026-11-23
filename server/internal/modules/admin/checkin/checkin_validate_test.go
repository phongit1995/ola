package admincheckin

import (
	"testing"

	"ola-chat-server/internal/models"
)

func strPtr(s string) *string { return &s }

func option(weight int, reward models.CheckinReward) models.CheckinGiftOption {
	return models.CheckinGiftOption{CheckinReward: reward, Weight: weight}
}

func slotWith(task *string, gifts ...models.CheckinGift) SlotDTO {
	return SlotDTO{Slot: 3, Gifts: gifts, Featured: true, RequireVip: true, Task: task}
}

func TestCleanSlotEmptyClearsFlags(t *testing.T) {
	slot, err := cleanSlot(SlotDTO{Slot: 4, Featured: true, RequireVip: true, Task: strPtr("random")})
	if err != nil {
		t.Fatal(err)
	}
	if slot.Featured || slot.RequireVip || slot.Task != nil || len(slot.Gifts) != 0 {
		t.Fatalf("empty slot must be check-in only, got %+v", slot)
	}
}

func TestCleanSlotRules(t *testing.T) {
	ken := models.CheckinReward{Type: models.CheckinRewardKen, Amount: 500}
	cases := []struct {
		name string
		in   SlotDTO
		ok   bool
	}{
		{"valid", slotWith(strPtr("random"), models.CheckinGift{Options: []models.CheckinGiftOption{option(100, ken)}}), true},
		{"no task", slotWith(nil, models.CheckinGift{Options: []models.CheckinGiftOption{option(100, ken)}}), false},
		{"unknown task", slotWith(strPtr("chat"), models.CheckinGift{Options: []models.CheckinGiftOption{option(100, ken)}}), false},
		{"total 99", slotWith(strPtr("me_post"), models.CheckinGift{Options: []models.CheckinGiftOption{option(99, ken)}}), false},
		{"total 101", slotWith(strPtr("me_post"), models.CheckinGift{Options: []models.CheckinGiftOption{option(60, ken), option(41, ken)}}), false},
		{"weight 0", slotWith(strPtr("me_post"), models.CheckinGift{Options: []models.CheckinGiftOption{option(0, ken), option(100, ken)}}), false},
		{"empty gift", slotWith(strPtr("me_post"), models.CheckinGift{}), false},
		{"six gifts", slotWith(strPtr("me_post"),
			models.CheckinGift{Options: []models.CheckinGiftOption{option(100, ken)}},
			models.CheckinGift{Options: []models.CheckinGiftOption{option(100, ken)}},
			models.CheckinGift{Options: []models.CheckinGiftOption{option(100, ken)}},
			models.CheckinGift{Options: []models.CheckinGiftOption{option(100, ken)}},
			models.CheckinGift{Options: []models.CheckinGiftOption{option(100, ken)}},
			models.CheckinGift{Options: []models.CheckinGiftOption{option(100, ken)}},
		), false},
	}
	for _, tc := range cases {
		_, err := cleanSlot(tc.in)
		if (err == nil) != tc.ok {
			t.Errorf("%s: ok=%v err=%v", tc.name, tc.ok, err)
		}
	}
}

func TestCleanRewardLimits(t *testing.T) {
	cases := []struct {
		name string
		in   models.CheckinReward
		ok   bool
	}{
		{"icon 365 days", models.CheckinReward{Type: models.CheckinRewardVipIcon, VipIconID: 30, ExpiresInDays: 365}, true},
		{"icon 366 days", models.CheckinReward{Type: models.CheckinRewardVipIcon, VipIconID: 30, ExpiresInDays: 366}, false},
		{"icon 138", models.CheckinReward{Type: models.CheckinRewardVipIcon, VipIconID: 138}, true},
		{"icon 139 not in catalog", models.CheckinReward{Type: models.CheckinRewardVipIcon, VipIconID: 139}, false},
		{"icon 32767 not in catalog", models.CheckinReward{Type: models.CheckinRewardVipIcon, VipIconID: 32767}, false},
		{"icon negative", models.CheckinReward{Type: models.CheckinRewardVipIcon, VipIconID: -1}, false},
		{"frame gap 024 not in catalog", models.CheckinReward{Type: models.CheckinRewardAvatarFrame, FrameID: "024"}, false},
		{"frame 999 not in catalog", models.CheckinReward{Type: models.CheckinRewardAvatarFrame, FrameID: "999"}, false},
		{"icon not picked", models.CheckinReward{Type: models.CheckinRewardVipIcon}, false},
		{"frame permanent", models.CheckinReward{Type: models.CheckinRewardAvatarFrame, FrameID: "004"}, true},
		{"frame not picked", models.CheckinReward{Type: models.CheckinRewardAvatarFrame, ExpiresInDays: 7}, false},
		{"frame 366 days", models.CheckinReward{Type: models.CheckinRewardAvatarFrame, FrameID: "004", ExpiresInDays: 366}, false},
		{"ticket no expiry", models.CheckinReward{Type: models.CheckinRewardMegaphoneTicket, Count: 1}, true},
		{"ticket 365 days", models.CheckinReward{Type: models.CheckinRewardMegaphoneTicket, Count: 1, ExpiresInDays: 365}, true},
		{"ticket 366 days", models.CheckinReward{Type: models.CheckinRewardMegaphoneTicket, Count: 1, ExpiresInDays: 366}, false},
		{"ticket 101", models.CheckinReward{Type: models.CheckinRewardMegaphoneTicket, Count: 101}, false},
		{"ken 10000", models.CheckinReward{Type: models.CheckinRewardKen, Amount: 10000}, true},
		{"ken 10001", models.CheckinReward{Type: models.CheckinRewardKen, Amount: 10001}, false},
		{"ken random 100-1000", models.CheckinReward{Type: models.CheckinRewardKen, AmountMin: 100, AmountMax: 1000}, true},
		{"ken random max 10000", models.CheckinReward{Type: models.CheckinRewardKen, AmountMin: 9900, AmountMax: 10000}, true},
		{"ken random not rounded", models.CheckinReward{Type: models.CheckinRewardKen, AmountMin: 150, AmountMax: 1000}, false},
		{"ken random min 0", models.CheckinReward{Type: models.CheckinRewardKen, AmountMax: 1000}, false},
		{"ken random min equals max", models.CheckinReward{Type: models.CheckinRewardKen, AmountMin: 500, AmountMax: 500}, false},
		{"ken random min above max", models.CheckinReward{Type: models.CheckinRewardKen, AmountMin: 1000, AmountMax: 100}, false},
		{"ken random over 10000", models.CheckinReward{Type: models.CheckinRewardKen, AmountMin: 100, AmountMax: 10100}, false},
		{"vip days 0", models.CheckinReward{Type: models.CheckinRewardVipDays}, false},
		{"unknown type", models.CheckinReward{Type: "activity_points", Count: 1}, false},
	}
	for _, tc := range cases {
		_, err := cleanReward(tc.in)
		if (err == nil) != tc.ok {
			t.Errorf("%s: ok=%v err=%v", tc.name, tc.ok, err)
		}
	}
}

func TestCleanRewardDropsForeignFields(t *testing.T) {
	got, err := cleanReward(models.CheckinReward{Type: models.CheckinRewardKen, Amount: 500, FrameID: "004", Days: 3})
	if err != nil {
		t.Fatal(err)
	}
	if got.FrameID != "" || got.Days != 0 || got.Amount != 500 {
		t.Fatalf("unexpected cleaned reward %+v", got)
	}
}

func TestCleanRandomKenDropsFixedAmount(t *testing.T) {
	got, err := cleanReward(models.CheckinReward{Type: models.CheckinRewardKen, Amount: 500, AmountMin: 100, AmountMax: 1000})
	if err != nil {
		t.Fatal(err)
	}
	if got.Amount != 0 || got.AmountMin != 100 || got.AmountMax != 1000 {
		t.Fatalf("unexpected cleaned reward %+v", got)
	}
}
