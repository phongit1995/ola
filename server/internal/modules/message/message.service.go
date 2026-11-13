package message

import (
	"context"
	"fmt"
	"time"

	"ola-chat-server/internal/config"
	messageEvents "ola-chat-server/internal/domain/message"
	"ola-chat-server/internal/modules/conversation"
	"ola-chat-server/internal/modules/relationships"
	userModule "ola-chat-server/internal/modules/user"
	usersetting "ola-chat-server/internal/modules/user-setting"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/kafka"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Service struct {
	repo           *Repository
	cache          *CacheService
	convRepo       *conversation.Repository
	convCache      *conversation.CacheService
	userCache      *userModule.CacheService
	userSettingSvc *usersetting.Service
	relRepo        *relationships.Repository
	relSvc         conversation.BlockChecker
	kafkaProducer  *kafka.Producer
	s3             *services.S3Service
	redis          *services.CacheService
	cfg            *config.Config
	logger         *zap.SugaredLogger
}

func NewService(repo *Repository, cache *CacheService, convRepo *conversation.Repository, convCache *conversation.CacheService, userCache *userModule.CacheService, userSettingSvc *usersetting.Service, relRepo *relationships.Repository, relSvc *relationships.Service, kafkaProducer *kafka.Producer, s3 *services.S3Service, redis *services.CacheService, cfg *config.Config, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:           repo,
		cache:          cache,
		convRepo:       convRepo,
		convCache:      convCache,
		userCache:      userCache,
		userSettingSvc: userSettingSvc,
		relRepo:        relRepo,
		relSvc:         relSvc,
		kafkaProducer:  kafkaProducer,
		s3:             s3,
		redis:          redis,
		cfg:            cfg,
		logger:         logger.Named("[message_service]"),
	}
}

func (s *Service) ensureMessageAccess(userID, conversationID uuid.UUID) error {
	conv, err := s.getConversationByIDCached(conversationID)
	if err != nil {
		return fmt.Errorf("conversation not found: %w", err)
	}
	members, err := s.getMembersCached(conversationID)
	if err != nil {
		return fmt.Errorf("failed to get members: %w", err)
	}
	if !isActiveMember(members, userID) {
		return ErrNotMember
	}
	return conversation.EnsureDirectInteractionAllowed(s.relSvc, conv, members, userID)
}

func (s *Service) cachedIdempotentMessage(senderID, conversationID uuid.UUID, messageType, clientMsgID string) (*MessageResponse, error) {
	if clientMsgID == "" {
		return nil, nil
	}
	existing, err := s.cache.GetMessageByClientMsgID(senderID, clientMsgID)
	if err != nil || existing == nil {
		return nil, nil
	}
	if existing.ConversationID != conversationID.String() || existing.Type != messageType {
		return nil, fmt.Errorf("%w: client message ID already used", ErrInvalidMetadata)
	}
	return existing, nil
}

func isActiveMember(members []conversation.ConversationMember, userID uuid.UUID) bool {
	return conversation.IsActiveMember(members, userID)
}

func isMember(members []conversation.ConversationMember, userID uuid.UUID) bool {
	return conversation.IsMember(members, userID)
}

func conversationToEventData(conv *conversation.Conversation) *messageEvents.ConversationData {
	if conv == nil {
		return nil
	}
	return &messageEvents.ConversationData{
		ID:               conv.ConversationID.String(),
		Type:             conv.Type,
		Name:             conv.Name,
		Avatar:           conv.Avatar,
		CreatedAt:        conv.CreatedAt.Format(time.RFC3339),
		UpdatedAt:        conv.UpdatedAt.Format(time.RFC3339),
		ParticipantCount: conv.ParticipantCount,
	}
}

func messageDataFromResponse(resp MessageResponse) *messageEvents.MessageData {
	return &messageEvents.MessageData{
		ID:             resp.ID,
		ConversationID: resp.ConversationID,
		SenderID:       resp.SenderID,
		SenderName:     resp.SenderName,
		SenderAvatar:   resp.SenderAvatar,
		Type:           resp.Type,
		Content:        resp.Content,
		Metadata:       resp.Metadata,
		CreatedAt:      resp.CreatedAt,
		UpdatedAt:      resp.UpdatedAt,
		EditedAt:       resp.EditedAt,
		ReplyToID:      resp.ReplyToID,
		ReplyTo:        toEventReplySnapshot(resp.ReplyTo),
		ClientMsgID:    resp.ClientMsgID,
	}
}

func (s *Service) publishWithTimeout(action string, publish func(ctx context.Context) error) {
	utils.PublishWithTimeout(s.logger, action, publish)
}

func (s *Service) publishAsync(action string, publish func(ctx context.Context) error) {
	utils.PublishAsync(s.logger, action, publish)
}

func (s *Service) conversationEventData(convID uuid.UUID) *messageEvents.ConversationData {
	conv, err := s.getConversationByIDCached(convID)
	if err != nil {
		return nil
	}
	return conversationToEventData(conv)
}

func (s *Service) publishMessageUpdatedAsync(resp MessageResponse, convID uuid.UUID) {
	s.publishAsync("message updated event", func(ctx context.Context) error {
		return s.kafkaProducer.PublishMessageUpdated(ctx, &messageEvents.MessageUpdatedEvent{
			Conversation: s.conversationEventData(convID),
			Message:      messageDataFromResponse(resp),
		})
	})
}

func (s *Service) getMembersCached(conversationID uuid.UUID) ([]conversation.ConversationMember, error) {
	return s.convCache.GetMembersCached(conversationID)
}

func (s *Service) getConversationByIDCached(conversationID uuid.UUID) (*conversation.Conversation, error) {
	return s.convCache.GetConversationByIDCached(conversationID)
}
