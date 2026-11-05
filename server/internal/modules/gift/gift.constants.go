package gift

import "time"

const (
	CacheKeyGiftCatalog     = "GIFT:CATALOG"
	CacheKeyGiftLeaderboard = "GIFT:LB:%s:%s"

	CacheTTLGiftCatalog     = 10 * time.Minute
	CacheTTLGiftLeaderboard = time.Minute

	ErrorCodeGiftDisabled            = "GIFT_DISABLED"
	ErrorCodeGiftNotFound            = "GIFT_NOT_FOUND"
	ErrorCodeGiftSelf                = "GIFT_SELF"
	ErrorCodeGiftBlocked             = "GIFT_BLOCKED"
	ErrorCodeGiftReceiverUnavailable = "GIFT_RECEIVER_UNAVAILABLE"
	ErrorCodeGiftInsufficientKen     = "GIFT_INSUFFICIENT_KEN"
	ErrorCodeGiftInvalidQuantity     = "GIFT_INVALID_QUANTITY"
	ErrorCodeGiftNoteTooLong         = "GIFT_NOTE_TOO_LONG"
	ErrorCodeGiftRequestConflict     = "GIFT_REQUEST_CONFLICT"

	LeaderboardTypeSender   = "sender"
	LeaderboardTypeReceiver = "receiver"

	LeaderboardDefaultLimit = 50
	LeaderboardMaxLimit     = 100

	HistoryDefaultLimit = 20
	HistoryMaxLimit     = 50

	HistoryDirectionReceived = "received"
	HistoryDirectionSent     = "sent"

	KenRefTypeUser = "user"
)
