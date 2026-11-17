package sociallimit

import "time"

const (
	CacheKeyNewChats       = "SOCIAL_LIMIT:NEW_CHAT:%s:%s"
	CacheKeyFriendRequests = "SOCIAL_LIMIT:FRIEND_REQUEST:%s:%s"
	CacheKeyPosts          = "SOCIAL_LIMIT:POST:%s:%s:%s"

	CacheTTLDaily = 48 * time.Hour

	ConfigTTL     = time.Minute
	RefundTimeout = 2 * time.Second
	DayUTCOffset  = 7 * 60 * 60

	ErrorCodeDailyNewChatLimit       = "DAILY_NEW_CHAT_LIMIT"
	ErrorCodeDailyFriendRequestLimit = "DAILY_FRIEND_REQUEST_LIMIT"
	ErrorCodeDailyMePostLimit        = "DAILY_ME_POST_LIMIT"
	ErrorCodeDailyMomentPostLimit    = "MOMENT_QUOTA_EXCEEDED"
)
