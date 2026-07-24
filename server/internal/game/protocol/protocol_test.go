package protocol

import (
	"encoding/json"
	"strings"
	"testing"
)

func TestVipTypeFieldsRemainBackwardCompatible(t *testing.T) {
	var legacyPlayer PlayerInfo
	if err := json.Unmarshal([]byte(`{"id":"player","name":"Player"}`), &legacyPlayer); err != nil {
		t.Fatal(err)
	}
	if legacyPlayer.VipType != nil {
		t.Fatalf("legacy player unexpectedly has VIP type: %+v", legacyPlayer)
	}

	legacyJSON, err := json.Marshal(legacyPlayer)
	if err != nil {
		t.Fatal(err)
	}
	if strings.Contains(string(legacyJSON), `"vipType"`) {
		t.Fatalf("nil VIP type was not omitted: %s", legacyJSON)
	}

	vipType := "vip-42"
	memberJSON, err := json.Marshal(RoomMember{
		ID:      "player",
		Name:    "Player",
		VipType: &vipType,
	})
	if err != nil {
		t.Fatal(err)
	}
	if !strings.Contains(string(memberJSON), `"vipType":"vip-42"`) {
		t.Fatalf("room member VIP type was not encoded: %s", memberJSON)
	}
}
