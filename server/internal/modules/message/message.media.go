package message

import (
	"context"
	"encoding/json"
	"fmt"
	"mime/multipart"
	"path/filepath"
	"strings"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/media"
	"ola-chat-server/internal/media/mediasend"

	"github.com/google/uuid"
)

func (s *Service) mediaSender() mediasend.Helper {
	return mediasend.Helper{Cache: s.redis, S3: s.s3, Logger: s.logger, Label: MediaSendLabel}
}

func (s *Service) acquireMediaUpload(senderID, conversationID uuid.UUID, messageType, clientMsgID string) (*MessageResponse, func(), error) {
	if clientMsgID == "" {
		return nil, func() {}, nil
	}
	lockKey := fmt.Sprintf(CacheKeyMediaUploadLock, senderID.String(), clientMsgID)
	return mediasend.AcquireUpload(s.mediaSender(), lockKey, func() (*MessageResponse, error) {
		return s.cachedIdempotentMessage(senderID, conversationID, messageType, clientMsgID)
	})
}

func (s *Service) SendImageMessage(ctx context.Context, userID, conversationID uuid.UUID, fileHeader *multipart.FileHeader, clientMsgID string) (*MessageResponse, error) {
	if err := s.ensureMessageAccess(userID, conversationID); err != nil {
		return nil, err
	}
	existing, release, err := s.acquireMediaUpload(userID, conversationID, constants.MessageTypeImage, clientMsgID)
	if err != nil {
		return nil, err
	}
	if existing != nil {
		return existing, nil
	}
	defer release()

	meta, objectName, err := s.uploadImageFile(ctx, userID, conversationID, fileHeader)
	if err != nil {
		return nil, err
	}
	metaJSON, err := json.Marshal(meta)
	if err != nil {
		s.mediaSender().Cleanup(objectName)
		return nil, fmt.Errorf("failed to marshal image metadata: %w", err)
	}
	response, err := s.SendMessage(userID, conversationID, constants.MessageTypeImage, "", string(metaJSON), nil, clientMsgID)
	if err != nil {
		s.mediaSender().Cleanup(objectName)
		return nil, err
	}
	if response.Metadata != string(metaJSON) {
		s.mediaSender().Cleanup(objectName)
	}
	return response, nil
}

func (s *Service) uploadImageFile(ctx context.Context, userID, conversationID uuid.UUID, fileHeader *multipart.FileHeader) (*ImageMetadata, string, error) {
	if fileHeader.Size > media.MaxImageUploadSize {
		return nil, "", fmt.Errorf("%w: max %d bytes", ErrFileTooLarge, media.MaxImageUploadSize)
	}
	if !s.mediaSender().AllowUpload(userID) {
		return nil, "", ErrRateLimit
	}

	file, err := fileHeader.Open()
	if err != nil {
		return nil, "", fmt.Errorf("failed to open file: %w", err)
	}
	defer file.Close()

	img, err := media.ReadImage(file, media.MaxImageUploadSize)
	if err != nil {
		return nil, "", err
	}

	safeName := "image" + media.ImageExtensionOrFile(img.Mime, fileHeader.Filename)
	folder := fmt.Sprintf("%s/%s/%s", UploadFolderMessages, conversationID.String(), time.Now().Format(media.UploadDateLayout))
	upload, err := s.s3.UploadNamedBytes(ctx, img.Data, safeName, folder)
	if err != nil {
		return nil, "", fmt.Errorf("failed to upload to storage: %w", err)
	}

	return &ImageMetadata{
		URL:      upload.URL,
		MimeType: img.Mime,
		Size:     int64(len(img.Data)),
		Width:    img.Width,
		Height:   img.Height,
		FileName: filepath.Base(fileHeader.Filename),
	}, upload.PublicID, nil
}

func (s *Service) SendAudioMessage(ctx context.Context, userID, conversationID uuid.UUID, fileHeader *multipart.FileHeader, duration float64, waveform []float64, replyToID *uuid.UUID, clientMsgID string) (*MessageResponse, error) {
	if err := media.ValidateDuration(duration); err != nil {
		return nil, err
	}
	if duration > MaxAudioDurationSeconds {
		return nil, fmt.Errorf("%w: max %d seconds", ErrInvalidMetadata, MaxAudioDurationSeconds)
	}
	if err := media.ValidateWaveform(waveform, maxAudioWaveformSamples); err != nil {
		return nil, err
	}
	if err := s.ensureMessageAccess(userID, conversationID); err != nil {
		return nil, err
	}
	existing, release, err := s.acquireMediaUpload(userID, conversationID, constants.MessageTypeAudio, clientMsgID)
	if err != nil {
		return nil, err
	}
	if existing != nil {
		return existing, nil
	}
	defer release()

	meta, objectName, err := s.uploadAudioFile(ctx, userID, conversationID, fileHeader, duration, waveform)
	if err != nil {
		return nil, err
	}
	metaJSON, err := json.Marshal(meta)
	if err != nil {
		s.mediaSender().Cleanup(objectName)
		return nil, fmt.Errorf("failed to marshal audio metadata: %w", err)
	}
	response, err := s.SendMessage(userID, conversationID, constants.MessageTypeAudio, "", string(metaJSON), replyToID, clientMsgID)
	if err != nil {
		s.mediaSender().Cleanup(objectName)
		return nil, err
	}
	if response.Metadata != string(metaJSON) {
		s.mediaSender().Cleanup(objectName)
	}
	return response, nil
}

func (s *Service) uploadAudioFile(ctx context.Context, userID, conversationID uuid.UUID, fileHeader *multipart.FileHeader, duration float64, waveform []float64) (*AudioMetadata, string, error) {
	if fileHeader.Size > media.MaxAudioUploadSize {
		return nil, "", fmt.Errorf("%w: max %d bytes", ErrFileTooLarge, media.MaxAudioUploadSize)
	}
	if !s.mediaSender().AllowUpload(userID) {
		return nil, "", ErrRateLimit
	}

	file, err := fileHeader.Open()
	if err != nil {
		return nil, "", fmt.Errorf("failed to open file: %w", err)
	}
	defer file.Close()

	data, finalMime, err := media.ReadAudio(file, fileHeader.Header.Get("Content-Type"), duration, MaxAudioDurationSeconds)
	if err != nil {
		return nil, "", err
	}

	safeName := "audio" + media.PickAudioExtension(finalMime, fileHeader.Filename)
	folder := fmt.Sprintf("%s/%s/%s", UploadFolderMessages, conversationID.String(), time.Now().Format(media.UploadDateLayout))
	upload, err := s.s3.UploadNamedBytes(ctx, data, safeName, folder)
	if err != nil {
		return nil, "", fmt.Errorf("failed to upload to storage: %w", err)
	}

	return &AudioMetadata{
		URL:      upload.URL,
		MimeType: finalMime,
		Size:     int64(len(data)),
		Duration: duration,
		Waveform: waveform,
	}, upload.PublicID, nil
}

func validateAudioMetadata(metadata string, isManagedURL func(string) bool) error {
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
	if isManagedURL == nil || !isManagedURL(meta.URL) {
		return fmt.Errorf("%w: audio URL is not managed storage", ErrInvalidMetadata)
	}
	if !media.IsAllowedAudioMime(meta.MimeType) {
		return fmt.Errorf("%w: mimeType %s", ErrInvalidMetadata, meta.MimeType)
	}
	if err := media.ValidateDuration(meta.Duration); err != nil {
		return err
	}
	if meta.Duration > MaxAudioDurationSeconds {
		return fmt.Errorf("%w: invalid duration", ErrInvalidMetadata)
	}
	if err := media.ValidateWaveform(meta.Waveform, maxAudioWaveformSamples); err != nil {
		return err
	}
	return nil
}

func validateImageMetadata(metadata string, isManagedURL func(string) bool) error {
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
	if isManagedURL == nil || !isManagedURL(meta.URL) {
		return fmt.Errorf("%w: image URL is not managed storage", ErrInvalidMetadata)
	}
	if !media.IsAllowedImageMime(meta.MimeType) {
		return fmt.Errorf("%w: mimeType %s", ErrInvalidMetadata, meta.MimeType)
	}
	return nil
}
