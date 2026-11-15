package wheel

import (
	"encoding/json"
	"strings"
	"testing"
)

func TestPlayerConfigHideOddsOmitsPercent(t *testing.T) {
	segPercent, optPercent, zero := 50.0, 25.0, 0.0
	resp := &PlayerConfigResponse{Segments: []PlayerSegmentView{
		{Label: "VIP", Percent: &segPercent, Options: []PlayerOptionView{{Label: "VIP 7 ngày", Percent: &optPercent}}},
		{Label: "Trượt", Percent: &zero},
	}}
	shown, _ := json.Marshal(resp)
	if strings.Count(string(shown), `"percent"`) != 3 || !strings.Contains(string(shown), `"percent":0`) {
		t.Fatalf("visible odds wrong: %s", shown)
	}
	resp.HideOdds()
	hidden, _ := json.Marshal(resp)
	if strings.Contains(string(hidden), "percent") {
		t.Fatalf("hidden odds still present: %s", hidden)
	}
}
