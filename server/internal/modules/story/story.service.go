package story

import (
	"context"
	"crypto/sha256"
	"errors"
	"net/http"
	"strconv"
	"strings"
	"sync"

	"ola-chat-server/internal/models"
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

type fetchedContent struct {
	text    string
	saveErr error
}

var storyStatuses = map[string]bool{
	StoryStatusOngoing:   true,
	StoryStatusCompleted: true,
}

type Service struct {
	store       Store
	admin       AdminStore
	source      ContentSource
	logger      *zap.SugaredLogger
	fetches     singleflight.Group
	bulkFetches sync.Map
}

func NewService(repo *Repository, source *VnkingsSource, logger *zap.SugaredLogger) *Service {
	return &Service{store: repo, admin: repo, source: source, logger: logger.Named("[story_service]")}
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

func (s *Service) Detail(ctx context.Context, rawID string) (*StoryResponse, error) {
	item, err := s.findStory(ctx, rawID)
	if err != nil {
		return nil, err
	}
	resp := toStoryResponse(*item)
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

func (s *Service) Chapter(ctx context.Context, rawID, rawPosition string) (*ChapterResponse, error) {
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
	if row.ContentText == "" {
		if err := s.loadContent(ctx, row, false); err != nil && !errors.Is(err, ErrChapterContentNotSaved) {
			return nil, err
		}
	}
	return &ChapterResponse{
		ChapterSummaryResponse: toChapterSummary(row.StoryChapter),
		Content:                row.ContentText,
		PrevPosition:           row.PrevPosition,
		NextPosition:           row.NextPosition,
	}, nil
}

func (s *Service) loadContent(ctx context.Context, row *ChapterRow, replace bool) error {
	key := row.ID.String() + ":" + strconv.FormatBool(replace)
	value, err, _ := s.fetches.Do(key, func() (interface{}, error) {
		fetchCtx, cancel := context.WithTimeout(context.WithoutCancel(ctx), StoryFetchTimeout)
		defer cancel()
		content, err := s.source.ChapterContent(fetchCtx, row)
		if err != nil {
			return nil, err
		}
		hash := sha256.Sum256([]byte(content))
		saveErr := s.store.SaveChapterContent(fetchCtx, row.ID, row.StoryID, content, len(strings.Fields(content)), hash[:], replace)
		if saveErr != nil {
			s.logger.Errorw("save chapter content failed", "chapterId", row.ID, "error", saveErr)
		}
		return fetchedContent{text: content, saveErr: saveErr}, nil
	})
	if err != nil {
		s.logger.Warnw("fetch chapter content failed", "chapterId", row.ID, "url", row.SourceURL, "error", err)
		return ErrChapterContentUnavailable
	}
	fetched := value.(fetchedContent)
	row.ContentText = fetched.text
	row.WordCount = len(strings.Fields(row.ContentText))
	if fetched.saveErr != nil {
		return ErrChapterContentNotSaved
	}
	return nil
}
