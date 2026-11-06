package megaphone

import "time"

const (
	ErrorCodeMegaphoneDisabled        = "MEGAPHONE_DISABLED"
	ErrorCodeMegaphoneContentEmpty    = "MEGAPHONE_CONTENT_EMPTY"
	ErrorCodeMegaphoneContentTooLong  = "MEGAPHONE_CONTENT_TOO_LONG"
	ErrorCodeMegaphoneLinkNotAllowed  = "MEGAPHONE_LINK_NOT_ALLOWED"
	ErrorCodeMegaphoneContentBlocked  = "MEGAPHONE_CONTENT_BLOCKED"
	ErrorCodeMegaphoneCooldown        = "MEGAPHONE_COOLDOWN"
	ErrorCodeMegaphoneDailyLimit      = "MEGAPHONE_DAILY_LIMIT"
	ErrorCodeMegaphoneQueueFull       = "MEGAPHONE_QUEUE_FULL"
	ErrorCodeMegaphoneInsufficientKen = "MEGAPHONE_INSUFFICIENT_KEN"
	ErrorCodeMegaphoneRequestConflict = "MEGAPHONE_REQUEST_CONFLICT"
	ErrorCodeMegaphoneNotFound        = "MEGAPHONE_NOT_FOUND"

	HistoryWindow       = 24 * time.Hour
	HistoryDefaultLimit = 20
	HistoryMaxLimit     = 50

	KenRefTypeMegaphone = "megaphone"

	CacheKeyMegaphoneSchedule    = "MEGAPHONE:SCHEDULE"
	CacheKeyMegaphoneItem        = "MEGAPHONE:ITEM:%s"
	CacheKeyMegaphoneVirtualPass = "MEGAPHONE:VIRTUAL_PASS"
	CacheKeyMegaphoneNextSlot    = "MEGAPHONE:NEXT_SLOT"
	CacheKeyMegaphoneLock        = "MEGAPHONE:LOCK"

	giftRequestPrefix      = "gift:"
	giftContentRunes       = 200
	queueAdvisoryLockKey   = int64(0x4d45474150484f4e)
	publishTimeout         = 5 * time.Second
	unknownSenderNameRunes = 8
	schedulerTick          = time.Second
	reconcileEvery         = time.Minute
	schedulerLockTTL       = 15 * time.Second
	itemTTLSlack           = time.Minute
)
