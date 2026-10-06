package story

import (
	"testing"
	"time"
)

func local(year int, month time.Month, day, hour, minute, second int) time.Time {
	return time.Date(year, month, day, hour, minute, second, 0, sourceZone)
}

func assertTimes(t *testing.T, got []*time.Time, want []time.Time) {
	t.Helper()
	if len(got) != len(want) {
		t.Fatalf("got %d times, want %d", len(got), len(want))
	}
	for i := range want {
		if got[i] == nil || !got[i].Equal(want[i]) {
			t.Fatalf("chapter %d: got %v, want %v", i+1, got[i], want[i].UTC())
		}
	}
}

func TestChapterTimesUseStoryTimestampsAsAnchors(t *testing.T) {
	labels := []string{"09/04/2026 lúc 9:12", "09/04/2026 lúc 9:12", "10/04/2026 lúc 9:36", "18/04/2026 lúc 12:12", "04/10/2026 lúc 8:21"}
	published := local(2026, 4, 9, 9, 12, 53)
	modified := local(2026, 10, 4, 20, 21, 16)
	got := chapterTimes(labels, local(2026, 10, 6, 21, 0, 0), published, modified)
	assertTimes(t, got, []time.Time{
		local(2026, 4, 9, 9, 12, 0),
		local(2026, 4, 9, 9, 12, 0),
		local(2026, 4, 10, 0, 0, 0),
		local(2026, 4, 18, 0, 0, 0),
		local(2026, 10, 4, 20, 21, 0),
	})
}

func TestChapterTimesFollowOrderWithinADay(t *testing.T) {
	labels := []string{"01/07/2024 lúc 3:36", "01/07/2024 lúc 3:38", "01/07/2024 lúc 9:10", "02/07/2024 lúc 7:00"}
	got := chapterTimes(labels, local(2026, 1, 1, 0, 0, 0), local(2024, 7, 1, 15, 36, 32))
	assertTimes(t, got, []time.Time{
		local(2024, 7, 1, 15, 36, 0),
		local(2024, 7, 1, 15, 38, 0),
		local(2024, 7, 1, 21, 10, 0),
		local(2024, 7, 2, 0, 0, 0),
	})
}

func TestChapterTimesRejectFutureCandidate(t *testing.T) {
	now := local(2026, 10, 6, 10, 0, 0)
	assertTimes(t, chapterTimes([]string{"06/10/2026 lúc 9:12"}, now), []time.Time{local(2026, 10, 6, 9, 12, 0)})
	assertTimes(t, chapterTimes([]string{"06/10/2026 lúc 12:30"}, now), []time.Time{local(2026, 10, 6, 0, 30, 0)})
	contradicting := chapterTimes([]string{"06/10/2026 lúc 9:12", "06/10/2026 lúc 12:30"}, now)
	assertTimes(t, contradicting, []time.Time{local(2026, 10, 6, 9, 12, 0), local(2026, 10, 6, 0, 0, 0)})
}

func TestChapterTimesStayDateOnlyWhenAmbiguous(t *testing.T) {
	now := local(2026, 12, 1, 0, 0, 0)
	conflicting := chapterTimes([]string{"05/10/2026 lúc 9:12"}, now, local(2026, 10, 5, 9, 12, 10), local(2026, 10, 5, 21, 12, 40))
	assertTimes(t, conflicting, []time.Time{local(2026, 10, 5, 0, 0, 0)})

	reordered := chapterTimes([]string{"05/10/2026 lúc 9:00", "04/10/2026 lúc 3:00", "05/10/2026 lúc 8:00"}, now, local(2026, 10, 5, 21, 0, 0))
	assertTimes(t, reordered, []time.Time{local(2026, 10, 5, 21, 0, 0), local(2026, 10, 4, 0, 0, 0), local(2026, 10, 5, 0, 0, 0)})

	dateOnly := chapterTimes([]string{"05/10/2026", "18/11/2022 10:28"}, now)
	assertTimes(t, dateOnly, []time.Time{local(2026, 10, 5, 0, 0, 0), local(2022, 11, 18, 0, 0, 0)})

	if got := chapterTimes([]string{"hôm qua"}, now); got[0] != nil {
		t.Fatalf("unparseable label must give nil, got %v", got[0])
	}
}
