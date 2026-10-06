package story

import (
	"time"

	"ola-chat-server/internal/modules/setting"
)

type ListQuery struct {
	Sort       string
	Genre      string
	Status     string
	Kind       string
	Visibility string
	Source     string
	Query      string
	Offset     int
	Limit      int
}

type StoryResponse struct {
	ID            string     `json:"id"`
	Slug          string     `json:"slug"`
	Title         string     `json:"title"`
	AuthorName    string     `json:"authorName"`
	Kind          string     `json:"kind"`
	Genres        []string   `json:"genres"`
	Tags          []string   `json:"tags"`
	Intro         string     `json:"intro"`
	CoverURL      *string    `json:"coverUrl"`
	Status        string     `json:"status"`
	AgeRating     string     `json:"ageRating"`
	ChapterCount  int        `json:"chapterCount"`
	WordCount     int        `json:"wordCount"`
	ViewCount     int64      `json:"viewCount"`
	CommentCount  int        `json:"commentCount"`
	LikeCount     int        `json:"likeCount"`
	SourceURL     string     `json:"sourceUrl"`
	PublishedAt   time.Time  `json:"publishedAt"`
	UpdatedAt     time.Time  `json:"updatedAt"`
	LastChapterAt *time.Time `json:"lastChapterAt"`
}

type StoryListResponse struct {
	Items   []StoryResponse `json:"items"`
	Total   int64           `json:"total"`
	HasMore bool            `json:"hasMore"`
}

type GenreItem struct {
	Name  string `json:"name"`
	Count int64  `json:"count"`
}

type GenreListResponse struct {
	Items []GenreItem `json:"items"`
}

type ChapterSummaryResponse struct {
	ID          string     `json:"id"`
	StoryID     string     `json:"storyId"`
	Position    int        `json:"position"`
	Title       string     `json:"title"`
	WordCount   int        `json:"wordCount"`
	PublishedAt *time.Time `json:"publishedAt"`
}

type ChapterListResponse struct {
	Items []ChapterSummaryResponse `json:"items"`
}

type ChapterResponse struct {
	ChapterSummaryResponse
	Content      string `json:"content"`
	PrevPosition *int   `json:"prevPosition"`
	NextPosition *int   `json:"nextPosition"`
}

type AdminStoryResponse struct {
	StoryResponse
	Source          string     `json:"source"`
	SourceStoryID   string     `json:"sourceStoryId"`
	IsHidden        bool       `json:"isHidden"`
	ContentChapters int        `json:"contentChapters"`
	CrawledAt       *time.Time `json:"crawledAt"`
	CreatedAt       time.Time  `json:"createdAt"`
}

type AdminStoryListResponse struct {
	Items  []AdminStoryResponse `json:"items"`
	Total  int64                `json:"total"`
	Limit  int                  `json:"limit"`
	Offset int                  `json:"offset"`
}

type AdminSummaryResponse struct {
	Stories         int64      `json:"stories"`
	HiddenStories   int64      `json:"hiddenStories"`
	LongStories     int64      `json:"longStories"`
	ShortStories    int64      `json:"shortStories"`
	Chapters        int64      `json:"chapters"`
	ContentChapters int64      `json:"contentChapters"`
	LastCrawledAt   *time.Time `json:"lastCrawledAt"`
}

type AdminChapterResponse struct {
	ChapterSummaryResponse
	SourceURL  string     `json:"sourceUrl"`
	HasContent bool       `json:"hasContent"`
	CrawledAt  *time.Time `json:"crawledAt"`
}

type AdminChapterListResponse struct {
	Items []AdminChapterResponse `json:"items"`
}

type AdminChapterDetailResponse struct {
	AdminChapterResponse
	Content string `json:"content"`
}

type UpdateStoryRequest struct {
	IsHidden *bool `json:"isHidden" binding:"required"`
}

type FetchMissingResponse struct {
	Queued int `json:"queued"`
}

type SourceItem struct {
	Name  string `json:"name"`
	Count int64  `json:"count"`
}

type SourceListResponse struct {
	Items []SourceItem `json:"items"`
}

type StoryFilter struct {
	Query      string `json:"q"`
	Genre      string `json:"genre"`
	Status     string `json:"status"`
	Kind       string `json:"kind"`
	Visibility string `json:"visibility"`
	Source     string `json:"source"`
}

type BulkVisibilityRequest struct {
	IsHidden *bool        `json:"isHidden" binding:"required"`
	IDs      []string     `json:"ids"`
	Filter   *StoryFilter `json:"filter"`
}

type BulkVisibilityResponse struct {
	Updated int64 `json:"updated"`
}

type CrawlError struct {
	SourceStoryID string `json:"sourceStoryId"`
	Title         string `json:"title"`
	Message       string `json:"message"`
}

type CrawlLog struct {
	ID                string       `json:"id"`
	Trigger           string       `json:"trigger"`
	Status            string       `json:"status"`
	Message           string       `json:"message,omitempty"`
	ImportNewStories  bool         `json:"importNewStories"`
	UserAgent         string       `json:"userAgent"`
	UseCookies        bool         `json:"useCookies"`
	Cookie            string       `json:"cookie,omitempty"`
	CookiesDied       []string     `json:"cookiesDied,omitempty"`
	Since             time.Time    `json:"since"`
	StartedAt         time.Time    `json:"startedAt"`
	FinishedAt        *time.Time   `json:"finishedAt"`
	DurationMs        int64        `json:"durationMs"`
	Truncated         bool         `json:"truncated"`
	PostsFound        int          `json:"postsFound"`
	PostsProcessed    int          `json:"postsProcessed"`
	StoriesChecked    int          `json:"storiesChecked"`
	StoriesUpdated    int          `json:"storiesUpdated"`
	StoriesCreated    int          `json:"storiesCreated"`
	StoriesSkippedNew int          `json:"storiesSkippedNew"`
	StoriesEmpty      int          `json:"storiesEmpty"`
	StoriesFailed     int          `json:"storiesFailed"`
	ChaptersAdded     int          `json:"chaptersAdded"`
	ChaptersUpdated   int          `json:"chaptersUpdated"`
	ChaptersRemoved   int64        `json:"chaptersRemoved"`
	Requests          int64        `json:"requests"`
	Errors            []CrawlError `json:"errors"`
}

type CrawlerConfigResponse struct {
	Enabled          bool                  `json:"enabled"`
	IntervalHours    int                   `json:"intervalHours"`
	ImportNewStories bool                  `json:"importNewStories"`
	RandomUserAgent  bool                  `json:"randomUserAgent"`
	UseCookies       bool                  `json:"useCookies"`
	Cookies          []setting.StoryCookie `json:"cookies"`
}

type CrawlerStatusResponse struct {
	Config     CrawlerConfigResponse `json:"config"`
	UserAgents int                   `json:"userAgents"`
	Running    bool                  `json:"running"`
	Progress   *CrawlLog             `json:"progress"`
	LastRunAt  *time.Time            `json:"lastRunAt"`
	NextRunAt  *time.Time            `json:"nextRunAt"`
	NextSince  *time.Time            `json:"nextSince"`
	Logs       []CrawlLog            `json:"logs"`
}

type CrawlRunResponse struct {
	Started bool `json:"started"`
}
