package constants

import "fmt"

const (
	CacheKeyPushPending = "PUSH:PENDING:%s:%s"
	PushSourceMeNotif   = "me"
	PushSourceAppNotif  = "app"
	PushSourceDMPrefix  = "dm:"
)

func PushDMSource(conversationID string) string {
	return PushSourceDMPrefix + conversationID
}

func PushPendingKey(recipientID, source string) string {
	return fmt.Sprintf(CacheKeyPushPending, recipientID, source)
}

const (
	PushPlatformAndroid = "android"
	PushPlatformIOS     = "ios"
)
