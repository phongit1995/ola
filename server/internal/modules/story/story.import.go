package story

import (
	"context"
	"crypto/sha256"
	"database/sql"
	"errors"
	"fmt"
	"strconv"
	"strings"
	"time"

	"github.com/google/uuid"
)

type StoryImport struct {
	SourceStoryID  string
	Slug           string
	Title          string
	AuthorName     string
	SourceAuthorID *string
	Kind           string
	Genres         []string
	Tags           []string
	Intro          string
	CoverURL       *string
	Status         string
	AgeRating      string
	LikeCount      int
	SourceURL      string
	PublishedAt    time.Time
	UpdatedAt      time.Time
}

type ChapterImport struct {
	SourceChapterID string
	Position        int
	Title           string
	URL             string
	WordCount       int
	PublishedAt     *time.Time
	Content         *string
}

type ImportResult struct {
	StoryInserted  bool
	Added          int
	Updated        int
	Unchanged      int
	WithoutContent int
	Removed        int64
}

func (r ImportResult) Changed() bool {
	return r.Added > 0 || r.Updated > 0 || r.Removed > 0
}

const upsertStorySQL = `
INSERT INTO stories (
	source, source_story_id, slug, source_url, title, author_name, source_author_id, kind, genres, tags,
	intro, cover_url, status, age_rating, like_count,
	published_at, source_updated_at, crawled_at, content_hash
) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19)
ON CONFLICT (source, source_story_id) DO UPDATE SET
	slug = EXCLUDED.slug,
	source_url = EXCLUDED.source_url,
	title = EXCLUDED.title,
	author_name = EXCLUDED.author_name,
	source_author_id = COALESCE(EXCLUDED.source_author_id, stories.source_author_id),
	kind = EXCLUDED.kind,
	genres = EXCLUDED.genres,
	tags = EXCLUDED.tags,
	intro = EXCLUDED.intro,
	cover_url = EXCLUDED.cover_url,
	status = EXCLUDED.status,
	age_rating = EXCLUDED.age_rating,
	like_count = EXCLUDED.like_count,
	published_at = EXCLUDED.published_at,
	source_updated_at = EXCLUDED.source_updated_at,
	crawled_at = EXCLUDED.crawled_at,
	content_hash = EXCLUDED.content_hash,
	updated_at = CURRENT_TIMESTAMP
RETURNING id, (xmax = 0) AS inserted`

var upsertChapterSQL = `
INSERT INTO story_chapters (
	story_id, source_chapter_id, position, title, source_url, content_text, word_count, published_at, crawled_at, content_hash
) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
ON CONFLICT (story_id, source_chapter_id) DO UPDATE SET
	position = EXCLUDED.position,
	title = EXCLUDED.title,
	source_url = EXCLUDED.source_url,
	content_text = EXCLUDED.content_text,
	word_count = EXCLUDED.word_count,
	` + publishedAtSetSQL + `,
	crawled_at = EXCLUDED.crawled_at,
	content_hash = EXCLUDED.content_hash,
	updated_at = CURRENT_TIMESTAMP
WHERE story_chapters.content_hash IS DISTINCT FROM EXCLUDED.content_hash
	OR story_chapters.position <> EXCLUDED.position
	OR story_chapters.title <> EXCLUDED.title
	OR story_chapters.source_url <> EXCLUDED.source_url
	OR ` + publishedAtChangedSQL + `
RETURNING (xmax = 0) AS inserted`

func sourceClock(column string) string {
	return "((" + column + " AT TIME ZONE 'UTC') + interval '" + strconv.Itoa(StoryVnkingsUTCOffsetSeconds) + " seconds')"
}

var keepPreciseTimeSQL = "COALESCE(story_chapters.published_at IS NOT NULL AND " +
	sourceClock("EXCLUDED.published_at") + "::time = time '00:00' AND " +
	sourceClock("story_chapters.published_at") + "::date = " + sourceClock("EXCLUDED.published_at") + "::date, false)"

var publishedAtSetSQL = "published_at = CASE WHEN " + keepPreciseTimeSQL + " THEN story_chapters.published_at ELSE EXCLUDED.published_at END"

var publishedAtChangedSQL = "NOT (story_chapters.published_at IS NOT DISTINCT FROM EXCLUDED.published_at OR " + keepPreciseTimeSQL + ")"

var upsertChapterInfoSQL = `
INSERT INTO story_chapters (
	story_id, source_chapter_id, position, title, source_url, word_count, published_at, crawled_at
) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
ON CONFLICT (story_id, source_chapter_id) DO UPDATE SET
	position = EXCLUDED.position,
	title = EXCLUDED.title,
	source_url = EXCLUDED.source_url,
	` + publishedAtSetSQL + `,
	crawled_at = EXCLUDED.crawled_at,
	updated_at = CURRENT_TIMESTAMP
WHERE story_chapters.position <> EXCLUDED.position
	OR story_chapters.title <> EXCLUDED.title
	OR story_chapters.source_url <> EXCLUDED.source_url
	OR ` + publishedAtChangedSQL + `
RETURNING (xmax = 0) AS inserted`

const removeStaleChaptersSQL = `
DELETE FROM story_chapters WHERE story_id = $1 AND NOT (source_chapter_id = ANY($2))`

const refreshStorySQL = `
UPDATE stories SET
	chapter_count = agg.chapters,
	word_count = agg.words,
	last_chapter_at = agg.last_at
FROM (
	SELECT COUNT(*) AS chapters, COALESCE(SUM(word_count), 0) AS words, MAX(published_at) AS last_at
	FROM story_chapters
	WHERE story_id = $1
) agg
WHERE stories.id = $1`

func contentHash(text string) []byte {
	sum := sha256.Sum256([]byte(text))
	return sum[:]
}

func ImportStory(ctx context.Context, db *sql.DB, source string, crawledAt time.Time, item StoryImport, chapters []ChapterImport) (ImportResult, error) {
	var result ImportResult
	sourceStoryID := strings.TrimSpace(item.SourceStoryID)
	if sourceStoryID == "" {
		return result, errors.New("story id is empty")
	}

	tx, err := db.BeginTx(ctx, nil)
	if err != nil {
		return result, err
	}
	defer tx.Rollback()

	var storyID uuid.UUID
	err = tx.QueryRowContext(ctx, upsertStorySQL,
		source, sourceStoryID, item.Slug, item.SourceURL, item.Title, item.AuthorName, item.SourceAuthorID,
		item.Kind, nonNil(item.Genres), nonNil(item.Tags), item.Intro, item.CoverURL, item.Status, item.AgeRating,
		item.LikeCount, item.PublishedAt, item.UpdatedAt, crawledAt, contentHash(item.Intro),
	).Scan(&storyID, &result.StoryInserted)
	if err != nil {
		return result, fmt.Errorf("upsert story: %w", err)
	}

	keep := make([]string, 0, len(chapters))
	for _, chapter := range chapters {
		chapterID := strings.TrimSpace(chapter.SourceChapterID)
		if chapterID == "" {
			return result, fmt.Errorf("story %s has a chapter without id", sourceStoryID)
		}
		sourceURL := chapter.URL
		if sourceURL == "" {
			sourceURL = item.SourceURL
		}
		var inserted bool
		if chapter.Content != nil {
			content := *chapter.Content
			err = tx.QueryRowContext(ctx, upsertChapterSQL,
				storyID, chapterID, chapter.Position, chapter.Title, sourceURL, content,
				len(strings.Fields(content)), chapter.PublishedAt, crawledAt, contentHash(content),
			).Scan(&inserted)
		} else {
			result.WithoutContent++
			err = tx.QueryRowContext(ctx, upsertChapterInfoSQL,
				storyID, chapterID, chapter.Position, chapter.Title, sourceURL,
				chapter.WordCount, chapter.PublishedAt, crawledAt,
			).Scan(&inserted)
		}
		switch {
		case errors.Is(err, sql.ErrNoRows):
			result.Unchanged++
		case err != nil:
			return result, fmt.Errorf("upsert chapter %d: %w", chapter.Position, err)
		case inserted:
			result.Added++
		default:
			result.Updated++
		}
		keep = append(keep, chapterID)
	}

	removed, err := tx.ExecContext(ctx, removeStaleChaptersSQL, storyID, keep)
	if err != nil {
		return result, fmt.Errorf("remove stale chapters: %w", err)
	}
	if result.Removed, err = removed.RowsAffected(); err != nil {
		return result, err
	}
	if _, err := tx.ExecContext(ctx, refreshStorySQL, storyID); err != nil {
		return result, fmt.Errorf("refresh counters: %w", err)
	}
	return result, tx.Commit()
}
