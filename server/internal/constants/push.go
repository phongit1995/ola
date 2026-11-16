package constants

import "fmt"

const (
	CacheKeyPushPending = "PUSH:PENDING:%s:%s"
	PushSourceMeNotif   = "me"
	PushSourceAppNotif  = "app"
	PushSourceDMPrefix  = "dm:"

	PushSourceFriendContent = "friend"
	FriendContentPost       = "post"
	FriendContentMoment     = "moment"
)

func PushDMSource(conversationID string) string {
	return PushSourceDMPrefix + conversationID
}

func PushFriendContentNotifID(contentID string) string {
	return PushSourceFriendContent + ":" + contentID
}

func PushPendingKey(recipientID, source string) string {
	return fmt.Sprintf(CacheKeyPushPending, recipientID, source)
}

const (
	PushPlatformAndroid = "android"
	PushPlatformIOS     = "ios"
)
