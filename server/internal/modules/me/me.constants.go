package me

const (
	UploadFolderPosts           = "posts"
	MaxPostImages               = 5
	MaxPostAudios               = 1
	MaxPostAudioDurationSeconds = 300
	MaxPostUploadCleanup        = MaxPostImages + MaxPostAudios

	CacheKeyMePostTopLikers    = "ME:POST:%s:TOP_LIKERS"
	CacheKeyMeCommentTopLikers = "ME:COMMENT:%s:TOP_LIKERS"
	MeTopLikersTTLSeconds      = 86400
	CacheKeyMeLikeLock         = "LOCK:ME_LIKE:%s"
	CacheKeyRateLimitMeLike    = "RATE_LIMIT:%s:ME_LIKE"
	CacheKeyMeNotifPushGuard   = "ME_NOTIF:PUSH_GUARD:%s:%s:%s"
	MeNotifPushGuardTTLSeconds = 600
	CacheKeyMePostUpload       = "ME:UPLOAD:V2:%s:%s"
	MePostUploadTTLSeconds     = 3600
)
