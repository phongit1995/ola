package adminmoment

import (
	"context"
	"errors"
	"net/http"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/moment"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var (
	errMomentNotFound   = utils.NewHTTPError(http.StatusNotFound, "moment not found")
	errTextNotPurgeable = utils.NewHTTPError(http.StatusBadRequest, "text moments keep their content")
	errStillProcessing  = utils.NewHTTPError(http.StatusConflict, "moment is still processing")
)

type Service struct {
	repo    *Repository
	store   *moment.RedisStore
	viewers *moment.Service
	cleaner *moment.Cleaner
	logger  *zap.SugaredLogger
	now     func() time.Time
}

func NewService(repo *Repository, store *moment.RedisStore, viewers *moment.Service, cleaner *moment.Cleaner, logger *zap.SugaredLogger) *Service {
	return &Service{repo: repo, store: store, viewers: viewers, cleaner: cleaner, logger: logger.Named("[admin_moment_service]"), now: time.Now}
}

type ListFilter struct {
	Query             string
	AuthorID          *uuid.UUID
	Type              string
	Visibility        string
	State             string
	Enabled           *bool
	HasPendingReports *bool
	SortBy            string
	SortDir           string
	Limit             int
	Offset            int
}

func (s *Service) List(ctx context.Context, f ListFilter) (*MomentListResponse, error) {
	now := s.now()
	moments, total, err := s.repo.List(f, now)
	if err != nil {
		return nil, err
	}
	items, err := s.toItems(ctx, moments, now)
	if err != nil {
		return nil, err
	}
	return &MomentListResponse{Items: items, Total: total, Limit: f.Limit, Offset: f.Offset}, nil
}

func (s *Service) GetByID(ctx context.Context, id uuid.UUID) (*MomentDetail, error) {
	found, err := s.getMoment(id)
	if err != nil {
		return nil, err
	}
	pages, err := s.repo.Pages(found)
	if err != nil {
		return nil, err
	}
	items, err := s.toItems(ctx, withPage(pages, found), s.now())
	if err != nil {
		return nil, err
	}
	detail := &MomentDetail{Pages: items}
	for _, item := range items {
		if item.ID == found.ID.String() {
			detail.MomentItem = item
		}
	}
	return detail, nil
}

func withPage(pages []*models.Moment, found *models.Moment) []*models.Moment {
	for _, page := range pages {
		if page.ID == found.ID {
			return pages
		}
	}
	return append(pages, found)
}

func (s *Service) SetEnabled(ctx context.Context, id uuid.UUID, enabled bool) (*MomentDetail, error) {
	updated, err := s.repo.SetEnabled(id, enabled, s.now())
	if err != nil {
		return nil, err
	}
	if !updated {
		return nil, errMomentNotFound
	}
	s.logger.Infow("Admin updated moment status", "moment_id", id, "enabled", enabled)
	return s.GetByID(ctx, id)
}

func (s *Service) PurgeMedia(ctx context.Context, id uuid.UUID) (*MomentDetail, error) {
	found, err := s.getMoment(id)
	if err != nil {
		return nil, err
	}
	switch {
	case found.Type == moment.MomentTypeText:
		return nil, errTextNotPurgeable
	case found.Status == moment.MomentStatusProcessing:
		return nil, errStillProcessing
	case found.Status != moment.MomentStatusPurged:
		if _, err := s.cleaner.PurgeMedia(ctx, id); err != nil {
			return nil, err
		}
	}
	return s.GetByID(ctx, id)
}

func (s *Service) ListViewers(ctx context.Context, id uuid.UUID, limit, offset int) (*moment.MomentViewersResponse, error) {
	exists, err := s.repo.Exists(id)
	if err != nil {
		return nil, err
	}
	if !exists {
		return nil, errMomentNotFound
	}
	resp, err := s.viewers.ViewersOf(ctx, id, limit, offset)
	if err != nil {
		return nil, err
	}
	s.viewers.AttachViewerReactions(ctx, id, resp.Items)
	return resp, nil
}

func (s *Service) MediaPurgeLogs(ctx context.Context, limit, offset int) (*MediaPurgeLogsResponse, error) {
	running, err := s.cleaner.MediaPurgeRunning()
	if err != nil {
		return nil, err
	}
	history, err := s.cleaner.MediaPurgeHistory(ctx, limit, offset)
	if err != nil {
		return nil, err
	}
	return &MediaPurgeLogsResponse{
		Running: running,
		Last:    history.Last,
		Items:   history.Items,
		Total:   history.Total,
		Totals:  history.Totals,
	}, nil
}

func (s *Service) StartMediaPurge() (*MediaPurgeRunResponse, error) {
	started, err := s.cleaner.StartMediaPurge()
	if err != nil {
		return nil, err
	}
	if started {
		s.logger.Infow("Admin started moment media purge")
	}
	return &MediaPurgeRunResponse{Started: started}, nil
}

func (s *Service) getMoment(id uuid.UUID) (*models.Moment, error) {
	found, err := s.repo.GetByID(id)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errMomentNotFound
		}
		return nil, err
	}
	return found, nil
}

func (s *Service) toItems(ctx context.Context, moments []*models.Moment, now time.Time) ([]MomentItem, error) {
	ids := make([]uuid.UUID, 0, len(moments))
	watched := make([]*models.Moment, 0, len(moments))
	for _, r := range moments {
		ids = append(ids, r.ID)
		if hasViewerData(r, now) {
			watched = append(watched, r)
		}
	}
	reports, err := s.repo.ReportCounts(ids)
	if err != nil {
		return nil, err
	}
	pageCounts, err := s.repo.PageCounts(moments)
	if err != nil {
		return nil, err
	}
	viewers, err := s.store.ViewerCounts(ctx, watched)
	if err != nil {
		s.logger.Warnw("Failed to read moment viewer counts", "error", err)
		viewers = nil
	}
	reactions := s.viewers.ReactionSummaries(ctx, moments)
	items := make([]MomentItem, 0, len(moments))
	for _, r := range moments {
		item := toMomentItem(r, now)
		count := max(viewers[r.ID], r.ViewerCount)
		item.ViewerCount = &count
		item.Reactions = reactions[r.ID]
		item.ReactionCount = moment.ReactionTotal(item.Reactions)
		counts := reports[r.ID.String()]
		item.ReportCount = counts.Total
		item.PendingReportCount = counts.Pending
		item.PageCount = max(pageCounts[pageKey(r.AuthorID, r.CreatedAt)], 1)
		items = append(items, item)
	}
	return items, nil
}

func hasViewerData(r *models.Moment, now time.Time) bool {
	return !r.DeletedAt.Valid && r.ExpiresAt.After(now)
}

func momentState(r *models.Moment, now time.Time) string {
	switch {
	case r.Status == moment.MomentStatusFailed:
		return moment.AdminMomentStateFailed
	case r.DeletedAt.Valid:
		return moment.AdminMomentStateDeleted
	case !r.ExpiresAt.After(now):
		return moment.AdminMomentStateExpired
	case r.Status == moment.MomentStatusProcessing:
		return moment.AdminMomentStateProcessing
	default:
		return moment.AdminMomentStateLive
	}
}

func toMomentItem(r *models.Moment, now time.Time) MomentItem {
	overlays := []models.MomentOverlay(r.Overlays)
	if overlays == nil {
		overlays = []models.MomentOverlay{}
	}
	purged := moment.IsMediaPurged(r)
	item := MomentItem{
		ID:          r.ID.String(),
		Type:        r.Type,
		Position:    r.Position,
		Background:  r.Background,
		Overlays:    overlays,
		Width:       r.Width,
		Height:      r.Height,
		Duration:    r.Duration,
		Size:        r.Size,
		MimeType:    r.MimeType,
		Visibility:  r.Visibility,
		Status:      r.Status,
		State:       momentState(r, now),
		Enabled:     r.Enabled,
		MediaPurged: purged,
		Author:      toAuthor(r.Author),
		CreatedAt:   r.CreatedAt.UTC().Format(time.RFC3339),
		ExpiresAt:   r.ExpiresAt.UTC().Format(time.RFC3339),
	}
	if r.Status == moment.MomentStatusReady {
		item.MediaURL = r.MediaURL
	}
	if !moment.IsMediaGone(r) {
		item.ThumbURL = r.ThumbURL
	}
	if !r.Enabled && r.HiddenBy != nil {
		item.HiddenBy = *r.HiddenBy
	}
	if !r.Enabled && r.HiddenAt != nil {
		item.HiddenAt = r.HiddenAt.UTC().Format(time.RFC3339)
	}
	if r.PurgedAt != nil {
		item.PurgedAt = r.PurgedAt.UTC().Format(time.RFC3339)
	}
	if r.DeletedAt.Valid {
		item.DeletedAt = r.DeletedAt.Time.UTC().Format(time.RFC3339)
	}
	return item
}

func toAuthor(u *models.User) *AuthorResponse {
	if u == nil {
		return nil
	}
	return &AuthorResponse{
		ID:       u.ID.String(),
		Username: u.Username,
		FullName: u.FullName,
		Avatar:   u.Avatar,
	}
}
