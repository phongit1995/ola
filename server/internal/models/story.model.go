package models

import (
	"time"

	"github.com/lib/pq"
)

type Story struct {
	ID              int64          `gorm:"primaryKey"`
	Source          string         `gorm:"type:varchar(30)"`
	SourceStoryID   int64          `gorm:"column:source_story_id"`
	Slug            string         `gorm:"type:varchar(255)"`
	SourceURL       string         `gorm:"column:source_url"`
	Title           string         `gorm:"type:varchar(500)"`
	AuthorName      string         `gorm:"type:varchar(200)"`
	SourceAuthorID  *int64         `gorm:"column:source_author_id"`
	Kind            string         `gorm:"type:varchar(10)"`
	Genres          pq.StringArray `gorm:"type:text[]"`
	Tags            pq.StringArray `gorm:"type:text[]"`
	Intro           string
	CoverURL        *string `gorm:"column:cover_url"`
	Status          string  `gorm:"type:varchar(20)"`
	AgeRating       string  `gorm:"type:varchar(100)"`
	ChapterCount    int
	WordCount       int
	ViewCount       int64
	CommentCount    int
	LikeCount       int
	PublishedAt     time.Time
	SourceUpdatedAt time.Time
	LastChapterAt   *time.Time
	CrawledAt       *time.Time
	IsHidden        bool
	CreatedAt       time.Time
	UpdatedAt       time.Time
}

func (Story) TableName() string {
	return "stories"
}

type StoryChapter struct {
	ID              int64 `gorm:"primaryKey"`
	StoryID         int64
	SourceChapterID int64  `gorm:"column:source_chapter_id"`
	Position        int    `gorm:"column:position"`
	Title           string `gorm:"type:varchar(500)"`
	SourceURL       string `gorm:"column:source_url"`
	ContentText     string
	WordCount       int
	PublishedAt     *time.Time
	CrawledAt       *time.Time
	CreatedAt       time.Time
	UpdatedAt       time.Time
}

func (StoryChapter) TableName() string {
	return "story_chapters"
}
