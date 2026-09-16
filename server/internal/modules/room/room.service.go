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
	"ola-chat-server/internal/media"
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
	ErrRoomFileTooLarge      = errors.New("file too large")
	ErrRoomUploadRateLimit   = errors.New("upload rate limit exceeded")
	ErrRoomUnsupportedImage  = errors.New("unsupported image type")
	ErrRoomDecodeImage       = errors.New("failed to decode image")
	ErrRoomMessageInProgress = errors.New("message upload already in progress")
	ErrRoomClientMessageUsed = errors.New("client message ID already used")
	ErrRoomBlockSelf         = errors.New("cannot block yourself")
	ErrRoomBlockUserNotFound = errors.New("user not found")
	ErrRoomBlockLimit        = errors.New("room block limit reached")
)

type Service struct {
	repo      *Repository
	redisMsg  *RedisMessageRepository
	blockRepo *BlockRepository
	userCache *userModule.CacheService
	wsServer  *websocket.Server
	producer  *kafka.Producer
	cache     *services.CacheService
	s3        *services.S3Service
	logger    *zap.SugaredLogger
}

func NewService(repo *Repository, redisMsg *RedisMessageRepository, blockRepo *BlockRepository, userCache *userModule.CacheService, wsServer *websocket.Server, producer *kafka.Producer, cache *services.CacheService, s3 *services.S3Service, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:      repo,
		redisMsg:  redisMsg,
		blockRepo: blockRepo,
		userCache: userCache,
		wsServer:  wsServer,
		producer:  producer,
		cache:     cache,
		s3:        s3,
		logger:    logger.Named("[room_service]"),
	}
}

func (s *Service) cachedRoomMediaMessage(ctx context.Context, userID, roomID uuid.UUID, messageType, clientMsgID string) (*RoomMessageResponse, error) {
	if clientMsgID == "" {
		return nil, nil
	}
	data, err := s.redisMsg.GetByClientMessageID(ctx, roomID.String(), userID.String(), clientMsgID)
	if err != nil || data == nil {
		return nil, err
	}
	var stored storedRoomMessage
	if err := json.Unmarshal(data, &stored); err != nil {
		return nil, err
	}
	if stored.RoomID != roomID.String() || stored.SenderID != userID.String() || stored.Type != messageType {
		return nil, ErrRoomClientMessageUsed
	}
	sender, _ := s.userCache.GetUserCache(userID, true)
	return toRoomMessageResponse(stored, sender), nil
}

func (s *Service) acquireRoomMediaUpload(ctx context.Context, userID, roomID uuid.UUID, messageType, clientMsgID string) (*RoomMessageResponse, func(), error) {
	noRelease := func() {}
	existing, err := s.cachedRoomMediaMessage(ctx, userID, roomID, messageType, clientMsgID)
	if err != nil || existing != nil || clientMsgID == "" {
		return existing, noRelease, err
	}

	lockKey := fmt.Sprintf(constants.CacheKeyRoomMediaUploadLock, roomID.String(), userID.String(), clientMsgID)
	lockToken := uuid.NewString()
	acquired, err := s.cache.SetNX(lockKey, lockToken, constants.CacheTTLMediaUploadLock*time.Second)
	if err != nil {
		return nil, noRelease, fmt.Errorf("failed to acquire room media upload lock: %w", err)
	}
	if !acquired {
		existing, existingErr := s.cachedRoomMediaMessage(ctx, userID, roomID, messageType, clientMsgID)
		if existingErr != nil || existing != nil {
			return existing, noRelease, existingErr
		}
		return nil, noRelease, ErrRoomMessageInProgress
	}

	release := func() {
		if _, err := s.cache.DeleteIfValue(lockKey, lockToken); err != nil {
			s.logger.Warnw("Failed to release room media upload lock", "key", lockKey, "error", err)
		}
	}
	existing, err = s.cachedRoomMediaMessage(ctx, userID, roomID, messageType, clientMsgID)
	if err != nil || existing != nil {
		release()
		return existing, noRelease, err
	}
	return nil, release, nil
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
	memberIDs := make([]string, 0, len(uuids))
	for _, uid := range uuids {
		memberIDs = append(memberIDs, uid.String())
	}
	presenceMap := s.wsServer.GetPresenceService().GetPresenceBatch(memberIDs)
	items := make([]RoomMemberResponse, 0, len(uuids))
	for _, uid := range uuids {
		u, ok := usersMap[uid]
		if !ok || u == nil {
			continue
		}
		member := RoomMemberResponse{
			UserID:     uid.String(),
			Username:   u.Username,
			FullName:   u.FullName,
			Avatar:     u.Avatar,
			Gender:     u.Gender,
			Bio:        u.Bio,
			BioImage:   u.BioImage,
			VipUsed:    u.VipUsed,
			DeviceType: presenceMap[uid.String()].DeviceType,
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

	existing, release, err := s.acquireRoomMediaUpload(ctx, userID, roomID, constants.MessageTypeImage, clientMsgID)
	if err != nil {
		return nil, err
	}
	if existing != nil {
		return existing, nil
	}
	defer release()

	imageUpload, err := s.uploadRoomImage(ctx, userID, roomID, fileHeader)
	if err != nil {
		return nil, err
	}

	sender, _ := s.userCache.GetUserCache(userID, true)
	msgID := uuid.New().String()
	createdAt := time.Now().UTC()
	createdAtStr := createdAt.Format(time.RFC3339)

	stored := storedRoomMessage{
		ID:          msgID,
		RoomID:      roomID.String(),
		SenderID:    userID.String(),
		Type:        constants.MessageTypeImage,
		Content:     "",
		ImageURL:    imageUpload.URL,
		CreatedAt:   createdAtStr,
		ClientMsgID: clientMsgID,
	}
	data, err := json.Marshal(stored)
	if err != nil {
		s.cleanupRoomUpload(imageUpload.ObjectName)
		return nil, err
	}
	persistedID, err := s.redisMsg.AppendIdempotent(ctx, roomID.String(), userID.String(), clientMsgID, msgID, createdAt, data)
	if err != nil {
		s.cleanupRoomUpload(imageUpload.ObjectName)
		return nil, err
	}
	if persistedID != msgID {
		s.cleanupRoomUpload(imageUpload.ObjectName)
		existing, err := s.cachedRoomMediaMessage(ctx, userID, roomID, constants.MessageTypeImage, clientMsgID)
		if err != nil {
			return nil, err
		}
		if existing == nil {
			return nil, errors.New("idempotent room message not found")
		}
		return existing, nil
	}

	msg := toRoomMessageResponse(stored, sender)

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
			ClientMsgID:  msg.ClientMsgID,
		},
	}
	if err := s.producer.PublishRoomMessageCreated(ctx, event); err != nil {
		s.logger.Errorw("Failed to publish room image message created", "room_id", roomID, "message_id", msgID, "error", err)
	}
	return msg, nil
}

func (s *Service) SendAudioMessage(ctx context.Context, userID, roomID uuid.UUID, fileHeader *multipart.FileHeader, duration float64, waveform []float64, replyToID, clientMsgID string) (*RoomMessageResponse, error) {
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

	if err := media.ValidateDuration(duration); err != nil {
		return nil, err
	}
	if duration > constants.MaxRoomAudioDurationSeconds {
		return nil, fmt.Errorf("%w: max %d seconds", media.ErrInvalidAudio, constants.MaxRoomAudioDurationSeconds)
	}
	if err := media.ValidateWaveform(waveform, constants.MaxAudioWaveformSamples); err != nil {
		return nil, err
	}

	existing, release, err := s.acquireRoomMediaUpload(ctx, userID, roomID, constants.MessageTypeAudio, clientMsgID)
	if err != nil {
		return nil, err
	}
	if existing != nil {
		return existing, nil
	}
	defer release()

	audio, err := s.uploadRoomAudio(ctx, userID, roomID, fileHeader, duration)
	if err != nil {
		return nil, err
	}

	sender, _ := s.userCache.GetUserCache(userID, true)
	msgID := uuid.New().String()
	createdAt := time.Now().UTC()
	createdAtStr := createdAt.Format(time.RFC3339)

	replyTo := s.resolveReplySnapshot(ctx, roomID.String(), replyToID)

	stored := storedRoomMessage{
		ID:            msgID,
		RoomID:        roomID.String(),
		SenderID:      userID.String(),
		Type:          constants.MessageTypeAudio,
		AudioURL:      audio.URL,
		AudioDuration: duration,
		AudioWaveform: waveform,
		AudioMimeType: audio.MimeType,
		AudioSize:     audio.Size,
		CreatedAt:     createdAtStr,
		ReplyTo:       replyTo,
		ClientMsgID:   clientMsgID,
	}
	data, err := json.Marshal(stored)
	if err != nil {
		s.cleanupRoomUpload(audio.ObjectName)
		return nil, err
	}
	persistedID, err := s.redisMsg.AppendIdempotent(ctx, roomID.String(), userID.String(), clientMsgID, msgID, createdAt, data)
	if err != nil {
		s.cleanupRoomUpload(audio.ObjectName)
		return nil, err
	}
	if persistedID != msgID {
		s.cleanupRoomUpload(audio.ObjectName)
		existing, err := s.cachedRoomMediaMessage(ctx, userID, roomID, constants.MessageTypeAudio, clientMsgID)
		if err != nil {
			return nil, err
		}
		if existing == nil {
			return nil, errors.New("idempotent room message not found")
		}
		return existing, nil
	}

	msg := toRoomMessageResponse(stored, sender)

	event := &roomEvents.RoomMessageCreatedEvent{
		Room: &roomEvents.RoomBrief{ID: room.ID.String(), Name: room.Name, ImageURL: room.ImageURL},
		Message: &roomEvents.RoomMessageData{
			ID:            msg.ID,
			RoomID:        msg.RoomID,
			SenderID:      msg.SenderID,
			SenderName:    msg.SenderName,
			SenderAvatar:  msg.SenderAvatar,
			SenderGender:  msg.SenderGender,
			SenderVip:     msg.SenderVip,
			SenderVipEnd:  msg.SenderVipEnd,
			Type:          msg.Type,
			Content:       msg.Content,
			AudioURL:      msg.AudioURL,
			AudioDuration: msg.AudioDuration,
			AudioWaveform: msg.AudioWaveform,
			AudioMimeType: msg.AudioMimeType,
			AudioSize:     msg.AudioSize,
			CreatedAt:     msg.CreatedAt,
			ReplyTo:       toEventReplySnapshot(replyTo),
			ClientMsgID:   msg.ClientMsgID,
		},
	}
	if err := s.producer.PublishRoomMessageCreated(ctx, event); err != nil {
		s.logger.Errorw("Failed to publish room audio message created", "room_id", roomID, "message_id", msgID, "error", err)
	}
	return msg, nil
}

type roomAudioUpload struct {
	URL        string
	ObjectName string
	MimeType   string
	Size       int64
}

type roomImageUpload struct {
	URL        string
	ObjectName string
}

func (s *Service) uploadRoomAudio(ctx context.Context, userID, roomID uuid.UUID, fileHeader *multipart.FileHeader, duration float64) (*roomAudioUpload, error) {
	if fileHeader.Size > constants.MaxAudioUploadSize {
		return nil, ErrRoomFileTooLarge
	}

	rateKey := fmt.Sprintf(constants.CacheKeyRateLimitUpload, userID.String())
	if err := s.checkRateLimit(rateKey, constants.RateLimitUploadWindowSeconds, constants.RateLimitUploadMaxRequests); err != nil {
		return nil, ErrRoomUploadRateLimit
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
		return nil, ErrRoomFileTooLarge
	}

	mimeType, err := media.DetectAudioMime(data, fileHeader.Header.Get("Content-Type"))
	if err != nil {
		return nil, err
	}
	if err := media.ValidatePayloadSize(int64(len(data)), duration); err != nil {
		return nil, err
	}
	if err := media.ValidateMeasuredDuration(data, mimeType, duration, constants.MaxRoomAudioDurationSeconds); err != nil {
		return nil, err
	}

	safeName := fmt.Sprintf("audio%s", media.PickAudioExtension(mimeType, fileHeader.Filename))
	folder := fmt.Sprintf("%s/%s", constants.UploadFolderRooms, time.Now().Format(constants.UploadDateLayoutDay))

	upload, err := s.s3.UploadFile(ctx, &roomFileReader{Reader: bytes.NewReader(data), size: int64(len(data))}, safeName, folder)
	if err != nil {
		return nil, fmt.Errorf("failed to upload to storage: %w", err)
	}
	return &roomAudioUpload{
		URL:        upload.URL,
		ObjectName: upload.PublicID,
		MimeType:   mimeType,
		Size:       int64(len(data)),
	}, nil
}

func (s *Service) cleanupRoomUpload(objectName string) {
	if objectName == "" || s.s3 == nil {
		return
	}
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	if err := s.s3.DeleteFile(ctx, objectName); err != nil {
		s.logger.Warnw("Failed to clean up uploaded room media", "object", objectName, "error", err)
	}
}

func (s *Service) uploadRoomImage(ctx context.Context, userID, roomID uuid.UUID, fileHeader *multipart.FileHeader) (*roomImageUpload, error) {
	if fileHeader.Size > constants.MaxImageUploadSize {
		return nil, ErrRoomFileTooLarge
	}

	rateKey := fmt.Sprintf(constants.CacheKeyRateLimitUpload, userID.String())
	if err := s.checkRateLimit(rateKey, constants.RateLimitUploadWindowSeconds, constants.RateLimitUploadMaxRequests); err != nil {
		return nil, ErrRoomUploadRateLimit
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
	if !isAllowedRoomImageMime(detectedMime) {
		return nil, fmt.Errorf("%w: %s", ErrRoomUnsupportedImage, detectedMime)
	}

	rest, err := io.ReadAll(file)
	if err != nil {
		return nil, fmt.Errorf("failed to read file: %w", err)
	}
	fullData := append(head, rest...)
	if int64(len(fullData)) > constants.MaxImageUploadSize {
		return nil, ErrRoomFileTooLarge
	}

	if _, _, err := image.DecodeConfig(bytes.NewReader(fullData)); err != nil {
		return nil, fmt.Errorf("%w: %v", ErrRoomDecodeImage, err)
	}

	ext := pickRoomImageExtension(detectedMime, fileHeader.Filename)
	safeName := fmt.Sprintf("image%s", ext)
	folder := fmt.Sprintf("%s/%s", constants.UploadFolderRooms, time.Now().Format(constants.UploadDateLayoutDay))

	upload, err := s.s3.UploadFile(ctx, &roomFileReader{Reader: bytes.NewReader(fullData), size: int64(len(fullData))}, safeName, folder)
	if err != nil {
		return nil, fmt.Errorf("failed to upload to storage: %w", err)
	}
	return &roomImageUpload{URL: upload.URL, ObjectName: upload.PublicID}, nil
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
		var sender *models.User
		if uid, err := uuid.Parse(m.SenderID); err == nil {
			sender = users[uid]
		}
		items = append(items, *toRoomMessageResponse(m, sender))
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
	actor, _ := s.userCache.GetUserCache(userID, true)
	actorUsername := ""
	if actor != nil {
		actorUsername = actor.Username
	}

	lockKey := fmt.Sprintf(constants.CacheKeyReactionLock, messageID)
	lockToken := uuid.NewString()
	acquired, lockErr := s.cache.SetNX(lockKey, lockToken, time.Duration(constants.ReactionLockTTLSeconds)*time.Second)
	if lockErr != nil {
		s.logger.Warnw("Room reaction lock SetNX failed", "message_id", messageID, "error", lockErr)
	}
	if !acquired {
		time.Sleep(time.Duration(constants.ReactionLockRetryMs) * time.Millisecond)
		acquired, lockErr = s.cache.SetNX(lockKey, lockToken, time.Duration(constants.ReactionLockTTLSeconds)*time.Second)
		if lockErr != nil {
			s.logger.Warnw("Room reaction lock SetNX retry failed", "message_id", messageID, "error", lockErr)
		}
		if !acquired {
			return nil, errors.New("reaction in progress, please retry")
		}
	}
	lockReleased := false
	releaseLock := func() {
		if lockReleased {
			return
		}
		lockReleased = true
		if _, err := s.cache.DeleteIfValue(lockKey, lockToken); err != nil {
			s.logger.Warnw("Failed to release room reaction lock", "message_id", messageID, "error", err)
		}
	}
	defer releaseLock()

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
	releaseLock()

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

	var msgSender *models.User
	if senderUUID, err := uuid.Parse(stored.SenderID); err == nil {
		msgSender, _ = s.userCache.GetUserCache(senderUUID, true)
	}
	return toRoomMessageResponse(stored, msgSender), nil
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

func toRoomMessageResponse(stored storedRoomMessage, sender *models.User) *RoomMessageResponse {
	senderName, senderAvatar, senderGender, senderVip, senderVipEnd := senderFields(sender)
	return &RoomMessageResponse{
		ID:            stored.ID,
		RoomID:        stored.RoomID,
		SenderID:      stored.SenderID,
		SenderName:    senderName,
		SenderAvatar:  senderAvatar,
		SenderGender:  senderGender,
		SenderVip:     senderVip,
		SenderVipEnd:  senderVipEnd,
		Type:          stored.Type,
		Content:       stored.Content,
		ImageURL:      stored.ImageURL,
		AudioURL:      stored.AudioURL,
		AudioDuration: stored.AudioDuration,
		AudioWaveform: stored.AudioWaveform,
		AudioMimeType: stored.AudioMimeType,
		AudioSize:     stored.AudioSize,
		CreatedAt:     stored.CreatedAt,
		ReplyTo:       stored.ReplyTo,
		Reactions:     stored.Reactions,
		ClientMsgID:   stored.ClientMsgID,
	}
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

func (s *Service) ListBlockedUsers(userID uuid.UUID) (*RoomBlockedUsersResponse, error) {
	rows, err := s.blockRepo.ListBlocked(userID)
	if err != nil {
		return nil, err
	}
	return toRoomBlockedUsersResponse(rows), nil
}

func (s *Service) BlockUser(userID, blockedUserID uuid.UUID, migration bool) (*RoomBlockedUsersResponse, error) {
	if userID == blockedUserID {
		return nil, ErrRoomBlockSelf
	}
	exists, err := s.blockRepo.Exists(userID, blockedUserID)
	if err != nil {
		return nil, err
	}
	if exists {
		return s.ListBlockedUsers(userID)
	}
	unblockedKey := fmt.Sprintf(constants.CacheKeyRoomUnblocked, userID.String(), blockedUserID.String())
	if migration {
		if unblocked, err := s.cache.Exists(unblockedKey); err == nil && unblocked {
			return s.ListBlockedUsers(userID)
		}
	}
	if target, err := s.userCache.GetUserCache(blockedUserID, true); err != nil || target == nil {
		return nil, ErrRoomBlockUserNotFound
	}
	count, err := s.blockRepo.CountBlocked(userID)
	if err != nil {
		return nil, err
	}
	if count >= constants.RoomMaxBlockedUsers {
		return nil, ErrRoomBlockLimit
	}
	if err := s.blockRepo.Create(userID, blockedUserID); err != nil {
		return nil, err
	}
	if err := s.cache.Delete(unblockedKey); err != nil {
		s.logger.Warnw("Failed to clear room unblock marker", "user_id", userID, "blocked_user_id", blockedUserID, "error", err.Error())
	}
	s.emitBlockListChanged(userID, blockedUserID, true)
	return s.ListBlockedUsers(userID)
}

func (s *Service) UnblockUser(userID, blockedUserID uuid.UUID) (*RoomBlockedUsersResponse, error) {
	changed, err := s.blockRepo.Delete(userID, blockedUserID)
	if err != nil {
		return nil, err
	}
	if changed {
		unblockedKey := fmt.Sprintf(constants.CacheKeyRoomUnblocked, userID.String(), blockedUserID.String())
		if err := s.cache.Set(unblockedKey, "1", constants.CacheTTLRoomUnblocked*time.Second); err != nil {
			s.logger.Warnw("Failed to set room unblock marker", "user_id", userID, "blocked_user_id", blockedUserID, "error", err.Error())
		}
		s.emitBlockListChanged(userID, blockedUserID, false)
	}
	return s.ListBlockedUsers(userID)
}

func (s *Service) emitBlockListChanged(userID, blockedUserID uuid.UUID, blocked bool) {
	if s.wsServer == nil {
		return
	}
	payload := utils.WrapWebSocketMessage(constants.WebSocketEventRoomBlockListChanged, map[string]interface{}{
		"userId":  blockedUserID.String(),
		"blocked": blocked,
	})
	s.wsServer.EmitToUser(userID.String(), constants.WebSocketMessageEvent, payload)
}

func toRoomBlockedUsersResponse(rows []BlockedUserRow) *RoomBlockedUsersResponse {
	userIDs := make([]string, 0, len(rows))
	users := make([]RoomBlockedUser, 0, len(rows))
	for _, row := range rows {
		id := row.UserID.String()
		userIDs = append(userIDs, id)
		users = append(users, RoomBlockedUser{
			UserID:   id,
			Username: row.Username,
			FullName: row.FullName,
			Avatar:   row.Avatar,
		})
	}
	return &RoomBlockedUsersResponse{UserIDs: userIDs, Users: users}
}
