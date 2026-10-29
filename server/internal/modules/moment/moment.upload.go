package moment

import (
	"bytes"
	"context"
	"errors"
	"image"
	_ "image/gif"
	_ "image/jpeg"
	_ "image/png"
	"io"
	"mime/multipart"
	"net/http"
	"strings"

	"ola-chat-server/internal/media"
	"ola-chat-server/internal/utils"

	_ "golang.org/x/image/webp"
)

var (
	errImageTooLarge    = utils.NewHTTPError(http.StatusBadRequest, "image too large")
	errImageUnsupported = utils.NewHTTPError(http.StatusBadRequest, "unsupported image type")
	errImageUnreadable  = utils.NewHTTPError(http.StatusBadRequest, "failed to read image")
	errVideoTooLarge    = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "video too large", ErrorCodeMomentVideoTooLarge)
	errVideoInvalid     = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "invalid video", ErrorCodeMomentVideoInvalid)
	errVideoTooLong     = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "video too long", ErrorCodeMomentVideoTooLong)
	errVideoCodec       = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "unsupported video codec", ErrorCodeMomentVideoCodec)
	errVideoNotMP4      = utils.NewHTTPErrorWithCode(http.StatusBadRequest, "only mp4 videos are supported", ErrorCodeMomentVideoNotMP4)
	errUploadFailed     = utils.NewHTTPError(http.StatusBadGateway, "failed to upload moment media")
)

type uploadedMedia struct {
	URL        string
	ObjectName string
	Processing bool
	Width      int
	Height     int
	Duration   float64
	Size       int64
	MimeType   string
}

type uploadTracker struct {
	objects []string
}

func (t *uploadTracker) add(objectName string) {
	t.objects = append(t.objects, objectName)
}

func readUpload(header *multipart.FileHeader, maxSize int64) ([]byte, bool, error) {
	if header.Size > maxSize {
		return nil, true, nil
	}
	file, err := header.Open()
	if err != nil {
		return nil, false, err
	}
	defer file.Close()
	data, err := io.ReadAll(io.LimitReader(file, maxSize+1))
	if err != nil {
		return nil, false, err
	}
	return data, int64(len(data)) > maxSize, nil
}

func (s *Service) uploadImage(
	ctx context.Context,
	folder string,
	header *multipart.FileHeader,
	maxSize int64,
	uploads *uploadTracker,
) (*uploadedMedia, error) {
	data, tooLarge, err := readUpload(header, maxSize)
	if err != nil {
		return nil, errImageUnreadable
	}
	if tooLarge {
		return nil, errImageTooLarge
	}
	mimeType := http.DetectContentType(data)
	if !allowedImageMime(mimeType) {
		return nil, errImageUnsupported
	}
	cfg, _, err := image.DecodeConfig(bytes.NewReader(data))
	if err != nil {
		return nil, errImageUnreadable
	}
	upload, err := s.s3.UploadBytes(ctx, data, folder, imageExtension(mimeType), mimeType)
	if err != nil {
		s.logger.Errorw("Failed to upload moment image", "error", err)
		return nil, errUploadFailed
	}
	uploads.add(upload.PublicID)
	return &uploadedMedia{
		URL:        upload.URL,
		ObjectName: upload.PublicID,
		Width:      cfg.Width,
		Height:     cfg.Height,
		Size:       int64(len(data)),
		MimeType:   mimeType,
	}, nil
}

func (s *Service) uploadVideo(
	ctx context.Context,
	folder string,
	header *multipart.FileHeader,
	uploads *uploadTracker,
) (*uploadedMedia, error) {
	data, tooLarge, err := readUpload(header, MaxMomentVideoUploadSize)
	if err != nil {
		return nil, errVideoInvalid
	}
	if tooLarge {
		return nil, errVideoTooLarge
	}
	if s.processor.Enabled() {
		return s.uploadVideoSource(ctx, folder, data, uploads)
	}
	if !media.IsISOBaseMedia(data) || media.IsQuickTimeMovie(data) {
		return nil, errVideoNotMP4
	}
	info, err := media.ProbeMP4Video(data)
	if err != nil {
		if errors.Is(err, media.ErrNotMP4Video) || errors.Is(err, media.ErrUnknownVideoDuration) {
			return nil, errVideoInvalid
		}
		return nil, err
	}
	if tooLong(info.Duration) {
		return nil, errVideoTooLong
	}
	if !allowedVideoCodec(info.Codec) {
		return nil, errVideoCodec
	}
	upload, err := s.s3.UploadBytes(ctx, data, folder, MomentVideoExtension, MomentVideoContentType)
	if err != nil {
		s.logger.Errorw("Failed to upload moment video", "error", err)
		return nil, errUploadFailed
	}
	uploads.add(upload.PublicID)
	return &uploadedMedia{
		URL:        upload.URL,
		ObjectName: upload.PublicID,
		Width:      info.Width,
		Height:     info.Height,
		Duration:   info.Duration,
		Size:       int64(len(data)),
		MimeType:   MomentVideoContentType,
	}, nil
}

func (s *Service) uploadVideoSource(ctx context.Context, folder string, data []byte, uploads *uploadTracker) (*uploadedMedia, error) {
	info, err := s.processor.ProbeUpload(ctx, data)
	switch {
	case errors.Is(err, errProbeFailed), errors.Is(err, errProbeNoVideo), errors.Is(err, errProbeNoDuration):
		return nil, errVideoInvalid
	case err != nil:
		s.logger.Errorw("Failed to probe moment video", "error", err)
		return nil, err
	case tooLong(info.Duration):
		return nil, errVideoTooLong
	}
	upload, err := s.s3.UploadBytes(ctx, data, folder, MomentVideoSourceExtension, MomentVideoSourceContentType)
	if err != nil {
		s.logger.Errorw("Failed to upload moment video source", "error", err)
		return nil, errUploadFailed
	}
	uploads.add(upload.PublicID)
	return &uploadedMedia{
		URL:        upload.URL,
		ObjectName: upload.PublicID,
		Processing: true,
		Width:      info.Width,
		Height:     info.Height,
		Duration:   info.Duration,
		Size:       int64(len(data)),
		MimeType:   MomentVideoContentType,
	}, nil
}

func tooLong(duration float64) bool {
	return duration > MaxMomentVideoSeconds+MomentVideoDurationTolerance
}

func allowedImageMime(mimeType string) bool {
	for _, allowed := range media.AllowedImageMimes {
		if strings.EqualFold(allowed, mimeType) {
			return true
		}
	}
	return false
}

func allowedVideoCodec(codec string) bool {
	for _, allowed := range AllowedMomentVideoCodecs {
		if allowed == codec {
			return true
		}
	}
	return false
}

func imageExtension(mimeType string) string {
	switch mimeType {
	case "image/png":
		return ".png"
	case "image/gif":
		return ".gif"
	case "image/webp":
		return ".webp"
	default:
		return ".jpg"
	}
}
