package reel

import (
	"context"
	"encoding/base64"
	"errors"
	"fmt"
	"net/http"
	"strconv"
	"strings"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var (
	errReelNotFound  = utils.NewHTTPError(http.StatusNotFound, "reel not found")
	errInvalidFiles  = utils.NewHTTPError(http.StatusBadRequest, "files do not match reel type")
	errInvalidCursor = utils.NewHTTPError(http.StatusBadRequest, "invalid tray cursor")
)

type Service struct {
	repo      *Repository
	store     *RedisStore
	s3        *services.S3Service
	processor *Processor
	logger    *zap.SugaredLogger
	now       func() time.Time
}

func NewService(repo *Repository, store *RedisStore, s3 *services.S3Service, processor *Processor, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:      repo,
		store:     store,
		s3:        s3,
		processor: processor,
		logger:    logger.Named("[reel_service]"),
		now:       func() time.Time { return time.Now().UTC() },
	}
}

func (s *Service) Create(ctx context.Context, userID uuid.UUID, input *CreateReelInput) (*CreateReelsResponse, error) {
	reelType := strings.TrimSpace(input.Type)
	if !validType(reelType) {
		return nil, errInvalidType
	}
	visibility, err := normalizeVisibility(input.Visibility)
	if err != nil {
		return nil, err
	}
	drafts, err := buildDrafts(userID, reelType, visibility, input.Items)
	if err != nil {
		return nil, err
	}
	if err := validateFiles(reelType, input, len(drafts)); err != nil {
		return nil, err
	}

	now := s.now()
	release, err := s.store.ReserveQuota(ctx, userID, len(drafts), now)
	if err != nil {
		var httpErr *utils.HTTPError
		if errors.As(err, &httpErr) {
			return nil, err
		}
		s.logger.Warnw("Failed to reserve reel quota", "user_id", userID, "error", err)
		return nil, errStateUnavailable
	}

	uploads := &uploadTracker{}
	fail := func(err error) (*CreateReelsResponse, error) {
		release()
		s.deleteObjectsAsync(uploads.objects)
		return nil, err
	}

	folder := fmt.Sprintf("%s/%s/%s", constants.UploadFolderReels, userID.String(), now.Format(constants.UploadDateLayout))
	if err := s.attachMedia(ctx, folder, reelType, input, drafts, uploads); err != nil {
		return fail(err)
	}
	for _, draft := range drafts {
		draft.CreatedAt = now
		draft.ExpiresAt = now.Add(constants.ReelLifetime)
	}
	if err := s.repo.CreateBatch(drafts); err != nil {
		s.logger.Errorw("Failed to save reels", "user_id", userID, "error", err)
		return fail(err)
	}
	if drafts[0].Status == constants.ReelStatusProcessing {
		s.processor.Notify()
	}

	author := ReelAuthorResponse{ID: userID.String()}
	if users, err := s.repo.FindUsers([]uuid.UUID{userID}); err == nil && len(users) == 1 {
		author = toAuthorResponse(&users[0])
	}
	resp := &CreateReelsResponse{Reels: make([]ReelResponse, 0, len(drafts))}
	zero := int64(0)
	for _, draft := range drafts {
		item := toReelResponse(draft, author)
		item.ViewerCount = &zero
		resp.Reels = append(resp.Reels, item)
	}
	s.logger.Infow("Reels created", "user_id", userID, "type", reelType, "count", len(drafts))
	return resp, nil
}

func buildDrafts(userID uuid.UUID, reelType, visibility string, items []CreateReelItem) ([]*models.Reel, error) {
	if err := validateItemCount(reelType, len(items)); err != nil {
		return nil, err
	}
	drafts := make([]*models.Reel, 0, len(items))
	for index, item := range items {
		background, err := normalizeBackground(reelType, item.Background)
		if err != nil {
			return nil, err
		}
		overlays, err := normalizeOverlays(item.Overlays)
		if err != nil {
			return nil, err
		}
		if reelType == constants.ReelTypeText && len(overlays) == 0 {
			return nil, errEmptyTextReel
		}
		drafts = append(drafts, &models.Reel{
			AuthorID:   userID,
			Type:       reelType,
			Position:   index,
			Background: background,
			Overlays:   overlays,
			Visibility: visibility,
			Status:     constants.ReelStatusReady,
		})
	}
	return drafts, nil
}

func validateFiles(reelType string, input *CreateReelInput, items int) error {
	hasImages := len(input.Images) > 0 || len(input.Thumbs) > 0
	hasVideo := input.Video != nil || input.Thumb != nil
	switch reelType {
	case constants.ReelTypeText:
		if hasImages || hasVideo {
			return errInvalidFiles
		}
	case constants.ReelTypeImage:
		if hasVideo || len(input.Images) != items || len(input.Thumbs) > items {
			return errInvalidFiles
		}
	case constants.ReelTypeVideo:
		if hasImages || input.Video == nil {
			return errInvalidFiles
		}
	}
	return nil
}

func (s *Service) attachMedia(
	ctx context.Context,
	folder, reelType string,
	input *CreateReelInput,
	drafts []*models.Reel,
	uploads *uploadTracker,
) error {
	switch reelType {
	case constants.ReelTypeImage:
		for index, header := range input.Images {
			image, err := s.uploadImage(ctx, folder, header, constants.MaxImageUploadSize, uploads)
			if err != nil {
				return err
			}
			applyMedia(drafts[index], image)
			if index < len(input.Thumbs) {
				thumb, err := s.uploadImage(ctx, folder, input.Thumbs[index], constants.MaxReelThumbUploadSize, uploads)
				if err != nil {
					return err
				}
				applyThumb(drafts[index], thumb)
			} else {
				drafts[index].ThumbURL = image.URL
			}
		}
	case constants.ReelTypeVideo:
		video, err := s.uploadVideo(ctx, folder, input.Video, uploads)
		if err != nil {
			return err
		}
		applyMedia(drafts[0], video)
		if input.Thumb != nil {
			thumb, err := s.uploadImage(ctx, folder, input.Thumb, constants.MaxReelThumbUploadSize, uploads)
			if err != nil {
				return err
			}
			applyThumb(drafts[0], thumb)
		}
	}
	return nil
}

func applyMedia(reel *models.Reel, media *uploadedMedia) {
	if media.Processing {
		reel.Status = constants.ReelStatusProcessing
		reel.SourceObject = media.ObjectName
	}
	reel.MediaURL = media.URL
	reel.MediaObject = media.ObjectName
	reel.Width = media.Width
	reel.Height = media.Height
	reel.Duration = media.Duration
	reel.Size = media.Size
	reel.MimeType = media.MimeType
}

func applyThumb(reel *models.Reel, thumb *uploadedMedia) {
	reel.ThumbURL = thumb.URL
	reel.ThumbObject = thumb.ObjectName
}

func (s *Service) Tray(ctx context.Context, viewerID uuid.UUID, rawCursor string) (*ReelTrayResponse, error) {
	after, err := decodeTrayCursor(rawCursor)
	if err != nil {
		return nil, errInvalidCursor
	}
	now := s.now()
	seen, err := s.store.SeenIDs(ctx, viewerID, now)
	if err != nil {
		s.logger.Warnw("Failed to read seen reels", "viewer_id", viewerID, "error", err)
		seen = nil
	}
	resp := &ReelTrayResponse{Mine: []ReelResponse{}, Groups: []ReelGroupResponse{}}
	if after == nil {
		if resp.Mine, err = s.mineResponses(ctx, viewerID, now); err != nil {
			return nil, err
		}
	}

	rows, err := s.repo.TrayPage(viewerID, now, seen, after, constants.ReelTrayPageSize+1)
	if err != nil {
		return nil, err
	}
	groups, next := groupTrayRows(rows, constants.ReelTrayPageSize)
	ids := make([]uuid.UUID, 0, len(rows))
	for _, group := range groups {
		ids = append(ids, group.reelIDs...)
	}
	reels, err := s.repo.FindWithAuthors(ids)
	if err != nil {
		return nil, err
	}
	for _, group := range groups {
		items := make([]ReelResponse, 0, len(group.reelIDs))
		for _, id := range group.reelIDs {
			if reel, ok := reels[id]; ok {
				items = append(items, toReelResponse(reel, authorOf(reel)))
			}
		}
		if len(items) > 0 {
			resp.Groups = append(resp.Groups, ReelGroupResponse{Author: items[0].Author, Reels: items})
		}
	}
	if next != nil {
		resp.NextCursor = encodeTrayCursor(next)
	}
	return resp, nil
}

func (s *Service) Mine(ctx context.Context, viewerID uuid.UUID) (*MyReelsResponse, error) {
	reels, err := s.mineResponses(ctx, viewerID, s.now())
	if err != nil {
		return nil, err
	}
	return &MyReelsResponse{Reels: reels}, nil
}

func (s *Service) mineResponses(ctx context.Context, viewerID uuid.UUID, now time.Time) ([]ReelResponse, error) {
	mine, err := s.repo.ListMine(viewerID, now)
	if err != nil {
		return nil, err
	}
	counts, err := s.store.ViewerCounts(ctx, mine)
	if err != nil {
		s.logger.Warnw("Failed to count reel viewers", "viewer_id", viewerID, "error", err)
		counts = map[uuid.UUID]int64{}
	}
	items := make([]ReelResponse, 0, len(mine))
	for _, reel := range mine {
		item := toReelResponse(reel, authorOf(reel))
		count := counts[reel.ID]
		item.ViewerCount = &count
		items = append(items, item)
	}
	return items, nil
}

type trayGroup struct {
	authorID uuid.UUID
	latest   time.Time
	reelIDs  []uuid.UUID
}

func groupTrayRows(rows []trayPageRow, limit int) ([]trayGroup, *trayCursor) {
	groups := make([]trayGroup, 0, limit+1)
	for _, row := range rows {
		if n := len(groups); n == 0 || groups[n-1].authorID != row.AuthorID {
			groups = append(groups, trayGroup{authorID: row.AuthorID, latest: row.Latest})
		}
		last := &groups[len(groups)-1]
		last.reelIDs = append(last.reelIDs, row.ID)
	}
	if len(groups) <= limit {
		return groups, nil
	}
	groups = groups[:limit]
	last := groups[limit-1]
	return groups, &trayCursor{Latest: last.latest, AuthorID: last.authorID}
}

func encodeTrayCursor(cursor *trayCursor) string {
	raw := strconv.FormatInt(cursor.Latest.UnixMicro(), 10) + "_" + cursor.AuthorID.String()
	return base64.RawURLEncoding.EncodeToString([]byte(raw))
}

func decodeTrayCursor(value string) (*trayCursor, error) {
	value = strings.TrimSpace(value)
	if value == "" {
		return nil, nil
	}
	raw, err := base64.RawURLEncoding.DecodeString(value)
	if err != nil {
		return nil, err
	}
	micros, author, ok := strings.Cut(string(raw), "_")
	if !ok {
		return nil, errInvalidCursor
	}
	at, err := strconv.ParseInt(micros, 10, 64)
	if err != nil {
		return nil, err
	}
	authorID, err := uuid.Parse(author)
	if err != nil {
		return nil, err
	}
	return &trayCursor{Latest: time.UnixMicro(at).UTC(), AuthorID: authorID}, nil
}

func (s *Service) MarkSeen(ctx context.Context, viewerID uuid.UUID, rawIDs []string) (*MarkSeenResponse, error) {
	ids := uniqueIDs(rawIDs)
	resp := &MarkSeenResponse{IDs: []string{}}
	if len(ids) == 0 {
		return resp, nil
	}
	now := s.now()
	reels, err := s.repo.FindSeenable(viewerID, now, ids)
	if err != nil {
		return nil, err
	}
	if len(reels) == 0 {
		return resp, nil
	}
	if err := s.store.MarkSeen(ctx, viewerID, reels, now); err != nil {
		s.logger.Warnw("Failed to mark reels seen", "viewer_id", viewerID, "error", err)
		return nil, errStateUnavailable
	}
	for _, reel := range reels {
		resp.IDs = append(resp.IDs, reel.ID.String())
	}
	return resp, nil
}

func uniqueIDs(raw []string) []uuid.UUID {
	seen := make(map[uuid.UUID]bool, len(raw))
	ids := make([]uuid.UUID, 0, len(raw))
	for _, value := range raw {
		id, err := uuid.Parse(strings.TrimSpace(value))
		if err != nil || seen[id] {
			continue
		}
		seen[id] = true
		ids = append(ids, id)
		if len(ids) == constants.MaxReelSeenBatch {
			break
		}
	}
	return ids
}

func (s *Service) Viewers(ctx context.Context, userID, reelID uuid.UUID, limit, offset int) (*ReelViewersResponse, error) {
	if _, err := s.ownedReel(userID, reelID); err != nil {
		return nil, err
	}
	return s.ViewersOf(ctx, reelID, limit, offset)
}

func (s *Service) ViewersOf(ctx context.Context, reelID uuid.UUID, limit, offset int) (*ReelViewersResponse, error) {
	page, total, err := s.store.ViewerPage(ctx, reelID, offset, limit)
	if err != nil {
		s.logger.Warnw("Failed to read reel viewers", "reel_id", reelID, "error", err)
		return nil, errStateUnavailable
	}
	ids := make([]uuid.UUID, 0, len(page))
	for _, entry := range page {
		if member, ok := entry.Member.(string); ok {
			if id, err := uuid.Parse(member); err == nil {
				ids = append(ids, id)
			}
		}
	}
	users, err := s.repo.FindUsers(ids)
	if err != nil {
		return nil, err
	}
	byID := make(map[uuid.UUID]*models.User, len(users))
	for i := range users {
		byID[users[i].ID] = &users[i]
	}
	resp := &ReelViewersResponse{
		Items:      make([]ReelViewerResponse, 0, len(page)),
		Total:      total,
		Limit:      limit,
		Offset:     offset,
		NextOffset: nextViewerOffset(offset, len(page), total),
	}
	for _, entry := range page {
		member, _ := entry.Member.(string)
		id, err := uuid.Parse(member)
		if err != nil {
			continue
		}
		user, ok := byID[id]
		if !ok {
			continue
		}
		resp.Items = append(resp.Items, ReelViewerResponse{
			User:     toAuthorResponse(user),
			ViewedAt: time.UnixMilli(int64(entry.Score)).UTC().Format(time.RFC3339),
		})
	}
	return resp, nil
}

func nextViewerOffset(offset, fetched int, total int64) *int {
	next := offset + fetched
	if fetched == 0 || int64(next) >= total {
		return nil
	}
	return &next
}

func (s *Service) Delete(userID, reelID uuid.UUID) error {
	if _, err := s.ownedReel(userID, reelID); err != nil {
		return err
	}
	return s.repo.SoftDelete(reelID)
}

func (s *Service) ownedReel(userID, reelID uuid.UUID) (*models.Reel, error) {
	reel, err := s.repo.FindActive(reelID, s.now())
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errReelNotFound
		}
		return nil, err
	}
	if reel.AuthorID != userID {
		return nil, errReelNotFound
	}
	return reel, nil
}

func (s *Service) deleteObjectsAsync(objectNames []string) {
	if len(objectNames) == 0 {
		return
	}
	queued := append([]string(nil), objectNames...)
	utils.SafeGo(s.logger, func() {
		for _, objectName := range queued {
			ctx, cancel := context.WithTimeout(context.Background(), constants.ReelObjectDeleteTimeout)
			err := s.s3.DeleteFile(ctx, objectName)
			cancel()
			if err != nil {
				s.logger.Warnw("Failed to delete reel object", "object", objectName, "error", err)
			}
		}
	})
}

func authorOf(reel *models.Reel) ReelAuthorResponse {
	if reel.Author == nil {
		return ReelAuthorResponse{ID: reel.AuthorID.String()}
	}
	return toAuthorResponse(reel.Author)
}

func toAuthorResponse(user *models.User) ReelAuthorResponse {
	return ReelAuthorResponse{
		ID:       user.ID.String(),
		Username: user.Username,
		FullName: user.FullName,
		Avatar:   user.Avatar,
	}
}

func toReelResponse(reel *models.Reel, author ReelAuthorResponse) ReelResponse {
	overlays := []models.ReelOverlay(reel.Overlays)
	if overlays == nil {
		overlays = []models.ReelOverlay{}
	}
	mediaURL := reel.MediaURL
	if reel.Status != constants.ReelStatusReady {
		mediaURL = ""
	}
	return ReelResponse{
		ID:         reel.ID.String(),
		Author:     author,
		Type:       reel.Type,
		Status:     reel.Status,
		Position:   reel.Position,
		Background: reel.Background,
		Overlays:   overlays,
		MediaURL:   mediaURL,
		ThumbURL:   reel.ThumbURL,
		Width:      reel.Width,
		Height:     reel.Height,
		Duration:   reel.Duration,
		Visibility: reel.Visibility,
		CreatedAt:  reel.CreatedAt.UTC().Format(time.RFC3339),
		ExpiresAt:  reel.ExpiresAt.UTC().Format(time.RFC3339),
	}
}
