package story

import (
	"context"
	"errors"
	"strings"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"

	"gorm.io/gorm"
)

type ChapterRow struct {
	models.StoryChapter
	StorySource   string
	StoryKind     string
	StorySourceID int64
	PrevPosition  *int
	NextPosition  *int
}

type Store interface {
	List(ctx context.Context, query ListQuery) ([]models.Story, int64, error)
	Genres(ctx context.Context) ([]GenreItem, error)
	FindStory(ctx context.Context, id int64) (*models.Story, error)
	Chapters(ctx context.Context, storyID int64) ([]models.StoryChapter, error)
	Chapter(ctx context.Context, storyID int64, position int) (*ChapterRow, error)
	SaveChapterContent(ctx context.Context, chapterID, storyID int64, content string, wordCount int, hash []byte) error
}

var storyOrders = map[string]string{
	constants.StorySortUpdated: "COALESCE(last_chapter_at, source_updated_at) DESC, id DESC",
	constants.StorySortViews:   "view_count DESC, id DESC",
	constants.StorySortNew:     "published_at DESC, id DESC",
}

const genresQuery = `
SELECT genre AS name, COUNT(*) AS count
FROM stories, unnest(genres) AS genre
WHERE NOT is_hidden
GROUP BY genre
ORDER BY count DESC, genre`

const chapterQuery = `
SELECT c.id, c.story_id, c.position, c.title, c.source_url, c.word_count, c.published_at, c.content_text,
	s.source AS story_source, s.kind AS story_kind, s.source_story_id AS story_source_id,
	(SELECT max(p.position) FROM story_chapters p WHERE p.story_id = c.story_id AND p.position < c.position) AS prev_position,
	(SELECT min(n.position) FROM story_chapters n WHERE n.story_id = c.story_id AND n.position > c.position) AS next_position
FROM story_chapters c
JOIN stories s ON s.id = c.story_id AND NOT s.is_hidden
WHERE c.story_id = ? AND c.position = ?`

const saveChapterContentQuery = `
UPDATE story_chapters
SET content_text = ?, word_count = ?, content_hash = ?, crawled_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP
WHERE id = ? AND content_text = ''`

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
		db = db.Where("NOT is_hidden")
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

func (r *Repository) Genres(ctx context.Context) ([]GenreItem, error) {
	var items []GenreItem
	if err := r.db.WithContext(ctx).Raw(genresQuery).Scan(&items).Error; err != nil {
		return nil, err
	}
	return items, nil
}

func (r *Repository) FindStory(ctx context.Context, id int64) (*models.Story, error) {
	var item models.Story
	err := r.db.WithContext(ctx).Where("id = ? AND NOT is_hidden", id).First(&item).Error
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &item, nil
}

func (r *Repository) Chapters(ctx context.Context, storyID int64) ([]models.StoryChapter, error) {
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

func (r *Repository) Chapter(ctx context.Context, storyID int64, position int) (*ChapterRow, error) {
	var row ChapterRow
	tx := r.db.WithContext(ctx).Raw(chapterQuery, storyID, position).Scan(&row)
	if tx.Error != nil {
		return nil, tx.Error
	}
	if tx.RowsAffected == 0 {
		return nil, nil
	}
	return &row, nil
}

func (r *Repository) SaveChapterContent(ctx context.Context, chapterID, storyID int64, content string, wordCount int, hash []byte) error {
	return r.db.WithContext(ctx).Transaction(func(tx *gorm.DB) error {
		saved := tx.Exec(saveChapterContentQuery, content, wordCount, hash, chapterID)
		if saved.Error != nil || saved.RowsAffected == 0 {
			return saved.Error
		}
		return tx.Exec(refreshStoryWordCountQuery, storyID, storyID).Error
	})
}
