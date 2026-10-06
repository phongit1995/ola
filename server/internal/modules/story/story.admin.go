package story

import (
	"context"
	"net/http"
	"strconv"
	"strings"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

var (
	ErrBulkFetchRunning   = utils.NewHTTPError(http.StatusConflict, "chapter content fetch already running for this story")
	ErrBulkTargetRequired = utils.NewHTTPError(http.StatusBadRequest, "ids or filter is required")
	ErrInvalidStoryIDs    = utils.NewHTTPError(http.StatusBadRequest, "invalid story ids")
)

var storyVisibilities = map[string]bool{
	constants.StoryVisibilityAll:     true,
	constants.StoryVisibilityVisible: true,
	constants.StoryVisibilityHidden:  true,
}

var storyKinds = map[string]bool{
	constants.StoryKindShort: true,
	constants.StoryKindLong:  true,
}

func normalizeAdminListQuery(query ListQuery) ListQuery {
	query = normalizePaging(query, constants.StoryAdminPageSize, constants.StoryAdminPageMax)
	if !storyVisibilities[query.Visibility] {
		query.Visibility = constants.StoryVisibilityAll
	}
	if !storyKinds[query.Kind] {
		query.Kind = ""
	}
	query.Source = strings.TrimSpace(query.Source)
	return query
}

func filterQuery(filter StoryFilter) ListQuery {
	return normalizeAdminListQuery(ListQuery{
		Query:      filter.Query,
		Genre:      filter.Genre,
		Status:     filter.Status,
		Kind:       filter.Kind,
		Visibility: filter.Visibility,
		Source:     filter.Source,
	})
}

func parseIDs(raw []string) ([]uuid.UUID, bool) {
	if len(raw) > constants.StoryBulkIDsMax {
		return nil, false
	}
	ids := make([]uuid.UUID, 0, len(raw))
	for _, value := range raw {
		id, ok := parseID(value)
		if !ok {
			return nil, false
		}
		ids = append(ids, id)
	}
	return ids, true
}

func toAdminStoryResponse(item models.Story, contentChapters int) AdminStoryResponse {
	return AdminStoryResponse{
		StoryResponse:   toStoryResponse(item),
		Source:          item.Source,
		SourceStoryID:   item.SourceStoryID,
		IsHidden:        item.IsHidden,
		ContentChapters: contentChapters,
		CrawledAt:       item.CrawledAt,
		CreatedAt:       item.CreatedAt,
	}
}

func toAdminChapter(row AdminChapterRow) AdminChapterResponse {
	return AdminChapterResponse{
		ChapterSummaryResponse: toChapterSummary(row.StoryChapter),
		SourceURL:              row.SourceURL,
		HasContent:             row.HasContent,
		CrawledAt:              row.CrawledAt,
	}
}

func toAdminChapterDetail(row *ChapterRow) *AdminChapterDetailResponse {
	return &AdminChapterDetailResponse{
		AdminChapterResponse: AdminChapterResponse{
			ChapterSummaryResponse: toChapterSummary(row.StoryChapter),
			SourceURL:              row.SourceURL,
			HasContent:             row.ContentText != "",
			CrawledAt:              row.CrawledAt,
		},
		Content: row.ContentText,
	}
}

func (s *Service) AdminList(ctx context.Context, query ListQuery) (*AdminStoryListResponse, error) {
	query = normalizeAdminListQuery(query)
	stories, total, err := s.admin.List(ctx, query)
	if err != nil {
		return nil, err
	}
	ids := make([]uuid.UUID, 0, len(stories))
	for _, item := range stories {
		ids = append(ids, item.ID)
	}
	counts, err := s.admin.ContentCounts(ctx, ids)
	if err != nil {
		return nil, err
	}
	items := make([]AdminStoryResponse, 0, len(stories))
	for _, item := range stories {
		items = append(items, toAdminStoryResponse(item, counts[item.ID]))
	}
	return &AdminStoryListResponse{Items: items, Total: total, Limit: query.Limit, Offset: query.Offset}, nil
}

func (s *Service) AdminGenres(ctx context.Context) (*GenreListResponse, error) {
	items, err := s.admin.AllGenres(ctx)
	if err != nil {
		return nil, err
	}
	if items == nil {
		items = []GenreItem{}
	}
	return &GenreListResponse{Items: items}, nil
}

func (s *Service) AdminSummary(ctx context.Context) (*AdminSummaryResponse, error) {
	return s.admin.Summary(ctx)
}

func (s *Service) AdminSources(ctx context.Context) (*SourceListResponse, error) {
	items, err := s.admin.Sources(ctx)
	if err != nil {
		return nil, err
	}
	if items == nil {
		items = []SourceItem{}
	}
	return &SourceListResponse{Items: items}, nil
}

func (s *Service) SetHiddenMany(ctx context.Context, req BulkVisibilityRequest) (*BulkVisibilityResponse, error) {
	hidden := req.IsHidden != nil && *req.IsHidden
	var updated int64
	switch {
	case len(req.IDs) > 0:
		ids, ok := parseIDs(req.IDs)
		if !ok {
			return nil, ErrInvalidStoryIDs
		}
		count, err := s.admin.SetHiddenByIDs(ctx, ids, hidden)
		if err != nil {
			return nil, err
		}
		updated = count
	case req.Filter != nil:
		count, err := s.admin.SetHiddenByFilter(ctx, filterQuery(*req.Filter), hidden)
		if err != nil {
			return nil, err
		}
		updated = count
	default:
		return nil, ErrBulkTargetRequired
	}
	s.logger.Infow("story visibility changed", "hidden", hidden, "ids", len(req.IDs), "filter", req.Filter, "updated", updated)
	return &BulkVisibilityResponse{Updated: updated}, nil
}

func (s *Service) findAnyStory(ctx context.Context, rawID string) (*models.Story, error) {
	id, ok := parseID(rawID)
	if !ok {
		return nil, ErrStoryNotFound
	}
	item, err := s.admin.FindAnyStory(ctx, id)
	if err != nil {
		return nil, err
	}
	if item == nil {
		return nil, ErrStoryNotFound
	}
	return item, nil
}

func (s *Service) AdminDetail(ctx context.Context, rawID string) (*AdminStoryResponse, error) {
	item, err := s.findAnyStory(ctx, rawID)
	if err != nil {
		return nil, err
	}
	counts, err := s.admin.ContentCounts(ctx, []uuid.UUID{item.ID})
	if err != nil {
		return nil, err
	}
	resp := toAdminStoryResponse(*item, counts[item.ID])
	return &resp, nil
}

func (s *Service) SetHidden(ctx context.Context, rawID string, hidden bool) (*AdminStoryResponse, error) {
	id, ok := parseID(rawID)
	if !ok {
		return nil, ErrStoryNotFound
	}
	updated, err := s.admin.SetHidden(ctx, id, hidden)
	if err != nil {
		return nil, err
	}
	if !updated {
		return nil, ErrStoryNotFound
	}
	return s.AdminDetail(ctx, rawID)
}

func (s *Service) DeleteStory(ctx context.Context, rawID string) error {
	id, ok := parseID(rawID)
	if !ok {
		return ErrStoryNotFound
	}
	deleted, err := s.admin.DeleteStory(ctx, id)
	if err != nil {
		return err
	}
	if !deleted {
		return ErrStoryNotFound
	}
	return nil
}

func (s *Service) AdminChapters(ctx context.Context, rawID string) (*AdminChapterListResponse, error) {
	item, err := s.findAnyStory(ctx, rawID)
	if err != nil {
		return nil, err
	}
	rows, err := s.admin.AdminChapters(ctx, item.ID)
	if err != nil {
		return nil, err
	}
	items := make([]AdminChapterResponse, 0, len(rows))
	for _, row := range rows {
		items = append(items, toAdminChapter(row))
	}
	return &AdminChapterListResponse{Items: items}, nil
}

func (s *Service) anyChapter(ctx context.Context, rawID, rawPosition string) (*ChapterRow, error) {
	id, ok := parseID(rawID)
	if !ok {
		return nil, ErrStoryNotFound
	}
	position, err := strconv.Atoi(rawPosition)
	if err != nil || position < 1 {
		return nil, ErrChapterNotFound
	}
	row, err := s.admin.AnyChapter(ctx, id, position)
	if err != nil {
		return nil, err
	}
	if row == nil {
		return nil, ErrChapterNotFound
	}
	return row, nil
}

func (s *Service) AdminChapter(ctx context.Context, rawID, rawPosition string) (*AdminChapterDetailResponse, error) {
	row, err := s.anyChapter(ctx, rawID, rawPosition)
	if err != nil {
		return nil, err
	}
	return toAdminChapterDetail(row), nil
}

func (s *Service) RefetchChapter(ctx context.Context, rawID, rawPosition string) (*AdminChapterDetailResponse, error) {
	row, err := s.anyChapter(ctx, rawID, rawPosition)
	if err != nil {
		return nil, err
	}
	if err := s.loadContent(ctx, row, true); err != nil {
		return nil, err
	}
	now := time.Now()
	row.CrawledAt = &now
	return toAdminChapterDetail(row), nil
}

func (s *Service) FetchMissingContent(ctx context.Context, rawID string) (*FetchMissingResponse, error) {
	item, err := s.findAnyStory(ctx, rawID)
	if err != nil {
		return nil, err
	}
	rows, err := s.admin.MissingContentChapters(ctx, item.ID)
	if err != nil {
		return nil, err
	}
	if len(rows) == 0 {
		return &FetchMissingResponse{}, nil
	}
	if _, running := s.bulkFetches.LoadOrStore(item.ID, true); running {
		return nil, ErrBulkFetchRunning
	}
	go s.fetchChapters(item.ID, rows)
	return &FetchMissingResponse{Queued: len(rows)}, nil
}

func (s *Service) fetchChapters(storyID uuid.UUID, rows []ChapterRow) {
	defer s.bulkFetches.Delete(storyID)
	ctx, cancel := context.WithTimeout(context.Background(), constants.StoryBulkFetchTimeout)
	defer cancel()
	failed := 0
	for i := range rows {
		if i > 0 {
			select {
			case <-ctx.Done():
			case <-time.After(constants.StoryBulkFetchGap):
			}
		}
		if ctx.Err() != nil {
			failed += len(rows) - i
			break
		}
		if err := s.loadContent(ctx, &rows[i], false); err != nil {
			failed++
		}
	}
	s.logger.Infow("bulk chapter fetch finished", "storyId", storyID, "chapters", len(rows), "failed", failed)
}
