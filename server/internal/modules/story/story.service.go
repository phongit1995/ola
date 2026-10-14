package story

import (
	"context"
	"crypto/sha256"
	"errors"
	"fmt"
	"net/http"
	"strconv"
	"strings"
	"sync"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
	userModule "ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"golang.org/x/sync/singleflight"
)

var (
	ErrStoryNotFound             = utils.NewHTTPError(http.StatusNotFound, "story not found")
	ErrChapterNotFound           = utils.NewHTTPError(http.StatusNotFound, "chapter not found")
	ErrChapterContentUnavailable = utils.NewHTTPErrorWithCode(http.StatusBadGateway, "chapter content unavailable", ErrorCodeStoryContentUnavailable)
	ErrChapterContentNotSaved    = utils.NewHTTPErrorWithCode(http.StatusInternalServerError, "Đã lấy được nội dung nhưng lưu vào DB thất bại", ErrorCodeStoryContentNotSaved)
)

var (
	errUnsupportedSource = errors.New("unsupported story source")
	errEmptyContent      = errors.New("chapter content is empty")
	errChapterLocked     = errors.New("chapter is locked at source")
)

type fetchedContent struct {
	text    string
	saveErr error
	filled  []uuid.UUID
}

var storyStatuses = map[string]bool{
	StoryStatusOngoing:   true,
	StoryStatusCompleted: true,
}

type ContentSource interface {
	ShortStoryContent(ctx context.Context, chapter *ChapterRow) (string, error)
	ChapterContent(ctx context.Context, chapter *ChapterRow) (string, error)
}

type siblingContentSource interface {
	ChapterWithSiblings(ctx context.Context, chapter *ChapterRow) (string, map[string]string, error)
}

type Service struct {
	store       Store
	admin       AdminStore
	comments    CommentStore
	sources     map[string]ContentSource
	views       *ViewCounter
	settings    readingSettings
	users       userLookup
	cache       *services.CacheService
	logger      *zap.SugaredLogger
	fetches     singleflight.Group
	bulkFetches sync.Map
	readingMu   sync.Mutex
	reading     setting.StoryReadingConfig
	readingAt   time.Time
}

func NewService(
	repo *Repository,
	vnkings *VnkingsService,
	rookies *RookiesService,
	views *ViewCounter,
	settings *setting.Service,
	users *userModule.CacheService,
	cache *services.CacheService,
	logger *zap.SugaredLogger,
) *Service {
	return &Service{
		store:    repo,
		admin:    repo,
		comments: repo,
		sources:  map[string]ContentSource{StorySourceVnkings: vnkings, StorySourceRookies: rookies},
		views:    views,
		settings: settings,
		users:    users,
		cache:    cache,
		logger:   logger.Named("[story_service]"),
	}
}

func (s *Service) fetchChapter(ctx context.Context, row *ChapterRow) (string, map[string]string, error) {
	source, ok := s.sources[row.StorySource]
	if !ok {
		return "", nil, fmt.Errorf("%w: %s", errUnsupportedSource, row.StorySource)
	}
	if batch, ok := source.(siblingContentSource); ok {
		return batch.ChapterWithSiblings(ctx, row)
	}
	var text string
	var err error
	if row.StoryKind == StoryKindShort {
		text, err = source.ShortStoryContent(ctx, row)
	} else {
		text, err = source.ChapterContent(ctx, row)
	}
	return text, nil, err
}

// Trang đọc của rookies nặng vài MB nên được chờ lâu hơn vnkings.
func fetchTimeout(source string) time.Duration {
	if source == StorySourceRookies {
		return StoryRookiesFetchTimeout
	}
	return StoryFetchTimeout
}

func normalizeListQuery(query ListQuery) ListQuery {
	query = normalizePaging(query, StoryPageSize, StoryPageMax)
	query.Kind = ""
	query.Visibility = ""
	query.Source = ""
	return query
}

func normalizePaging(query ListQuery, pageSize, pageMax int) ListQuery {
	if _, ok := storyOrders[query.Sort]; !ok {
		query.Sort = StorySortUpdated
	}
	if !storyStatuses[query.Status] {
		query.Status = ""
	}
	query.Genre = strings.TrimSpace(query.Genre)
	query.Query = strings.TrimSpace(query.Query)
	if runes := []rune(query.Query); len(runes) > StoryQueryMaxRunes {
		query.Query = string(runes[:StoryQueryMaxRunes])
	}
	if query.Offset < 0 {
		query.Offset = 0
	}
	if query.Limit <= 0 {
		query.Limit = pageSize
	}
	if query.Limit > pageMax {
		query.Limit = pageMax
	}
	return query
}

func parseID(raw string) (uuid.UUID, bool) {
	id, err := uuid.Parse(raw)
	return id, err == nil && id != uuid.Nil
}

func nonNil(values []string) []string {
	if values == nil {
		return []string{}
	}
	return values
}

func toStoryResponse(item models.Story) StoryResponse {
	return StoryResponse{
		ID:            item.ID.String(),
		Slug:          item.Slug,
		Title:         item.Title,
		AuthorName:    item.AuthorName,
		Kind:          item.Kind,
		Genres:        nonNil(item.Genres),
		Tags:          nonNil(item.Tags),
		Intro:         item.Intro,
		CoverURL:      item.CoverURL,
		Status:        item.Status,
		AgeRating:     item.AgeRating,
		ChapterCount:  item.ChapterCount,
		WordCount:     item.WordCount,
		ViewCount:     item.ViewCount,
		CommentCount:  item.CommentCount,
		LikeCount:     item.LikeCount,
		SourceURL:     item.SourceURL,
		PublishedAt:   item.PublishedAt,
		UpdatedAt:     item.SourceUpdatedAt,
		LastChapterAt: item.LastChapterAt,
	}
}

func toChapterSummary(item models.StoryChapter) ChapterSummaryResponse {
	return ChapterSummaryResponse{
		ID:          item.ID.String(),
		StoryID:     item.StoryID.String(),
		Position:    item.Position,
		Title:       item.Title,
		WordCount:   item.WordCount,
		PublishedAt: item.PublishedAt,
	}
}

func (s *Service) List(ctx context.Context, query ListQuery) (*StoryListResponse, error) {
	query = normalizeListQuery(query)
	stories, total, err := s.store.List(ctx, query)
	if err != nil {
		return nil, err
	}
	items := make([]StoryResponse, 0, len(stories))
	for _, item := range stories {
		items = append(items, toStoryResponse(item))
	}
	return &StoryListResponse{
		Items:   items,
		Total:   total,
		HasMore: int64(query.Offset+len(items)) < total,
	}, nil
}

func (s *Service) Genres(ctx context.Context) (*GenreListResponse, error) {
	items, err := s.store.Genres(ctx)
	if err != nil {
		return nil, err
	}
	if items == nil {
		items = []GenreItem{}
	}
	return &GenreListResponse{Items: items}, nil
}

func (s *Service) findStory(ctx context.Context, rawID string) (*models.Story, error) {
	id, ok := parseID(rawID)
	if !ok {
		return nil, ErrStoryNotFound
	}
	item, err := s.store.FindStory(ctx, id)
	if err != nil {
		return nil, err
	}
	if item == nil {
		return nil, ErrStoryNotFound
	}
	return item, nil
}

func (s *Service) Detail(ctx context.Context, viewerID uuid.UUID, rawID string) (*StoryResponse, error) {
	item, err := s.findStory(ctx, rawID)
	if err != nil {
		return nil, err
	}
	resp := toStoryResponse(*item)
	grant := s.access(ctx, viewerID, item.ID, nil, false)
	resp.Access = &grant.access
	return &resp, nil
}

func (s *Service) Chapters(ctx context.Context, rawID string) (*ChapterListResponse, error) {
	item, err := s.findStory(ctx, rawID)
	if err != nil {
		return nil, err
	}
	chapters, err := s.store.Chapters(ctx, item.ID)
	if err != nil {
		return nil, err
	}
	items := make([]ChapterSummaryResponse, 0, len(chapters))
	for _, chapter := range chapters {
		items = append(items, toChapterSummary(chapter))
	}
	return &ChapterListResponse{Items: items}, nil
}

func (s *Service) Chapter(ctx context.Context, viewerID uuid.UUID, rawID, rawPosition string, prefetch bool) (*ChapterResponse, error) {
	id, ok := parseID(rawID)
	if !ok {
		return nil, ErrStoryNotFound
	}
	position, err := strconv.Atoi(rawPosition)
	if err != nil || position < 1 {
		return nil, ErrChapterNotFound
	}
	row, err := s.store.Chapter(ctx, id, position)
	if err != nil {
		return nil, err
	}
	if row == nil {
		return nil, ErrChapterNotFound
	}
	grant := s.access(ctx, viewerID, row.StoryID, &row.ID, !prefetch)
	if !grant.allowed {
		return &ChapterResponse{
			ChapterSummaryResponse: toChapterSummary(row.StoryChapter),
			PrevPosition:           row.PrevPosition,
			NextPosition:           row.NextPosition,
			Locked:                 true,
			Access:                 grant.access,
		}, nil
	}
	if row.ContentText == "" {
		if err := s.loadContent(ctx, row, false); err != nil && !errors.Is(err, ErrChapterContentNotSaved) {
			s.refundFreeRead(ctx, grant, row.ID)
			return nil, err
		}
	}
	s.views.Track(viewerID, row.StoryID)
	return &ChapterResponse{
		ChapterSummaryResponse: toChapterSummary(row.StoryChapter),
		Content:                row.ContentText,
		PrevPosition:           row.PrevPosition,
		NextPosition:           row.NextPosition,
		Access:                 grant.access,
	}, nil
}

func (s *Service) loadContent(ctx context.Context, row *ChapterRow, replace bool) error {
	_, err := s.loadChapterContent(ctx, row, replace)
	return err
}

func (s *Service) loadChapterContent(ctx context.Context, row *ChapterRow, replace bool) ([]uuid.UUID, error) {
	key := row.ID.String() + ":" + strconv.FormatBool(replace)
	value, err, _ := s.fetches.Do(key, func() (interface{}, error) {
		fetchCtx, cancel := context.WithTimeout(context.WithoutCancel(ctx), fetchTimeout(row.StorySource))
		defer cancel()
		content, siblings, err := s.fetchChapter(fetchCtx, row)
		if err != nil {
			return nil, err
		}
		// Tải trang có thể dùng gần hết thời gian chờ, nên lưu bằng context riêng.
		saveCtx, cancelSave := context.WithTimeout(context.WithoutCancel(ctx), StoryContentSaveTimeout)
		defer cancelSave()
		hash := sha256.Sum256([]byte(content))
		saveErr := s.store.SaveChapterContent(saveCtx, row.ID, row.StoryID, content, len(strings.Fields(content)), hash[:], replace)
		if saveErr != nil {
			s.logger.Errorw("save chapter content failed", "chapterId", row.ID, "error", saveErr)
			return fetchedContent{text: content, saveErr: saveErr}, nil
		}
		delete(siblings, row.SourceChapterID)
		if len(siblings) == 0 {
			return fetchedContent{text: content}, nil
		}
		filled, err := s.store.SaveMissingChapterContents(saveCtx, row.StoryID, siblings)
		if err != nil {
			s.logger.Warnw("save sibling chapter contents failed", "storyId", row.StoryID, "error", err)
		}
		return fetchedContent{text: content, filled: filled}, nil
	})
	if err != nil {
		s.logger.Warnw("fetch chapter content failed", "chapterId", row.ID, "url", row.SourceURL, "error", err)
		return nil, ErrChapterContentUnavailable
	}
	fetched := value.(fetchedContent)
	row.ContentText = fetched.text
	row.WordCount = len(strings.Fields(row.ContentText))
	if fetched.saveErr != nil {
		return nil, ErrChapterContentNotSaved
	}
	return fetched.filled, nil
}
