package constants

const (
	ReactionTypeLike  = "LIKE"
	ReactionTypeLove  = "LOVE"
	ReactionTypeHaha  = "HAHA"
	ReactionTypeWow   = "WOW"
	ReactionTypeSad   = "SAD"
	ReactionTypeAngry = "ANGRY"
)

var AllowedReactionTypes = []string{
	ReactionTypeLike,
	ReactionTypeLove,
	ReactionTypeHaha,
	ReactionTypeWow,
	ReactionTypeSad,
	ReactionTypeAngry,
}

const (
	CacheKeyRateLimitReaction      = "RATE_LIMIT:%s:REACTION"
	RateLimitReactionMaxRequests   = 60
	RateLimitReactionWindowSeconds = 60
	CacheKeyReactionLock           = "LOCK:REACTION:%s"
	ReactionLockTTLSeconds         = 3
	ReactionLockRetryMs            = 150
	ReactionActionAdded            = "added"
	ReactionActionRemoved          = "removed"
)
