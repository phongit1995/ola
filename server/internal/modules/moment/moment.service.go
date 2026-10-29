package moment

import (
	"context"
	"encoding/base64"
	"errors"
	"fmt"
	"net/http"
	"slices"
	"strconv"
	"strings"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
	userModule "ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"github.com/redis/go-redis/v9"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var (
	errMomentNotFound   = utils.NewHTTPError(http.StatusNotFound, "moment not found")
	errInvalidFiles     = utils.NewHTTPError(http.StatusBadRequest, "files do not match moment type")
	errInvalidCursor    = utils.NewHTTPError(http.StatusBadRequest, "invalid tray cursor")
	errHiddenByAdmin    = utils.NewHTTPErrorWithCode(http.StatusForbidden, "moment hidden by admin", ErrorCodeMomentHiddenByAdmin)
	errMediaPurgeFailed = utils.NewHTTPError(http.StatusBadGateway, "failed to delete moment media")
)

type Service struct {
	repo      *Repository
	store     *RedisStore
	s3        *services.S3Service
	processor *Processor
	settings  momentVideoSettings
	users     momentVipUsers
	notifier  Notifier
	logger    *zap.SugaredLogger
	now       func() time.Time
}

type Notifier interface {
	MomentCommented(ownerID, actorID, momentID uuid.UUID, content string)
	MomentReacted(ownerID, actorID, momentID uuid.UUID, reaction string)
	MomentDeleted(momentID uuid.UUID)
}

func NewService(repo *Repository, store *RedisStore, s3 *services.S3Service, processor *Processor, settings *setting.Service, users *userModule.CacheService, notifier Notifier, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:      repo,
		store:     store,
		s3:        s3,
		processor: processor,
		settings:  settings,
		users:     users,
		notifier:  notifier,
		logger:    logger.Named("[moment_service]"),
		now:       func() time.Time { return time.Now().UTC() },
	}
}

func (s *Service) Create(ctx context.Context, userID uuid.UUID, input *CreateMomentInput) (*CreateMomentsResponse, error) {
	momentType := strings.TrimSpace(input.Type)
	if !validType(momentType) {
		return nil, errInvalidType
	}
	if momentType == MomentTypeVideo {
		if err := checkVideoAllowed(s.settings, s.users, userID, s.now(), s.logger); err != nil {
			return nil, err
		}
	}
	visibility, err := normalizeVisibility(input.Visibility)
	if err != nil {
		return nil, err
	}
	drafts, err := buildDrafts(userID, momentType, visibility, input.Items)
	if err != nil {
		return nil, err
	}
	if err := validateFiles(momentType, input, drafts); err != nil {
		return nil, err
	}

	now := s.now()
	release, err := s.store.ReserveQuota(ctx, userID, len(drafts), now)
	if err != nil {
		var httpErr *utils.HTTPError
		if errors.As(err, &httpErr) {
			return nil, err
		}
		s.logger.Warnw("Failed to reserve moment quota", "user_id", userID, "error", err)
		return nil, errStateUnavailable
	}

	uploads := &uploadTracker{}
	fail := func(err error) (*CreateMomentsResponse, error) {
		release()
		s.deleteObjectsAsync(uploads.objects)
		return nil, err
	}

	if err := s.attachMedia(ctx, uploadFolder(momentType, now), momentType, input, drafts, uploads); err != nil {
		return fail(err)
	}
	for _, draft := range drafts {
		draft.CreatedAt = now
		draft.ExpiresAt = now.Add(MomentLifetime)
	}
	if err := s.repo.CreateBatch(drafts); err != nil {
		s.logger.Errorw("Failed to save moments", "user_id", userID, "error", err)
		return fail(err)
	}
	if drafts[0].Status == MomentStatusProcessing {
		s.processor.Notify()
	}

	author := MomentAuthorResponse{ID: userID.String()}
	if users, err := s.repo.FindUsers([]uuid.UUID{userID}); err == nil && len(users) == 1 {
		author = toAuthorResponse(&users[0])
	}
	resp := &CreateMomentsResponse{Moments: make([]MomentResponse, 0, len(drafts))}
	zero := int64(0)
	for _, draft := range drafts {
		item := toMomentResponse(draft, author)
		item.ViewerCount = &zero
		resp.Moments = append(resp.Moments, item)
	}
	s.logger.Infow("Moments created", "user_id", userID, "type", momentType, "count", len(drafts))
	return resp, nil
}

func localDay(now time.Time) time.Time {
	return now.UTC().Add(MomentDayUTCOffset)
}

func uploadFolder(momentType string, now time.Time) string {
	kind := MomentUploadImagesFolder
	if momentType == MomentTypeVideo {
		kind = MomentUploadVideosFolder
	}
	return fmt.Sprintf("%s/%s/%s", UploadFolderMoments, localDay(now).Format(constants.UploadDateLayoutDay), kind)
}

func buildDrafts(userID uuid.UUID, momentType, visibility string, items []CreateMomentItem) ([]*models.Moment, error) {
	if err := validateItemCount(momentType, len(items)); err != nil {
		return nil, err
	}
	drafts := make([]*models.Moment, 0, len(items))
	for index, item := range items {
		itemType, err := slideType(momentType, item.Type)
		if err != nil {
			return nil, err
		}
		background, err := normalizeBackground(itemType, item.Background)
		if err != nil {
			return nil, err
		}
		overlays, err := normalizeOverlays(item.Overlays)
		if err != nil {
			return nil, err
		}
		if itemType == MomentTypeText && len(overlays) == 0 {
			return nil, errEmptyTextMoment
		}
		drafts = append(drafts, &models.Moment{
			AuthorID:   userID,
			Type:       itemType,
			Position:   index,
			Background: background,
			Overlays:   overlays,
			Visibility: visibility,
			Status:     MomentStatusReady,
		})
	}
	return drafts, nil
}

func validateFiles(momentType string, input *CreateMomentInput, drafts []*models.Moment) error {
	if momentType == MomentTypeVideo {
		if len(input.Images) > 0 || len(input.Thumbs) > 0 || input.Video == nil {
			return errInvalidFiles
		}
		return nil
	}
	images := len(imageDrafts(drafts))
	if input.Video != nil || input.Thumb != nil || len(input.Images) != images || len(input.Thumbs) > images {
		return errInvalidFiles
	}
	return nil
}

func imageDrafts(drafts []*models.Moment) []*models.Moment {
	images := make([]*models.Moment, 0, len(drafts))
	for _, draft := range drafts {
		if draft.Type == MomentTypeImage {
			images = append(images, draft)
		}
	}
	return images
}

func (s *Service) attachMedia(
	ctx context.Context,
	folder, momentType string,
	input *CreateMomentInput,
	drafts []*models.Moment,
	uploads *uploadTracker,
) error {
	switch momentType {
	case MomentTypeText, MomentTypeImage:
		for index, draft := range imageDrafts(drafts) {
			image, err := s.uploadImage(ctx, folder, input.Images[index], constants.MaxImageUploadSize, uploads)
			if err != nil {
				return err
			}
			applyMedia(draft, image)
			if index < len(input.Thumbs) {
				thumb, err := s.uploadImage(ctx, folder, input.Thumbs[index], MaxMomentThumbUploadSize, uploads)
				if err != nil {
					return err
				}
				applyThumb(draft, thumb)
			} else {
				draft.ThumbURL = image.URL
			}
		}
	case MomentTypeVideo:
		video, err := s.uploadVideo(ctx, folder, input.Video, uploads)
		if err != nil {
			return err
		}
		applyMedia(drafts[0], video)
		if input.Thumb != nil {
			thumb, err := s.uploadImage(ctx, folder, input.Thumb, MaxMomentThumbUploadSize, uploads)
			if err != nil {
				return err
			}
			applyThumb(drafts[0], thumb)
		}
	}
	return nil
}

func applyMedia(moment *models.Moment, media *uploadedMedia) {
	if media.Processing {
		moment.Status = MomentStatusProcessing
		moment.SourceObject = media.ObjectName
	}
	moment.MediaURL = media.URL
	moment.MediaObject = media.ObjectName
	moment.Width = media.Width
	moment.Height = media.Height
	moment.Duration = media.Duration
	moment.Size = media.Size
	moment.MimeType = media.MimeType
}

func applyThumb(moment *models.Moment, thumb *uploadedMedia) {
	moment.ThumbURL = thumb.URL
	moment.ThumbObject = thumb.ObjectName
}

func (s *Service) Tray(ctx context.Context, viewerID uuid.UUID, rawCursor string) (*MomentTrayResponse, error) {
	after, err := decodeTrayCursor(rawCursor)
	if err != nil {
		return nil, errInvalidCursor
	}
	now := s.now()
	seen, err := s.store.SeenIDs(ctx, viewerID, now)
	if err != nil {
		s.logger.Warnw("Failed to read seen moments", "viewer_id", viewerID, "error", err)
		seen = nil
	}
	resp := &MomentTrayResponse{Mine: []MomentResponse{}, Groups: []MomentGroupResponse{}}
	if after == nil {
		if resp.Mine, err = s.mineResponses(ctx, viewerID, now); err != nil {
			return nil, err
		}
	}

	rows, err := s.repo.TrayPage(viewerID, now, seen, after, MomentTrayPageSize+1)
	if err != nil {
		return nil, err
	}
	groups, next := groupTrayRows(rows, MomentTrayPageSize)
	ids := make([]uuid.UUID, 0, len(rows))
	for _, group := range groups {
		ids = append(ids, group.momentIDs...)
	}
	seenByViewer := make(map[uuid.UUID]bool, len(rows))
	for _, row := range rows {
		if row.Seen {
			seenByViewer[row.ID] = true
		}
	}
	moments, err := s.repo.FindWithAuthors(ids)
	if err != nil {
		return nil, err
	}
	myComments := s.myComments(viewerID, ids)
	for _, group := range groups {
		items := make([]MomentResponse, 0, len(group.momentIDs))
		for _, id := range group.momentIDs {
			if moment, ok := moments[id]; ok {
				item := toMomentResponse(moment, authorOf(moment))
				item.Seen = seenByViewer[id]
				item.MyComment = myComments[id]
				items = append(items, item)
			}
		}
		if len(items) > 0 {
			resp.Groups = append(resp.Groups, MomentGroupResponse{Author: items[0].Author, Moments: items})
		}
	}
	if next != nil {
		resp.NextCursor = encodeTrayCursor(next)
	}
	return resp, nil
}

func (s *Service) Mine(ctx context.Context, viewerID uuid.UUID) (*MyMomentsResponse, error) {
	moments, err := s.mineResponses(ctx, viewerID, s.now())
	if err != nil {
		return nil, err
	}
	return &MyMomentsResponse{Moments: moments}, nil
}

func (s *Service) mineResponses(ctx context.Context, viewerID uuid.UUID, now time.Time) ([]MomentResponse, error) {
	mine, err := s.repo.ListMine(viewerID, now)
	if err != nil {
		return nil, err
	}
	return s.withOwnerStats(ctx, viewerID, mine), nil
}

func (s *Service) withOwnerStats(ctx context.Context, viewerID uuid.UUID, mine []*models.Moment) []MomentResponse {
	counts, err := s.store.ViewerCounts(ctx, mine)
	if err != nil {
		s.logger.Warnw("Failed to count moment viewers", "viewer_id", viewerID, "error", err)
		counts = map[uuid.UUID]int64{}
	}
	reactions := s.ReactionSummaries(ctx, mine)
	items := make([]MomentResponse, 0, len(mine))
	for _, moment := range mine {
		item := toMomentResponse(moment, authorOf(moment))
		count := max(counts[moment.ID], moment.ViewerCount)
		item.ViewerCount = &count
		item.Reactions = reactions[moment.ID]
		reactionCount := ReactionTotal(item.Reactions)
		item.ReactionCount = &reactionCount
		commentCount := moment.CommentCount
		item.CommentCount = &commentCount
		items = append(items, item)
	}
	return items
}

func (s *Service) History(ctx context.Context, viewerID uuid.UUID, limit, offset int) (*MomentHistoryResponse, error) {
	moments, err := s.repo.ListHistory(viewerID, limit+1, offset)
	if err != nil {
		return nil, err
	}
	resp := &MomentHistoryResponse{}
	if len(moments) > limit {
		moments = moments[:limit]
		next := offset + limit
		resp.NextOffset = &next
	}
	resp.Moments = s.withOwnerStats(ctx, viewerID, moments)
	return resp, nil
}

func (s *Service) SetHidden(ctx context.Context, userID, momentID uuid.UUID, hidden bool) (*MomentResponse, error) {
	if _, err := s.ownedMoment(userID, momentID); err != nil {
		return nil, err
	}
	updated, err := s.repo.SetHiddenByOwner(momentID, userID, hidden, s.now())
	if err != nil {
		return nil, err
	}
	if !updated && !hidden {
		return nil, errHiddenByAdmin
	}
	return s.ownerItem(ctx, userID, momentID)
}

func (s *Service) Get(ctx context.Context, userID, momentID uuid.UUID) (*MomentResponse, error) {
	if _, err := s.ownedMoment(userID, momentID); err != nil {
		return nil, err
	}
	return s.ownerItem(ctx, userID, momentID)
}

func (s *Service) ownerItem(ctx context.Context, userID, momentID uuid.UUID) (*MomentResponse, error) {
	byID, err := s.repo.FindWithAuthors([]uuid.UUID{momentID})
	if err != nil {
		return nil, err
	}
	moment, ok := byID[momentID]
	if !ok {
		return nil, errMomentNotFound
	}
	item := s.withOwnerStats(ctx, userID, []*models.Moment{moment})[0]
	return &item, nil
}

type trayGroup struct {
	authorID  uuid.UUID
	latest    time.Time
	allSeen   bool
	momentIDs []uuid.UUID
}

func groupTrayRows(rows []trayPageRow, limit int) ([]trayGroup, *trayCursor) {
	groups := make([]trayGroup, 0, limit+1)
	for _, row := range rows {
		if n := len(groups); n == 0 || groups[n-1].authorID != row.AuthorID {
			groups = append(groups, trayGroup{authorID: row.AuthorID, latest: row.Latest, allSeen: row.AllSeen})
		}
		last := &groups[len(groups)-1]
		last.momentIDs = append(last.momentIDs, row.ID)
	}
	if len(groups) <= limit {
		return groups, nil
	}
	groups = groups[:limit]
	last := groups[limit-1]
	return groups, &trayCursor{AllSeen: last.allSeen, Latest: last.latest, AuthorID: last.authorID}
}

const (
	trayCursorUnseen = "0"
	trayCursorSeen   = "1"
)

func encodeTrayCursor(cursor *trayCursor) string {
	seen := trayCursorUnseen
	if cursor.AllSeen {
		seen = trayCursorSeen
	}
	raw := strconv.FormatInt(cursor.Latest.UnixMicro(), 10) + "_" + cursor.AuthorID.String() + "_" + seen
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
	parts := strings.Split(string(raw), "_")
	if len(parts) < 2 || len(parts) > 3 {
		return nil, errInvalidCursor
	}
	at, err := strconv.ParseInt(parts[0], 10, 64)
	if err != nil {
		return nil, err
	}
	authorID, err := uuid.Parse(parts[1])
	if err != nil {
		return nil, err
	}
	allSeen := false
	if len(parts) == 3 {
		switch parts[2] {
		case trayCursorSeen:
			allSeen = true
		case trayCursorUnseen:
		default:
			return nil, errInvalidCursor
		}
	}
	return &trayCursor{AllSeen: allSeen, Latest: time.UnixMicro(at).UTC(), AuthorID: authorID}, nil
}

func (s *Service) MarkSeen(ctx context.Context, viewerID uuid.UUID, rawIDs []string) (*MarkSeenResponse, error) {
	ids := uniqueIDs(rawIDs)
	resp := &MarkSeenResponse{IDs: []string{}}
	if len(ids) == 0 {
		return resp, nil
	}
	now := s.now()
	moments, err := s.repo.FindSeenable(viewerID, now, ids)
	if err != nil {
		return nil, err
	}
	if len(moments) == 0 {
		return resp, nil
	}
	if err := s.recordViews(ctx, viewerID, moments, now); err != nil {
		return nil, err
	}
	for _, moment := range moments {
		resp.IDs = append(resp.IDs, moment.ID.String())
	}
	return resp, nil
}

func (s *Service) recordViews(ctx context.Context, viewerID uuid.UUID, moments []*models.Moment, now time.Time) error {
	counts, err := s.store.MarkSeen(ctx, viewerID, moments, now)
	if err != nil {
		s.logger.Warnw("Failed to mark moments seen", "viewer_id", viewerID, "error", err)
		return errStateUnavailable
	}
	if err := s.repo.RaiseViewerCounts(counts); err != nil {
		s.logger.Warnw("Failed to persist moment viewer counts, sync job will retry", "viewer_id", viewerID, "error", err)
	}
	return nil
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
		if len(ids) == MaxMomentSeenBatch {
			break
		}
	}
	return ids
}

func (s *Service) Viewers(ctx context.Context, userID, momentID uuid.UUID, limit, offset int) (*MomentViewersResponse, error) {
	if _, err := s.ownedMoment(userID, momentID); err != nil {
		return nil, err
	}
	return s.ViewersOf(ctx, momentID, limit, offset)
}

func (s *Service) ViewersOf(ctx context.Context, momentID uuid.UUID, limit, offset int) (*MomentViewersResponse, error) {
	page, total, err := s.store.ViewerPage(ctx, momentID, offset, limit)
	if err != nil {
		s.logger.Warnw("Failed to read moment viewers", "moment_id", momentID, "error", err)
		return nil, errStateUnavailable
	}
	ranked, err := s.rankedUsers(page)
	if err != nil {
		return nil, err
	}
	resp := &MomentViewersResponse{
		Items:      make([]MomentViewerResponse, 0, len(ranked)),
		Total:      total,
		Limit:      limit,
		Offset:     offset,
		NextOffset: nextViewerOffset(offset, len(page), total),
	}
	for _, entry := range ranked {
		resp.Items = append(resp.Items, MomentViewerResponse{
			User:     toAuthorResponse(entry.user),
			ViewedAt: entry.at.Format(time.RFC3339),
		})
	}
	return resp, nil
}

type rankedUser struct {
	user *models.User
	at   time.Time
}

func (s *Service) rankedUsers(page []redis.Z) ([]rankedUser, error) {
	ids := make([]uuid.UUID, 0, len(page))
	times := make([]time.Time, 0, len(page))
	for _, entry := range page {
		member, _ := entry.Member.(string)
		id, err := uuid.Parse(member)
		if err != nil {
			continue
		}
		ids = append(ids, id)
		times = append(times, time.UnixMilli(int64(entry.Score)).UTC())
	}
	users, err := s.repo.FindUsers(ids)
	if err != nil {
		return nil, err
	}
	byID := make(map[uuid.UUID]*models.User, len(users))
	for i := range users {
		byID[users[i].ID] = &users[i]
	}
	ranked := make([]rankedUser, 0, len(ids))
	for i, id := range ids {
		if user, ok := byID[id]; ok {
			ranked = append(ranked, rankedUser{user: user, at: times[i]})
		}
	}
	return ranked, nil
}

func nextViewerOffset(offset, fetched int, total int64) *int {
	next := offset + fetched
	if fetched == 0 || int64(next) >= total {
		return nil
	}
	return &next
}

func (s *Service) Delete(userID, momentID uuid.UUID) error {
	if _, err := s.ownedMoment(userID, momentID); err != nil {
		return err
	}
	if err := s.repo.SoftDelete(momentID); err != nil {
		return err
	}
	if s.notifier != nil {
		s.notifier.MomentDeleted(momentID)
	}
	return nil
}

func (s *Service) ownedMoment(userID, momentID uuid.UUID) (*models.Moment, error) {
	moment, err := s.repo.FindByID(momentID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errMomentNotFound
		}
		return nil, err
	}
	if moment.AuthorID != userID {
		return nil, errMomentNotFound
	}
	return moment, nil
}

func (s *Service) deleteObjectsAsync(objectNames []string) {
	if len(objectNames) == 0 {
		return
	}
	queued := append([]string(nil), objectNames...)
	utils.SafeGo(s.logger, func() {
		for _, objectName := range queued {
			ctx, cancel := context.WithTimeout(context.Background(), MomentObjectDeleteTimeout)
			err := s.s3.DeleteFile(ctx, objectName)
			cancel()
			if err != nil {
				s.logger.Warnw("Failed to delete moment object", "object", objectName, "error", err)
			}
		}
	})
}

func authorOf(moment *models.Moment) MomentAuthorResponse {
	if moment.Author == nil {
		return MomentAuthorResponse{ID: moment.AuthorID.String()}
	}
	return toAuthorResponse(moment.Author)
}

func toAuthorResponse(user *models.User) MomentAuthorResponse {
	return MomentAuthorResponse{
		ID:       user.ID.String(),
		Username: user.Username,
		FullName: user.FullName,
		Avatar:   user.Avatar,
	}
}

func toMomentResponse(moment *models.Moment, author MomentAuthorResponse) MomentResponse {
	overlays := []models.MomentOverlay(moment.Overlays)
	if overlays == nil {
		overlays = []models.MomentOverlay{}
	}
	mediaURL := moment.MediaURL
	if moment.Status != MomentStatusReady {
		mediaURL = ""
	}
	thumbURL := moment.ThumbURL
	if IsMediaGone(moment) {
		thumbURL = ""
	}
	resp := MomentResponse{
		ID:          moment.ID.String(),
		Author:      author,
		Type:        moment.Type,
		Status:      moment.Status,
		Position:    moment.Position,
		Background:  moment.Background,
		Overlays:    overlays,
		MediaURL:    mediaURL,
		ThumbURL:    thumbURL,
		Width:       moment.Width,
		Height:      moment.Height,
		Duration:    moment.Duration,
		Visibility:  moment.Visibility,
		Hidden:      !moment.Enabled,
		MediaPurged: IsMediaPurged(moment),
		CreatedAt:   moment.CreatedAt.UTC().Format(time.RFC3339),
		ExpiresAt:   moment.ExpiresAt.UTC().Format(time.RFC3339),
	}
	if !moment.Enabled && moment.HiddenBy != nil {
		resp.HiddenBy = *moment.HiddenBy
	}
	return resp
}

func IsMediaGone(moment *models.Moment) bool {
	return slices.Contains(MomentMediaGoneStatuses, moment.Status)
}

func IsMediaPurged(moment *models.Moment) bool {
	return moment.Type != MomentTypeText && moment.Status == MomentStatusPurged
}
