package story

import (
	"context"
	"errors"
	"strings"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type ChapterRow struct {
	models.StoryChapter
	StorySource   string
	StoryKind     string
	StorySourceID string
	PrevPosition  *int
	NextPosition  *int
}

type AdminChapterRow struct {
	models.StoryChapter
	HasContent bool
}

type Store interface {
	List(ctx context.Context, query ListQuery) ([]models.Story, int64, error)
	Genres(ctx context.Context) ([]GenreItem, error)
	FindStory(ctx context.Context, id uuid.UUID) (*models.Story, error)
	Chapters(ctx context.Context, storyID uuid.UUID) ([]models.StoryChapter, error)
	Chapter(ctx context.Context, storyID uuid.UUID, position int) (*ChapterRow, error)
	SaveChapterContent(ctx context.Context, chapterID, storyID uuid.UUID, content string, wordCount int, hash []byte, replace bool) error
}

type AdminStore interface {
	Store
	AllGenres(ctx context.Context) ([]GenreItem, error)
	Summary(ctx context.Context) (*AdminSummaryResponse, error)
	ContentCounts(ctx context.Context, storyIDs []uuid.UUID) (map[uuid.UUID]int, error)
	FindAnyStory(ctx context.Context, id uuid.UUID) (*models.Story, error)
	Sources(ctx context.Context) ([]SourceItem, error)
	SetHidden(ctx context.Context, id uuid.UUID, hidden bool) (bool, error)
	SetHiddenByIDs(ctx context.Context, ids []uuid.UUID, hidden bool) (int64, error)
	SetHiddenByFilter(ctx context.Context, query ListQuery, hidden bool) (int64, error)
	DeleteStory(ctx context.Context, id uuid.UUID) (bool, error)
	AdminChapters(ctx context.Context, storyID uuid.UUID) ([]AdminChapterRow, error)
	AnyChapter(ctx context.Context, storyID uuid.UUID, position int) (*ChapterRow, error)
	MissingContentChapters(ctx context.Context, storyID uuid.UUID) ([]ChapterRow, error)
}

var storyOrders = map[string]string{
	constants.StorySortUpdated: "COALESCE(last_chapter_at, source_updated_at) DESC, id DESC",
	constants.StorySortViews:   "view_count DESC, COALESCE(last_chapter_at, source_updated_at) DESC, id DESC",
	constants.StorySortNew:     "published_at DESC, id DESC",
}

const genresQuery = `
SELECT genre AS name, COUNT(*) AS count
FROM stories, unnest(genres) AS genre
WHERE ? OR NOT is_hidden
GROUP BY genre
ORDER BY count DESC, genre`

const sourcesQuery = `
SELECT source AS name, COUNT(*) AS count
FROM stories
GROUP BY source
ORDER BY count DESC, source`

const chapterRowColumns = `
	c.id, c.story_id, c.position, c.title, c.source_url, c.word_count, c.published_at, c.content_text,
	s.source AS story_source, s.kind AS story_kind, s.source_story_id AS story_source_id`

const chapterQuery = `
SELECT ` + chapterRowColumns + `,
	(SELECT max(p.position) FROM story_chapters p WHERE p.story_id = c.story_id AND p.position < c.position) AS prev_position,
	(SELECT min(n.position) FROM story_chapters n WHERE n.story_id = c.story_id AND n.position > c.position) AS next_position
FROM story_chapters c
JOIN stories s ON s.id = c.story_id AND (? OR NOT s.is_hidden)
WHERE c.story_id = ? AND c.position = ?`

const missingContentQuery = `
SELECT ` + chapterRowColumns + `
FROM story_chapters c
JOIN stories s ON s.id = c.story_id
WHERE c.story_id = ? AND c.content_text = ''
ORDER BY c.position`

const adminChaptersQuery = `
SELECT id, story_id, position, title, source_url, word_count, published_at, crawled_at, content_text <> '' AS has_content
FROM story_chapters
WHERE story_id = ?
ORDER BY position`

const contentCountsQuery = `
SELECT story_id, COUNT(*) AS count
FROM story_chapters
WHERE story_id IN ? AND content_text <> ''
GROUP BY story_id`

const summaryQuery = `
SELECT
	COUNT(*) AS stories,
	COUNT(*) FILTER (WHERE is_hidden) AS hidden_stories,
	COUNT(*) FILTER (WHERE kind = ?) AS long_stories,
	COUNT(*) FILTER (WHERE kind = ?) AS short_stories,
	(SELECT COUNT(*) FROM story_chapters) AS chapters,
	(SELECT COUNT(*) FROM story_chapters WHERE content_text <> '') AS content_chapters,
	MAX(crawled_at) AS last_crawled_at
FROM stories`

const saveChapterContentQuery = `
UPDATE story_chapters
SET content_text = ?, word_count = ?, content_hash = ?, crawled_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP
WHERE id = ? AND (? OR content_text = '')`

const refreshStoryWordCountQuery = `
UPDATE stories
SET word_count = (SELECT COALESCE(SUM(word_count), 0) FROM story_chapters WHERE story_id = ?)
WHERE id = ?`

var likeEscaper = strings.NewReplacer(`\`, `\\`, `%`, `\%`, `_`, `\_`)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func listFilter(query ListQuery) func(*gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		switch query.Visibility {
		case constants.StoryVisibilityAll:
		case constants.StoryVisibilityHidden:
			db = db.Where("is_hidden")
		default:
			db = db.Where("NOT is_hidden")
		}
		if query.Source != "" {
			db = db.Where("source = ?", query.Source)
		}
		if query.Kind != "" {
			db = db.Where("kind = ?", query.Kind)
		}
		if query.Genre != "" {
			db = db.Where("genres @> ARRAY[?]::text[]", query.Genre)
		}
		if query.Status != "" {
			db = db.Where("status = ?", query.Status)
		}
		if query.Query != "" {
			db = db.Where(
				"search_text LIKE '%' || lower(public.unaccent('public.unaccent'::regdictionary, ?)) || '%'",
				likeEscaper.Replace(query.Query),
			)
		}
		return db
	}
}

func (r *Repository) List(ctx context.Context, query ListQuery) ([]models.Story, int64, error) {
	var total int64
	if err := r.db.WithContext(ctx).Model(&models.Story{}).Scopes(listFilter(query)).Count(&total).Error; err != nil {
		return nil, 0, err
	}
	if total == 0 || int64(query.Offset) >= total {
		return nil, total, nil
	}
	var items []models.Story
	err := r.db.WithContext(ctx).
		Scopes(listFilter(query)).
		Order(storyOrders[query.Sort]).
		Offset(query.Offset).
		Limit(query.Limit).
		Find(&items).Error
	if err != nil {
		return nil, 0, err
	}
	return items, total, nil
}

func (r *Repository) genres(ctx context.Context, includeHidden bool) ([]GenreItem, error) {
	var items []GenreItem
	if err := r.db.WithContext(ctx).Raw(genresQuery, includeHidden).Scan(&items).Error; err != nil {
		return nil, err
	}
	return items, nil
}

func (r *Repository) Genres(ctx context.Context) ([]GenreItem, error) {
	return r.genres(ctx, false)
}

func (r *Repository) AllGenres(ctx context.Context) ([]GenreItem, error) {
	return r.genres(ctx, true)
}

func (r *Repository) findStory(ctx context.Context, id uuid.UUID, includeHidden bool) (*models.Story, error) {
	var item models.Story
	err := r.db.WithContext(ctx).Where("id = ? AND (? OR NOT is_hidden)", id, includeHidden).First(&item).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &item, nil
}

func (r *Repository) FindStory(ctx context.Context, id uuid.UUID) (*models.Story, error) {
	return r.findStory(ctx, id, false)
}

func (r *Repository) FindAnyStory(ctx context.Context, id uuid.UUID) (*models.Story, error) {
	return r.findStory(ctx, id, true)
}

func (r *Repository) Chapters(ctx context.Context, storyID uuid.UUID) ([]models.StoryChapter, error) {
	var items []models.StoryChapter
	err := r.db.WithContext(ctx).
		Select("id", "story_id", "position", "title", "word_count", "published_at").
		Where("story_id = ?", storyID).
		Order("position").
		Find(&items).Error
	if err != nil {
		return nil, err
	}
	return items, nil
}

func (r *Repository) chapter(ctx context.Context, storyID uuid.UUID, position int, includeHidden bool) (*ChapterRow, error) {
	var row ChapterRow
	tx := r.db.WithContext(ctx).Raw(chapterQuery, includeHidden, storyID, position).Scan(&row)
	if tx.Error != nil {
		return nil, tx.Error
	}
	if tx.RowsAffected == 0 {
		return nil, nil
	}
	return &row, nil
}

func (r *Repository) Chapter(ctx context.Context, storyID uuid.UUID, position int) (*ChapterRow, error) {
	return r.chapter(ctx, storyID, position, false)
}

func (r *Repository) AnyChapter(ctx context.Context, storyID uuid.UUID, position int) (*ChapterRow, error) {
	return r.chapter(ctx, storyID, position, true)
}

func (r *Repository) SaveChapterContent(ctx context.Context, chapterID, storyID uuid.UUID, content string, wordCount int, hash []byte, replace bool) error {
	return r.db.WithContext(ctx).Transaction(func(tx *gorm.DB) error {
		saved := tx.Exec(saveChapterContentQuery, content, wordCount, hash, chapterID, replace)
		if saved.Error != nil || saved.RowsAffected == 0 {
			return saved.Error
		}
		return tx.Exec(refreshStoryWordCountQuery, storyID, storyID).Error
	})
}

func (r *Repository) Summary(ctx context.Context) (*AdminSummaryResponse, error) {
	var summary AdminSummaryResponse
	err := r.db.WithContext(ctx).Raw(summaryQuery, constants.StoryKindLong, constants.StoryKindShort).Scan(&summary).Error
	if err != nil {
		return nil, err
	}
	return &summary, nil
}

func (r *Repository) ContentCounts(ctx context.Context, storyIDs []uuid.UUID) (map[uuid.UUID]int, error) {
	counts := make(map[uuid.UUID]int, len(storyIDs))
	if len(storyIDs) == 0 {
		return counts, nil
	}
	var rows []struct {
		StoryID uuid.UUID
		Count   int
	}
	if err := r.db.WithContext(ctx).Raw(contentCountsQuery, storyIDs).Scan(&rows).Error; err != nil {
		return nil, err
	}
	for _, row := range rows {
		counts[row.StoryID] = row.Count
	}
	return counts, nil
}

func (r *Repository) Sources(ctx context.Context) ([]SourceItem, error) {
	var items []SourceItem
	if err := r.db.WithContext(ctx).Raw(sourcesQuery).Scan(&items).Error; err != nil {
		return nil, err
	}
	return items, nil
}

func (r *Repository) SetHidden(ctx context.Context, id uuid.UUID, hidden bool) (bool, error) {
	tx := r.db.WithContext(ctx).Model(&models.Story{}).Where("id = ?", id).Update("is_hidden", hidden)
	return tx.RowsAffected > 0, tx.Error
}

func (r *Repository) setHiddenWhere(ctx context.Context, scope func(*gorm.DB) *gorm.DB, hidden bool) (int64, error) {
	db := r.db.WithContext(ctx).Model(&models.Story{}).Where("is_hidden <> ?", hidden)
	tx := scope(db).Update("is_hidden", hidden)
	return tx.RowsAffected, tx.Error
}

func (r *Repository) SetHiddenByIDs(ctx context.Context, ids []uuid.UUID, hidden bool) (int64, error) {
	return r.setHiddenWhere(ctx, func(db *gorm.DB) *gorm.DB {
		return db.Where("id IN ?", ids)
	}, hidden)
}

func (r *Repository) SetHiddenByFilter(ctx context.Context, query ListQuery, hidden bool) (int64, error) {
	return r.setHiddenWhere(ctx, listFilter(query), hidden)
}

func (r *Repository) DeleteStory(ctx context.Context, id uuid.UUID) (bool, error) {
	tx := r.db.WithContext(ctx).Where("id = ?", id).Delete(&models.Story{})
	return tx.RowsAffected > 0, tx.Error
}

func (r *Repository) AdminChapters(ctx context.Context, storyID uuid.UUID) ([]AdminChapterRow, error) {
	var rows []AdminChapterRow
	if err := r.db.WithContext(ctx).Raw(adminChaptersQuery, storyID).Scan(&rows).Error; err != nil {
		return nil, err
	}
	return rows, nil
}

func (r *Repository) MissingContentChapters(ctx context.Context, storyID uuid.UUID) ([]ChapterRow, error) {
	var rows []ChapterRow
	if err := r.db.WithContext(ctx).Raw(missingContentQuery, storyID).Scan(&rows).Error; err != nil {
		return nil, err
	}
	return rows, nil
}

type KnownStory struct {
	SourceStoryID string
	Kind          string
	ChapterCount  int
}

func (r *Repository) KnownStories(ctx context.Context, source string, sourceIDs []string) (map[string]KnownStory, error) {
	known := make(map[string]KnownStory, len(sourceIDs))
	if len(sourceIDs) == 0 {
		return known, nil
	}
	var rows []KnownStory
	err := r.db.WithContext(ctx).Model(&models.Story{}).
		Select("source_story_id, kind, chapter_count").
		Where("source = ? AND source_story_id IN ?", source, sourceIDs).
		Scan(&rows).Error
	if err != nil {
		return nil, err
	}
	for _, row := range rows {
		known[row.SourceStoryID] = row
	}
	return known, nil
}

func (r *Repository) LatestSourceUpdate(ctx context.Context, source string) (*time.Time, error) {
	var latest *time.Time
	err := r.db.WithContext(ctx).Model(&models.Story{}).
		Where("source = ?", source).
		Select("MAX(source_updated_at)").
		Scan(&latest).Error
	return latest, err
}

func (r *Repository) ImportStory(ctx context.Context, source string, crawledAt time.Time, item StoryImport, chapters []ChapterImport) (ImportResult, error) {
	db, err := r.db.DB()
	if err != nil {
		return ImportResult{}, err
	}
	return ImportStory(ctx, db, source, crawledAt, item, chapters)
}
