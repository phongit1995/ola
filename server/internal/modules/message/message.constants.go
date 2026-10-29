package message

const (
	CacheKeyMessage     = "MESSAGE:%s:DETAIL"
	CacheKeyMessageList = "CONVERSATION:%s:MESSAGES"

	MessageReplyExcerptMaxRunes = 120

	CacheTTLMessage          = 3600
	CacheTTLMessageList      = 300
	CacheTTLClientMsgIDDedup = 300

	MessageDeletedPreview = "[Tin nhắn đã bị xóa]"

	MaxAudioDurationSeconds = 300
	UploadFolderMessages    = "messages"

	MaxReactionTypesPerUserPerMessage = 5
)
