package me

type PostImageInput struct {
	URL      string `json:"url" binding:"required,url" example:"http://localhost:9000/chat-uploads/posts/abc.jpg"`
	Width    int    `json:"width" binding:"omitempty,min=0"`
	Height   int    `json:"height" binding:"omitempty,min=0"`
	MimeType string `json:"mimeType" binding:"omitempty"`
}

type CreatePostRequest struct {
	Content    string           `json:"content" binding:"omitempty,max=5000" example:"Hôm nay trời đẹp quá!"`
	Images     []PostImageInput `json:"images" binding:"omitempty,max=5,dive"`
	Visibility string           `json:"visibility" binding:"omitempty,oneof=public private" example:"public"`
}

type UpdatePostRequest struct {
	Content    *string           `json:"content" binding:"omitempty,max=5000"`
	Images     *[]PostImageInput `json:"images" binding:"omitempty,max=5,dive"`
	Visibility *string           `json:"visibility" binding:"omitempty,oneof=public private"`
}

type ReactRequest struct {
	Type string `json:"type" binding:"required,oneof=like dislike" example:"like"`
}

type PostImageResponse struct {
	URL      string `json:"url"`
	Width    int    `json:"width,omitempty"`
	Height   int    `json:"height,omitempty"`
	MimeType string `json:"mimeType,omitempty"`
}

type AuthorResponse struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	FullName string `json:"fullName,omitempty"`
	Avatar   string `json:"avatar,omitempty"`
}

type PostResponse struct {
	ID           string              `json:"id"`
	Content      string              `json:"content,omitempty"`
	Images       []PostImageResponse `json:"images"`
	Visibility   string              `json:"visibility"`
	LikeCount    int                 `json:"likeCount"`
	DislikeCount int                 `json:"dislikeCount"`
	CommentCount int                 `json:"commentCount"`
	MyReaction   *string             `json:"myReaction"`
	Author       *AuthorResponse     `json:"author,omitempty"`
	CreatedAt    string              `json:"createdAt"`
	UpdatedAt    string              `json:"updatedAt"`
}

type PostListResponse struct {
	Items  []PostResponse `json:"items"`
	Total  int64          `json:"total"`
	Limit  int            `json:"limit"`
	Offset int            `json:"offset"`
}

type CreateCommentRequest struct {
	Content string `json:"content" binding:"required,min=1,max=2000" example:"Bài viết hay quá!"`
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

type UploadedImage struct {
	URL      string `json:"url"`
	Width    int    `json:"width"`
	Height   int    `json:"height"`
	MimeType string `json:"mimeType"`
}

type UploadImagesResponse struct {
	Images []UploadedImage `json:"images"`
}
