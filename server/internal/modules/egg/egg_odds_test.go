package egg

import (
	"encoding/json"
	"strings"
	"testing"
)

func TestGiftListHideOddsOmitsPercent(t *testing.T) {
	percent, miss := 12.5, 40.0
	resp := &GiftListResponse{
		Items:       []GiftSectionView{{Rewards: []GiftRewardView{{Label: "100 KEN", Percent: &percent}}}},
		MissPercent: &miss,
	}
	shown, _ := json.Marshal(resp)
	if !strings.Contains(string(shown), `"percent":12.5`) || !strings.Contains(string(shown), `"missPercent":40`) {
		t.Fatalf("visible odds missing: %s", shown)
	}
	resp.HideOdds()
	hidden, _ := json.Marshal(resp)
	if strings.Contains(string(hidden), "ercent") {
		t.Fatalf("hidden odds still present: %s", hidden)
	}
}
