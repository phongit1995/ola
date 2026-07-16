package message

import (
	"fmt"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/services"
	"time"

	"github.com/gocql/gocql"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type CacheService struct {
	cache  *services.CacheService
	logger *zap.SugaredLogger
}

func NewCacheService(cache *services.CacheService, logger *zap.SugaredLogger) *CacheService {
	return &CacheService{
		cache:  cache,
		logger: logger.Named("[message_cache]"),
	}
}

func (c *CacheService) SetMessage(message *Message) error {
	key := fmt.Sprintf(constants.CacheKeyMessage, fmt.Sprintf("%s:%s", message.ConversationID.String(), message.MessageID.String()))
	return c.cache.Set(key, message, constants.CacheTTLMessage*time.Second)
}

func (c *CacheService) GetMessage(conversationID uuid.UUID, messageID gocql.UUID) (*Message, error) {
	key := fmt.Sprintf(constants.CacheKeyMessage, fmt.Sprintf("%s:%s", conversationID.String(), messageID.String()))
	var msg Message
	if err := c.cache.Get(key, &msg); err != nil {
		return nil, err
	}
	return &msg, nil
}

func (c *CacheService) DeleteMessage(conversationID uuid.UUID, messageID gocql.UUID) error {
	key := fmt.Sprintf(constants.CacheKeyMessage, fmt.Sprintf("%s:%s", conversationID.String(), messageID.String()))
	return c.cache.Delete(key)
}

type cachedMessagePage struct {
	Messages  []Message
	Exhausted bool
}

func (c *CacheService) GetConversationMessages(conversationID uuid.UUID) ([]Message, bool, error) {
	key := fmt.Sprintf(constants.CacheKeyMessageList, conversationID.String())
	var page cachedMessagePage
	if err := c.cache.Get(key, &page); err != nil {
		return nil, false, err
	}
	return page.Messages, page.Exhausted, nil
}

func (c *CacheService) SetConversationMessages(conversationID uuid.UUID, messages []Message, exhausted bool) error {
	key := fmt.Sprintf(constants.CacheKeyMessageList, conversationID.String())
	return c.cache.Set(key, cachedMessagePage{Messages: messages, Exhausted: exhausted}, constants.CacheTTLMessageList*time.Second)
}

func (c *CacheService) DeleteConversationMessages(conversationID uuid.UUID) error {
	key := fmt.Sprintf(constants.CacheKeyMessageList, conversationID.String())
	return c.cache.Delete(key)
}

func (c *CacheService) InvalidateConversationMessages(conversationID uuid.UUID) error {
	if err := c.DeleteConversationMessages(conversationID); err != nil {
		c.logger.Warnw("Failed to delete conversation messages cache", "conversation_id", conversationID, "error", err)
	}

	return nil
}

func clientMsgIDKey(senderID uuid.UUID, clientMsgID string) string {
	return fmt.Sprintf("dedup:%s:%s", senderID.String(), clientMsgID)
}

func (c *CacheService) GetMessageByClientMsgID(senderID uuid.UUID, clientMsgID string) (*MessageResponse, error) {
	var resp MessageResponse
	if err := c.cache.Get(clientMsgIDKey(senderID, clientMsgID), &resp); err != nil {
		return nil, err
	}
	return &resp, nil
}

func (c *CacheService) SetMessageByClientMsgID(senderID uuid.UUID, clientMsgID string, resp *MessageResponse) error {
	return c.cache.Set(clientMsgIDKey(senderID, clientMsgID), resp, constants.CacheTTLClientMsgIDDedup*time.Second)
}
