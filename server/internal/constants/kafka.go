package constants

const (
	KafkaTopicMessageCreated             = "CHAT.MESSAGE.CREATED"
	KafkaTopicMessageDeleted             = "CHAT.MESSAGE.DELETED"
	KafkaTopicMessageUpdated             = "CHAT.MESSAGE.UPDATED"
	KafkaTopicMessageReactionUpdated     = "CHAT.MESSAGE.REACTION_UPDATED"
	KafkaTopicConversationCreated        = "CHAT.CONVERSATION.CREATED"
	KafkaTopicConversationUpdated        = "CHAT.CONVERSATION.UPDATED"
	KafkaTopicConversationDeleted        = "CHAT.CONVERSATION.DELETED"
	KafkaTopicUserTyping                 = "CHAT.USER.TYPING"
	KafkaTopicCallInvited                = "CHAT.CALL.INVITED"
	KafkaTopicCallAccepted               = "CHAT.CALL.ACCEPTED"
	KafkaTopicCallDeclined               = "CHAT.CALL.DECLINED"
	KafkaTopicCallEnded                  = "CHAT.CALL.ENDED"
	KafkaTopicRoomMessageCreated         = "CHAT.ROOM.MESSAGE.CREATED"
	KafkaTopicRoomMessageDeleted         = "CHAT.ROOM.MESSAGE.DELETED"
	KafkaTopicRoomMessageReactionUpdated = "CHAT.ROOM.MESSAGE.REACTION_UPDATED"
	KafkaTopicWordChainEvent             = "CHAT.WORD_CHAIN.EVENT"
	KafkaTopicKenChestAvailable          = "CHAT.KEN.CHEST.AVAILABLE"
	KafkaTopicKenChestClosed             = "CHAT.KEN.CHEST.CLOSED"
	KafkaTopicMeNotification             = "CHAT.ME.NOTIFICATION"
	KafkaTopicAppNotification            = "CHAT.APP.NOTIFICATION"
	KafkaTopicUserBanned                 = "CHAT.USER.BANNED"
	KafkaTopicPushBroadcast              = "CHAT.PUSH.BROADCAST"
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
		KafkaTopicRoomMessageReactionUpdated,
		KafkaTopicWordChainEvent,
		KafkaTopicKenChestAvailable,
		KafkaTopicKenChestClosed,
		KafkaTopicMeNotification,
		KafkaTopicAppNotification,
		KafkaTopicUserBanned,
		KafkaTopicPushBroadcast,
	}
}

const KafkaConsumerGroup = "CHAT-SERVICE-CONSUMERS"
