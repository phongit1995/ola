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

func TestUserInfoIncludesStableUserID(t *testing.T) {
	payload, err := json.Marshal(UserInfoData{
		ID:       "player-123",
		Username: "Player",
		Ken:      42,
	})
	if err != nil {
		t.Fatal(err)
	}

	var encoded map[string]any
	if err := json.Unmarshal(payload, &encoded); err != nil {
		t.Fatal(err)
	}
	if encoded["id"] != "player-123" {
		t.Fatalf("user info did not encode its stable id: %s", payload)
	}
}

func TestLeaderboardKeepsEmptyItemsAsArray(t *testing.T) {
	payload, err := json.Marshal(LeaderboardData{
		Period: "day",
		From:   1,
		To:     2,
		Items:  []LeaderboardEntry{},
	})
	if err != nil {
		t.Fatal(err)
	}

	var encoded map[string]any
	if err := json.Unmarshal(payload, &encoded); err != nil {
		t.Fatal(err)
	}
	items, ok := encoded["items"].([]any)
	if !ok || len(items) != 0 {
		t.Fatalf("leaderboard items must encode as an empty array: %s", payload)
	}
}

func TestMatchOverIncludesWinnerPayoutAndNetDelta(t *testing.T) {
	payload, err := json.Marshal(MatchOverData{
		MatchID:  "match-1",
		WinnerID: "player-1",
		Reason:   "win",
		Payout:   19_500,
		KenDelta: 9_500,
	})
	if err != nil {
		t.Fatal(err)
	}

	var encoded map[string]any
	if err := json.Unmarshal(payload, &encoded); err != nil {
		t.Fatal(err)
	}
	if encoded["payout"] != float64(19_500) || encoded["kenDelta"] != float64(9_500) {
		t.Fatalf("match result omitted payout data: %s", payload)
	}
}

func TestMatchOverKeepsZeroNetDelta(t *testing.T) {
	payload, err := json.Marshal(MatchOverData{
		MatchID:  "match-100-percent-commission",
		WinnerID: "player-1",
		Reason:   "win",
		Bet:      10_000,
		Payout:   10_000,
		KenDelta: 0,
	})
	if err != nil {
		t.Fatal(err)
	}

	var encoded map[string]any
	if err := json.Unmarshal(payload, &encoded); err != nil {
		t.Fatal(err)
	}
	if delta, exists := encoded["kenDelta"]; !exists || delta != float64(0) {
		t.Fatalf("zero net delta must remain explicit: %s", payload)
	}
}
