package checkin

import (
	"testing"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/utils"
)

func vnAt(year int, month time.Month, day, hour int) time.Time {
	return time.Date(year, month, day, hour, 0, 0, 0, utils.VietnamTime)
}

func monthRow(published *time.Time) *models.CheckinMonth {
	return &models.CheckinMonth{Month: time.Date(2026, 11, 1, 0, 0, 0, 0, time.UTC), SlotCount: 28, PublishedAt: published}
}

func TestCalendarDateUsesVietnamDay(t *testing.T) {
	utcEvening := time.Date(2026, 11, 18, 17, 30, 0, 0, time.UTC)
	if got := DayKey(CalendarDate(utcEvening)); got != "2026-11-19" {
		t.Fatalf("17:30 UTC is 00:30 VN next day, got %s", got)
	}
	if got := MonthKey(MonthDate(time.Date(2026, 10, 31, 17, 0, 0, 0, time.UTC))); got != "2026-11" {
		t.Fatalf("31/10 17:00 UTC is 01/11 VN, got %s", got)
	}
}

func TestLockedThrough(t *testing.T) {
	before := vnAt(2026, 10, 25, 10)
	midMonth := vnAt(2026, 11, 19, 8)
	cases := []struct {
		name  string
		month *models.CheckinMonth
		now   time.Time
		want  int
	}{
		{"draft never locks", monthRow(nil), vnAt(2026, 11, 19, 10), 0},
		{"published before month, day 19", monthRow(&before), vnAt(2026, 11, 19, 10), 19},
		{"published before month, day 1", monthRow(&before), vnAt(2026, 11, 1, 0), 1},
		{"published mid month same day", monthRow(&midMonth), vnAt(2026, 11, 19, 23), 1},
		{"published mid month next day", monthRow(&midMonth), vnAt(2026, 11, 20, 1), 2},
		{"upcoming month", monthRow(&before), vnAt(2026, 10, 30, 10), 0},
		{"past month", monthRow(&before), vnAt(2026, 12, 2, 10), 28},
		{"capped at slot count", monthRow(&before), vnAt(2026, 11, 30, 10), 28},
	}
	for _, tc := range cases {
		if got := LockedThrough(tc.month, tc.now); got != tc.want {
			t.Errorf("%s: got %d want %d", tc.name, got, tc.want)
		}
	}
}

func TestIsLive(t *testing.T) {
	published := vnAt(2026, 11, 19, 8)
	if IsLive(monthRow(nil), vnAt(2026, 11, 19, 10)) {
		t.Fatal("draft must not be live")
	}
	if IsLive(monthRow(&published), vnAt(2026, 11, 19, 7)) {
		t.Fatal("not live before publish time")
	}
	if !IsLive(monthRow(&published), vnAt(2026, 11, 19, 9)) {
		t.Fatal("live after publish")
	}
	if IsLive(monthRow(&published), vnAt(2026, 12, 1, 9)) {
		t.Fatal("not live in another month")
	}
}

func TestReachable(t *testing.T) {
	month := time.Date(2026, 11, 1, 0, 0, 0, 0, time.UTC)
	if got := Reachable(0, false, month, vnAt(2026, 11, 15, 9)); got != 16 {
		t.Fatalf("joining on 15/11 reaches slot 16, got %d", got)
	}
	if got := Reachable(16, true, month, vnAt(2026, 11, 18, 9)); got != 28 {
		t.Fatalf("16 check-ins done today on 18/11 reach 28, got %d", got)
	}
	if got := Reachable(16, false, month, vnAt(2026, 11, 18, 9)); got != 29 {
		t.Fatalf("16 check-ins not yet today on 18/11 reach 29, got %d", got)
	}
}

func TestSlotBox(t *testing.T) {
	gifts := models.CheckinGifts{{Options: []models.CheckinGiftOption{{Weight: 100}}}}
	if SlotBox(nil, true) != BoxNone || SlotBox(gifts, false) != BoxNormal || SlotBox(gifts, true) != BoxBig {
		t.Fatal("unexpected box kind")
	}
}

func TestDrawPicksOneOptionPerGift(t *testing.T) {
	picks := []int{1, 0}
	s := &Service{pick: func([]float64) int {
		p := picks[0]
		picks = picks[1:]
		return p
	}}
	gifts := models.CheckinGifts{
		{Options: []models.CheckinGiftOption{
			{CheckinReward: models.CheckinReward{Type: models.CheckinRewardVipIcon, VipIconID: 30}, Weight: 60},
			{CheckinReward: models.CheckinReward{Type: models.CheckinRewardAvatarFrame, FrameID: "004"}, Weight: 40},
		}},
		{Options: []models.CheckinGiftOption{
			{CheckinReward: models.CheckinReward{Type: models.CheckinRewardMegaphoneTicket, Count: 1}, Weight: 100},
		}},
	}
	items := s.draw(gifts)
	if len(items) != 2 {
		t.Fatalf("want 2 items, got %d", len(items))
	}
	if items[0].Gift != 1 || items[0].Option != 2 || items[0].FrameID != "004" {
		t.Fatalf("gift 1 should pick option 2, got %+v", items[0])
	}
	if items[1].Gift != 2 || items[1].Option != 1 || items[1].Count != 1 {
		t.Fatalf("gift 2 should pick option 1, got %+v", items[1])
	}
}

func TestDrawRespectsWeights(t *testing.T) {
	s := &Service{pick: utils.WeightedPick}
	gifts := models.CheckinGifts{{Options: []models.CheckinGiftOption{
		{CheckinReward: models.CheckinReward{Type: models.CheckinRewardKen, Amount: 1}, Weight: 70},
		{CheckinReward: models.CheckinReward{Type: models.CheckinRewardKen, Amount: 2}, Weight: 30},
	}}}
	const runs = 10000
	first := 0
	for i := 0; i < runs; i++ {
		if s.draw(gifts)[0].Option == 1 {
			first++
		}
	}
	ratio := float64(first) / runs
	if ratio < 0.68 || ratio > 0.72 {
		t.Fatalf("70%% option drawn %.3f of the time", ratio)
	}
}

func TestDrawRandomKen(t *testing.T) {
	s := &Service{pick: utils.WeightedPick}
	gifts := models.CheckinGifts{{Options: []models.CheckinGiftOption{
		{CheckinReward: models.CheckinReward{Type: models.CheckinRewardKen, AmountMin: KenRandomMin, AmountMax: KenRandomMax}, Weight: 100},
	}}}
	seen := map[int]int{}
	const runs = 20000
	for i := 0; i < runs; i++ {
		item := s.draw(gifts)[0]
		if item.AmountMin != 0 || item.AmountMax != 0 {
			t.Fatalf("result must keep only the drawn amount, got %+v", item)
		}
		if item.Amount < KenRandomMin || item.Amount > KenRandomMax || item.Amount%KenRandomStep != 0 {
			t.Fatalf("amount %d outside 100-1000 step 100", item.Amount)
		}
		seen[item.Amount]++
	}
	if len(seen) != 10 {
		t.Fatalf("want 10 possible amounts, got %v", seen)
	}
	for amount, n := range seen {
		if ratio := float64(n) / runs; ratio < 0.085 || ratio > 0.115 {
			t.Fatalf("amount %d drawn %.3f of the time, want about 0.1", amount, ratio)
		}
	}
}

func TestDefaultRandomTasksSkipKenTasks(t *testing.T) {
	for _, code := range DefaultRandomTasks() {
		if code == TaskSendGift || code == TaskSendMegaphone {
			t.Fatalf("%s costs KEN and must not be in the default random list", code)
		}
	}
	if !IsSlotTask(models.CheckinTaskRandom) || !IsSlotTask(TaskPlayGame) || IsSlotTask("chat") {
		t.Fatal("unexpected slot task validation")
	}
}

func gateOf(code string) taskGate {
	def, _ := findTask(code)
	return def.gate
}

func TestPickableTasksSkipClosedFeatures(t *testing.T) {
	noStoryMoment := func(code string) bool {
		g := gateOf(code)
		return g != gateStory && g != gateMoment
	}
	cfg := setting.CheckinConfig{RandomTasks: []string{TaskStoryComment, TaskMomentPost, TaskMeComment}}
	if got := PickableTasks(cfg, noStoryMoment); len(got) != 1 || got[0] != TaskMeComment {
		t.Fatalf("want only me_comment, got %v", got)
	}
	onlyStory := setting.CheckinConfig{RandomTasks: []string{TaskStoryComment}}
	got := PickableTasks(onlyStory, noStoryMoment)
	if len(got) == 0 {
		t.Fatal("must fall back to default tasks the client can do")
	}
	for _, code := range got {
		if !noStoryMoment(code) {
			t.Fatalf("fallback includes closed task %s", code)
		}
	}
}

func TestResolveTaskFallsBackWhenFixedTaskClosed(t *testing.T) {
	s := &Service{pick: func([]float64) int { return 0 }}
	gift := TaskSendGift
	closedGift := func(code string) bool { return code != TaskSendGift }
	cfg := setting.CheckinConfig{RandomTasks: []string{TaskMePost}}
	if got := s.resolveTask(&gift, cfg, closedGift); got != TaskMePost {
		t.Fatalf("closed fixed task must fall back to random, got %s", got)
	}
	if got := s.resolveTask(&gift, cfg, func(string) bool { return true }); got != TaskSendGift {
		t.Fatalf("open fixed task must be kept, got %s", got)
	}
}
