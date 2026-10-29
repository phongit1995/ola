package push

const (
	CacheKeyPushEvent      = "PUSH:EVENT:%s:%s"
	PushEventTTLSeconds    = 120
	CacheKeyPushThrottle   = "PUSH:THROTTLE:%s:%s"
	PushThrottleTTLSeconds = 45
	PushPendingTTLSeconds  = 120
	PushExcerptMaxRunes    = 120
	PushSendTimeoutSeconds = 10
	PushDispatchWorkers    = 4
	PushDispatchQueueSize  = 1024

	PushCollapseDM       = "dm"
	PushTTLHours         = 24
	PushSendBatchSize    = 500
	PushDataTypeDM       = "dm"
	PushDataTypeMeNotif  = "me_notification"
	PushDataTypeAppNotif = "app_notification"
	PushChannelMessages  = "messages"
	PushChannelSocial    = "social"
	PushChannelSystem    = "system"

	APNSHeaderPushType   = "apns-push-type"
	APNSHeaderPriority   = "apns-priority"
	APNSHeaderExpiration = "apns-expiration"
	APNSHeaderCollapseID = "apns-collapse-id"
	APNSPushTypeAlert    = "alert"
	APNSPriorityHigh     = "10"
	APNSSoundDefault     = "default"

	PushSourceBroadcast      = "broadcast"
	PushDataTypeBroadcast    = "broadcast"
	PushCollapseBroadcast    = "broadcast"
	PushBroadcastNotifPrefix = "broadcast:"
	PushAudienceAll          = "all"
	PushAudienceVIP          = "vip"
	PushAudienceUser         = "user"
)

func PushBroadcastNotifID(campaignID string) string {
	return PushBroadcastNotifPrefix + campaignID
}
