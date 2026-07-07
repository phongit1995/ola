package message

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"image"
	_ "image/gif"
	_ "image/jpeg"
	_ "image/png"
	"io"
	"mime/multipart"
	"net/http"
	"net/url"
	"ola-chat-server/internal/config"
	"ola-chat-server/internal/constants"
	conversationEvents "ola-chat-server/internal/domain/conversation"
	messageEvents "ola-chat-server/internal/domain/message"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/conversation"
	"ola-chat-server/internal/modules/relationships"
	userModule "ola-chat-server/internal/modules/user"
	usersetting "ola-chat-server/internal/modules/user-setting"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/kafka"
	"ola-chat-server/internal/utils"
	"path/filepath"
	"strings"
	"sync"
	"time"

	_ "golang.org/x/image/webp"

	"github.com/gocql/gocql"
	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type Service struct {
	repo           *Repository
	cache          *CacheService
	convRepo       *conversation.Repository
	convCache      *conversation.CacheService
	userCache      *userModule.CacheService
	userSettingSvc *usersetting.Service
	relRepo        *relationships.Repository
	db             *gorm.DB
	kafkaProducer  *kafka.Producer
	s3             *services.S3Service
	redis          *services.CacheService
	cfg            *config.Config
	logger         *zap.SugaredLogger
}

func NewService(repo *Repository, cache *CacheService, convRepo *conversation.Repository, convCache *conversation.CacheService, userCache *userModule.CacheService, userSettingSvc *usersetting.Service, relRepo *relationships.Repository, db *gorm.DB, kafkaProducer *kafka.Producer, s3 *services.S3Service, redis *services.CacheService, cfg *config.Config, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:           repo,
		cache:          cache,
		convRepo:       convRepo,
		convCache:      convCache,
		userCache:      userCache,
		userSettingSvc: userSettingSvc,
		relRepo:        relRepo,
		db:             db,
		kafkaProducer:  kafkaProducer,
		s3:             s3,
		redis:          redis,
		cfg:            cfg,
		logger:         logger.Named("[message_service]"),
	}
}

func (s *Service) SendImageMessage(ctx context.Context, userID, conversationID uuid.UUID, fileHeader *multipart.FileHeader, clientMsgID string) (*MessageResponse, error) {
	meta, err := s.uploadImageFile(ctx, userID, conversationID, fileHeader)
	if err != nil {
		return nil, err
	}
	metaJSON, err := json.Marshal(meta)
	if err != nil {
		return nil, fmt.Errorf("failed to marshal image metadata: %w", err)
	}
	return s.SendMessage(userID, conversationID, constants.MessageTypeImage, "", string(metaJSON), nil, clientMsgID)
}

func (s *Service) uploadImageFile(ctx context.Context, userID, conversationID uuid.UUID, fileHeader *multipart.FileHeader) (*ImageMetadata, error) {
	if fileHeader.Size > constants.MaxImageUploadSize {
		return nil, fmt.Errorf("%w: max %d bytes", ErrFileTooLarge, constants.MaxImageUploadSize)
	}

	if _, err := s.getConversationByIDCached(conversationID); err != nil {
		return nil, fmt.Errorf("conversation not found: %w", err)
	}
	members, err := s.getMembersCached(conversationID)
	if err != nil {
		return nil, fmt.Errorf("failed to get members: %w", err)
	}
	if !isActiveMember(members, userID) {
		return nil, ErrNotMember
	}

	rateKey := fmt.Sprintf(constants.CacheKeyRateLimitUpload, userID.String())
	if err := s.checkRateLimit(rateKey, constants.RateLimitUploadWindowSeconds, constants.RateLimitUploadMaxRequests); err != nil {
		return nil, err
	}

	file, err := fileHeader.Open()
	if err != nil {
		return nil, fmt.Errorf("failed to open file: %w", err)
	}
	defer file.Close()

	head := make([]byte, 512)
	n, _ := io.ReadFull(file, head)
	head = head[:n]
	detectedMime := http.DetectContentType(head)
	if !isAllowedImageMime(detectedMime) {
		return nil, fmt.Errorf("%w: %s", ErrUnsupportedImage, detectedMime)
	}

	rest, err := io.ReadAll(file)
	if err != nil {
		return nil, fmt.Errorf("failed to read file: %w", err)
	}
	fullData := append(head, rest...)
	if int64(len(fullData)) > constants.MaxImageUploadSize {
		return nil, ErrFileTooLarge
	}

	cfg, _, err := image.DecodeConfig(bytes.NewReader(fullData))
	if err != nil {
		return nil, fmt.Errorf("%w: %v", ErrDecodeImage, err)
	}

	ext := pickExtension(detectedMime, fileHeader.Filename)
	safeName := fmt.Sprintf("image%s", ext)
	folder := fmt.Sprintf("%s/%s/%s", constants.UploadFolderMessages, conversationID.String(), time.Now().Format(constants.UploadDateLayout))

	upload, err := s.s3.UploadFile(ctx, &multipartFileReader{Reader: bytes.NewReader(fullData), size: int64(len(fullData))}, safeName, folder)
	if err != nil {
		return nil, fmt.Errorf("failed to upload to storage: %w", err)
	}

	return &ImageMetadata{
		URL:      upload.URL,
		MimeType: detectedMime,
		Size:     int64(len(fullData)),
		Width:    cfg.Width,
		Height:   cfg.Height,
		FileName: filepath.Base(fileHeader.Filename),
	}, nil
}

func isAllowedImageMime(mime string) bool {
	for _, m := range constants.AllowedImageMimes {
		if strings.EqualFold(m, mime) {
			return true
		}
	}
	return false
}

func isAllowedAudioMime(mime string) bool {
	base := mime
	if idx := strings.Index(base, ";"); idx >= 0 {
		base = strings.TrimSpace(base[:idx])
	}
	for _, m := range constants.AllowedAudioMimes {
		if strings.EqualFold(m, base) {
			return true
		}
	}
	return false
}

func pickAudioExtension(mime, originalName string) string {
	base := mime
	if idx := strings.Index(base, ";"); idx >= 0 {
		base = strings.TrimSpace(base[:idx])
	}
	switch strings.ToLower(base) {
	case "audio/webm":
		return ".webm"
	case "audio/mp4", "audio/aac":
		return ".m4a"
	case "audio/mpeg":
		return ".mp3"
	case "audio/wav", "audio/x-wav":
		return ".wav"
	case "audio/ogg":
		return ".ogg"
	}
	if ext := strings.ToLower(filepath.Ext(originalName)); ext != "" {
		return ext
	}
	return ".bin"
}

func (s *Service) SendAudioMessage(ctx context.Context, userID, conversationID uuid.UUID, fileHeader *multipart.FileHeader, duration float64, waveform []float64, clientMsgID string) (*MessageResponse, error) {
	if duration <= 0 {
		return nil, fmt.Errorf("%w: duration required", ErrInvalidMetadata)
	}
	if duration > constants.MaxAudioDurationSeconds {
		return nil, fmt.Errorf("%w: max %d seconds", ErrInvalidMetadata, constants.MaxAudioDurationSeconds)
	}

	meta, err := s.uploadAudioFile(ctx, userID, conversationID, fileHeader, duration, waveform)
	if err != nil {
		return nil, err
	}
	metaJSON, err := json.Marshal(meta)
	if err != nil {
		return nil, fmt.Errorf("failed to marshal audio metadata: %w", err)
	}
	return s.SendMessage(userID, conversationID, constants.MessageTypeAudio, "", string(metaJSON), nil, clientMsgID)
}

func (s *Service) uploadAudioFile(ctx context.Context, userID, conversationID uuid.UUID, fileHeader *multipart.FileHeader, duration float64, waveform []float64) (*AudioMetadata, error) {
	if fileHeader.Size > constants.MaxAudioUploadSize {
		return nil, fmt.Errorf("%w: max %d bytes", ErrFileTooLarge, constants.MaxAudioUploadSize)
	}

	if _, err := s.getConversationByIDCached(conversationID); err != nil {
		return nil, fmt.Errorf("conversation not found: %w", err)
	}
	members, err := s.getMembersCached(conversationID)
	if err != nil {
		return nil, fmt.Errorf("failed to get members: %w", err)
	}
	if !isActiveMember(members, userID) {
		return nil, ErrNotMember
	}

	rateKey := fmt.Sprintf(constants.CacheKeyRateLimitUpload, userID.String())
	if err := s.checkRateLimit(rateKey, constants.RateLimitUploadWindowSeconds, constants.RateLimitUploadMaxRequests); err != nil {
		return nil, err
	}

	file, err := fileHeader.Open()
	if err != nil {
		return nil, fmt.Errorf("failed to open file: %w", err)
	}
	defer file.Close()

	data, err := io.ReadAll(file)
	if err != nil {
		return nil, fmt.Errorf("failed to read file: %w", err)
	}
	if int64(len(data)) > constants.MaxAudioUploadSize {
		return nil, ErrFileTooLarge
	}

	declaredMime := fileHeader.Header.Get("Content-Type")
	detectedMime := http.DetectContentType(data)
	finalMime := declaredMime
	if !isAllowedAudioMime(finalMime) {
		finalMime = detectedMime
	}
	if !isAllowedAudioMime(finalMime) {
		return nil, fmt.Errorf("%w: %s", ErrUnsupportedImage, finalMime)
	}

	ext := pickAudioExtension(finalMime, fileHeader.Filename)
	safeName := fmt.Sprintf("audio%s", ext)
	folder := fmt.Sprintf("%s/%s/%s", constants.UploadFolderMessages, conversationID.String(), time.Now().Format(constants.UploadDateLayout))

	upload, err := s.s3.UploadFile(ctx, &multipartFileReader{Reader: bytes.NewReader(data), size: int64(len(data))}, safeName, folder)
	if err != nil {
		return nil, fmt.Errorf("failed to upload to storage: %w", err)
	}

	return &AudioMetadata{
		URL:      upload.URL,
		MimeType: finalMime,
		Size:     int64(len(data)),
		Duration: duration,
		Waveform: waveform,
	}, nil
}

func validateAudioMetadata(metadata string) error {
	if strings.TrimSpace(metadata) == "" {
		return fmt.Errorf("%w: required", ErrInvalidMetadata)
	}
	var meta AudioMetadata
	if err := json.Unmarshal([]byte(metadata), &meta); err != nil {
		return fmt.Errorf("%w: %v", ErrInvalidMetadata, err)
	}
	if meta.URL == "" {
		return fmt.Errorf("%w: url required", ErrInvalidMetadata)
	}
	if !isAllowedAudioMime(meta.MimeType) {
		return fmt.Errorf("%w: mimeType %s", ErrInvalidMetadata, meta.MimeType)
	}
	if meta.Duration <= 0 || meta.Duration > constants.MaxAudioDurationSeconds {
		return fmt.Errorf("%w: invalid duration", ErrInvalidMetadata)
	}
	return nil
}

func pickExtension(mime, originalName string) string {
	switch strings.ToLower(mime) {
	case "image/jpeg":
		return ".jpg"
	case "image/png":
		return ".png"
	case "image/gif":
		return ".gif"
	case "image/webp":
		return ".webp"
	}
	return strings.ToLower(filepath.Ext(originalName))
}

type multipartFileReader struct {
	*bytes.Reader
	size int64
}

func (r *multipartFileReader) Close() error { return nil }

var _ multipart.File = (*multipartFileReader)(nil)

func validateImageMetadata(metadata string, allowedHosts []string) error {
	if strings.TrimSpace(metadata) == "" {
		return fmt.Errorf("%w: required", ErrInvalidMetadata)
	}
	var meta ImageMetadata
	if err := json.Unmarshal([]byte(metadata), &meta); err != nil {
		return fmt.Errorf("%w: %v", ErrInvalidMetadata, err)
	}
	if meta.URL == "" {
		return fmt.Errorf("%w: url required", ErrInvalidMetadata)
	}
	if !isAllowedImageMime(meta.MimeType) {
		return fmt.Errorf("%w: mimeType %s", ErrInvalidMetadata, meta.MimeType)
	}
	if len(allowedHosts) > 0 {
		u, err := url.Parse(meta.URL)
		if err != nil {
			return fmt.Errorf("%w: %v", ErrInvalidMetadata, err)
		}
		ok := false
		for _, h := range allowedHosts {
			if strings.EqualFold(u.Host, h) {
				ok = true
				break
			}
		}
		if !ok {
			return fmt.Errorf("%w: host %s not allowed", ErrInvalidMetadata, u.Host)
		}
	}
	return nil
}

func parseReactions(raw string) map[string][]string {
	if strings.TrimSpace(raw) == "" {
		return map[string][]string{}
	}
	var m map[string][]string
	if err := json.Unmarshal([]byte(raw), &m); err != nil {
		return map[string][]string{}
	}
	if m == nil {
		return map[string][]string{}
	}
	return m
}

func applyReactionToggle(reactions map[string][]string, reactionType, userIDStr string) (string, error) {
	users := reactions[reactionType]

	filtered := make([]string, 0, len(users))
	hasReacted := false
	for _, u := range users {
		if u == userIDStr {
			hasReacted = true
			continue
		}
		filtered = append(filtered, u)
	}

	if hasReacted {
		if len(filtered) == 0 {
			delete(reactions, reactionType)
		} else {
			reactions[reactionType] = filtered
		}
		return constants.ReactionActionRemoved, nil
	}

	typesByUser := 0
	for _, ulist := range reactions {
		for _, u := range ulist {
			if u == userIDStr {
				typesByUser++
				break
			}
		}
	}
	if typesByUser >= constants.MaxReactionTypesPerUserPerMessage {
		return "", fmt.Errorf("%w: max %d", ErrMaxReactions, constants.MaxReactionTypesPerUserPerMessage)
	}

	newUsers := make([]string, len(users)+1)
	copy(newUsers, users)
	newUsers[len(users)] = userIDStr
	reactions[reactionType] = newUsers
	return constants.ReactionActionAdded, nil
}

func isAllowedReactionType(t string) bool {
	for _, v := range constants.AllowedReactionTypes {
		if v == t {
			return true
		}
	}
	return false
}

func isActiveMember(members []conversation.ConversationMember, userID uuid.UUID) bool {
	return conversation.IsActiveMember(members, userID)
}

func (s *Service) checkRateLimit(key string, windowSecs, maxReqs int) error {
	count, err := s.redis.Increment(key)
	if err != nil {
		s.logger.Errorw("Rate limit Redis failure, failing closed", "key", key, "error", err)
		return ErrRateLimit
	}
	if count == 1 {
		if expErr := s.redis.SetExpire(key, time.Duration(windowSecs)*time.Second); expErr != nil {
			s.logger.Warnw("Failed to set rate limit expiry, deleting key to prevent permanent block", "key", key, "error", expErr)
			s.redis.Delete(key)
		}
	}
	if count > int64(maxReqs) {
		return ErrRateLimit
	}
	return nil
}

func isMember(members []conversation.ConversationMember, userID uuid.UUID) bool {
	return conversation.IsMember(members, userID)
}

func truncatePreview(content string, maxRunes int) string {
	runes := []rune(content)
	if len(runes) <= maxRunes {
		return content
	}
	return string(runes[:maxRunes]) + "…"
}

func imagePreviewText(content string) string {
	c := strings.TrimSpace(content)
	if c == "" {
		return "📷 Photo"
	}
	return "📷 " + truncatePreview(c, 50)
}

func audioPreviewText() string {
	return "🎵 Audio"
}

func validateMessageContent(messageType, content, metadata string) error {
	switch messageType {
	case constants.MessageTypeImage:
		return validateImageMetadata(metadata, nil)
	case constants.MessageTypeAudio:
		return validateAudioMetadata(metadata)
	case constants.MessageTypeText:
		if strings.TrimSpace(content) == "" {
			return fmt.Errorf("content required for text message")
		}
	}
	return nil
}

func previewForType(messageType, content string) string {
	switch messageType {
	case constants.MessageTypeImage:
		return imagePreviewText(content)
	case constants.MessageTypeAudio:
		return audioPreviewText()
	default:
		return truncatePreview(content, 100)
	}
}

func (s *Service) SendDirectMessage(senderID, recipientID uuid.UUID, messageType, content, metadata, clientMsgID string) (*MessageResponse, error) {
	if senderID == recipientID {
		return nil, fmt.Errorf("cannot send direct message to yourself")
	}

	userA, userB := senderID, recipientID
	if senderID.String() > recipientID.String() {
		userA, userB = recipientID, senderID
	}

	existingID, err := s.convRepo.GetDirectConversationID(userA, userB)
	if err != nil {
		return nil, err
	}
	if existingID == nil {
		if err := conversation.BlockIfPrivateFromStranger(s.userSettingSvc, s.relRepo, senderID, recipientID); err != nil {
			return nil, err
		}
	}

	conversationID, isNew, err := s.convRepo.GetOrCreateDirectConversation(userA, userB)
	if err != nil {
		return nil, fmt.Errorf("failed to get/create conversation: %w", err)
	}

	if isNew {
		if err := s.createFullDirectConversation(conversationID, userA, userB, senderID); err != nil {
			return nil, fmt.Errorf("failed to create full conversation structure: %w", err)
		}
		s.logger.Infow("Created new direct conversation with full structure", "conversation_id", conversationID)
	}

	messageResponse, err := s.SendMessage(senderID, conversationID, messageType, content, metadata, nil, clientMsgID)
	if err != nil {
		return nil, err
	}

	if isNew {
		utils.SafeGo(s.logger, func() {
			s.publishConversationCreatedEvent(conversationID, senderID, recipientID, messageResponse)
		})
	}

	return messageResponse, nil
}

func directDisplayName(u *models.User) string {
	if u.FullName != "" {
		return u.FullName
	}
	return u.Username
}

func newDirectInbox(owner, other, convID gocql.UUID, otherName, otherAvatar string, lastMessageAt gocql.UUID, now time.Time) *conversation.ConversationByUser {
	otherID := other
	updatedAt := now
	return &conversation.ConversationByUser{
		UserID:           owner,
		ConversationID:   convID,
		ConversationType: constants.ConversationTypeDirect,
		DisplayName:      otherName,
		DisplayAvatar:    otherAvatar,
		OtherUserID:      &otherID,
		OtherUserName:    otherName,
		OtherUserAvatar:  otherAvatar,
		LastMessageAt:    lastMessageAt,
		UnreadCount:      0,
		UpdatedAt:        &updatedAt,
	}
}

func (s *Service) createFullDirectConversation(conversationID, userA, userB, createdBy uuid.UUID) error {
	user1Info, err := s.userCache.GetUserCache(userA, true)
	if err != nil {
		return fmt.Errorf("userA not found: %w", err)
	}
	user2Info, err := s.userCache.GetUserCache(userB, true)
	if err != nil {
		return fmt.Errorf("userB not found: %w", err)
	}

	now := time.Now()
	lastMessageAt := gocql.TimeUUID()

	batch := s.convRepo.NewBatch()

	conv := &conversation.Conversation{
		ConversationID:   conversationID,
		Type:             constants.ConversationTypeDirect,
		Name:             "",
		Avatar:           "",
		CreatedBy:        createdBy,
		CreatedAt:        now,
		UpdatedAt:        now,
		ParticipantCount: 2,
	}
	s.convRepo.AddConversationToBatch(batch, conv)

	userAMember := &conversation.ConversationMember{
		ConversationID: conversationID,
		UserID:         userA,
		JoinedAt:       now,
		IsActive:       true,
		Role:           constants.MemberRoleDefault,
	}
	userBMember := &conversation.ConversationMember{
		ConversationID: conversationID,
		UserID:         userB,
		JoinedAt:       now,
		IsActive:       true,
		Role:           constants.MemberRoleDefault,
	}
	s.convRepo.AddMemberToBatch(batch, userAMember)
	s.convRepo.AddMemberToBatch(batch, userBMember)

	gocqlUserAID, err := utils.ToGocqlUUID(userA)
	if err != nil {
		return fmt.Errorf("failed to convert userA: %w", err)
	}
	gocqlUserBID, err := utils.ToGocqlUUID(userB)
	if err != nil {
		return fmt.Errorf("failed to convert userB: %w", err)
	}
	gocqlConvID, err := utils.ToGocqlUUID(conversationID)
	if err != nil {
		return fmt.Errorf("failed to convert conversationID: %w", err)
	}

	user1DisplayName := directDisplayName(user1Info)
	user2DisplayName := directDisplayName(user2Info)

	userAInbox := newDirectInbox(gocqlUserAID, gocqlUserBID, gocqlConvID, user2DisplayName, user2Info.Avatar, lastMessageAt, now)
	userBInbox := newDirectInbox(gocqlUserBID, gocqlUserAID, gocqlConvID, user1DisplayName, user1Info.Avatar, lastMessageAt, now)

	if err := s.convRepo.ExecuteBatch(batch); err != nil {
		return fmt.Errorf("failed to execute batch: %w", err)
	}

	if err := s.convRepo.AddConversationToUserInbox(userAInbox); err != nil {
		return fmt.Errorf("failed to add userA inbox: %w", err)
	}

	if err := s.convRepo.AddConversationToUserInbox(userBInbox); err != nil {
		return fmt.Errorf("failed to add userB inbox: %w", err)
	}

	members := []conversation.ConversationMember{*userAMember, *userBMember}

	var wg sync.WaitGroup
	wg.Add(2)
	utils.SafeGo(s.logger, func() {
		defer wg.Done()
		s.convCache.InvalidateUserConversations([]uuid.UUID{userA, userB})
	})
	utils.SafeGo(s.logger, func() {
		defer wg.Done()
		if err := s.convCache.SetConversationMembers(conversationID, members); err != nil {
			s.logger.Warnw("Failed to cache conversation members after creation",
				"conversation_id", conversationID, "error", err)
		}
	})
	wg.Wait()

	return nil
}

func (s *Service) SendMessage(senderID, conversationID uuid.UUID, messageType, content, metadata string, replyToID *uuid.UUID, clientMsgID string) (*MessageResponse, error) {
	if clientMsgID != "" {
		if existing, err := s.cache.GetMessageByClientMsgID(senderID, clientMsgID); err == nil && existing != nil {
			s.logger.Infow("Idempotent send: returning existing message",
				"client_msg_id", clientMsgID, "message_id", existing.ID)
			return existing, nil
		}
	}

	if _, err := s.getConversationByIDCached(conversationID); err != nil {
		return nil, fmt.Errorf("conversation not found: %w", err)
	}

	members, err := s.getMembersCached(conversationID)
	if err != nil {
		return nil, fmt.Errorf("failed to get members: %w", err)
	}

	if !isActiveMember(members, senderID) {
		return nil, ErrNotMember
	}

	if err := validateMessageContent(messageType, content, metadata); err != nil {
		return nil, err
	}

	now := time.Now()
	messageID := gocql.TimeUUID()

	senderInfo, err := s.userCache.GetUserCache(senderID, true)
	if err != nil {
		return nil, fmt.Errorf("failed to get sender info: %w", err)
	}

	msg := &Message{
		ConversationID: conversationID,
		MessageID:      messageID,
		SenderID:       senderID,
		SenderName:     senderInfo.Username,
		SenderAvatar:   senderInfo.Avatar,
		MessageType:    messageType,
		Content:        content,
		Metadata:       metadata,
		CreatedAt:      now,
		UpdatedAt:      now,
		ReplyToID:      replyToID,
	}

	if err := s.repo.CreateMessage(msg); err != nil {
		return nil, fmt.Errorf("failed to create message: %w", err)
	}

	shortContent := previewForType(messageType, content)

	memberIDs := conversation.ActiveMemberIDs(members)

	response := &MessageResponse{
		ID:             messageID.String(),
		ConversationID: conversationID.String(),
		SenderID:       senderID.String(),
		SenderName:     senderInfo.Username,
		SenderAvatar:   senderInfo.Avatar,
		Type:           messageType,
		Content:        content,
		Metadata:       metadata,
		Status:         "sent",
		CreatedAt:      now.Format(time.RFC3339),
		UpdatedAt:      now.Format(time.RFC3339),
		ClientMsgID:    clientMsgID,
	}

	if replyToID != nil {
		response.ReplyToID = replyToID.String()
	}

	if clientMsgID != "" {
		if err := s.cache.SetMessageByClientMsgID(senderID, clientMsgID, response); err != nil {
			s.logger.Warnw("Failed to set client_msg_id dedup cache", "client_msg_id", clientMsgID, "error", err)
		}
	}

	utils.SafeGo(s.logger, func() {
		s.postSendMessageTasks(conversationID, memberIDs, members, msg, response, shortContent, senderID, messageID, now)
	})

	return response, nil
}

func (s *Service) applyInboxFanout(conversationID uuid.UUID, members []conversation.ConversationMember,
	messageID gocql.UUID, shortContent string, senderID uuid.UUID, now time.Time) {

	conv, err := s.getConversationByIDCached(conversationID)
	if err != nil {
		s.logger.Warnw("Failed to fetch conversation for inbox fanout, skipping hidden-member processing",
			"conversation_id", conversationID, "error", err)
	}

	activeIDs := conversation.ActiveMemberIDs(members)

	currentUnread, err := s.repo.GetUnreadCounts(activeIDs, conversationID)
	if err != nil {
		s.logger.Errorw("Failed to batch read unread counts", "conversation_id", conversationID, "error", err)
		currentUnread = map[uuid.UUID]int{}
	}

	inboxUpdates := make([]*ConversationInboxUpdate, 0, len(activeIDs))
	var hiddenMembers []conversation.ConversationMember

	for _, member := range members {
		if !member.IsActive {
			continue
		}

		_, hasInbox := currentUnread[member.UserID]
		if !hasInbox {
			isHidden, hiddenErr := s.convRepo.CheckIfHidden(member.UserID, conversationID)
			if hiddenErr != nil {
				s.logger.Warnw("Failed to check hidden status, treating as not hidden",
					"user_id", member.UserID, "conversation_id", conversationID, "error", hiddenErr)
			}
			if isHidden {
				hiddenMembers = append(hiddenMembers, member)
			} else {
				s.logger.Warnw("Inbox entry missing, will recreate", "user_id", member.UserID)
				memberID := member.UserID
				utils.SafeGo(s.logger, func() {
					s.recreateInboxEntry(memberID, conversationID, messageID, shortContent, senderID, memberID != senderID)
				})
			}
			continue
		}

		newUnread := currentUnread[member.UserID]
		if member.UserID != senderID {
			newUnread++
		}

		inboxUpdates = append(inboxUpdates, &ConversationInboxUpdate{
			UserID:             member.UserID,
			ConversationID:     conversationID,
			LastMessageAt:      messageID,
			LastMessageID:      &messageID,
			LastMessagePreview: shortContent,
			LastMessageSender:  &senderID,
			UnreadCount:        newUnread,
			UpdatedAt:          &now,
		})
	}

	if len(inboxUpdates) > 0 {
		if err := s.repo.BatchUpdateInbox(inboxUpdates); err != nil {
			s.logger.Errorw("Failed to batch update inbox", "error", err)
		}
	}

	if len(hiddenMembers) > 0 && conv != nil {
		s.processHiddenMembers(hiddenMembers, conv, members, conversationID, messageID, shortContent, senderID)
	}
}

func (s *Service) processHiddenMembers(hiddenMembers []conversation.ConversationMember, conv *conversation.Conversation,
	allMembers []conversation.ConversationMember, conversationID uuid.UUID, messageID gocql.UUID, shortContent string, senderID uuid.UUID) {

	for _, m := range hiddenMembers {
		s.logger.Infow("Auto-unhiding conversation", "user_id", m.UserID, "conversation_id", conversationID)

		d := conversation.ResolveConversationDisplay(conv, m.UserID, allMembers, s.userCache)

		unreadAfterUnhide := 0
		if m.UserID != senderID {
			unreadAfterUnhide = 1
		}

		if err := s.convRepo.UnhideConversation(m.UserID, conversationID, messageID,
			&messageID, shortContent, &senderID,
			d.ConversationType, d.DisplayName, d.DisplayAvatar, d.OtherUserID, d.OtherUserName, d.OtherUserAvatar,
			unreadAfterUnhide); err != nil {
			s.logger.Errorw("Failed to auto-unhide", "user_id", m.UserID, "error", err)
			continue
		}

		s.convCache.RemoveHiddenConversation(m.UserID, conversationID)
	}
}

func (s *Service) postSendMessageTasks(conversationID uuid.UUID, memberIDs []uuid.UUID,
	members []conversation.ConversationMember, msg *Message, response *MessageResponse,
	shortContent string, senderID uuid.UUID, messageID gocql.UUID, now time.Time) {

	s.applyInboxFanout(conversationID, members, messageID, shortContent, senderID, now)

	if err := s.cache.SetMessage(msg); err != nil {
		s.logger.Warnw("Failed to cache message", "message_id", msg.MessageID, "error", err)
	}

	s.invalidateCachesAfterSend(conversationID, memberIDs)

	s.publishWithTimeout("message created event", func(ctx context.Context) error {
		return s.kafkaProducer.PublishMessageCreated(ctx, &messageEvents.MessageCreatedEvent{
			Conversation: s.conversationEventData(conversationID),
			Message:      messageDataFromResponse(*response),
		})
	})
}

func (s *Service) GetMessages(userID, conversationID uuid.UUID, limit int, beforeMessageID *string) (*MessagesListResponse, error) {
	members, err := s.getMembersCached(conversationID)
	if err != nil {
		return nil, fmt.Errorf("failed to get members: %w", err)
	}

	if !isActiveMember(members, userID) {
		return nil, ErrNotMember
	}

	var beforeTimeuuid *gocql.UUID
	if beforeMessageID != nil && *beforeMessageID != "" {
		parsed, err := gocql.ParseUUID(*beforeMessageID)
		if err != nil {
			return nil, fmt.Errorf("invalid beforeMessageID: %w", err)
		}
		beforeTimeuuid = &parsed
	}

	var messages []Message
	if beforeTimeuuid == nil {
		if cached, err := s.cache.GetConversationMessages(conversationID, limit); err == nil && len(cached) > 0 {
			s.logger.Debugw("Cache HIT for messages", "conversation_id", conversationID)
			messages = cached
		}
	}

	if len(messages) == 0 {
		s.logger.Debugw("Cache MISS for messages", "conversation_id", conversationID)
		messages, err = s.repo.GetMessages(conversationID, limit, beforeTimeuuid)
		if err != nil {
			return nil, fmt.Errorf("failed to get messages: %w", err)
		}

		if beforeTimeuuid == nil && len(messages) > 0 {
			utils.SafeGo(s.logger, func() {
				if err := s.cache.SetConversationMessages(conversationID, limit, messages); err != nil {
					s.logger.Warnw("Failed to cache messages", "conversation_id", conversationID, "error", err)
				}
			})
		}
	}

	senderIDSet := make(map[uuid.UUID]struct{}, len(messages))
	for _, msg := range messages {
		if msg.DeletedAt == nil {
			senderIDSet[msg.SenderID] = struct{}{}
		}
	}
	senderIDs := make([]uuid.UUID, 0, len(senderIDSet))
	for id := range senderIDSet {
		senderIDs = append(senderIDs, id)
	}
	senders := s.userCache.GetUsersBatch(senderIDs, false)

	responses := make([]MessageResponse, 0, len(messages))
	for _, msg := range messages {
		if msg.DeletedAt != nil {
			continue
		}

		senderName := msg.SenderName
		senderAvatar := msg.SenderAvatar
		if u, ok := senders[msg.SenderID]; ok && u != nil {
			senderName = u.Username
			senderAvatar = u.Avatar
		}

		resp := MessageResponse{
			ID:             msg.MessageID.String(),
			ConversationID: msg.ConversationID.String(),
			SenderID:       msg.SenderID.String(),
			SenderName:     senderName,
			SenderAvatar:   senderAvatar,
			Type:           msg.MessageType,
			Content:        msg.Content,
			Metadata:       msg.Metadata,
			Status:         "sent",
			CreatedAt:      msg.CreatedAt.Format(time.RFC3339),
			UpdatedAt:      msg.UpdatedAt.Format(time.RFC3339),
			Reactions:      parseReactions(msg.Reactions),
		}

		if msg.EditedAt != nil {
			resp.EditedAt = msg.EditedAt.Format(time.RFC3339)
		}

		if msg.ReplyToID != nil {
			resp.ReplyToID = msg.ReplyToID.String()
		}

		responses = append(responses, resp)
	}

	return &MessagesListResponse{
		Messages: responses,
		Total:    len(responses),
	}, nil
}

func (s *Service) UpdateMessage(userID uuid.UUID, conversationIDStr, messageIDStr, newContent string) (*MessageResponse, error) {
	conversationID, err := uuid.Parse(conversationIDStr)
	if err != nil {
		return nil, fmt.Errorf("invalid conversation ID: %w", err)
	}

	messageID, err := gocql.ParseUUID(messageIDStr)
	if err != nil {
		return nil, fmt.Errorf("invalid message ID: %w", err)
	}

	// Get existing message
	msg, err := s.repo.GetMessageByID(conversationID, messageID)
	if err != nil {
		return nil, fmt.Errorf("message not found: %w", err)
	}

	// Validate ownership
	if msg.SenderID != userID {
		return nil, fmt.Errorf("you can only update your own messages")
	}

	// Validate message is not deleted
	if msg.DeletedAt != nil {
		return nil, fmt.Errorf("cannot update deleted message")
	}

	// Validate content
	if newContent == "" {
		return nil, fmt.Errorf("content cannot be empty")
	}

	// Check membership
	members, err := s.getMembersCached(conversationID)
	if err != nil {
		return nil, fmt.Errorf("failed to check conversation membership: %w", err)
	}
	if !isMember(members, userID) {
		return nil, ErrNotMember
	}

	// Update message in ScyllaDB
	if err := s.repo.UpdateMessage(conversationID, messageID, newContent); err != nil {
		return nil, fmt.Errorf("failed to update message: %w", err)
	}

	senderName := ""
	senderAvatar := ""
	if u, err := s.userCache.GetUserCache(userID, true); err == nil && u != nil {
		senderName = u.Username
		senderAvatar = u.Avatar
	}

	// Update inbox preview if this is the last message
	utils.SafeGo(s.logger, func() {
		s.updateInboxPreviewIfLastMessage(conversationID, messageID, newContent, members)
	})

	// Build response
	now := time.Now()
	response := &MessageResponse{
		ID:             messageID.String(),
		ConversationID: conversationID.String(),
		SenderID:       userID.String(),
		SenderName:     senderName,
		SenderAvatar:   senderAvatar,
		Type:           msg.MessageType,
		Content:        newContent,
		Status:         "sent",
		CreatedAt:      msg.CreatedAt.Format(time.RFC3339),
		UpdatedAt:      now.Format(time.RFC3339),
		EditedAt:       now.Format(time.RFC3339),
	}

	s.invalidateMessageCachesAsync(conversationID, messageID)
	s.publishMessageUpdatedAsync(*response, conversationID)

	s.logger.Infow("Message updated successfully",
		"conversation_id", conversationID,
		"message_id", messageID,
		"user_id", userID,
	)

	return response, nil
}

func (s *Service) invalidateMessageCachesAsync(conversationID uuid.UUID, messageID gocql.UUID) {
	utils.SafeGo(s.logger, func() {
		if err := s.cache.DeleteMessage(conversationID, messageID); err != nil {
			s.logger.Warnw("Failed to invalidate message cache after update",
				"conversation_id", conversationID, "message_id", messageID, "error", err)
		}
		if err := s.cache.DeleteConversationMessages(conversationID); err != nil {
			s.logger.Warnw("Failed to invalidate conversation messages cache after update",
				"conversation_id", conversationID, "error", err)
		}
	})
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

func (s *Service) DeleteMessage(userID uuid.UUID, conversationIDStr, messageIDStr string) error {
	conversationID, err := uuid.Parse(conversationIDStr)
	if err != nil {
		return fmt.Errorf("invalid conversation ID: %w", err)
	}

	messageID, err := gocql.ParseUUID(messageIDStr)
	if err != nil {
		return fmt.Errorf("invalid message ID: %w", err)
	}

	msg, err := s.repo.GetMessageByID(conversationID, messageID)
	if err != nil {
		return fmt.Errorf("message not found: %w", err)
	}

	if msg.SenderID != userID {
		return fmt.Errorf("you can only delete your own messages")
	}

	if window := s.cfg.MessageDeleteWindowSeconds; window > 0 {
		age := time.Since(msg.CreatedAt)
		if age > time.Duration(window)*time.Second {
			return fmt.Errorf("message is too old to delete")
		}
	}

	members, err := s.getMembersCached(conversationID)
	if err != nil {
		return fmt.Errorf("failed to check conversation membership: %w", err)
	}
	if !isMember(members, userID) {
		return ErrNotMember
	}

	if err := s.repo.DeleteMessage(conversationID, messageID); err != nil {
		return fmt.Errorf("failed to delete message: %w", err)
	}

	// Update inbox preview if this is the last message
	utils.SafeGo(s.logger, func() { s.updateInboxPreviewAfterDelete(conversationID, messageID, members) })

	utils.SafeGo(s.logger, func() { s.invalidateCachesAfterDelete(conversationID, messageID) })

	s.publishAsync("message deleted event", func(ctx context.Context) error {
		return s.kafkaProducer.PublishMessageDeleted(ctx, &messageEvents.MessageDeletedEvent{
			Conversation: s.conversationEventData(conversationID),
			MessageID:    messageIDStr,
		})
	})

	return nil
}

func (s *Service) getMembersCached(conversationID uuid.UUID) ([]conversation.ConversationMember, error) {
	return s.convCache.GetMembersCached(conversationID)
}

func (s *Service) getConversationByIDCached(conversationID uuid.UUID) (*conversation.Conversation, error) {
	return s.convCache.GetConversationByIDCached(conversationID)
}

func (s *Service) invalidateCachesAfterSend(conversationID uuid.UUID, memberIDs []uuid.UUID) {
	if err := s.cache.InvalidateConversationMessages(conversationID); err != nil {
		s.logger.Warnw("Failed to invalidate conversation messages cache", "conversation_id", conversationID, "error", err)
	}

	var wg sync.WaitGroup
	for _, userID := range memberIDs {
		wg.Add(1)
		uid := userID
		utils.SafeGo(s.logger, func() {
			defer wg.Done()
			if err := s.convCache.DeleteUserConversations(uid); err != nil {
				s.logger.Warnw("Failed to invalidate user conversations cache", "user_id", uid, "error", err)
			}
		})
	}
	wg.Wait()

	s.logger.Debugw("Cache invalidated after send", "conversation_id", conversationID, "member_count", len(memberIDs))
}

func (s *Service) invalidateCachesAfterDelete(conversationID uuid.UUID, messageID gocql.UUID) {
	if err := s.cache.InvalidateConversationMessages(conversationID); err != nil {
		s.logger.Warnw("Failed to invalidate conversation messages cache", "conversation_id", conversationID, "error", err)
	}

	if err := s.cache.DeleteMessage(conversationID, messageID); err != nil {
		s.logger.Warnw("Failed to invalidate message cache", "message_id", messageID, "error", err)
	}

	s.logger.Debugw("Cache invalidated after delete", "conversation_id", conversationID, "message_id", messageID)
}

func (s *Service) publishConversationCreatedEvent(convID, senderID, recipientID uuid.UUID, lastMessage *MessageResponse) {
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	conv, err := s.getConversationByIDCached(convID)
	if err != nil {
		s.logger.Errorw("Failed to get conversation for CREATED event", "conversation_id", convID, "error", err)
		return
	}

	senderUser, err := s.userCache.GetUserCache(senderID, true)
	if err != nil || senderUser == nil {
		s.logger.Errorw("Failed to get sender user", "user_id", senderID, "error", err)
		return
	}
	recipientUser, err := s.userCache.GetUserCache(recipientID, true)
	if err != nil || recipientUser == nil {
		s.logger.Errorw("Failed to get recipient user", "user_id", recipientID, "error", err)
		return
	}

	lastMessageText := ""
	lastMessageAt := conv.CreatedAt.Format(time.RFC3339)
	if lastMessage != nil {
		lastMessageText = lastMessage.Content
		lastMessageAt = lastMessage.CreatedAt
	}

	participants := []map[string]interface{}{
		{
			"userId":   senderID.String(),
			"username": senderUser.Username,
			"avatar":   senderUser.Avatar,
		},
		{
			"userId":   recipientID.String(),
			"username": recipientUser.Username,
			"avatar":   recipientUser.Avatar,
		},
	}

	senderEvent := &conversationEvents.CreatedEvent{
		ConversationID: convID.String(),
		Data: map[string]interface{}{
			"id":               conv.ConversationID.String(),
			"type":             conv.Type,
			"name":             recipientUser.Username,
			"avatar":           recipientUser.Avatar,
			"createdAt":        conv.CreatedAt.Format(time.RFC3339),
			"updatedAt":        conv.UpdatedAt.Format(time.RFC3339),
			"participantCount": conv.ParticipantCount,
			"lastMessageText":  lastMessageText,
			"lastMessageAt":    lastMessageAt,
			"unreadCount":      0,
			"participants":     participants,
		},
	}

	recipientEvent := &conversationEvents.CreatedEvent{
		ConversationID: convID.String(),
		Data: map[string]interface{}{
			"id":               conv.ConversationID.String(),
			"type":             conv.Type,
			"name":             senderUser.Username,
			"avatar":           senderUser.Avatar,
			"createdAt":        conv.CreatedAt.Format(time.RFC3339),
			"updatedAt":        conv.UpdatedAt.Format(time.RFC3339),
			"participantCount": conv.ParticipantCount,
			"lastMessageText":  lastMessageText,
			"lastMessageAt":    lastMessageAt,
			"unreadCount":      1,
			"participants":     participants,
		},
	}

	if err := s.kafkaProducer.PublishConversationCreated(ctx, senderEvent); err != nil {
		s.logger.Errorw("Failed to publish CONVERSATION_CREATED event for sender", "conversation_id", convID, "error", err)
	} else {
		s.logger.Infow("Published CONVERSATION_CREATED event for sender", "conversation_id", convID)
	}

	if err := s.kafkaProducer.PublishConversationCreated(ctx, recipientEvent); err != nil {
		s.logger.Errorw("Failed to publish CONVERSATION_CREATED event for recipient", "conversation_id", convID, "error", err)
	} else {
		s.logger.Infow("Published CONVERSATION_CREATED event for recipient", "conversation_id", convID)
	}
}

func (s *Service) updateInboxPreviewAfterDelete(conversationID uuid.UUID, deletedMessageID gocql.UUID, members []conversation.ConversationMember) {
	for _, m := range members {
		inboxEntry, _, err := s.repo.GetConversationInboxEntry(m.UserID, conversationID)
		if err != nil || inboxEntry == nil || inboxEntry.LastMessageID == nil {
			continue
		}

		if *inboxEntry.LastMessageID == deletedMessageID {
			if err := s.repo.UpdateConversationPreview(m.UserID, conversationID, constants.MessageDeletedPreview); err != nil {
				s.logger.Errorw("Failed to update inbox preview after delete",
					"user_id", m.UserID,
					"conversation_id", conversationID,
					"error", err,
				)
			} else {
				s.convCache.DeleteUserConversations(m.UserID)
			}
		}
	}
}

func (s *Service) updateInboxPreviewIfLastMessage(conversationID uuid.UUID, messageID gocql.UUID, newContent string, members []conversation.ConversationMember) {
	shortContent := truncatePreview(newContent, 100)

	for _, m := range members {
		inboxEntry, _, err := s.repo.GetConversationInboxEntry(m.UserID, conversationID)
		if err != nil || inboxEntry == nil || inboxEntry.LastMessageID == nil {
			continue
		}

		if *inboxEntry.LastMessageID == messageID {
			if err := s.repo.UpdateConversationPreview(m.UserID, conversationID, shortContent); err != nil {
				s.logger.Errorw("Failed to update inbox preview",
					"user_id", m.UserID,
					"conversation_id", conversationID,
					"error", err,
				)
			} else {
				s.convCache.DeleteUserConversations(m.UserID)
			}
		}
	}
}

func (s *Service) recreateInboxEntry(userID, conversationID uuid.UUID, messageID gocql.UUID, messageBody string, senderID uuid.UUID, incrementUnread bool) error {
	conv, err := s.getConversationByIDCached(conversationID)
	if err != nil {
		return fmt.Errorf("failed to get conversation: %w", err)
	}

	gocqlUserID, err := utils.ToGocqlUUID(userID)
	if err != nil {
		return fmt.Errorf("failed to convert userID: %w", err)
	}
	gocqlConvID, err := utils.ToGocqlUUID(conversationID)
	if err != nil {
		return fmt.Errorf("failed to convert conversationID: %w", err)
	}
	gocqlSenderID, err := utils.ToGocqlUUID(senderID)
	if err != nil {
		return fmt.Errorf("failed to convert senderID: %w", err)
	}

	initialUnread := 0
	if incrementUnread {
		initialUnread = 1
	}
	now := time.Now()

	inboxEntry := &conversation.ConversationByUser{
		UserID:             gocqlUserID,
		ConversationID:     gocqlConvID,
		LastMessageAt:      messageID,
		LastMessageID:      &messageID,
		LastMessagePreview: messageBody,
		LastMessageSender:  &gocqlSenderID,
		UnreadCount:        initialUnread,
		UpdatedAt:          &now,
	}

	if conv.Type == constants.ConversationTypeDirect {
		otherUser, gocqlOtherUserID, err := s.resolveDirectOther(conversationID, userID)
		if err != nil {
			return err
		}
		name := directDisplayName(otherUser)
		inboxEntry.ConversationType = constants.ConversationTypeDirect
		inboxEntry.DisplayName = name
		inboxEntry.DisplayAvatar = otherUser.Avatar
		inboxEntry.OtherUserID = &gocqlOtherUserID
		inboxEntry.OtherUserName = name
		inboxEntry.OtherUserAvatar = otherUser.Avatar
	} else {
		inboxEntry.ConversationType = constants.ConversationTypeGroupDB
		inboxEntry.DisplayName = conv.Name
		inboxEntry.DisplayAvatar = conv.Avatar
	}

	if err := s.convRepo.AddConversationToUserInbox(inboxEntry); err != nil {
		return fmt.Errorf("failed to add conversation to inbox: %w", err)
	}

	utils.SafeGo(s.logger, func() { s.convCache.DeleteUserConversations(userID) })

	return nil
}

func (s *Service) resolveDirectOther(conversationID, selfID uuid.UUID) (*models.User, gocql.UUID, error) {
	members, err := s.getMembersCached(conversationID)
	if err != nil {
		return nil, gocql.UUID{}, fmt.Errorf("failed to get members: %w", err)
	}

	var otherUserID uuid.UUID
	for _, member := range members {
		if member.UserID != selfID && member.IsActive {
			otherUserID = member.UserID
			break
		}
	}
	if otherUserID == uuid.Nil {
		return nil, gocql.UUID{}, fmt.Errorf("failed to find other user in conversation")
	}

	otherUser, err := s.userCache.GetUserCache(otherUserID, true)
	if err != nil {
		return nil, gocql.UUID{}, fmt.Errorf("failed to get other user: %w", err)
	}
	gocqlOtherUserID, err := utils.ToGocqlUUID(otherUserID)
	if err != nil {
		return nil, gocql.UUID{}, fmt.Errorf("failed to convert otherUserID: %w", err)
	}
	return otherUser, gocqlOtherUserID, nil
}

func (s *Service) ToggleReaction(ctx context.Context, userID, conversationID uuid.UUID, messageIDStr, reactionType string) (*MessageResponse, error) {
	if !isAllowedReactionType(reactionType) {
		return nil, fmt.Errorf("%w: %s", ErrInvalidMetadata, reactionType)
	}

	messageID, err := gocql.ParseUUID(messageIDStr)
	if err != nil {
		return nil, fmt.Errorf("invalid message ID: %w", err)
	}

	members, err := s.getMembersCached(conversationID)
	if err != nil {
		return nil, fmt.Errorf("failed to get members: %w", err)
	}
	if !isActiveMember(members, userID) {
		return nil, ErrNotMember
	}

	rateKey := fmt.Sprintf(constants.CacheKeyRateLimitReaction, userID.String())
	if err := s.checkRateLimit(rateKey, constants.RateLimitReactionWindowSeconds, constants.RateLimitReactionMaxRequests); err != nil {
		return nil, err
	}

	lockKey := fmt.Sprintf(constants.CacheKeyReactionLock, messageIDStr)
	acquired, lockErr := s.redis.SetNX(lockKey, "1", time.Duration(constants.ReactionLockTTLSeconds)*time.Second)
	if lockErr != nil {
		s.logger.Warnw("Reaction lock SetNX failed", "message_id", messageIDStr, "error", lockErr)
	}
	if !acquired {
		time.Sleep(time.Duration(constants.ReactionLockRetryMs) * time.Millisecond)
		acquired, lockErr = s.redis.SetNX(lockKey, "1", time.Duration(constants.ReactionLockTTLSeconds)*time.Second)
		if lockErr != nil {
			s.logger.Warnw("Reaction lock SetNX retry failed", "message_id", messageIDStr, "error", lockErr)
		}
		if !acquired {
			return nil, fmt.Errorf("reaction in progress, please retry")
		}
	}
	defer s.redis.Delete(lockKey)

	msg, err := s.repo.GetMessageByID(conversationID, messageID)
	if err != nil {
		return nil, fmt.Errorf("message not found: %w", err)
	}
	if msg.DeletedAt != nil {
		return nil, fmt.Errorf("message deleted")
	}

	reactions := parseReactions(msg.Reactions)
	userIDStr := userID.String()
	action, err := applyReactionToggle(reactions, reactionType, userIDStr)
	if err != nil {
		return nil, err
	}

	var newRaw string
	if len(reactions) == 0 {
		newRaw = ""
	} else {
		b, err := json.Marshal(reactions)
		if err != nil {
			return nil, fmt.Errorf("failed to marshal reactions: %w", err)
		}
		newRaw = string(b)
	}

	if err := s.repo.UpdateReactions(conversationID, messageID, newRaw); err != nil {
		return nil, fmt.Errorf("failed to persist reactions: %w", err)
	}

	s.cache.InvalidateConversationMessages(conversationID)
	s.cache.DeleteMessage(conversationID, messageID)

	s.publishAsync("reaction event", func(ctx context.Context) error {
		return s.kafkaProducer.PublishMessageReactionUpdated(ctx, &messageEvents.MessageReactionUpdatedEvent{
			ConversationID: conversationID.String(),
			MessageID:      messageIDStr,
			Reactions:      reactions,
			ActorUserID:    userIDStr,
			Type:           reactionType,
			Action:         action,
		})
	})

	senderUUID, _ := uuid.Parse(msg.SenderID.String())
	resp := &MessageResponse{
		ID:             messageID.String(),
		ConversationID: conversationID.String(),
		SenderID:       senderUUID.String(),
		SenderName:     msg.SenderName,
		SenderAvatar:   msg.SenderAvatar,
		Type:           msg.MessageType,
		Content:        msg.Content,
		Metadata:       msg.Metadata,
		Status:         "sent",
		CreatedAt:      msg.CreatedAt.Format(time.RFC3339),
		UpdatedAt:      time.Now().Format(time.RFC3339),
		Reactions:      reactions,
	}
	if msg.ReplyToID != nil {
		resp.ReplyToID = msg.ReplyToID.String()
	}
	return resp, nil
}
