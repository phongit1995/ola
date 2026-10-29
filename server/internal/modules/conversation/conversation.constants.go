package conversation

const (
	CacheKeyConversation        = "CONVERSATION:%s:DETAIL"
	CacheKeyConversationList    = "USER:%s:CONVERSATIONS"
	CacheKeyHiddenConversations = "USER:%s:HIDDEN_CONVERSATIONS"
	CacheKeyUnreadCount         = "CONVERSATION:%s:USER:%s:UNREAD"
	CacheKeyTypingRateLimit     = "TYPING:%s:%s:RATE_LIMIT"
	CacheKeyLastRead            = "LAST_READ:%s:%s"
	CacheKeyClearedMarker       = "CLEARED:%s:%s"

	CacheTTLConversationList    = 120
	CacheTTLHiddenConversations = 1800
	CacheTTLUnreadCount         = 2592000
	CacheTTLLastRead            = 31536000
	CacheTTLClearedMarker       = 31536000

	MaxConversationListLimit = 200
)
