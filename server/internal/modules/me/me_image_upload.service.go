package me

import (
	"context"
	"fmt"
	"net/http"
	"net/url"
	"path"
	"strings"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

func (s *Service) CleanupImages(ctx context.Context, userID uuid.UUID, objectNames []string) error {
	cleaned, err := validPostUploadObjectNames(userID, objectNames)
	if err != nil {
		return err
	}
	records := make([]postUploadRecord, 0, len(cleaned))
	for _, objectName := range cleaned {
		record, pending, err := s.pendingPostUpload(userID, objectName)
		if err != nil {
			return err
		}
		if pending {
			records = append(records, record)
		}
	}
	if err := s.ensurePostUploadsUnreferenced(records); err != nil {
		return err
	}

	failed := 0
	for _, record := range records {
		reserved, err := s.cache.DeleteIfValue(postUploadCacheKey(userID, record.ObjectName), record)
		if err != nil {
			s.logger.Warnw("Failed to reserve post image cleanup", "object", record.ObjectName, "error", err)
			failed++
			continue
		}
		if !reserved {
			continue
		}
		if err := s.s3.DeleteFile(ctx, record.ObjectName); err != nil {
			s.logger.Warnw("Failed to clean up post image", "object", record.ObjectName, "error", err)
			s.restorePostUpload(record)
			failed++
			continue
		}
	}
	if failed > 0 {
		return fmt.Errorf("failed to clean up %d post image(s)", failed)
	}
	return nil
}

func postUploadCacheKey(userID uuid.UUID, objectName string) string {
	return fmt.Sprintf(constants.CacheKeyMePostUpload, userID.String(), objectName)
}

type postUploadRecord struct {
	UserID     string `json:"userId"`
	ObjectName string `json:"objectName"`
	URL        string `json:"url"`
}

func newPostUploadRecord(userID uuid.UUID, image UploadedImage) postUploadRecord {
	return postUploadRecord{
		UserID:     userID.String(),
		ObjectName: image.ObjectName,
		URL:        image.URL,
	}
}

func (s *Service) rememberPostUploads(userID uuid.UUID, images []UploadedImage) error {
	ttl := time.Duration(constants.MePostUploadTTLSeconds) * time.Second
	remembered := make([]postUploadRecord, 0, len(images))
	for _, image := range images {
		if image.ObjectName == "" {
			continue
		}
		record := newPostUploadRecord(userID, image)
		if err := s.cache.Set(postUploadCacheKey(userID, record.ObjectName), record, ttl); err != nil {
			s.logger.Warnw("Failed to track uploaded post image", "object", record.ObjectName, "error", err)
			s.forgetPostUpload(record)
			for _, previous := range remembered {
				s.forgetPostUpload(previous)
			}
			return utils.NewHTTPError(http.StatusServiceUnavailable, "post image upload state unavailable")
		}
		remembered = append(remembered, record)
	}
	return nil
}

func (s *Service) pendingPostUpload(userID uuid.UUID, objectName string) (postUploadRecord, bool, error) {
	var record postUploadRecord
	exists, err := s.cache.Exists(postUploadCacheKey(userID, objectName))
	if err != nil {
		s.logger.Warnw("Failed to verify uploaded post image", "object", objectName, "error", err)
		return record, false, utils.NewHTTPError(http.StatusServiceUnavailable, "post image upload state unavailable")
	}
	if !exists {
		return record, false, nil
	}
	if err := s.cache.Get(postUploadCacheKey(userID, objectName), &record); err != nil {
		s.logger.Warnw("Failed to read uploaded post image", "object", objectName, "error", err)
		return record, false, utils.NewHTTPError(http.StatusServiceUnavailable, "post image upload state unavailable")
	}
	if record.UserID != userID.String() || record.ObjectName != objectName || record.URL == "" {
		return postUploadRecord{}, false, errInvalidPostUpload
	}
	return record, true, nil
}

func (s *Service) pendingPostUploads(
	userID uuid.UUID,
	images []MeImageInput,
	knownReferences models.MeImages,
) ([]postUploadRecord, error) {
	prefix := postUploadPrefix(userID)
	records := make([]postUploadRecord, 0, len(images))
	seenRecords := make(map[string]struct{}, len(images))
	unresolvedURLs := make(map[string]struct{}, len(images))
	knownURLs := make(map[string]struct{}, len(knownReferences))
	for _, image := range knownReferences {
		knownURLs[normalizedPostImageURL(image.URL)] = struct{}{}
	}

	for _, image := range images {
		objectName := s.s3.ObjectNameFromURL(image.URL)
		explicitObjectName := strings.TrimSpace(image.ObjectName)
		if explicitObjectName != "" {
			valid, err := validPostUploadObjectNames(userID, []string{explicitObjectName})
			if err != nil || len(valid) != 1 || objectName != explicitObjectName {
				return nil, errInvalidPostUpload
			}
		}
		if objectName == "" || !strings.HasPrefix(objectName, prefix) {
			if explicitObjectName != "" {
				return nil, errInvalidPostUpload
			}
			continue
		}

		record, pending, err := s.pendingPostUpload(userID, objectName)
		if err != nil {
			return nil, err
		}
		if pending {
			if record.URL != image.URL {
				return nil, errInvalidPostUpload
			}
			if _, seen := seenRecords[objectName]; !seen {
				seenRecords[objectName] = struct{}{}
				records = append(records, record)
			}
			continue
		}
		if explicitObjectName != "" {
			return nil, errInvalidPostUpload
		}
		normalizedURL := normalizedPostImageURL(image.URL)
		if _, known := knownURLs[normalizedURL]; !known {
			unresolvedURLs[normalizedURL] = struct{}{}
		}
	}

	if len(unresolvedURLs) > 0 {
		urls := make([]string, 0, len(unresolvedURLs))
		for imageURL := range unresolvedURLs {
			urls = append(urls, imageURL)
		}
		referenced, err := s.repo.ReferencedImageURLs(urls)
		if err != nil {
			return nil, err
		}
		for imageURL := range unresolvedURLs {
			if _, ok := referenced[imageURL]; !ok {
				return nil, errInvalidPostUpload
			}
		}
	}

	return records, nil
}

func normalizedPostImageURL(rawURL string) string {
	parsed, err := url.Parse(rawURL)
	if err != nil {
		return rawURL
	}
	parsed.RawQuery = ""
	parsed.ForceQuery = false
	parsed.Fragment = ""
	parsed.RawFragment = ""
	return parsed.String()
}

func (s *Service) claimPostUploads(records []postUploadRecord) ([]postUploadRecord, error) {
	return claimPostUploadRecords(records, func(record postUploadRecord) (bool, error) {
		userID, err := uuid.Parse(record.UserID)
		if err != nil {
			return false, errInvalidPostUpload
		}
		ok, err := s.cache.DeleteIfValue(
			postUploadCacheKey(userID, record.ObjectName),
			record,
		)
		if err != nil {
			return false, utils.NewHTTPError(http.StatusServiceUnavailable, "post image upload state unavailable")
		}
		return ok, nil
	})
}

func claimPostUploadRecords(
	records []postUploadRecord,
	claim func(postUploadRecord) (bool, error),
) ([]postUploadRecord, error) {
	claimed := make([]postUploadRecord, 0, len(records))
	for _, record := range records {
		ok, err := claim(record)
		if err != nil {
			return claimed, err
		}
		if !ok {
			return claimed, errInvalidPostUpload
		}
		claimed = append(claimed, record)
	}
	return claimed, nil
}

func (s *Service) ensurePostUploadsUnreferenced(records []postUploadRecord) error {
	urls := make([]string, 0, len(records))
	for _, record := range records {
		urls = append(urls, normalizedPostImageURL(record.URL))
	}
	referenced, err := s.repo.ReferencedImageURLs(urls)
	if err != nil {
		return err
	}
	if len(referenced) > 0 {
		return errInvalidImageCleanup
	}
	return nil
}

func (s *Service) restorePostUpload(record postUploadRecord) {
	userID, err := uuid.Parse(record.UserID)
	if err != nil {
		return
	}
	ttl := time.Duration(constants.MePostUploadTTLSeconds) * time.Second
	if err := s.cache.Set(postUploadCacheKey(userID, record.ObjectName), record, ttl); err != nil {
		s.logger.Warnw("Failed to restore post image cleanup state", "object", record.ObjectName, "error", err)
	}
}

func (s *Service) forgetPostUpload(record postUploadRecord) {
	userID, err := uuid.Parse(record.UserID)
	if err != nil {
		return
	}
	if err := s.cache.Delete(postUploadCacheKey(userID, record.ObjectName)); err != nil {
		s.logger.Warnw("Failed to forget uploaded post image", "object", record.ObjectName, "error", err)
	}
}

func postUploadPrefix(userID uuid.UUID) string {
	return fmt.Sprintf("%s/%s/", constants.UploadFolderPosts, userID.String())
}

func validPostUploadObjectNames(userID uuid.UUID, objectNames []string) ([]string, error) {
	if len(objectNames) == 0 || len(objectNames) > constants.MaxPostImages {
		return nil, errInvalidImageCleanup
	}
	prefix := postUploadPrefix(userID)
	seen := make(map[string]struct{}, len(objectNames))
	cleaned := make([]string, 0, len(objectNames))
	for _, raw := range objectNames {
		objectName := strings.TrimSpace(raw)
		if objectName == "" ||
			path.Clean(objectName) != objectName ||
			!strings.HasPrefix(objectName, prefix) {
			return nil, errInvalidImageCleanup
		}
		if _, exists := seen[objectName]; exists {
			continue
		}
		seen[objectName] = struct{}{}
		cleaned = append(cleaned, objectName)
	}
	return cleaned, nil
}

func uploadedObjectNames(images []UploadedImage) []string {
	objectNames := make([]string, 0, len(images))
	for _, image := range images {
		if image.ObjectName == "" {
			continue
		}
		objectNames = append(objectNames, image.ObjectName)
	}
	return objectNames
}

func postUploadObjectNames(records []postUploadRecord) []string {
	objectNames := make([]string, 0, len(records))
	for _, record := range records {
		objectNames = append(objectNames, record.ObjectName)
	}
	return objectNames
}

func (s *Service) deletePostUploadRecordsAsync(records []postUploadRecord) {
	s.deletePostObjectsAsync(postUploadObjectNames(records))
}

func (s *Service) deletePostObjectsAsync(objectNames []string) {
	if len(objectNames) == 0 {
		return
	}
	queued := append([]string(nil), objectNames...)
	go func() {
		for _, objectName := range queued {
			ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
			err := s.s3.DeleteFile(ctx, objectName)
			cancel()
			if err != nil {
				s.logger.Warnw("Failed to delete post image", "object", objectName, "error", err)
			}
		}
	}()
}
