package megaphone

import (
	"strings"
	"testing"
	"unicode/utf8"
)

func TestLuckyRewardText(t *testing.T) {
	ken := 150000
	zero := 0
	days := 30
	vip := int16(7)
	cases := []struct {
		name   string
		reward LuckyReward
		want   string
	}{
		{"ken amount wins over label", LuckyReward{Label: "Ken ngẫu nhiên", KenAmount: &ken}, "150,000 Ken"},
		{"label", LuckyReward{Label: " Icon VIP Kim Cương ", VipTypeID: &vip}, "Icon VIP Kim Cương"},
		{"zero ken falls back to label", LuckyReward{Label: "Quà", KenAmount: &zero}, "Quà"},
		{"vip days without label", LuckyReward{VipDays: &days}, "30 ngày VIP"},
		{"vip type without label", LuckyReward{VipTypeID: &vip}, "VIP 7"},
		{"empty", LuckyReward{}, ""},
	}
	for _, tc := range cases {
		if got := tc.reward.Text(); got != tc.want {
			t.Errorf("%s: got %q, want %q", tc.name, got, tc.want)
		}
	}
}

func TestLuckyContent(t *testing.T) {
	if got := luckyContent(LuckyGameEgg, "Icon VIP"); got != "vừa đập trứng trúng Icon VIP 🎉" {
		t.Errorf("egg content: %q", got)
	}
	if got := luckyContent(LuckyGameWheel, "30 ngày VIP"); got != "vừa quay trúng 30 ngày VIP 🎉" {
		t.Errorf("wheel content: %q", got)
	}
	long := luckyContent(LuckyGameEgg, strings.Repeat("á", 300))
	if utf8.RuneCountInString(long) != systemContentRunes {
		t.Errorf("content should be cut to %d runes, got %d", systemContentRunes, utf8.RuneCountInString(long))
	}
}

func TestLuckyRequestIDFitsColumn(t *testing.T) {
	id := luckyRequestPrefix + LuckyGameWheel + ":" + "550e8400-e29b-41d4-a716-446655440000"
	if len(id) > 64 {
		t.Errorf("client request id too long: %d", len(id))
	}
}

func TestLuckyRewardRoundTrip(t *testing.T) {
	ken := 5000
	vip := int16(7)
	in := LuckyAnnouncement{Game: LuckyGameWheel, Reward: LuckyReward{Label: "Ken lớn", KenAmount: &ken, VipTypeID: &vip}}
	got := luckyInfoFrom(luckyRewardJSONB(in.info()))
	if got == nil {
		t.Fatal("expected lucky info")
	}
	if got.Game != LuckyGameWheel || got.Label != "5,000 Ken" || got.KenAmount == nil || *got.KenAmount != 5000 || got.VipTypeID == nil || *got.VipTypeID != 7 || got.VipDays != nil {
		t.Errorf("unexpected lucky info: %+v", got)
	}
	if luckyInfoFrom(nil) != nil {
		t.Error("nil reward should give nil info")
	}
}
