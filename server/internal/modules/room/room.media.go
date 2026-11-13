package room

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"mime/multipart"
	"time"

	"ola-chat-server/internal/constants"
	roomEvents "ola-chat-server/internal/domain/room"
	"ola-chat-server/internal/media"
	"ola-chat-server/internal/media/mediasend"

	"github.com/google/uuid"
)

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

func (s *Service) mediaSender() mediasend.Helper {
	return mediasend.Helper{Cache: s.cache, S3: s.s3, Logger: s.logger, Label: RoomMediaSendLabel}
}

func (s *Service) acquireRoomMediaUpload(ctx context.Context, userID, roomID uuid.UUID, messageType, clientMsgID string) (*RoomMessageResponse, func(), error) {
	if clientMsgID == "" {
		return nil, func() {}, nil
	}
	lockKey := fmt.Sprintf(CacheKeyRoomMediaUploadLock, roomID.String(), userID.String(), clientMsgID)
	return mediasend.AcquireUpload(s.mediaSender(), lockKey, func() (*RoomMessageResponse, error) {
		return s.cachedRoomMediaMessage(ctx, userID, roomID, messageType, clientMsgID)
	})
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
		s.mediaSender().Cleanup(imageUpload.ObjectName)
		return nil, err
	}
	persistedID, err := s.redisMsg.AppendIdempotent(ctx, roomID.String(), userID.String(), clientMsgID, msgID, createdAt, data)
	if err != nil {
		s.mediaSender().Cleanup(imageUpload.ObjectName)
		return nil, err
	}
	if persistedID != msgID {
		s.mediaSender().Cleanup(imageUpload.ObjectName)
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
	if duration > MaxRoomAudioDurationSeconds {
		return nil, fmt.Errorf("%w: max %d seconds", media.ErrInvalidAudio, MaxRoomAudioDurationSeconds)
	}
	if err := media.ValidateWaveform(waveform, media.MaxAudioWaveformSamples); err != nil {
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
		s.mediaSender().Cleanup(audio.ObjectName)
		return nil, err
	}
	persistedID, err := s.redisMsg.AppendIdempotent(ctx, roomID.String(), userID.String(), clientMsgID, msgID, createdAt, data)
	if err != nil {
		s.mediaSender().Cleanup(audio.ObjectName)
		return nil, err
	}
	if persistedID != msgID {
		s.mediaSender().Cleanup(audio.ObjectName)
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
	if fileHeader.Size > media.MaxAudioUploadSize {
		return nil, ErrRoomFileTooLarge
	}
	if !s.mediaSender().AllowUpload(userID) {
		return nil, ErrRoomUploadRateLimit
	}

	file, err := fileHeader.Open()
	if err != nil {
		return nil, fmt.Errorf("failed to open file: %w", err)
	}
	defer file.Close()

	data, mimeType, err := media.ReadAudio(file, fileHeader.Header.Get("Content-Type"), duration, MaxRoomAudioDurationSeconds)
	if err != nil {
		return nil, err
	}

	safeName := "audio" + media.PickAudioExtension(mimeType, fileHeader.Filename)
	folder := fmt.Sprintf("%s/%s", UploadFolderRooms, time.Now().Format(media.UploadDateLayoutDay))
	upload, err := s.s3.UploadNamedBytes(ctx, data, safeName, folder)
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

func (s *Service) uploadRoomImage(ctx context.Context, userID, roomID uuid.UUID, fileHeader *multipart.FileHeader) (*roomImageUpload, error) {
	if fileHeader.Size > media.MaxImageUploadSize {
		return nil, ErrRoomFileTooLarge
	}
	if !s.mediaSender().AllowUpload(userID) {
		return nil, ErrRoomUploadRateLimit
	}

	file, err := fileHeader.Open()
	if err != nil {
		return nil, fmt.Errorf("failed to open file: %w", err)
	}
	defer file.Close()

	img, err := media.ReadImage(file, media.MaxImageUploadSize)
	if err != nil {
		return nil, err
	}

	safeName := "image" + media.ImageExtensionOrFile(img.Mime, fileHeader.Filename)
	folder := fmt.Sprintf("%s/%s", UploadFolderRooms, time.Now().Format(media.UploadDateLayoutDay))
	upload, err := s.s3.UploadNamedBytes(ctx, img.Data, safeName, folder)
	if err != nil {
		return nil, fmt.Errorf("failed to upload to storage: %w", err)
	}
	return &roomImageUpload{URL: upload.URL, ObjectName: upload.PublicID}, nil
}
