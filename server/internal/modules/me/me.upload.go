package me

import (
	"context"
	"errors"
	"mime/multipart"
	"net/http"
	"time"

	"ola-chat-server/internal/media"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

func (s *Service) UploadImages(ctx context.Context, userID uuid.UUID, files []*multipart.FileHeader) (*UploadImagesResponse, error) {
	if len(files) == 0 {
		return nil, errors.New("no images provided")
	}
	if len(files) > MaxPostImages {
		return nil, errors.New("max 5 images")
	}

	folder := postUploadPrefix(userID) + time.Now().Format(media.UploadDateLayout)
	images := make([]UploadedImage, 0, len(files))
	for _, fileHeader := range files {
		img, err := s.uploadImage(ctx, folder, fileHeader)
		if err != nil {
			s.deletePostObjectsAsync(uploadedObjectNames(uploadedImageRefs(images)))
			return nil, err
		}
		images = append(images, *img)
	}
	if err := s.rememberPostUploads(userID, uploadedImageRefs(images)); err != nil {
		s.deletePostObjectsAsync(uploadedObjectNames(uploadedImageRefs(images)))
		return nil, err
	}
	return &UploadImagesResponse{Images: images}, nil
}

func (s *Service) UploadAudio(
	ctx context.Context,
	userID uuid.UUID,
	fileHeader *multipart.FileHeader,
	duration float64,
	waveform []float64,
) (*UploadAudioResponse, error) {
	if fileHeader == nil {
		return nil, errors.New("no audio provided")
	}
	if err := media.ValidateDuration(duration); err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid duration")
	}
	if duration > MaxPostAudioDurationSeconds {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "audio too long")
	}
	if err := media.ValidateWaveform(waveform, media.MaxAudioWaveformSamples); err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid waveform")
	}
	if fileHeader.Size > media.MaxAudioUploadSize {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "audio too large")
	}

	file, err := fileHeader.Open()
	if err != nil {
		return nil, errors.New("failed to open audio")
	}
	defer file.Close()

	data, mimeType, err := media.ReadAudio(file, fileHeader.Header.Get("Content-Type"), duration, MaxPostAudioDurationSeconds)
	switch {
	case errors.Is(err, media.ErrFileTooLarge):
		return nil, utils.NewHTTPError(http.StatusBadRequest, "audio too large")
	case errors.Is(err, media.ErrUnsupportedAudio):
		return nil, utils.NewHTTPError(http.StatusBadRequest, "unsupported audio type")
	case errors.Is(err, media.ErrInvalidAudio):
		return nil, utils.NewHTTPError(http.StatusBadRequest, err.Error())
	case err != nil:
		return nil, errors.New("failed to read audio")
	}

	folder := postUploadPrefix(userID) + time.Now().Format(media.UploadDateLayout)
	safeName := "audio" + media.PickAudioExtension(mimeType, fileHeader.Filename)
	upload, err := s.s3.UploadNamedBytes(ctx, data, safeName, folder)
	if err != nil {
		s.logger.Errorw("Failed to upload post audio", "error", err)
		return nil, errors.New("failed to upload audio")
	}

	audio := UploadedAudio{
		URL:        upload.URL,
		ObjectName: upload.PublicID,
		MimeType:   mimeType,
		Size:       int64(len(data)),
		Duration:   duration,
		Waveform:   waveform,
	}
	if err := s.rememberPostUploads(userID, []postUploadRef{{URL: audio.URL, ObjectName: audio.ObjectName}}); err != nil {
		s.deletePostObjectsAsync([]string{audio.ObjectName})
		return nil, err
	}
	return &UploadAudioResponse{Audio: audio}, nil
}

func (s *Service) uploadImage(ctx context.Context, folder string, fileHeader *multipart.FileHeader) (*UploadedImage, error) {
	if fileHeader.Size > media.MaxImageUploadSize {
		return nil, media.ErrImageTooLarge
	}

	file, err := fileHeader.Open()
	if err != nil {
		return nil, media.ErrOpenImage
	}
	defer file.Close()

	img, err := media.ReadImage(file, media.MaxImageUploadSize)
	if err != nil {
		return nil, media.PlainImageError(err)
	}

	upload, err := s.s3.UploadNamedBytes(ctx, img.Data, "image"+media.ImageExtension(img.Mime), folder)
	if err != nil {
		s.logger.Errorw("Failed to upload post image", "error", err)
		return nil, errors.New("failed to upload image")
	}

	return &UploadedImage{
		URL:        upload.URL,
		ObjectName: upload.PublicID,
		Width:      img.Width,
		Height:     img.Height,
		MimeType:   img.Mime,
	}, nil
}
