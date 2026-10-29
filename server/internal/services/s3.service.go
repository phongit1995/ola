package services

import (
	"bytes"
	"context"
	"fmt"
	"mime/multipart"
	"net/url"
	"ola-chat-server/internal/config"
	"path"
	"path/filepath"
	"strings"
	"time"

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

func (s *S3Service) DownloadToFile(ctx context.Context, objectName, filePath string) error {
	if err := s.client.FGetObject(ctx, s.bucket, objectName, filePath, minio.GetObjectOptions{}); err != nil {
		return fmt.Errorf("failed to download object: %w", err)
	}
	return nil
}

func (s *S3Service) UploadBytes(ctx context.Context, data []byte, folder, ext, contentType string) (*UploadResult, error) {
	objectName := fmt.Sprintf("%s/%s%s", folder, uuid.New().String(), ext)
	_, err := s.client.PutObject(ctx, s.bucket, objectName, bytes.NewReader(data), int64(len(data)), minio.PutObjectOptions{
		ContentType: contentType,
	})
	if err != nil {
		s.logger.Errorw("Failed to upload to S3", "object", objectName, "error", err)
		return nil, fmt.Errorf("failed to upload file: %w", err)
	}
	url := fmt.Sprintf("%s/%s/%s", s.publicURL, s.bucket, objectName)
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

func (s *S3Service) ObjectSize(ctx context.Context, objectName string) (int64, bool, error) {
	info, err := s.client.StatObject(ctx, s.bucket, objectName, minio.StatObjectOptions{})
	if err != nil {
		if minio.ToErrorResponse(err).Code == minio.NoSuchKey {
			return 0, false, nil
		}
		return 0, false, fmt.Errorf("failed to stat object: %w", err)
	}
	return info.Size, true, nil
}

type StoredObject struct {
	Name         string
	Size         int64
	LastModified time.Time
}

func (s *S3Service) WalkObjects(ctx context.Context, prefix string, visit func(StoredObject)) error {
	for obj := range s.client.ListObjectsIter(ctx, s.bucket, minio.ListObjectsOptions{Prefix: prefix, Recursive: true}) {
		if obj.Err != nil {
			return fmt.Errorf("failed to list objects: %w", obj.Err)
		}
		visit(StoredObject{Name: obj.Key, Size: obj.Size, LastModified: obj.LastModified})
	}
	return ctx.Err()
}

func (s *S3Service) DeleteFiles(ctx context.Context, objectNames []string) ([]string, error) {
	objects := func(yield func(minio.ObjectInfo) bool) {
		for _, name := range objectNames {
			if name == "" || path.IsAbs(name) || strings.Contains(name, "..") {
				continue
			}
			if !yield(minio.ObjectInfo{Key: name}) {
				return
			}
		}
	}
	results, err := s.client.RemoveObjectsWithIter(ctx, s.bucket, objects, minio.RemoveObjectsOptions{})
	if err != nil {
		return nil, fmt.Errorf("failed to delete objects: %w", err)
	}
	deleted := make([]string, 0, len(objectNames))
	for result := range results {
		if result.Err == nil && result.ObjectName != "" {
			deleted = append(deleted, result.ObjectName)
		}
	}
	return deleted, ctx.Err()
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

// Returns "" when the URL was not produced by this service, so callers can
// never turn a foreign URL into a delete.
func (s *S3Service) ObjectNameFromURL(rawURL string) string {
	if !s.IsManagedURL(rawURL) {
		return ""
	}
	target, err := url.Parse(rawURL)
	if err != nil {
		return ""
	}
	base, err := url.Parse(strings.TrimRight(s.publicURL, "/") + "/" + s.bucket + "/")
	if err != nil {
		return ""
	}
	objectName := strings.TrimPrefix(target.Path, strings.TrimRight(base.Path, "/")+"/")
	if objectName == "" || path.IsAbs(objectName) || path.Clean(objectName) != objectName {
		return ""
	}
	return objectName
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
