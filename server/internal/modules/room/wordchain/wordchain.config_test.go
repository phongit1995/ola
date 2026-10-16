package wordchain

import (
	"ola-chat-server/internal/modules/setting"
	"testing"
)

func TestVipAccess(t *testing.T) {
	cases := []struct {
		name             string
		view, play, vip  bool
		canView, canPlay bool
	}{
		{"open room", false, false, false, true, true},
		{"play needs vip, not vip", false, true, false, true, false},
		{"play needs vip, vip", false, true, true, true, true},
		{"view needs vip, not vip", true, false, false, false, false},
		{"view needs vip, vip", true, false, true, true, true},
		{"both need vip, not vip", true, true, false, false, false},
	}
	for _, tc := range cases {
		cfg := setting.WordChainConfig{VipRequiredToView: tc.view, VipRequiredToPlay: tc.play}
		canView, canPlay := vipAccess(cfg, tc.vip)
		if canView != tc.canView || canPlay != tc.canPlay {
			t.Errorf("%s: got view=%v play=%v, want view=%v play=%v", tc.name, canView, canPlay, tc.canView, tc.canPlay)
		}
	}
}
