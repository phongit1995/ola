package constants

const (
	KafkaTopicMessageCreated         = "CHAT.MESSAGE.CREATED"
	KafkaTopicMessageDeleted         = "CHAT.MESSAGE.DELETED"
	KafkaTopicMessageUpdated         = "CHAT.MESSAGE.UPDATED"
	KafkaTopicMessageReactionUpdated = "CHAT.MESSAGE.REACTION_UPDATED"
	KafkaTopicConversationCreated = "CHAT.CONVERSATION.CREATED"
	KafkaTopicConversationUpdated = "CHAT.CONVERSATION.UPDATED"
	KafkaTopicConversationDeleted = "CHAT.CONVERSATION.DELETED"
	KafkaTopicUserTyping          = "CHAT.USER.TYPING"
	KafkaTopicCallInvited         = "CHAT.CALL.INVITED"
	KafkaTopicCallAccepted        = "CHAT.CALL.ACCEPTED"
	KafkaTopicCallDeclined        = "CHAT.CALL.DECLINED"
	KafkaTopicCallEnded           = "CHAT.CALL.ENDED"
	KafkaTopicRoomMessageCreated  = "CHAT.ROOM.MESSAGE.CREATED"
	KafkaTopicRoomMessageDeleted  = "CHAT.ROOM.MESSAGE.DELETED"
)

func AllKafkaTopics() []string {
	return []string{
		KafkaTopicMessageCreated,
		KafkaTopicMessageDeleted,
		KafkaTopicMessageUpdated,
		KafkaTopicMessageReactionUpdated,
		KafkaTopicConversationCreated,
		KafkaTopicConversationUpdated,
		KafkaTopicConversationDeleted,
		KafkaTopicUserTyping,
		KafkaTopicCallInvited,
		KafkaTopicCallAccepted,
		KafkaTopicCallDeclined,
		KafkaTopicCallEnded,
		KafkaTopicRoomMessageCreated,
		KafkaTopicRoomMessageDeleted,
	}
}

const (
	KafkaConsumerGroup = "CHAT-SERVICE-CONSUMERS"
)

const (
	CacheKeyUserProfile         = "USER:%s:PROFILE"
	CacheKeyUserSession         = "USER:%s:SESSION"
	CacheKeyUserRefreshToken    = "USER:%s:REFRESH_TOKEN"
	CacheKeyTokenBlacklist      = "JWT_BLACKLIST:%s"
	CacheKeySessionRevoked      = "SESSION_REVOKED:%s"
	CacheKeyConversation        = "CONVERSATION:%s:DETAIL"
	CacheKeyConversationList    = "USER:%s:CONVERSATIONS"
	CacheKeyConversationMembers = "CONVERSATION:%s:MEMBERS"
	CacheKeyHiddenConversations = "USER:%s:HIDDEN_CONVERSATIONS"
	CacheKeyMessage             = "MESSAGE:%s:DETAIL"
	CacheKeyMessageList         = "CONVERSATION:%s:MESSAGES"
	CacheKeyRelationship        = "RELATIONSHIP:%s:DETAIL"
	CacheKeyRelationshipList    = "USER:%s:RELATIONSHIPS"
	CacheKeyFriendList          = "USER:%s:FRIENDS"
	CacheKeyUnreadCount         = "CONVERSATION:%s:USER:%s:UNREAD"
	CacheKeyTypingUsers         = "CONVERSATION:%s:TYPING"
	CacheKeyTypingRateLimit     = "TYPING:%s:%s:RATE_LIMIT"
	CacheKeyRateLimitLogin      = "RATE_LIMIT:%s:LOGIN"
	CacheKeyRateLimitRegister   = "RATE_LIMIT:%s:REGISTER"
	CacheKeyRateLimitAPI        = "RATE_LIMIT:%s:API"
	CacheKeyOTPVerification     = "OTP:%s:VERIFICATION"
	CacheKeyPasswordResetToken  = "PASSWORD:%s:RESET_TOKEN"
	CacheKeyConversationPattern = "USER:*:CONVERSATIONS"
	CacheKeyLastRead            = "LAST_READ:%s:%s"
	CacheKeyRoomMembers         = "ROOM:%s:MEMBERS"
	CacheKeyRoomUserConn        = "ROOM:%s:USER:%s:CONN"
	CacheKeyRoomMsgIndex        = "ROOM:%s:MSG_INDEX"
	CacheKeyRoomMsgData         = "ROOM:%s:MSG"
	CacheKeyRoomJoinTicket      = "ROOM:JOIN_TICKET:%s"
)

const (
	RoomPresenceTTLSeconds   = 300
	RoomJoinTicketTTLSeconds = 5
)

const (
	SocketEventRoomJoin  = "ROOM:JOIN"
	SocketEventRoomLeave = "ROOM:LEAVE"
)

const (
	WebSocketEventConnect             = "CONNECT"
	WebSocketEventDisconnect          = "DISCONNECT"
	WebSocketEventNewMessage          = "NEW_MESSAGE"
	WebSocketEventMessageDeleted          = "MESSAGE_DELETED"
	WebSocketEventMessageUpdated          = "MESSAGE_UPDATED"
	WebSocketEventMessageReactionUpdated  = "MESSAGE_REACTION_UPDATED"
	WebSocketEventConversationCreated = "CONVERSATION_CREATED"
	WebSocketEventConversationUpdated = "CONVERSATION_UPDATED"
	WebSocketEventConversationDeleted = "CONVERSATION_DELETED"
	WebSocketEventUserTyping          = "USER_TYPING"
	WebSocketEventUserStopTyping      = "USER_STOP_TYPING"
	WebSocketEventIncomingCall        = "INCOMING_CALL"
	WebSocketEventCallAccepted        = "CALL_ACCEPTED"
	WebSocketEventCallDeclined        = "CALL_DECLINED"
	WebSocketEventCallEnded           = "CALL_ENDED"
	WebSocketEventError               = "ERROR"
	WebSocketEventNewRoomMessage      = "NEW_ROOM_MESSAGE"
	WebSocketEventRoomMessageDeleted  = "ROOM_MESSAGE_DELETED"
	WebSocketEventRoomMemberJoined    = "ROOM_MEMBER_JOINED"
	WebSocketEventRoomMemberLeft      = "ROOM_MEMBER_LEFT"
	WebSocketEventSessionReplaced     = "SESSION_REPLACED"
)

var CallRingTimeoutSeconds = 30

const (
	WebSocketMessageEvent = "message"
)

const (
	CacheKeyPresence       = "PRESENCE:%s:ONLINE"
	PresenceTTLSeconds     = 300
	CacheKeyLastActive     = "PRESENCE:%s:LAST_ACTIVE"
	LastActiveTTLSeconds   = 86400
	OnlineGraceWindowSecs  = 120
)

const (
	CacheTTLUserProfile         = 3600
	CacheTTLUserSession         = 86400
	CacheTTLConversation        = 1800
	CacheTTLConversationList    = 600
	CacheTTLHiddenConversations = 1800
	CacheTTLMessage             = 3600
	CacheTTLMessageList         = 300
	CacheTTLRelationship        = 3600
	CacheTTLFriendList          = 60
	CacheTTLUnreadCount         = 60
	CacheTTLRateLimit           = 60
	CacheTTLOTP                 = 300
	CacheTTLPasswordResetToken  = 1800
	CacheTTLClientMsgIDDedup    = 300
	CacheTTLLastRead            = 31536000
)

const (
	RateLimitLoginMaxRequests    = 5
	RateLimitRegisterMaxRequests = 3
	RateLimitAPIMaxRequests      = 100
	RateLimitWindowSeconds       = 60
)

const (
	MessageStatusSent      = "SENT"
	MessageStatusDelivered = "DELIVERED"
	MessageStatusRead      = "READ"
	MessageStatusDeleted   = "DELETED"
)

const (
	ConversationTypePrivate = "PRIVATE"
	ConversationTypeGroup   = "GROUP"
	ConversationTypeChannel = "CHANNEL"

	ConversationTypeDirect  = "direct"
	ConversationTypeGroupDB = "group"
	MemberRoleDefault       = "member"
	MemberRoleAdmin         = "admin"
)

const (
	RelationshipStatusPending  = "PENDING"
	RelationshipStatusAccepted = "ACCEPTED"
	RelationshipStatusBlocked  = "BLOCKED"
	RelationshipStatusRejected = "REJECTED"
)

const (
	UserRoleUser  = "USER"
	UserRoleAdmin = "ADMIN"
	UserRoleMod   = "MODERATOR"
)

const (
	ContextKeyUserID    = "USER_ID"
	ContextKeyTraceID   = "TRACE_ID"
	ContextKeyRequestID = "REQUEST_ID"
)

const (
	MessageTypeText  = "text"
	MessageTypeImage = "image"
	MessageTypeFile  = "file"
	MessageTypeVideo = "video"
	MessageTypeAudio = "audio"

	MessageDeletedPreview = "[Tin nhắn đã bị xóa]"
)

const (
	MaxImageUploadSize             = 2 * 1024 * 1024
	MaxAudioUploadSize             = 10 * 1024 * 1024
	MaxAudioDurationSeconds        = 300
	UploadFolderMessages           = "messages"
	UploadFolderPosts              = "posts"
	MaxPostImages                  = 5
	CacheKeyRateLimitUpload        = "RATE_LIMIT:%s:UPLOAD"
	RateLimitUploadMaxRequests     = 30
	RateLimitUploadWindowSeconds   = 60
)

var AllowedImageMimes = []string{
	"image/jpeg",
	"image/png",
	"image/gif",
	"image/webp",
}

var AllowedAudioMimes = []string{
	"audio/webm",
	"audio/mp4",
	"audio/aac",
	"audio/mpeg",
	"audio/wav",
	"audio/x-wav",
	"audio/ogg",
}

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
	MaxReactionTypesPerUserPerMessage = 5
	CacheKeyRateLimitReaction         = "RATE_LIMIT:%s:REACTION"
	RateLimitReactionMaxRequests      = 60
	RateLimitReactionWindowSeconds    = 60
	CacheKeyReactionLock              = "LOCK:REACTION:%s"
	ReactionLockTTLSeconds            = 3
	ReactionLockRetryMs               = 150

	ReactionActionAdded   = "added"
	ReactionActionRemoved = "removed"
)
