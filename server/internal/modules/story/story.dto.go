package story

import "time"

type ListQuery struct {
	Sort   string
	Genre  string
	Status string
	Query  string
	Offset int
	Limit  int
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
