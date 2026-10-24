package adminreel

import (
	"context"
	"errors"
	"net/http"
	"slices"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/reel"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var errReelNotFound = utils.NewHTTPError(http.StatusNotFound, "reel not found")

type Service struct {
	repo    *Repository
	store   *reel.RedisStore
	viewers *reel.Service
	logger  *zap.SugaredLogger
	now     func() time.Time
}

func NewService(repo *Repository, store *reel.RedisStore, viewers *reel.Service, logger *zap.SugaredLogger) *Service {
	return &Service{repo: repo, store: store, viewers: viewers, logger: logger.Named("[admin_reel_service]"), now: time.Now}
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

func (s *Service) List(ctx context.Context, f ListFilter) (*ReelListResponse, error) {
	now := s.now()
	reels, total, err := s.repo.List(f, now)
	if err != nil {
		return nil, err
	}
	items, err := s.toItems(ctx, reels, now)
	if err != nil {
		return nil, err
	}
	return &ReelListResponse{Items: items, Total: total, Limit: f.Limit, Offset: f.Offset}, nil
}

func (s *Service) GetByID(ctx context.Context, id uuid.UUID) (*ReelItem, error) {
	found, err := s.getReel(id)
	if err != nil {
		return nil, err
	}
	return s.toItem(ctx, found)
}

func (s *Service) SetEnabled(ctx context.Context, id uuid.UUID, enabled bool) (*ReelItem, error) {
	updated, err := s.repo.SetEnabled(id, enabled)
	if err != nil {
		return nil, err
	}
	if !updated {
		return nil, errReelNotFound
	}
	s.logger.Infow("Admin updated reel status", "reel_id", id, "enabled", enabled)
	return s.GetByID(ctx, id)
}

func (s *Service) ListViewers(ctx context.Context, id uuid.UUID, limit, offset int) (*reel.ReelViewersResponse, error) {
	exists, err := s.repo.Exists(id)
	if err != nil {
		return nil, err
	}
	if !exists {
		return nil, errReelNotFound
	}
	return s.viewers.ViewersOf(ctx, id, limit, offset)
}

func (s *Service) getReel(id uuid.UUID) (*models.Reel, error) {
	found, err := s.repo.GetByID(id)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errReelNotFound
		}
		return nil, err
	}
	return found, nil
}

func (s *Service) toItem(ctx context.Context, found *models.Reel) (*ReelItem, error) {
	items, err := s.toItems(ctx, []*models.Reel{found}, s.now())
	if err != nil {
		return nil, err
	}
	return &items[0], nil
}

func (s *Service) toItems(ctx context.Context, reels []*models.Reel, now time.Time) ([]ReelItem, error) {
	ids := make([]uuid.UUID, 0, len(reels))
	watched := make([]*models.Reel, 0, len(reels))
	for _, r := range reels {
		ids = append(ids, r.ID)
		if hasViewerData(r, now) {
			watched = append(watched, r)
		}
	}
	reports, err := s.repo.ReportCounts(ids)
	if err != nil {
		return nil, err
	}
	viewers, err := s.store.ViewerCounts(ctx, watched)
	if err != nil {
		s.logger.Warnw("Failed to read reel viewer counts", "error", err)
		viewers = nil
	}
	items := make([]ReelItem, 0, len(reels))
	for _, r := range reels {
		item := toReelItem(r, now)
		if count, ok := viewers[r.ID]; ok {
			item.ViewerCount = &count
		}
		counts := reports[r.ID.String()]
		item.ReportCount = counts.Total
		item.PendingReportCount = counts.Pending
		items = append(items, item)
	}
	return items, nil
}

func hasViewerData(r *models.Reel, now time.Time) bool {
	return !r.DeletedAt.Valid && r.ExpiresAt.After(now)
}

func reelState(r *models.Reel, now time.Time) string {
	switch {
	case r.Status == constants.ReelStatusFailed:
		return constants.AdminReelStateFailed
	case r.DeletedAt.Valid:
		return constants.AdminReelStateDeleted
	case !r.ExpiresAt.After(now):
		return constants.AdminReelStateExpired
	case r.Status == constants.ReelStatusProcessing:
		return constants.AdminReelStateProcessing
	default:
		return constants.AdminReelStateLive
	}
}

func toReelItem(r *models.Reel, now time.Time) ReelItem {
	overlays := []models.ReelOverlay(r.Overlays)
	if overlays == nil {
		overlays = []models.ReelOverlay{}
	}
	purged := r.Type != constants.ReelTypeText && slices.Contains(constants.ReelMediaGoneStatuses, r.Status)
	item := ReelItem{
		ID:          r.ID.String(),
		Type:        r.Type,
		Background:  r.Background,
		Overlays:    overlays,
		Width:       r.Width,
		Height:      r.Height,
		Duration:    r.Duration,
		Size:        r.Size,
		MimeType:    r.MimeType,
		Visibility:  r.Visibility,
		Status:      r.Status,
		State:       reelState(r, now),
		Enabled:     r.Enabled,
		MediaPurged: purged,
		Author:      toAuthor(r.Author),
		CreatedAt:   r.CreatedAt.UTC().Format(time.RFC3339),
		ExpiresAt:   r.ExpiresAt.UTC().Format(time.RFC3339),
	}
	if r.Status == constants.ReelStatusReady {
		item.MediaURL = r.MediaURL
	}
	if !purged {
		item.ThumbURL = r.ThumbURL
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
