package room

import (
	"bytes"
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"image"
	_ "image/gif"
	_ "image/jpeg"
	_ "image/png"
	"io"
	"mime/multipart"
	"net/http"
	"ola-chat-server/internal/constants"
	roomEvents "ola-chat-server/internal/domain/room"
	"ola-chat-server/internal/models"
	userModule "ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/kafka"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"
	"path/filepath"
	"strings"
	"time"

	_ "golang.org/x/image/webp"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var (
	ErrRoomFileTooLarge     = errors.New("file too large")
	ErrRoomUploadRateLimit  = errors.New("upload rate limit exceeded")
	ErrRoomUnsupportedImage = errors.New("unsupported image type")
	ErrRoomDecodeImage      = errors.New("failed to decode image")
)

type Service struct {
	repo      *Repository
	redisMsg  *RedisMessageRepository
	userCache *userModule.CacheService
	wsServer  *websocket.Server
	producer  *kafka.Producer
	cache     *services.CacheService
	s3        *services.S3Service
	logger    *zap.SugaredLogger
}

func NewService(repo *Repository, redisMsg *RedisMessageRepository, userCache *userModule.CacheService, wsServer *websocket.Server, producer *kafka.Producer, cache *services.CacheService, s3 *services.S3Service, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:      repo,
		redisMsg:  redisMsg,
		userCache: userCache,
		wsServer:  wsServer,
		producer:  producer,
		cache:     cache,
		s3:        s3,
		logger:    logger.Named("[room_service]"),
	}
}

func (s *Service) Create(adminID uuid.UUID, req *CreateRoomRequest) (*RoomResponse, error) {
	room := &models.Room{
		Name:        req.Name,
		Description: req.Description,
		ImageURL:    req.ImageURL,
		MaxMembers:  req.MaxMembers,
		Index:       req.Index,
		Enabled:     true,
		CreatedBy:   adminID,
	}
	if err := s.repo.Create(room); err != nil {
		return nil, err
	}
	s.logger.Infow("Room created", "room_id", room.ID, "admin_id", adminID)
	return toRoomResponse(room, 0), nil
}

func (s *Service) Update(ctx context.Context, id uuid.UUID, req *UpdateRoomRequest) (*RoomResponse, error) {
	room, err := s.getRoom(id)
	if err != nil {
		return nil, err
	}
	if req.Name != nil {
		room.Name = *req.Name
	}
	if req.Description != nil {
		room.Description = *req.Description
	}
	if req.ImageURL != nil {
		room.ImageURL = *req.ImageURL
	}
	if req.MaxMembers != nil {
		room.MaxMembers = *req.MaxMembers
	}
	if req.Index != nil {
		room.Index = *req.Index
	}
	if req.Enabled != nil {
		room.Enabled = *req.Enabled
	}
	if err := s.repo.Save(room); err != nil {
		return nil, err
	}
	count, _ := s.wsServer.GetRoomPresence().MemberCount(ctx, room.ID.String())
	return toRoomResponse(room, count), nil
}

func (s *Service) Delete(id uuid.UUID) error {
	if _, err := s.getRoom(id); err != nil {
		return err
	}
	return s.repo.SoftDelete(id)
}

func (s *Service) ListAdmin(ctx context.Context, query string, limit, offset int) (*RoomListResponse, error) {
	rooms, total, err := s.repo.ListAll(query, limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildList(ctx, rooms, total, limit, offset), nil
}

func (s *Service) ListPublic(ctx context.Context, query string, limit, offset int) (*RoomListResponse, error) {
	rooms, total, err := s.repo.ListPublic(query, limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildList(ctx, rooms, total, limit, offset), nil
}

func (s *Service) GetByID(ctx context.Context, id uuid.UUID) (*RoomResponse, error) {
	room, err := s.getRoom(id)
	if err != nil {
		return nil, err
	}
	count, _ := s.wsServer.GetRoomPresence().MemberCount(ctx, id.String())
	return toRoomResponse(room, count), nil
}

func (s *Service) ListMembers(ctx context.Context, roomID uuid.UUID) (*RoomMembersResponse, error) {
	if _, err := s.getRoom(roomID); err != nil {
		return nil, err
	}
	ids, err := s.wsServer.GetRoomPresence().OnlineMembers(ctx, roomID.String())
	if err != nil {
		return nil, err
	}

	uuids := make([]uuid.UUID, 0, len(ids))
	for _, id := range ids {
		if uid, err := uuid.Parse(id); err == nil {
			uuids = append(uuids, uid)
		}
	}

	usersMap := s.userCache.GetUsersBatch(uuids, true)
	items := make([]RoomMemberResponse, 0, len(uuids))
	for _, uid := range uuids {
		u, ok := usersMap[uid]
		if !ok || u == nil {
			continue
		}
		member := RoomMemberResponse{
			UserID:   uid.String(),
			Username: u.Username,
			FullName: u.FullName,
			Avatar:   u.Avatar,
			Gender:   u.Gender,
			Bio:      u.Bio,
			BioImage: u.BioImage,
			VipUsed:  u.VipUsed,
		}
		if u.VipEndTime != nil {
			vipEnd := u.VipEndTime.Format(time.RFC3339)
			member.VipEndTime = &vipEnd
		}
		items = append(items, member)
	}
	return &RoomMembersResponse{Items: items, Total: len(items)}, nil
}

func (s *Service) RequestJoin(ctx context.Context, userID, roomID uuid.UUID) (*JoinRoomResponse, error) {
	room, err := s.getRoom(roomID)
	if err != nil {
		return nil, err
	}
	if !room.Enabled {
		return nil, errors.New("room is disabled")
	}

	presence := s.wsServer.GetRoomPresence()
	if room.MaxMembers > 0 {
		isMember, err := presence.IsMember(ctx, roomID.String(), userID.String())
		if err != nil {
			return nil, err
		}
		if !isMember {
			count, err := presence.MemberCount(ctx, roomID.String())
			if err != nil {
				return nil, err
			}
			if count >= room.MaxMembers {
				return nil, errors.New("room is full")
			}
		}
	}

	ticket, err := presence.IssueJoinTicket(ctx, roomID.String(), userID.String(), room.MaxMembers)
	if err != nil {
		return nil, err
	}
	return &JoinRoomResponse{Ticket: ticket, ExpiresIn: constants.RoomJoinTicketTTLSeconds}, nil
}

func (s *Service) SendMessage(ctx context.Context, userID, roomID uuid.UUID, req *SendRoomMessageRequest) (*RoomMessageResponse, error) {
	room, err := s.getRoom(roomID)
	if err != nil {
		return nil, err
	}
	if !room.Enabled {
		return nil, errors.New("room is disabled")
	}

	isMember, err := s.wsServer.GetRoomPresence().IsMember(ctx, roomID.String(), userID.String())
	if err != nil {
		return nil, err
	}
	if !isMember {
		return nil, errors.New("not a room member")
	}

	sender, _ := s.userCache.GetUserCache(userID, true)
	senderName, senderAvatar, senderGender, senderVip, senderVipEnd := senderFields(sender)
	msgID := uuid.New().String()
	createdAt := time.Now().UTC()
	createdAtStr := createdAt.Format(time.RFC3339)

	replyTo := s.resolveReplySnapshot(ctx, roomID.String(), req.ReplyToID)

	stored := storedRoomMessage{
		ID:        msgID,
		RoomID:    roomID.String(),
		SenderID:  userID.String(),
		Type:      constants.MessageTypeText,
		Content:   req.Content,
		CreatedAt: createdAtStr,
		ReplyTo:   replyTo,
	}
	data, err := json.Marshal(stored)
	if err != nil {
		return nil, err
	}
	if err := s.redisMsg.Append(ctx, roomID.String(), msgID, createdAt, data); err != nil {
		return nil, err
	}

	msg := RoomMessageResponse{
		ID:           msgID,
		RoomID:       roomID.String(),
		SenderID:     userID.String(),
		SenderName:   senderName,
		SenderAvatar: senderAvatar,
		SenderGender: senderGender,
		SenderVip:    senderVip,
		SenderVipEnd: senderVipEnd,
		Type:         constants.MessageTypeText,
		Content:      req.Content,
		CreatedAt:    createdAtStr,
		ReplyTo:      replyTo,
	}

	event := &roomEvents.RoomMessageCreatedEvent{
		Room: &roomEvents.RoomBrief{ID: room.ID.String(), Name: room.Name, ImageURL: room.ImageURL},
		Message: &roomEvents.RoomMessageData{
			ID:           msg.ID,
			RoomID:       msg.RoomID,
			SenderID:     msg.SenderID,
			SenderName:   msg.SenderName,
			SenderAvatar: msg.SenderAvatar,
			SenderGender: msg.SenderGender,
			SenderVip:    msg.SenderVip,
			SenderVipEnd: msg.SenderVipEnd,
			Type:         msg.Type,
			Content:      msg.Content,
			ImageURL:     msg.ImageURL,
			CreatedAt:    msg.CreatedAt,
			ReplyTo:      toEventReplySnapshot(replyTo),
		},
	}
	if err := s.producer.PublishRoomMessageCreated(ctx, event); err != nil {
		s.logger.Errorw("Failed to publish room message created", "room_id", roomID, "message_id", msgID, "error", err)
	}
	return &msg, nil
}

func (s *Service) SendImageMessage(ctx context.Context, userID, roomID uuid.UUID, fileHeader *multipart.FileHeader, clientMsgID string) (*RoomMessageResponse, error) {
	room, err := s.getRoom(roomID)
	if err != nil {
		return nil, err
	}
	if !room.Enabled {
		return nil, errors.New("room is disabled")
	}

	isMember, err := s.wsServer.GetRoomPresence().IsMember(ctx, roomID.String(), userID.String())
	if err != nil {
		return nil, err
	}
	if !isMember {
		return nil, errors.New("not a room member")
	}

	imageURL, err := s.uploadRoomImage(ctx, userID, roomID, fileHeader)
	if err != nil {
		return nil, err
	}

	sender, _ := s.userCache.GetUserCache(userID, true)
	senderName, senderAvatar, senderGender, senderVip, senderVipEnd := senderFields(sender)
	msgID := uuid.New().String()
	createdAt := time.Now().UTC()
	createdAtStr := createdAt.Format(time.RFC3339)

	stored := storedRoomMessage{
		ID:        msgID,
		RoomID:    roomID.String(),
		SenderID:  userID.String(),
		Type:      constants.MessageTypeImage,
		Content:   "",
		ImageURL:  imageURL,
		CreatedAt: createdAtStr,
	}
	data, err := json.Marshal(stored)
	if err != nil {
		return nil, err
	}
	if err := s.redisMsg.Append(ctx, roomID.String(), msgID, createdAt, data); err != nil {
		return nil, err
	}

	msg := RoomMessageResponse{
		ID:           msgID,
		RoomID:       roomID.String(),
		SenderID:     userID.String(),
		SenderName:   senderName,
		SenderAvatar: senderAvatar,
		SenderGender: senderGender,
		SenderVip:    senderVip,
		SenderVipEnd: senderVipEnd,
		Type:         constants.MessageTypeImage,
		Content:      "",
		ImageURL:     imageURL,
		CreatedAt:    createdAtStr,
		ClientMsgID:  clientMsgID,
	}

	event := &roomEvents.RoomMessageCreatedEvent{
		Room: &roomEvents.RoomBrief{ID: room.ID.String(), Name: room.Name, ImageURL: room.ImageURL},
		Message: &roomEvents.RoomMessageData{
			ID:           msg.ID,
			RoomID:       msg.RoomID,
			SenderID:     msg.SenderID,
			SenderName:   msg.SenderName,
			SenderAvatar: msg.SenderAvatar,
			SenderGender: msg.SenderGender,
			SenderVip:    msg.SenderVip,
			SenderVipEnd: msg.SenderVipEnd,
			Type:         msg.Type,
			Content:      msg.Content,
			ImageURL:     msg.ImageURL,
			CreatedAt:    msg.CreatedAt,
			ClientMsgID:  clientMsgID,
		},
	}
	if err := s.producer.PublishRoomMessageCreated(ctx, event); err != nil {
		s.logger.Errorw("Failed to publish room image message created", "room_id", roomID, "message_id", msgID, "error", err)
	}
	return &msg, nil
}

func (s *Service) uploadRoomImage(ctx context.Context, userID, roomID uuid.UUID, fileHeader *multipart.FileHeader) (string, error) {
	if fileHeader.Size > constants.MaxImageUploadSize {
		return "", ErrRoomFileTooLarge
	}

	rateKey := fmt.Sprintf(constants.CacheKeyRateLimitUpload, userID.String())
	if err := s.checkRateLimit(rateKey, constants.RateLimitUploadWindowSeconds, constants.RateLimitUploadMaxRequests); err != nil {
		return "", ErrRoomUploadRateLimit
	}

	file, err := fileHeader.Open()
	if err != nil {
		return "", fmt.Errorf("failed to open file: %w", err)
	}
	defer file.Close()

	head := make([]byte, 512)
	n, _ := io.ReadFull(file, head)
	head = head[:n]
	detectedMime := http.DetectContentType(head)
	if !isAllowedRoomImageMime(detectedMime) {
		return "", fmt.Errorf("%w: %s", ErrRoomUnsupportedImage, detectedMime)
	}

	rest, err := io.ReadAll(file)
	if err != nil {
		return "", fmt.Errorf("failed to read file: %w", err)
	}
	fullData := append(head, rest...)
	if int64(len(fullData)) > constants.MaxImageUploadSize {
		return "", ErrRoomFileTooLarge
	}

	if _, _, err := image.DecodeConfig(bytes.NewReader(fullData)); err != nil {
		return "", fmt.Errorf("%w: %v", ErrRoomDecodeImage, err)
	}

	ext := pickRoomImageExtension(detectedMime, fileHeader.Filename)
	safeName := fmt.Sprintf("image%s", ext)
	folder := fmt.Sprintf("%s/%s", constants.UploadFolderRooms, time.Now().Format(constants.UploadDateLayoutDay))

	upload, err := s.s3.UploadFile(ctx, &roomFileReader{Reader: bytes.NewReader(fullData), size: int64(len(fullData))}, safeName, folder)
	if err != nil {
		return "", fmt.Errorf("failed to upload to storage: %w", err)
	}
	return upload.URL, nil
}

func isAllowedRoomImageMime(mime string) bool {
	for _, m := range constants.AllowedImageMimes {
		if strings.EqualFold(m, mime) {
			return true
		}
	}
	return false
}

func pickRoomImageExtension(mime, originalName string) string {
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

type roomFileReader struct {
	*bytes.Reader
	size int64
}

func (r *roomFileReader) Close() error { return nil }

var _ multipart.File = (*roomFileReader)(nil)

func (s *Service) DeleteMessage(ctx context.Context, userID, roomID uuid.UUID, messageID string) error {
	if _, err := s.getRoom(roomID); err != nil {
		return err
	}

	data, err := s.redisMsg.Get(ctx, roomID.String(), messageID)
	if err != nil {
		return err
	}
	if data == nil {
		return errors.New("message not found")
	}

	var existing RoomMessageResponse
	if err := json.Unmarshal(data, &existing); err != nil {
		return err
	}
	if existing.SenderID != userID.String() {
		return errors.New("you can only delete your own messages")
	}

	if err := s.redisMsg.Delete(ctx, roomID.String(), messageID); err != nil {
		return err
	}

	if err := s.producer.PublishRoomMessageDeleted(ctx, &roomEvents.RoomMessageDeletedEvent{
		RoomID:    roomID.String(),
		MessageID: messageID,
	}); err != nil {
		s.logger.Errorw("Failed to publish room message deleted", "room_id", roomID, "message_id", messageID, "error", err)
	}
	return nil
}

func (s *Service) DeleteMessageAdmin(ctx context.Context, roomID uuid.UUID, messageID string) error {
	if _, err := s.getRoom(roomID); err != nil {
		return err
	}

	data, err := s.redisMsg.Get(ctx, roomID.String(), messageID)
	if err != nil {
		return err
	}
	if data == nil {
		return errors.New("message not found")
	}

	if err := s.redisMsg.Delete(ctx, roomID.String(), messageID); err != nil {
		return err
	}

	if err := s.producer.PublishRoomMessageDeleted(ctx, &roomEvents.RoomMessageDeletedEvent{
		RoomID:    roomID.String(),
		MessageID: messageID,
	}); err != nil {
		s.logger.Errorw("Failed to publish room message deleted", "room_id", roomID, "message_id", messageID, "error", err)
	}
	return nil
}

func (s *Service) GetMessages(ctx context.Context, roomID uuid.UUID, limit int, beforeID string) (*RoomMessagesListResponse, error) {
	room, err := s.getRoom(roomID)
	if err != nil {
		return nil, err
	}
	if !room.Enabled {
		return nil, errors.New("room is disabled")
	}
	return s.fetchMessages(ctx, roomID, limit, beforeID)
}

func (s *Service) GetMessagesAdmin(ctx context.Context, roomID uuid.UUID, limit int, beforeID string) (*RoomMessagesListResponse, error) {
	if _, err := s.getRoom(roomID); err != nil {
		return nil, err
	}
	return s.fetchMessages(ctx, roomID, limit, beforeID)
}

func (s *Service) fetchMessages(ctx context.Context, roomID uuid.UUID, limit int, beforeID string) (*RoomMessagesListResponse, error) {
	raws, err := s.redisMsg.List(ctx, roomID.String(), limit, beforeID)
	if err != nil {
		return nil, err
	}

	stored := make([]storedRoomMessage, 0, len(raws))
	idSet := make(map[uuid.UUID]struct{})
	for _, raw := range raws {
		var m storedRoomMessage
		if err := json.Unmarshal(raw, &m); err != nil {
			continue
		}
		stored = append(stored, m)
		if uid, err := uuid.Parse(m.SenderID); err == nil {
			idSet[uid] = struct{}{}
		}
	}

	ids := make([]uuid.UUID, 0, len(idSet))
	for id := range idSet {
		ids = append(ids, id)
	}
	users := s.userCache.GetUsersBatch(ids, true)

	items := make([]RoomMessageResponse, 0, len(stored))
	for _, m := range stored {
		item := RoomMessageResponse{
			ID:        m.ID,
			RoomID:    m.RoomID,
			SenderID:  m.SenderID,
			Type:      m.Type,
			Content:   m.Content,
			ImageURL:  m.ImageURL,
			CreatedAt: m.CreatedAt,
			ReplyTo:   m.ReplyTo,
			Reactions: m.Reactions,
		}
		if uid, err := uuid.Parse(m.SenderID); err == nil {
			item.SenderName, item.SenderAvatar, item.SenderGender, item.SenderVip, item.SenderVipEnd = senderFields(users[uid])
		}
		items = append(items, item)
	}

	resp := &RoomMessagesListResponse{Items: items, HasMore: len(raws) == limit}
	if len(items) > 0 {
		resp.NextBefore = items[len(items)-1].ID
	}
	return resp, nil
}

func (s *Service) ToggleReaction(ctx context.Context, userID, roomID uuid.UUID, messageID, reactionType string) (*RoomMessageResponse, error) {
	if !isAllowedRoomReactionType(reactionType) {
		return nil, fmt.Errorf("invalid reaction type: %s", reactionType)
	}
	if _, err := uuid.Parse(messageID); err != nil {
		return nil, errors.New("invalid message id")
	}

	room, err := s.getRoom(roomID)
	if err != nil {
		return nil, err
	}
	if !room.Enabled {
		return nil, errors.New("room is disabled")
	}

	isMember, err := s.wsServer.GetRoomPresence().IsMember(ctx, roomID.String(), userID.String())
	if err != nil {
		return nil, err
	}
	if !isMember {
		return nil, errors.New("not a room member")
	}

	rateKey := fmt.Sprintf(constants.CacheKeyRateLimitReaction, userID.String())
	if err := s.checkRateLimit(rateKey, constants.RateLimitReactionWindowSeconds, constants.RateLimitReactionMaxRequests); err != nil {
		return nil, err
	}

	lockKey := fmt.Sprintf(constants.CacheKeyReactionLock, messageID)
	acquired, lockErr := s.cache.SetNX(lockKey, "1", time.Duration(constants.ReactionLockTTLSeconds)*time.Second)
	if lockErr != nil {
		s.logger.Warnw("Room reaction lock SetNX failed", "message_id", messageID, "error", lockErr)
	}
	if !acquired {
		time.Sleep(time.Duration(constants.ReactionLockRetryMs) * time.Millisecond)
		acquired, lockErr = s.cache.SetNX(lockKey, "1", time.Duration(constants.ReactionLockTTLSeconds)*time.Second)
		if lockErr != nil {
			s.logger.Warnw("Room reaction lock SetNX retry failed", "message_id", messageID, "error", lockErr)
		}
		if !acquired {
			return nil, errors.New("reaction in progress, please retry")
		}
	}
	defer s.cache.Delete(lockKey)

	data, err := s.redisMsg.Get(ctx, roomID.String(), messageID)
	if err != nil {
		return nil, err
	}
	if data == nil {
		return nil, errors.New("message not found")
	}
	var stored storedRoomMessage
	if err := json.Unmarshal(data, &stored); err != nil {
		return nil, err
	}

	actor, _ := s.userCache.GetUserCache(userID, true)
	actorUsername := ""
	if actor != nil {
		actorUsername = actor.Username
	}

	if stored.Reactions == nil {
		stored.Reactions = map[string][]RoomReactor{}
	}
	action := applyRoomReactionReplace(stored.Reactions, reactionType, RoomReactor{UserID: userID.String(), Username: actorUsername})
	if len(stored.Reactions) == 0 {
		stored.Reactions = nil
	}

	updated, err := json.Marshal(stored)
	if err != nil {
		return nil, err
	}
	if err := s.redisMsg.Update(ctx, roomID.String(), messageID, updated); err != nil {
		return nil, err
	}

	if err := s.producer.PublishRoomMessageReactionUpdated(ctx, &roomEvents.RoomMessageReactionUpdatedEvent{
		RoomID:        roomID.String(),
		MessageID:     messageID,
		Reactions:     toEventReactions(stored.Reactions),
		ActorUserID:   userID.String(),
		ActorUsername: actorUsername,
		Type:          reactionType,
		Action:        action,
	}); err != nil {
		s.logger.Errorw("Failed to publish room reaction updated", "room_id", roomID, "message_id", messageID, "error", err)
	}

	item := RoomMessageResponse{
		ID:        stored.ID,
		RoomID:    stored.RoomID,
		SenderID:  stored.SenderID,
		Content:   stored.Content,
		CreatedAt: stored.CreatedAt,
		ReplyTo:   stored.ReplyTo,
		Reactions: stored.Reactions,
	}
	if senderUUID, err := uuid.Parse(stored.SenderID); err == nil {
		msgSender, _ := s.userCache.GetUserCache(senderUUID, true)
		item.SenderName, item.SenderAvatar, item.SenderGender, item.SenderVip, item.SenderVipEnd = senderFields(msgSender)
	}
	return &item, nil
}

func (s *Service) resolveReplySnapshot(ctx context.Context, roomID, replyToID string) *RoomReplySnapshot {
	if replyToID == "" {
		return nil
	}
	data, err := s.redisMsg.Get(ctx, roomID, replyToID)
	if err != nil || data == nil {
		return nil
	}
	var orig storedRoomMessage
	if err := json.Unmarshal(data, &orig); err != nil {
		return nil
	}
	snapshot := &RoomReplySnapshot{
		MessageID: orig.ID,
		SenderID:  orig.SenderID,
		Excerpt:   utils.TruncateRunes(orig.Content, constants.RoomReplyExcerptMaxRunes),
		Type:      orig.Type,
		ImageURL:  orig.ImageURL,
	}
	if senderUUID, err := uuid.Parse(orig.SenderID); err == nil {
		if sender, _ := s.userCache.GetUserCache(senderUUID, true); sender != nil {
			snapshot.SenderName = sender.Username
		}
	}
	return snapshot
}

func (s *Service) checkRateLimit(key string, windowSecs, maxReqs int) error {
	count, err := s.cache.Increment(key)
	if err != nil {
		s.logger.Errorw("Rate limit Redis failure, failing closed", "key", key, "error", err)
		return errors.New("too many requests")
	}
	if count == 1 {
		if expErr := s.cache.SetExpire(key, time.Duration(windowSecs)*time.Second); expErr != nil {
			s.logger.Warnw("Failed to set rate limit expiry, deleting key to prevent permanent block", "key", key, "error", expErr)
			s.cache.Delete(key)
		}
	}
	if count > int64(maxReqs) {
		return errors.New("too many requests")
	}
	return nil
}

func applyRoomReactionReplace(reactions map[string][]RoomReactor, reactionType string, reactor RoomReactor) string {
	hadSameType := false
	for t, users := range reactions {
		filtered := make([]RoomReactor, 0, len(users))
		for _, u := range users {
			if u.UserID == reactor.UserID {
				if t == reactionType {
					hadSameType = true
				}
				continue
			}
			filtered = append(filtered, u)
		}
		if len(filtered) == 0 {
			delete(reactions, t)
		} else {
			reactions[t] = filtered
		}
	}
	if hadSameType {
		return constants.ReactionActionRemoved
	}
	reactions[reactionType] = append(reactions[reactionType], reactor)
	return constants.ReactionActionAdded
}

func isAllowedRoomReactionType(t string) bool {
	for _, v := range constants.AllowedReactionTypes {
		if v == t {
			return true
		}
	}
	return false
}

func toEventReplySnapshot(snapshot *RoomReplySnapshot) *roomEvents.RoomReplySnapshot {
	if snapshot == nil {
		return nil
	}
	return &roomEvents.RoomReplySnapshot{
		MessageID:  snapshot.MessageID,
		SenderID:   snapshot.SenderID,
		SenderName: snapshot.SenderName,
		Excerpt:    snapshot.Excerpt,
		Type:       snapshot.Type,
		ImageURL:   snapshot.ImageURL,
	}
}

func toEventReactions(reactions map[string][]RoomReactor) map[string][]roomEvents.RoomReactor {
	out := map[string][]roomEvents.RoomReactor{}
	for t, users := range reactions {
		converted := make([]roomEvents.RoomReactor, 0, len(users))
		for _, u := range users {
			converted = append(converted, roomEvents.RoomReactor{UserID: u.UserID, Username: u.Username})
		}
		out[t] = converted
	}
	return out
}

func (s *Service) RoomEnabled(roomID string) (bool, error) {
	id, err := uuid.Parse(roomID)
	if err != nil {
		return false, errors.New("invalid room id")
	}
	room, err := s.getRoom(id)
	if err != nil {
		return false, err
	}
	return room.Enabled, nil
}

func senderFields(u *models.User) (name, avatar, gender string, vip, vipEnd *string) {
	if u == nil {
		return "", "", "", nil, nil
	}
	name = u.Username
	gender = u.Gender
	vip = u.VipUsed
	if u.VipEndTime != nil {
		formatted := u.VipEndTime.Format(time.RFC3339)
		vipEnd = &formatted
	}
	return name, u.Avatar, gender, vip, vipEnd
}

func (s *Service) getRoom(id uuid.UUID) (*models.Room, error) {
	room, err := s.repo.GetByID(id)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errors.New("room not found")
		}
		return nil, err
	}
	return room, nil
}

func (s *Service) buildList(ctx context.Context, rooms []*models.Room, total int64, limit, offset int) *RoomListResponse {
	ids := make([]string, 0, len(rooms))
	for _, room := range rooms {
		ids = append(ids, room.ID.String())
	}
	counts := s.wsServer.GetRoomPresence().MemberCounts(ctx, ids)

	items := make([]RoomResponse, 0, len(rooms))
	for _, room := range rooms {
		items = append(items, *toRoomResponse(room, counts[room.ID.String()]))
	}
	return &RoomListResponse{Items: items, Total: total, Limit: limit, Offset: offset}
}

func toRoomResponse(room *models.Room, memberCount int) *RoomResponse {
	return &RoomResponse{
		ID:          room.ID.String(),
		Name:        room.Name,
		Description: room.Description,
		ImageURL:    room.ImageURL,
		MaxMembers:  room.MaxMembers,
		Index:       room.Index,
		MemberCount: memberCount,
		Enabled:     room.Enabled,
		CreatedBy:   room.CreatedBy.String(),
		CreatedAt:   room.CreatedAt.UTC().Format(time.RFC3339),
	}
}
