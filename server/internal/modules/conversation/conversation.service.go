package conversation

import (
	"context"
	"errors"
	"fmt"
	"time"

	"ola-chat-server/internal/constants"
	conversationEvents "ola-chat-server/internal/domain/conversation"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/relationships"
	userModule "ola-chat-server/internal/modules/user"
	usersetting "ola-chat-server/internal/modules/user-setting"
	"ola-chat-server/internal/transport/kafka"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/gocql/gocql"
	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type Service struct {
	repo           *Repository
	cache          *CacheService
	userCache      *userModule.CacheService
	userSettingSvc *usersetting.Service
	relRepo        *relationships.Repository
	relSvc         BlockChecker
	kafkaProducer  *kafka.Producer
	presence       *websocket.PresenceService
	logger         *zap.SugaredLogger
}

func NewService(
	repo *Repository,
	cache *CacheService,
	userCache *userModule.CacheService,
	userSettingSvc *usersetting.Service,
	relRepo *relationships.Repository,
	relSvc *relationships.Service,
	kafkaProducer *kafka.Producer,
	presence *websocket.PresenceService,
	logger *zap.SugaredLogger,
) *Service {
	return &Service{
		repo:           repo,
		cache:          cache,
		userCache:      userCache,
		userSettingSvc: userSettingSvc,
		relRepo:        relRepo,
		relSvc:         relSvc,
		kafkaProducer:  kafkaProducer,
		presence:       presence,
		logger:         logger.Named("[conversation_service]"),
	}
}

type userCacheGetter interface {
	GetUserCache(userID uuid.UUID, fallbackToDB bool) (*models.User, error)
}

type ResolvedDisplay struct {
	ConversationType string
	DisplayName      string
	DisplayAvatar    string
	OtherUserID      *gocql.UUID
	OtherUserName    string
	OtherUserAvatar  string
}

func (s *Service) resolveConversationDisplay(conv *Conversation, viewerID uuid.UUID, members []ConversationMember) ResolvedDisplay {
	return ResolveConversationDisplay(conv, viewerID, members, s.userCache)
}

func ResolveConversationDisplay(conv *Conversation, viewerID uuid.UUID, members []ConversationMember, userCache userCacheGetter) ResolvedDisplay {
	if conv.Type == constants.ConversationTypeDirect {
		for _, m := range members {
			if m.UserID == viewerID || !m.IsActive {
				continue
			}
			if otherUser, err := userCache.GetUserCache(m.UserID, true); err == nil {
				name := userDisplayName(otherUser)
				gocqlID, _ := utils.ToGocqlUUID(m.UserID)
				return ResolvedDisplay{
					ConversationType: constants.ConversationTypeDirect,
					DisplayName:      name,
					DisplayAvatar:    otherUser.Avatar,
					OtherUserID:      &gocqlID,
					OtherUserName:    name,
					OtherUserAvatar:  otherUser.Avatar,
				}
			}
			break
		}
		return ResolvedDisplay{ConversationType: constants.ConversationTypeDirect}
	}
	return ResolvedDisplay{
		ConversationType: constants.ConversationTypeGroupDB,
		DisplayName:      conv.Name,
		DisplayAvatar:    conv.Avatar,
	}
}

func requireActiveMember(members []ConversationMember, userID uuid.UUID) bool {
	return IsActiveMember(members, userID)
}

func (s *Service) buildConversationResponse(conv ConversationByUser, viewerID uuid.UUID, otherLastRead *gocql.UUID, users map[uuid.UUID]*models.User) ConversationResponse {
	resp := ConversationResponse{
		ID:              conv.ConversationID.String(),
		Type:            conv.ConversationType,
		Name:            conv.DisplayName,
		Avatar:          conv.DisplayAvatar,
		LastMessageText: conv.LastMessagePreview,
		UnreadCount:     conv.UnreadCount,
		IsMuted:         conv.IsMuted,
		LastMessageAt:   conv.LastMessageAt.Time().Format(time.RFC3339),
	}

	if conv.ConversationType == constants.ConversationTypeDirect && conv.OtherUserID != nil {
		if otherUserID, err := uuid.Parse(conv.OtherUserID.String()); err == nil {
			u := users[otherUserID]
			var lookupErr error
			if u == nil {
				u, lookupErr = s.userCache.GetUserCache(otherUserID, true)
			}
			if u == nil {
				if lookupErr != nil && !errors.Is(lookupErr, gorm.ErrRecordNotFound) {
					s.logger.Warnw("buildConversationResponse: failed to fetch other user",
						"conversation_id", conv.ConversationID, "other_user_id", otherUserID, "error", lookupErr)
				}
			} else {
				resp.Name = userDisplayName(u)
				resp.Avatar = u.Avatar
				resp.OtherUser = &OtherUserBrief{
					ID:            otherUserID.String(),
					Username:      u.Username,
					FullName:      u.FullName,
					Avatar:        u.Avatar,
					Bio:           u.Bio,
					AvatarFrameID: u.ActiveAvatarFrameID(time.Now()),
				}
			}
		}
	} else if conv.ConversationType == constants.ConversationTypeDirect {
		s.logger.Warnw("Direct conversation missing OtherUserID",
			"conversation_id", conv.ConversationID, "viewer_id", viewerID)
	}

	if conv.LastMessageSender != nil {
		senderIDStr := conv.LastMessageSender.String()
		resp.LastMessageSenderID = senderIDStr
		resp.IsLastMessageFromMe = senderIDStr == viewerID.String()
		if senderUUID, err := uuid.Parse(senderIDStr); err == nil {
			u := users[senderUUID]
			if u == nil && users == nil {
				u, _ = s.userCache.GetUserCache(senderUUID, false)
			}
			if u != nil {
				resp.LastMessageSenderName = userDisplayName(u)
			}
		}
	}

	if conv.LastMessageID == nil {
		resp.Seen = true
	} else if resp.IsLastMessageFromMe {
		if otherLastRead != nil {
			resp.Seen = *otherLastRead == *conv.LastMessageID
		}
	} else {
		resp.Seen = conv.LastReadMessageID != nil && *conv.LastReadMessageID == *conv.LastMessageID
	}

	return resp
}

func (s *Service) GetMembersCached(conversationID uuid.UUID) ([]ConversationMember, error) {
	return s.cache.GetMembersCached(conversationID)
}

func (s *Service) GetConversationByIDCached(conversationID uuid.UUID) (*Conversation, error) {
	return s.cache.GetConversationByIDCached(conversationID)
}

func (s *Service) GetUserConversationsCached(userID uuid.UUID, limit int) ([]ConversationByUser, error) {
	return s.cache.GetUserConversationsCached(userID, limit)
}

func (s *Service) InvalidateMembersCache(conversationID uuid.UUID) {
	if err := s.cache.DeleteConversationMembers(conversationID); err != nil {
		s.logger.Warnw("Failed to invalidate members cache", "conversation_id", conversationID, "error", err)
	}
}

func (s *Service) InvalidateUserConversationsCache(userIDs []uuid.UUID) {
	for _, userID := range userIDs {
		if err := s.cache.DeleteUserConversations(userID); err != nil {
			s.logger.Warnw("Failed to invalidate user conversations cache", "user_id", userID, "error", err)
		}
	}
}

func (s *Service) InvalidateConversationCache(conversationID uuid.UUID) {
	s.cache.InvalidateConversation(conversationID)
}

func (s *Service) SendTypingIndicator(userID, conversationID uuid.UUID, isTyping bool) error {
	conv, err := s.GetConversationByIDCached(conversationID)
	if err != nil {
		return fmt.Errorf("failed to get conversation: %w", err)
	}

	members, err := s.GetMembersCached(conversationID)
	if err != nil {
		return fmt.Errorf("failed to get members: %w", err)
	}

	if !requireActiveMember(members, userID) {
		return fmt.Errorf("user is not a member of this conversation")
	}
	if err := EnsureDirectInteractionAllowed(s.relSvc, conv, members, userID); err != nil {
		return err
	}

	if isTyping {
		if s.cache.IsTypingRateLimited(userID, conversationID) {
			s.logger.Debugw("Typing indicator rate limited", "user_id", userID, "conversation_id", conversationID)
			return nil
		}
		s.cache.SetTypingRateLimit(userID, conversationID)
	}

	u, err := s.userCache.GetUserCache(userID, true)
	if err != nil {
		return fmt.Errorf("user not found: %w", err)
	}

	event := &conversationEvents.TypingEvent{
		ConversationID: conversationID.String(),
		UserID:         userID.String(),
		Username:       u.Username,
		Time:           time.Now(),
	}

	ctx, cancel := context.WithTimeout(context.Background(), 3*time.Second)
	defer cancel()

	if err := s.kafkaProducer.PublishConversationTyping(ctx, event); err != nil {
		s.logger.Errorw("Failed to publish typing event", "error", err)
		return fmt.Errorf("failed to publish typing event: %w", err)
	}

	s.logger.Debugw("Typing indicator sent", "user_id", userID, "conversation_id", conversationID, "is_typing", isTyping)
	return nil
}

func (s *Service) GetConversationDetail(userID, conversationID uuid.UUID) (*ConversationResponse, error) {
	conv, err := s.repo.GetUserConversationByID(userID, conversationID)
	if err != nil {
		return nil, fmt.Errorf("failed to get conversation: %w", err)
	}
	if conv == nil {
		return nil, fmt.Errorf("conversation not found")
	}

	var otherLastRead *gocql.UUID
	if conv.ConversationType == constants.ConversationTypeDirect && conv.OtherUserID != nil {
		if otherUUID, err := uuid.Parse(conv.OtherUserID.String()); err == nil {
			otherLastRead, _, _ = s.repo.GetReadStatus(conversationID, otherUUID)
		}
	}

	resp := s.buildConversationResponse(*conv, userID, otherLastRead, nil)
	resp.ParticipantCount = 0

	if conv.ConversationType == constants.ConversationTypeDirect && conv.OtherUserID != nil && resp.OtherUser != nil {
		if otherUserID, err := uuid.Parse(conv.OtherUserID.String()); err == nil && s.presence != nil {
			info := s.presence.GetPresence(otherUserID.String())
			resp.OtherUser.IsOnline = info.IsOnline
			resp.OtherUser.LastActiveAt = info.LastActiveAt
		}
	}

	if members, merr := s.GetMembersCached(conversationID); merr == nil {
		resp.ParticipantCount = len(members)
	}

	return &resp, nil
}
