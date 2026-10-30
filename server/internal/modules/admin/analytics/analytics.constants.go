package adminanalytics

import "time"

const (
	CacheKeyAdminAnalyticsOverview = "ADMIN:ANALYTICS:OVERVIEW:V2:%s"
	AdminAnalyticsOverviewTTL      = 15 * time.Minute
	CacheKeyAdminAnalyticsRealtime = "ADMIN:ANALYTICS:REALTIME:V3:%s"
	AdminAnalyticsRealtimeTTL      = time.Minute
)
