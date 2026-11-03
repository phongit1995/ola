package utils

import "time"

const (
	PeriodDay   = "day"
	PeriodWeek  = "week"
	PeriodMonth = "month"
	PeriodAll   = "all"
)

var VietnamTime = time.FixedZone("GMT+7", 7*60*60)

func VietnamPeriodStart(now time.Time, period string) (time.Time, bool) {
	local := now.In(VietnamTime)
	start := time.Date(local.Year(), local.Month(), local.Day(), 0, 0, 0, 0, VietnamTime)
	switch period {
	case PeriodDay:
	case PeriodWeek:
		start = start.AddDate(0, 0, -((int(local.Weekday()) + 6) % 7))
	case PeriodMonth:
		start = time.Date(local.Year(), local.Month(), 1, 0, 0, 0, 0, VietnamTime)
	default:
		return time.Time{}, false
	}
	return start.UTC(), true
}
