package relationships

const (
	CacheKeyRelationshipBlock = "RELATIONSHIP:BLOCK:%s:%s"
	CacheKeyFriendList        = "USER:%s:FRIENDS"

	CacheTTLRelationship        = 86400
	CacheTTLRelationshipAllowed = 300
	CacheTTLFriendList          = 60

	MaxFriendsPerUser      = 100
	MaxPendingSentRequests = 200
)
