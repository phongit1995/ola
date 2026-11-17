package friendcontent

import "time"

const (
	CacheKeyAuthorGuard    = "FRIEND_CONTENT:AUTHOR:%s"
	AuthorGuardTTL         = 6 * time.Hour
	CacheKeyRecipientGuard = "FRIEND_CONTENT:RECIPIENT:%s"
	RecipientGuardTTL      = time.Hour
	momentStatusReady      = "ready"
	friendContentLogLabel  = "[friend_content_events]"
)
