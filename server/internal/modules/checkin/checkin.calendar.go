package checkin

import (
	"fmt"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"
)

func CalendarDate(t time.Time) time.Time {
	v := t.In(utils.VietnamTime)
	return time.Date(v.Year(), v.Month(), v.Day(), 0, 0, 0, 0, time.UTC)
}

func MonthDate(t time.Time) time.Time {
	v := t.In(utils.VietnamTime)
	return time.Date(v.Year(), v.Month(), 1, 0, 0, 0, 0, time.UTC)
}

func DayRange(day time.Time) (time.Time, time.Time) {
	start := time.Date(day.Year(), day.Month(), day.Day(), 0, 0, 0, 0, utils.VietnamTime)
	return start, start.AddDate(0, 0, 1)
}

func MonthKey(month time.Time) string {
	return month.Format(MonthLayout)
}

func DayKey(day time.Time) string {
	return day.Format(DayLayout)
}

func ParseMonth(value string) (time.Time, bool) {
	t, err := time.Parse(MonthLayout, value)
	if err != nil {
		return time.Time{}, false
	}
	return t, true
}

func DaysInMonth(month time.Time) int {
	return time.Date(month.Year(), month.Month()+1, 0, 0, 0, 0, 0, time.UTC).Day()
}

func MonthName(month time.Time) string {
	return fmt.Sprintf("tháng %d", int(month.Month()))
}

func IsLive(month *models.CheckinMonth, now time.Time) bool {
	return month != nil && month.PublishedAt != nil && !month.PublishedAt.After(now) && month.Month.Equal(MonthDate(now))
}

func LockedThrough(month *models.CheckinMonth, now time.Time) int {
	current := MonthDate(now)
	slotCount := int(month.SlotCount)
	if month.Month.Before(current) {
		return slotCount
	}
	if month.PublishedAt == nil || month.Month.After(current) {
		return 0
	}
	firstDay := 1
	if MonthDate(*month.PublishedAt).Equal(current) {
		firstDay = month.PublishedAt.In(utils.VietnamTime).Day()
	}
	k := now.In(utils.VietnamTime).Day() - firstDay + 1
	return max(0, min(k, slotCount))
}

func SlotBox(gifts models.CheckinGifts, featured bool) string {
	if len(gifts) == 0 {
		return BoxNone
	}
	if featured {
		return BoxBig
	}
	return BoxNormal
}

func Reachable(count int, checkedToday bool, month time.Time, now time.Time) int {
	remaining := DaysInMonth(month) - now.In(utils.VietnamTime).Day() + 1
	if checkedToday {
		remaining--
	}
	return count + remaining
}
