package admincheckin

import "time"

const (
	CacheKeyCheckinBackfilledDay = "CHECKIN:BACKFILLED:%s"
	CacheTTLCheckinBackfilledDay = 45 * 24 * time.Hour
)
