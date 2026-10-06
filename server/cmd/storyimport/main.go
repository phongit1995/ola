package main

import (
	"context"
	"database/sql"
	"encoding/json"
	"errors"
	"flag"
	"log"
	"net"
	"net/url"
	"os"
	"path/filepath"
	"strconv"
	"strings"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/modules/story"

	"github.com/caarlos0/env/v11"
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
		if result.StoryInserted {
			newStories++
		}
		added += result.Added
		updated += result.Updated
		unchanged += result.Unchanged
		withoutContent += result.WithoutContent
		removed += result.Removed
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

func toImport(item exportStory) story.StoryImport {
	var sourceAuthorID *string
	if item.SourceAuthorID != nil {
		value := string(*item.SourceAuthorID)
		sourceAuthorID = &value
	}
	return story.StoryImport{
		SourceStoryID:  item.ID,
		Slug:           item.Slug,
		Title:          item.Title,
		AuthorName:     item.AuthorName,
		SourceAuthorID: sourceAuthorID,
		Kind:           item.Kind,
		Genres:         item.Genres,
		Tags:           item.Tags,
		Intro:          item.Intro,
		CoverURL:       item.CoverURL,
		Status:         item.Status,
		AgeRating:      item.AgeRating,
		LikeCount:      item.LikeCount,
		SourceURL:      item.SourceURL,
		PublishedAt:    item.PublishedAt,
		UpdatedAt:      item.UpdatedAt,
	}
}

func toChapterImports(chapters []exportChapter, contents map[string]string) []story.ChapterImport {
	out := make([]story.ChapterImport, 0, len(chapters))
	for _, chapter := range chapters {
		item := story.ChapterImport{
			SourceChapterID: chapter.ID,
			Position:        chapter.Position,
			Title:           chapter.Title,
			URL:             chapter.URL,
			WordCount:       chapter.WordCount,
			PublishedAt:     chapter.PublishedAt,
		}
		if content, ok := contents[strings.TrimSpace(chapter.ID)]; ok {
			item.Content = &content
		}
		out = append(out, item)
	}
	return out
}

func importStory(ctx context.Context, db *sql.DB, source, dir string, crawledAt time.Time, item exportStory, chapters []exportChapter) (story.ImportResult, error) {
	contents, err := readContents(dir, strings.TrimSpace(item.ID))
	if err != nil {
		return story.ImportResult{}, err
	}
	return story.ImportStory(ctx, db, source, crawledAt, toImport(item), toChapterImports(chapters, contents))
}
