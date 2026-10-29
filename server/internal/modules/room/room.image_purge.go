package room

import (
	"context"
	"fmt"
	"net/http"
	"net/url"
	"path"
	"strings"
	"time"

	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

var (
	ErrRoomImagePurgeDays = utils.NewHTTPError(http.StatusBadRequest,
		fmt.Sprintf("Số ngày phải từ %d đến %d", RoomImagePurgeMinDays, RoomImagePurgeMaxDays))
	ErrRoomImagePurgeTooRecent = utils.NewHTTPError(http.StatusBadRequest,
		fmt.Sprintf("Chỉ xoá được ảnh cũ hơn %d ngày", RoomImagePurgeMinDays))
	ErrRoomImagePurgeRunning = utils.NewHTTPError(http.StatusConflict,
		"Đang xoá ảnh phòng chat, đợi xong rồi thử lại")
)

var roomImageExtensions = map[string]bool{
	".jpg":  true,
	".jpeg": true,
	".png":  true,
	".gif":  true,
	".webp": true,
}

func isRoomImageObject(name string) bool {
	return roomImageExtensions[strings.ToLower(path.Ext(name))]
}

func reportedObjectKeys(rawURLs []string) map[string]struct{} {
	keys := make(map[string]struct{})
	for _, rawURL := range rawURLs {
		parsed, err := url.Parse(rawURL)
		if err != nil {
			continue
		}
		key := strings.TrimLeft(parsed.Path, "/")
		for key != "" {
			keys[key] = struct{}{}
			idx := strings.Index(key, "/")
			if idx < 0 {
				break
			}
			key = key[idx+1:]
		}
	}
	return keys
}

func (s *Service) agedRoomImages(ctx context.Context, before time.Time) ([]services.StoredObject, int, error) {
	urls, err := s.repo.PendingReportImageURLs()
	if err != nil {
		return nil, 0, err
	}
	reported := reportedObjectKeys(urls)
	var aged []services.StoredObject
	kept := 0
	err = s.s3.WalkObjects(ctx, UploadFolderRooms+"/", func(obj services.StoredObject) {
		if !obj.LastModified.Before(before) || !isRoomImageObject(obj.Name) {
			return
		}
		if _, ok := reported[obj.Name]; ok {
			kept++
			return
		}
		aged = append(aged, obj)
	})
	return aged, kept, err
}

func (s *Service) PreviewImagePurge(ctx context.Context, olderThanDays int) (*RoomImagePurgePreview, error) {
	if olderThanDays < RoomImagePurgeMinDays || olderThanDays > RoomImagePurgeMaxDays {
		return nil, ErrRoomImagePurgeDays
	}
	before := time.Now().UTC().AddDate(0, 0, -olderThanDays).Truncate(time.Second)
	aged, kept, err := s.agedRoomImages(ctx, before)
	if err != nil {
		return nil, err
	}
	preview := &RoomImagePurgePreview{OlderThanDays: olderThanDays, Before: before, Files: len(aged), Kept: kept}
	for _, obj := range aged {
		preview.Bytes += obj.Size
	}
	return preview, nil
}

func (s *Service) PurgeImages(ctx context.Context, before time.Time) (*RoomImagePurgeResult, error) {
	if before.IsZero() || before.After(time.Now().UTC().AddDate(0, 0, -RoomImagePurgeMinDays)) {
		return nil, ErrRoomImagePurgeTooRecent
	}
	token := uuid.NewString()
	acquired, err := s.cache.SetNX(CacheKeyRoomImagePurgeLock, token, RoomImagePurgeLockTTL)
	if err != nil {
		return nil, err
	}
	if !acquired {
		return nil, ErrRoomImagePurgeRunning
	}
	defer func() {
		if _, err := s.cache.DeleteIfValue(CacheKeyRoomImagePurgeLock, token); err != nil {
			s.logger.Warnw("Failed to release room image purge lock", "error", err)
		}
	}()

	runCtx, cancel := context.WithTimeout(context.WithoutCancel(ctx), RoomImagePurgeTimeout)
	defer cancel()

	aged, kept, err := s.agedRoomImages(runCtx, before)
	if err != nil {
		return nil, err
	}
	result := &RoomImagePurgeResult{Before: before, Kept: kept}
	purgeErr := s.deleteAged(runCtx, aged, result)
	result.Failed = len(aged) + kept - result.Files - result.Kept
	if purgeErr != nil {
		s.logger.Warnw("Room image purge stopped early", "files", result.Files, "failed", result.Failed, "error", purgeErr)
		if result.Files == 0 {
			return nil, purgeErr
		}
	}
	s.logger.Infow("Room images purged", "before", before, "files", result.Files, "bytes", result.Bytes,
		"failed", result.Failed, "kept", result.Kept)
	return result, nil
}

func (s *Service) deleteAged(ctx context.Context, aged []services.StoredObject, result *RoomImagePurgeResult) error {
	for start := 0; start < len(aged); start += RoomImagePurgeBatch {
		batch := aged[start:min(start+RoomImagePurgeBatch, len(aged))]
		if err := s.repo.WithPendingReportImagesLocked(ctx, func(imageURLs []string) error {
			return s.deleteUnreported(ctx, batch, reportedObjectKeys(imageURLs), result)
		}); err != nil {
			return err
		}
	}
	return nil
}

func (s *Service) deleteUnreported(ctx context.Context, batch []services.StoredObject, reported map[string]struct{}, result *RoomImagePurgeResult) error {
	sizes := make(map[string]int64, len(batch))
	names := make([]string, 0, len(batch))
	for _, obj := range batch {
		if _, ok := reported[obj.Name]; ok {
			result.Kept++
			continue
		}
		sizes[obj.Name] = obj.Size
		names = append(names, obj.Name)
	}
	if len(names) == 0 {
		return nil
	}
	deleted, err := s.s3.DeleteFiles(ctx, names)
	result.Files += len(deleted)
	for _, name := range deleted {
		result.Bytes += sizes[name]
	}
	return err
}
