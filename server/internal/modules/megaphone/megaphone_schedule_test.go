package megaphone

import (
	"testing"
	"time"

	megaphoneEvents "ola-chat-server/internal/domain/megaphone"
)

const testRepeatBase = 720

func entry(id string, pass float64, weight int, now time.Time, lastPlayedAgo time.Duration) scheduleEntry {
	item := &scheduledItem{
		Megaphone: megaphoneEvents.Megaphone{ID: id, ExpiresAt: now.Add(time.Hour)},
		Weight:    weight,
	}
	if lastPlayedAgo > 0 {
		played := now.Add(-lastPlayedAgo)
		item.LastPlayedAt = &played
	}
	return scheduleEntry{ID: id, Pass: pass, Item: item}
}

func TestSelectNextTakesLowestEligiblePass(t *testing.T) {
	now := time.Now()
	entries := []scheduleEntry{
		entry("just-played", 10, 3, now, time.Minute),
		entry("due", 20, 3, now, 5*time.Minute),
		entry("later", 30, 3, now, 5*time.Minute),
	}
	if got := selectNext(entries, now, testRepeatBase); got != 1 {
		t.Fatalf("got index %d, want the first entry past its repeat interval", got)
	}
}

func TestSelectNextPlaysNewEntryImmediately(t *testing.T) {
	now := time.Now()
	entries := []scheduleEntry{entry("new", 50, 1, now, 0)}
	if got := selectNext(entries, now, testRepeatBase); got != 0 {
		t.Fatalf("a never played entry must be eligible, got %d", got)
	}
}

func TestSelectNextSkipsExpiredAndMissing(t *testing.T) {
	now := time.Now()
	expired := entry("expired", 1, 6, now, 0)
	expired.Item.Megaphone.ExpiresAt = now.Add(-time.Second)
	entries := []scheduleEntry{expired, {ID: "missing", Pass: 2}}
	if got := selectNext(entries, now, testRepeatBase); got != -1 {
		t.Fatalf("got %d, want nothing to play", got)
	}
}

func TestRepeatIntervalShrinksWithWeight(t *testing.T) {
	for weight, want := range map[int]time.Duration{1: 12 * time.Minute, 3: 4 * time.Minute, 6: 2 * time.Minute} {
		if got := repeatInterval(testRepeatBase, weight); got != want {
			t.Fatalf("weight %d → %s, want %s", weight, got, want)
		}
	}
}

func TestAdvancePassKeepsVirtualTimeMonotonic(t *testing.T) {
	pass, virtual := advancePass(100, 40, testRepeatBase, 6)
	if virtual != 100 || pass != 220 {
		t.Fatalf("pass %v virtual %v", pass, virtual)
	}
	pass, virtual = advancePass(10, 100, testRepeatBase, 3)
	if virtual != 100 || pass != 340 {
		t.Fatalf("lagging entry must catch up to virtual time, pass %v virtual %v", pass, virtual)
	}
}

func TestSchedulingSharesTurnsByWeightWithoutStarving(t *testing.T) {
	now := time.Now()
	light := entry("light", 0, 1, now, 0)
	heavy := entry("heavy", 0, 6, now, 0)
	entries := []scheduleEntry{heavy, light}
	turns := map[string]int{}
	virtual := 0.0
	for slot := 0; slot < 700; slot++ {
		sortByPass(entries)
		picked := selectNext(entries, now, 0)
		turns[entries[picked].ID]++
		entries[picked].Pass, virtual = advancePass(entries[picked].Pass, virtual, testRepeatBase, entries[picked].Item.Weight)
	}
	if turns["light"] == 0 {
		t.Fatal("light entry must not starve")
	}
	ratio := float64(turns["heavy"]) / float64(turns["light"])
	if ratio < 5 || ratio > 7 {
		t.Fatalf("turns %v, want about 6 to 1", turns)
	}
}

func sortByPass(entries []scheduleEntry) {
	if entries[1].Pass < entries[0].Pass {
		entries[0], entries[1] = entries[1], entries[0]
	}
}

func TestGiftContentIsCutToColumnSize(t *testing.T) {
	long := make([]rune, 300)
	for i := range long {
		long[i] = 'à'
	}
	sender := megaphoneEvents.Sender{Username: string(long)}
	receiver := megaphoneEvents.Sender{Username: "b", FullName: "Bình"}
	if got := []rune(giftContent(sender, receiver, "Hoa", 1)); len(got) != systemContentRunes {
		t.Fatalf("content has %d runes", len(got))
	}
	if got := giftContent(megaphoneEvents.Sender{Username: "an"}, receiver, "Hoa", 5); got != "an đã tặng Bình Hoa ×5" {
		t.Fatalf("got %q", got)
	}
}

func TestPlayEventStaleness(t *testing.T) {
	now := time.Now()
	view := megaphoneEvents.Megaphone{DisplaySeconds: 12, ExpiresAt: now.Add(time.Hour)}
	if (megaphoneEvents.PlayEvent{Megaphone: view, PlayedAt: now.Add(-5 * time.Second)}).Stale(now) {
		t.Fatal("recent play must be delivered")
	}
	if !(megaphoneEvents.PlayEvent{Megaphone: view, PlayedAt: now.Add(-time.Minute)}).Stale(now) {
		t.Fatal("old play must be skipped")
	}
	view.ExpiresAt = now
	if !(megaphoneEvents.PlayEvent{Megaphone: view, PlayedAt: now}).Stale(now) {
		t.Fatal("expired megaphone must be skipped")
	}
}

func TestQueueWaitCountsRunningSlotAndWaitingItems(t *testing.T) {
	if got := queueWait(0, 15, 0); got != 0 {
		t.Fatalf("empty queue waits %v", got)
	}
	if got := queueWait(0, 15, 9*time.Second); got != 9*time.Second {
		t.Fatalf("running slot only waits %v", got)
	}
	if got := queueWait(2, 15, 9*time.Second); got != 39*time.Second {
		t.Fatalf("running slot and queue wait %v", got)
	}
}
