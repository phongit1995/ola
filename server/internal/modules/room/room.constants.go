package room

import "time"

const (
	CacheKeyRoomUnblocked       = "ROOM_UNBLOCKED:%s:%s"
	CacheKeyRoomMsgIndex        = "ROOM:%s:MSG_INDEX"
	CacheKeyRoomMsgData         = "ROOM:%s:MSG"
	CacheKeyRoomClientMessage   = "ROOM:%s:USER:%s:CLIENT_MSG:%s"
	CacheKeyRoomMediaUploadLock = "LOCK:ROOM_MEDIA_UPLOAD:%s:%s:%s"
	CacheKeyRoomImagePurgeLock  = "LOCK:ROOM_IMAGE_PURGE"
	AdvisoryLockRoomImagePurge  = "room_image_purge"

	RoomReplyExcerptMaxRunes = 120
	RoomMaxBlockedUsers      = 500

	ErrorCodeRoomVipRequired = "ROOM_VIP_REQUIRED"

	CacheTTLRoomUnblocked = 2592000

	MaxRoomAudioDurationSeconds = 60
	UploadFolderRooms           = "rooms"

	RoomImagePurgeMinDays = 30
	RoomImagePurgeMaxDays = 3650
	RoomImagePurgeTimeout = 10 * time.Minute
	RoomImagePurgeLockTTL = 15 * time.Minute
	RoomImagePurgeBatch   = 200
)
