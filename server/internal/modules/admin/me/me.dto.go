package adminme

type AuthorResponse struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	FullName string `json:"fullName,omitempty"`
	Avatar   string `json:"avatar,omitempty"`
}

type PostImageResponse struct {
	URL      string `json:"url"`
	Width    int    `json:"width,omitempty"`
	Height   int    `json:"height,omitempty"`
	MimeType string `json:"mimeType,omitempty"`
}

type CheckInResponse struct {
	Name       string  `json:"name"`
	Address    string  `json:"address,omitempty"`
	Lat        float64 `json:"lat,omitempty"`
	Lng        float64 `json:"lng,omitempty"`
	Action     string  `json:"action,omitempty"`
	ActionIcon string  `json:"actionIcon,omitempty"`
}

type PostListItem struct {
	ID           string              `json:"id"`
	Content      string              `json:"content,omitempty"`
	Images       []PostImageResponse `json:"images"`
	CheckIn      *CheckInResponse    `json:"checkIn,omitempty"`
	Sticker      string              `json:"sticker,omitempty"`
	Visibility   string              `json:"visibility"`
	Enabled      bool                `json:"enabled"`
	LikeCount    int                 `json:"likeCount"`
	DislikeCount int                 `json:"dislikeCount"`
	CommentCount int                 `json:"commentCount"`
	Author       *AuthorResponse     `json:"author,omitempty"`
	CreatedAt    string              `json:"createdAt"`
}

type PostListResponse struct {
	Items  []PostListItem `json:"items"`
	Total  int64          `json:"total"`
	Limit  int            `json:"limit"`
	Offset int            `json:"offset"`
}

type PostDetail struct {
	ID           string              `json:"id"`
	Content      string              `json:"content,omitempty"`
	Images       []PostImageResponse `json:"images"`
	Mentions     []string            `json:"mentions,omitempty"`
	CheckIn      *CheckInResponse    `json:"checkIn,omitempty"`
	Sticker      string              `json:"sticker,omitempty"`
	Visibility   string              `json:"visibility"`
	Enabled      bool                `json:"enabled"`
	LikeCount    int                 `json:"likeCount"`
	DislikeCount int                 `json:"dislikeCount"`
	CommentCount int                 `json:"commentCount"`
	Author       *AuthorResponse     `json:"author,omitempty"`
	CreatedAt    string              `json:"createdAt"`
	UpdatedAt    string              `json:"updatedAt"`
}

type UpdateStatusRequest struct {
	Enabled *bool `json:"enabled" binding:"required" example:"false"`
}

type CommentResponse struct {
	ID        string          `json:"id"`
	PostID    string          `json:"postId"`
	Content   string          `json:"content"`
	Author    *AuthorResponse `json:"author,omitempty"`
	CreatedAt string          `json:"createdAt"`
}

type CommentListResponse struct {
	Items  []CommentResponse `json:"items"`
	Total  int64             `json:"total"`
	Limit  int               `json:"limit"`
	Offset int               `json:"offset"`
}
