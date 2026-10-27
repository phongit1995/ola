package moment

import (
	"reflect"
	"testing"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
)

func TestReactionListSortsByCountThenReactionOrder(t *testing.T) {
	got := reactionList(map[string]int64{"ANGRY": 2, "LOVE": 5, "LIKE": 2, "WOW": 0})
	want := []MomentReactionCount{{Type: "LOVE", Count: 5}, {Type: "LIKE", Count: 2}, {Type: "ANGRY", Count: 2}}
	if !reflect.DeepEqual(got, want) {
		t.Fatalf("got %+v, want %+v", got, want)
	}
	if empty := reactionList(nil); empty == nil || len(empty) != 0 {
		t.Fatalf("no reactions must give an empty list, got %#v", empty)
	}
}

func TestMergeReactionCountsNeverLowersStoredTotals(t *testing.T) {
	stored := models.MomentReactionCounts{"LOVE": 10, "HAHA": 4}
	live := map[string]int64{"LOVE": 7, "LIKE": 3}
	got := mergeReactionCounts(stored, live)
	want := models.MomentReactionCounts{"LOVE": 10, "HAHA": 4, "LIKE": 3}
	if !reflect.DeepEqual(got, want) {
		t.Fatalf("got %+v, want %+v", got, want)
	}
	if stored["LIKE"] != 0 {
		t.Fatal("merge must not modify the stored map")
	}
}

func TestStaleReactionCountsOnlyReturnsChangedMoments(t *testing.T) {
	unchanged := &models.Moment{ID: uuid.New(), ReactionCounts: models.MomentReactionCounts{"LOVE": 2}}
	grown := &models.Moment{ID: uuid.New(), ReactionCounts: models.MomentReactionCounts{"LOVE": 2}}
	fresh := &models.Moment{ID: uuid.New()}
	quiet := &models.Moment{ID: uuid.New()}
	live := map[uuid.UUID]map[string]int64{
		unchanged.ID: {"LOVE": 2},
		grown.ID:     {"LOVE": 5},
		fresh.ID:     {"WOW": 1},
		quiet.ID:     {},
	}
	got := staleReactionCounts([]*models.Moment{unchanged, grown, fresh, quiet}, live)
	want := map[uuid.UUID]models.MomentReactionCounts{
		grown.ID: {"LOVE": 5},
		fresh.ID: {"WOW": 1},
	}
	if !reflect.DeepEqual(got, want) {
		t.Fatalf("got %+v, want %+v", got, want)
	}
}

func TestCountsByReactionReadsHMGetValuesInReactionOrder(t *testing.T) {
	got := countsByReaction([]interface{}{"3", nil, "0", "bad", "12", nil})
	want := map[string]int64{"LIKE": 3, "SAD": 12}
	if !reflect.DeepEqual(got, want) {
		t.Fatalf("got %+v, want %+v", got, want)
	}
}

func TestClampReactionCount(t *testing.T) {
	cases := map[int]int{0: 1, -3: 1, 1: 1, 7: 7, MomentReactionMaxPerRequest: MomentReactionMaxPerRequest, 500: MomentReactionMaxPerRequest}
	for input, want := range cases {
		if got := clampReactionCount(input); got != want {
			t.Errorf("clampReactionCount(%d) = %d, want %d", input, got, want)
		}
	}
}

func TestReactionTotal(t *testing.T) {
	if got := ReactionTotal([]MomentReactionCount{{Type: "LOVE", Count: 5}, {Type: "HAHA", Count: 3}}); got != 8 {
		t.Fatalf("got %d", got)
	}
	if got := ReactionTotal(nil); got != 0 {
		t.Fatalf("empty list must total 0, got %d", got)
	}
}
