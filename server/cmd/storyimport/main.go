package main

import (
	"context"
	"crypto/sha256"
	"database/sql"
	"encoding/json"
	"errors"
	"flag"
	"fmt"
	"log"
	"net"
	"net/url"
	"os"
	"path/filepath"
	"strconv"
	"strings"
	"time"

	"ola-chat-server/internal/constants"

	"github.com/caarlos0/env/v11"
	"github.com/google/uuid"
	_ "github.com/jackc/pgx/v5/stdlib"
	"github.com/joho/godotenv"
)

type dbConfig struct {
	Host     string `env:"DB_HOST" envDefault:"localhost"`
	Port     int    `env:"DB_PORT" envDefault:"5432"`
	User     string `env:"DB_USER" envDefault:"postgres"`
	Password string `env:"DB_PASSWORD" envDefault:"postgres"`
	Name     string `env:"DB_NAME" envDefault:"chat_db"`
	SSLMode  string `env:"DB_SSL_MODE" envDefault:"disable"`
}

type exportIndex struct {
	GeneratedAt time.Time                  `json:"generatedAt"`
	Stories     []exportStory              `json:"stories"`
	Chapters    map[string][]exportChapter `json:"chapters"`
}

type sourceID string

func (s *sourceID) UnmarshalJSON(data []byte) error {
	var text string
	if err := json.Unmarshal(data, &text); err == nil {
		*s = sourceID(text)
		return nil
	}
	var number json.Number
	if err := json.Unmarshal(data, &number); err != nil {
		return err
	}
	*s = sourceID(number.String())
	return nil
}

type exportStory struct {
	ID             string    `json:"id"`
	Slug           string    `json:"slug"`
	Title          string    `json:"title"`
	AuthorName     string    `json:"authorName"`
	SourceAuthorID *sourceID `json:"sourceAuthorId"`
	Kind           string    `json:"kind"`
	Genres         []string  `json:"genres"`
	Tags           []string  `json:"tags"`
	Intro          string    `json:"intro"`
	CoverURL       *string   `json:"coverUrl"`
	Status         string    `json:"status"`
	AgeRating      string    `json:"ageRating"`
	LikeCount      int       `json:"likeCount"`
	SourceURL      string    `json:"sourceUrl"`
	PublishedAt    time.Time `json:"publishedAt"`
	UpdatedAt      time.Time `json:"updatedAt"`
}

type exportChapter struct {
	ID          string     `json:"id"`
	Position    int        `json:"position"`
	Title       string     `json:"title"`
	URL         string     `json:"url"`
	WordCount   int        `json:"wordCount"`
	PublishedAt *time.Time `json:"publishedAt"`
}

type importResult struct {
	storyInserted  bool
	added          int
	updated        int
	unchanged      int
	withoutContent int
	removed        int64
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

const upsertChapterSQL = `
INSERT INTO story_chapters (
	story_id, source_chapter_id, position, title, source_url, content_text, word_count, published_at, crawled_at, content_hash
) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
ON CONFLICT (story_id, source_chapter_id) DO UPDATE SET
	position = EXCLUDED.position,
	title = EXCLUDED.title,
	source_url = EXCLUDED.source_url,
	content_text = EXCLUDED.content_text,
	word_count = EXCLUDED.word_count,
	published_at = EXCLUDED.published_at,
	crawled_at = EXCLUDED.crawled_at,
	content_hash = EXCLUDED.content_hash,
	updated_at = CURRENT_TIMESTAMP
WHERE story_chapters.content_hash IS DISTINCT FROM EXCLUDED.content_hash
	OR story_chapters.position <> EXCLUDED.position
	OR story_chapters.title <> EXCLUDED.title
	OR story_chapters.source_url <> EXCLUDED.source_url
	OR story_chapters.published_at IS DISTINCT FROM EXCLUDED.published_at
RETURNING (xmax = 0) AS inserted`

const upsertChapterInfoSQL = `
INSERT INTO story_chapters (
	story_id, source_chapter_id, position, title, source_url, word_count, published_at, crawled_at
) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
ON CONFLICT (story_id, source_chapter_id) DO UPDATE SET
	position = EXCLUDED.position,
	title = EXCLUDED.title,
	source_url = EXCLUDED.source_url,
	published_at = EXCLUDED.published_at,
	crawled_at = EXCLUDED.crawled_at,
	updated_at = CURRENT_TIMESTAMP
WHERE story_chapters.position <> EXCLUDED.position
	OR story_chapters.title <> EXCLUDED.title
	OR story_chapters.source_url <> EXCLUDED.source_url
	OR story_chapters.published_at IS DISTINCT FROM EXCLUDED.published_at
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

func main() {
	dir := flag.String("dir", "../scripts/vnkings/data", "directory written by scripts/vnkings/export_stories.py")
	source := flag.String("source", constants.StorySourceVnkings, "value stored in stories.source")
	flag.Parse()

	if err := godotenv.Load(); err != nil {
		_ = godotenv.Load("../.env")
	}
	cfg := dbConfig{}
	if err := env.Parse(&cfg); err != nil {
		log.Fatalf("parse config: %v", err)
	}

	index, err := readIndex(*dir)
	if err != nil {
		log.Fatalf("read %s: %v", *dir, err)
	}

	db, err := sql.Open("pgx", dsn(cfg))
	if err != nil {
		log.Fatalf("open database: %v", err)
	}
	defer db.Close()
	ctx := context.Background()
	if err := db.PingContext(ctx); err != nil {
		log.Fatalf("ping database: %v", err)
	}

	var stories, newStories, added, updated, unchanged, withoutContent int
	var removed int64
	for _, item := range index.Stories {
		chapters := index.Chapters[item.ID]
		if len(chapters) == 0 {
			log.Printf("skip %s %q: no chapters", item.ID, item.Title)
			continue
		}
		result, err := importStory(ctx, db, *source, *dir, index.GeneratedAt, item, chapters)
		if err != nil {
			log.Fatalf("import %s %q: %v", item.ID, item.Title, err)
		}
		stories++
		if result.storyInserted {
			newStories++
		}
		added += result.added
		updated += result.updated
		unchanged += result.unchanged
		withoutContent += result.withoutContent
		removed += result.removed
	}
	log.Printf("stories: %d (%d new); chapters: %d added, %d updated, %d unchanged, %d removed; %d chapters imported without content",
		stories, newStories, added, updated, unchanged, removed, withoutContent)
}

func dsn(cfg dbConfig) string {
	u := url.URL{
		Scheme:   "postgres",
		User:     url.UserPassword(cfg.User, cfg.Password),
		Host:     net.JoinHostPort(cfg.Host, strconv.Itoa(cfg.Port)),
		Path:     "/" + cfg.Name,
		RawQuery: url.Values{"sslmode": {cfg.SSLMode}}.Encode(),
	}
	return u.String()
}

func readIndex(dir string) (*exportIndex, error) {
	raw, err := os.ReadFile(filepath.Join(dir, "index.json"))
	if err != nil {
		return nil, err
	}
	var index exportIndex
	if err := json.Unmarshal(raw, &index); err != nil {
		return nil, err
	}
	return &index, nil
}

func readContents(dir, storyID string) (map[string]string, error) {
	raw, err := os.ReadFile(filepath.Join(dir, "chapters", storyID+".json"))
	if errors.Is(err, os.ErrNotExist) {
		return map[string]string{}, nil
	}
	if err != nil {
		return nil, err
	}
	contents := map[string]string{}
	if err := json.Unmarshal(raw, &contents); err != nil {
		return nil, err
	}
	return contents, nil
}

func hash(text string) []byte {
	sum := sha256.Sum256([]byte(text))
	return sum[:]
}

func nonNil(values []string) []string {
	if values == nil {
		return []string{}
	}
	return values
}

func importStory(ctx context.Context, db *sql.DB, source, dir string, crawledAt time.Time, item exportStory, chapters []exportChapter) (importResult, error) {
	var result importResult
	sourceStoryID := strings.TrimSpace(item.ID)
	if sourceStoryID == "" {
		return result, errors.New("story id is empty")
	}
	contents, err := readContents(dir, item.ID)
	if err != nil {
		return result, err
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
		item.LikeCount, item.PublishedAt, item.UpdatedAt, crawledAt, hash(item.Intro),
	).Scan(&storyID, &result.storyInserted)
	if err != nil {
		return result, fmt.Errorf("upsert story: %w", err)
	}

	keep := make([]string, 0, len(chapters))
	for _, chapter := range chapters {
		chapterID := strings.TrimSpace(chapter.ID)
		if chapterID == "" {
			return result, fmt.Errorf("story %s has a chapter without id", sourceStoryID)
		}
		sourceURL := chapter.URL
		if sourceURL == "" {
			sourceURL = item.SourceURL
		}
		var inserted bool
		if content, ok := contents[strconv.Itoa(chapter.Position)]; ok {
			err = tx.QueryRowContext(ctx, upsertChapterSQL,
				storyID, chapterID, chapter.Position, chapter.Title, sourceURL, content,
				len(strings.Fields(content)), chapter.PublishedAt, crawledAt, hash(content),
			).Scan(&inserted)
		} else {
			result.withoutContent++
			err = tx.QueryRowContext(ctx, upsertChapterInfoSQL,
				storyID, chapterID, chapter.Position, chapter.Title, sourceURL,
				chapter.WordCount, chapter.PublishedAt, crawledAt,
			).Scan(&inserted)
		}
		switch {
		case errors.Is(err, sql.ErrNoRows):
			result.unchanged++
		case err != nil:
			return result, fmt.Errorf("upsert chapter %d: %w", chapter.Position, err)
		case inserted:
			result.added++
		default:
			result.updated++
		}
		keep = append(keep, chapterID)
	}

	removed, err := tx.ExecContext(ctx, removeStaleChaptersSQL, storyID, keep)
	if err != nil {
		return result, fmt.Errorf("remove stale chapters: %w", err)
	}
	if result.removed, err = removed.RowsAffected(); err != nil {
		return result, err
	}
	if _, err := tx.ExecContext(ctx, refreshStorySQL, storyID); err != nil {
		return result, fmt.Errorf("refresh counters: %w", err)
	}
	return result, tx.Commit()
}
