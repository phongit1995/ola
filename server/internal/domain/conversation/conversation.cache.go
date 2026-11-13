package conversation

import (
	"fmt"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"
	"time"

	"github.com/gocql/gocql"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type ConversationMember struct {
	ConversationID uuid.UUID
	UserID         uuid.UUID
	JoinedAt       time.Time
	LeftAt         *time.Time
	IsActive       bool
	Role           string
}

type ConversationCache struct {
	cache  *services.CacheService
	logger *zap.SugaredLogger
}

func NewConversationCache(cache *services.CacheService, logger *zap.SugaredLogger) *ConversationCache {
	return &ConversationCache{
		cache:  cache,
		logger: logger.Named("[conversation_cache]"),
	}
}

func (c *ConversationCache) GetConversationMembers(conversationID uuid.UUID) ([]ConversationMember, error) {
	key := fmt.Sprintf(CacheKeyConversationMembers, conversationID.String())

	var members []ConversationMember
	if err := c.cache.Get(key, &members); err != nil {
		c.logger.Debugw("Cache miss for conversation members", "conversation_id", conversationID, "error", err)
		return nil, err
	}

	c.logger.Debugw("Cache hit for conversation members", "conversation_id", conversationID, "count", len(members))
	return members, nil
}

func (c *ConversationCache) SetConversationMembers(conversationID uuid.UUID, members []ConversationMember) error {
	key := fmt.Sprintf(CacheKeyConversationMembers, conversationID.String())
	return c.cache.Set(key, members, CacheTTLConversation*time.Second)
}

type ConversationCacheAdapter struct {
	cache   *ConversationCache
	session *gocql.Session
	logger  *zap.SugaredLogger
}

func NewConversationCacheAdapter(cache *ConversationCache, session *gocql.Session, logger *zap.SugaredLogger) *ConversationCacheAdapter {
	return &ConversationCacheAdapter{
		cache:   cache,
		session: session,
		logger:  logger.Named("[conv_cache_adapter]"),
	}
}

func (a *ConversationCacheAdapter) GetConversationMembers(conversationID string) ([]string, error) {
	convID, err := uuid.Parse(conversationID)
	if err != nil {
		return nil, err
	}

	members, err := a.cache.GetConversationMembers(convID)
	if err != nil || len(members) == 0 {
		members, err = a.loadMembers(convID)
		if err != nil {
			a.logger.Errorw("Failed to load conversation members", "conversation_id", conversationID, "error", err)
			return nil, err
		}
		loaded := members
		utils.SafeGo(a.logger, func() {
			if err := a.cache.SetConversationMembers(convID, loaded); err != nil {
				a.logger.Warnw("Failed to backfill members cache", "conversation_id", conversationID, "error", err)
			}
		})
	}

	userIDs := make([]string, 0, len(members))
	for _, member := range members {
		if member.IsActive {
			userIDs = append(userIDs, member.UserID.String())
		}
	}
	return userIDs, nil
}

func (a *ConversationCacheAdapter) loadMembers(convID uuid.UUID) ([]ConversationMember, error) {
	iter := a.session.Query(
		`SELECT user_id, joined_at, left_at, is_active, role FROM conversation_members_by_conversation WHERE conversation_id = ?`,
		gocql.UUID(convID),
	).Iter()

	var members []ConversationMember
	var (
		userID   gocql.UUID
		joinedAt time.Time
		leftAt   *time.Time
		isActive bool
		role     string
	)
	for iter.Scan(&userID, &joinedAt, &leftAt, &isActive, &role) {
		members = append(members, ConversationMember{
			ConversationID: convID,
			UserID:         uuid.UUID(userID),
			JoinedAt:       joinedAt,
			LeftAt:         leftAt,
			IsActive:       isActive,
			Role:           role,
		})
		leftAt = nil
	}
	if err := iter.Close(); err != nil {
		return nil, err
	}
	return members, nil
}
