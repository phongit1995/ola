package services

import (
	"context"
	"fmt"
	"mime/multipart"
	"net/url"
	"ola-chat-server/internal/config"
	"path"
	"path/filepath"
	"strings"

	"github.com/google/uuid"
	"github.com/minio/minio-go/v7"
	"github.com/minio/minio-go/v7/pkg/credentials"
	"go.uber.org/zap"
)

type UploadResult struct {
	URL       string `json:"url"`
	PublicID  string `json:"public_id"`
	Width     int    `json:"width"`
	Height    int    `json:"height"`
	Format    string `json:"format"`
	SecureURL string `json:"secure_url"`
}

type S3Service struct {
	client    *minio.Client
	bucket    string
	publicURL string
	logger    *zap.SugaredLogger
}

func NewS3Service(cfg *config.Config, logger *zap.SugaredLogger) (*S3Service, error) {
	client, err := minio.New(cfg.S3Endpoint, &minio.Options{
		Creds:  credentials.NewStaticV4(cfg.S3AccessKey, cfg.S3SecretKey, ""),
		Secure: cfg.S3UseSSL,
	})
	if err != nil {
		return nil, fmt.Errorf("failed to initialize S3 client: %w", err)
	}

	ctx := context.Background()
	exists, err := client.BucketExists(ctx, cfg.S3Bucket)
	if err != nil {
		return nil, fmt.Errorf("failed to check S3 bucket: %w", err)
	}
	if !exists {
		if err := client.MakeBucket(ctx, cfg.S3Bucket, minio.MakeBucketOptions{}); err != nil {
			return nil, fmt.Errorf("failed to create S3 bucket: %w", err)
		}

		policy := fmt.Sprintf(`{
			"Version":"2012-10-17",
			"Statement":[{
				"Effect":"Allow",
				"Principal":{"AWS":["*"]},
				"Action":["s3:GetObject"],
				"Resource":["arn:aws:s3:::%s/*"]
			}]
		}`, cfg.S3Bucket)
		if err := client.SetBucketPolicy(ctx, cfg.S3Bucket, policy); err != nil {
			logger.Warnw("Failed to set bucket public policy", "error", err)
		}
	}

	publicURL := cfg.S3PublicURL
	if publicURL == "" {
		scheme := "http"
		if cfg.S3UseSSL {
			scheme = "https"
		}
		publicURL = fmt.Sprintf("%s://%s", scheme, cfg.S3Endpoint)
	}

	logger.Info("S3 service initialized successfully")

	return &S3Service{
		client:    client,
		bucket:    cfg.S3Bucket,
		publicURL: publicURL,
		logger:    logger.Named("[s3]"),
	}, nil
}

var allowedExts = map[string]string{
	".jpg":  "image/jpeg",
	".jpeg": "image/jpeg",
	".png":  "image/png",
	".gif":  "image/gif",
	".webp": "image/webp",
	".webm": "audio/webm",
	".m4a":  "audio/mp4",
	".mp4":  "audio/mp4",
	".mp3":  "audio/mpeg",
	".wav":  "audio/wav",
	".ogg":  "audio/ogg",
	".aac":  "audio/aac",
}

func (s *S3Service) UploadFile(ctx context.Context, file multipart.File, filename string, folder string) (*UploadResult, error) {
	ext := strings.ToLower(filepath.Ext(filename))
	contentType, ok := allowedExts[ext]
	if !ok {
		return nil, fmt.Errorf("invalid file type: %s", ext)
	}

	objectName := fmt.Sprintf("%s/%s%s", folder, uuid.New().String(), ext)

	fileSize, err := getFileSize(file)
	if err != nil {
		return nil, fmt.Errorf("failed to determine file size: %w", err)
	}

	s.logger.Infow("Uploading file to S3",
		"object", objectName,
		"size", fileSize,
		"content_type", contentType,
	)

	_, err = s.client.PutObject(ctx, s.bucket, objectName, file, fileSize, minio.PutObjectOptions{
		ContentType: contentType,
	})
	if err != nil {
		s.logger.Errorw("Failed to upload to S3", "object", objectName, "error", err)
		return nil, fmt.Errorf("failed to upload file: %w", err)
	}

	url := fmt.Sprintf("%s/%s/%s", s.publicURL, s.bucket, objectName)

	s.logger.Infow("File uploaded successfully", "object", objectName, "url", url)

	return &UploadResult{
		URL:       url,
		SecureURL: url,
		PublicID:  objectName,
		Format:    strings.TrimPrefix(ext, "."),
	}, nil
}

// Callers must only pass object names produced by this service.
func (s *S3Service) DeleteFile(ctx context.Context, objectName string) error {
	objectName = strings.TrimSpace(objectName)
	if objectName == "" || path.IsAbs(objectName) || strings.Contains(objectName, "..") {
		return fmt.Errorf("invalid object name")
	}
	if err := s.client.RemoveObject(ctx, s.bucket, objectName, minio.RemoveObjectOptions{}); err != nil {
		return fmt.Errorf("failed to delete object: %w", err)
	}
	return nil
}

// Media message metadata must never make clients fetch an arbitrary
// third-party URL.
func (s *S3Service) IsManagedURL(rawURL string) bool {
	base, err := url.Parse(strings.TrimRight(s.publicURL, "/") + "/" + s.bucket + "/")
	if err != nil {
		return false
	}
	target, err := url.Parse(rawURL)
	if err != nil || target.User != nil || target.Fragment != "" {
		return false
	}
	if target.Scheme != "http" && target.Scheme != "https" {
		return false
	}
	basePath := strings.TrimRight(base.Path, "/") + "/"
	if path.Clean(target.Path) != target.Path {
		return false
	}
	return strings.EqualFold(target.Scheme, base.Scheme) &&
		strings.EqualFold(target.Host, base.Host) &&
		strings.HasPrefix(target.Path, basePath) &&
		len(target.Path) > len(basePath)
}

func getFileSize(file multipart.File) (int64, error) {
	type sizer interface {
		Seek(offset int64, whence int) (int64, error)
	}
	if s, ok := file.(sizer); ok {
		size, err := s.Seek(0, 2)
		if err != nil {
			return -1, err
		}
		_, err = s.Seek(0, 0)
		if err != nil {
			return -1, err
		}
		return size, nil
	}
	return -1, nil
}
