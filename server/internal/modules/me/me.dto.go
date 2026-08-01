package me

type MeImageInput struct {
	URL        string `json:"url" binding:"required,url" example:"http://localhost:9000/chat-uploads/posts/abc.jpg"`
	ObjectName string `json:"objectName" binding:"omitempty,max=500"`
	Width      int    `json:"width" binding:"omitempty,min=0"`
	Height     int    `json:"height" binding:"omitempty,min=0"`
	MimeType   string `json:"mimeType" binding:"omitempty"`
}

type CheckInInput struct {
	Name       string  `json:"name" binding:"required,max=255" example:"The Coffee House"`
	Address    string  `json:"address" binding:"omitempty,max=500" example:"86-88 Cao Thắng, Q3"`
	Lat        float64 `json:"lat" binding:"omitempty,latitude" example:"10.771"`
	Lng        float64 `json:"lng" binding:"omitempty,longitude" example:"106.682"`
	Action     string  `json:"action" binding:"omitempty,max=100" example:"Đang ăn"`
	ActionIcon string  `json:"actionIcon" binding:"omitempty,max=16" example:"🍜"`
}

type CreateMeRequest struct {
	Content    string         `json:"content" binding:"omitempty,max=5000" example:"Hôm nay trời đẹp quá!"`
	Images     []MeImageInput `json:"images" binding:"omitempty,max=5,dive"`
	CheckIn    *CheckInInput  `json:"checkIn" binding:"omitempty"`
	Sticker    string         `json:"sticker" binding:"omitempty,max=500"`
	Visibility string         `json:"visibility" binding:"omitempty,oneof=public friend private" example:"public"`
}

type UpdateMeRequest struct {
	Content      *string         `json:"content" binding:"omitempty,max=5000"`
	Images       *[]MeImageInput `json:"images" binding:"omitempty,max=5,dive"`
	CheckIn      *CheckInInput   `json:"checkIn" binding:"omitempty"`
	ClearCheckIn bool            `json:"clearCheckIn" binding:"omitempty"`
	Sticker      *string         `json:"sticker" binding:"omitempty,max=500"`
	Visibility   *string         `json:"visibility" binding:"omitempty,oneof=public friend private"`
}

type CheckInResponse struct {
	Name       string  `json:"name"`
	Address    string  `json:"address,omitempty"`
	Lat        float64 `json:"lat,omitempty"`
	Lng        float64 `json:"lng,omitempty"`
	Action     string  `json:"action,omitempty"`
	ActionIcon string  `json:"actionIcon,omitempty"`
}

type ReactRequest struct {
	Type string `json:"type" binding:"required,oneof=like dislike" example:"like"`
}

type MeImageResponse struct {
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
	IsFriend bool   `json:"isFriend,omitempty"`
	IsSelf   bool   `json:"isSelf,omitempty"`
}

type MeResponse struct {
	ID           string            `json:"id"`
	ClanID       string            `json:"clanId,omitempty"`
	ClanHandle   string            `json:"clanHandle,omitempty"`
	Content      string            `json:"content,omitempty"`
	Images       []MeImageResponse `json:"images"`
	Mentions     []string          `json:"mentions,omitempty"`
	CheckIn      *CheckInResponse  `json:"checkIn,omitempty"`
	Sticker      string            `json:"sticker,omitempty"`
	Visibility   string            `json:"visibility"`
	LikeCount    int               `json:"likeCount"`
	DislikeCount int               `json:"dislikeCount"`
	CommentCount int               `json:"commentCount"`
	MyReaction   *string           `json:"myReaction"`
	IsPinned     bool              `json:"isPinned"`
	Author       *AuthorResponse   `json:"author,omitempty"`
	TopLikers    []AuthorResponse  `json:"topLikers,omitempty"`
	CreatedAt    string            `json:"createdAt"`
	UpdatedAt    string            `json:"updatedAt"`
}

type MeListResponse struct {
	Items  []MeResponse `json:"items"`
	Total  int64        `json:"total"`
	Limit  int          `json:"limit"`
	Offset int          `json:"offset"`
}

type MePhotoResponse struct {
	URL       string `json:"url"`
	Width     int    `json:"width"`
	Height    int    `json:"height"`
	MimeType  string `json:"mimeType,omitempty"`
	PostID    string `json:"postId"`
	CreatedAt string `json:"createdAt"`
}

type MePhotoListResponse struct {
	Items  []MePhotoResponse `json:"items"`
	Total  int64             `json:"total"`
	Limit  int               `json:"limit"`
	Offset int               `json:"offset"`
}

type MeFeedResponse struct {
	Items      []MeResponse `json:"items"`
	NextCursor string       `json:"nextCursor,omitempty"`
}

type LikerListResponse struct {
	Items  []AuthorResponse `json:"items"`
	Total  int64            `json:"total"`
	Limit  int              `json:"limit"`
	Offset int              `json:"offset"`
}

type CreateCommentRequest struct {
	Content  string  `json:"content" binding:"required,min=1,max=2000" example:"Bài viết hay quá!"`
	ParentID *string `json:"parentId" binding:"omitempty,uuid" example:"550e8400-e29b-41d4-a716-446655440000"`
}

type CommentReplySnapshot struct {
	CommentID  string `json:"commentId"`
	AuthorName string `json:"authorName"`
	Excerpt    string `json:"excerpt"`
}

type CommentResponse struct {
	ID        string                `json:"id"`
	PostID    string                `json:"postId"`
	ParentID  string                `json:"parentId,omitempty"`
	Content   string                `json:"content"`
	Author    *AuthorResponse       `json:"author,omitempty"`
	ReplyTo   *CommentReplySnapshot `json:"replyTo,omitempty"`
	LikeCount int                   `json:"likeCount"`
	Liked     bool                  `json:"liked"`
	TopLikers []AuthorResponse      `json:"topLikers,omitempty"`
	CreatedAt string                `json:"createdAt"`
}

type MeNotificationResponse struct {
	ID        string          `json:"id"`
	Type      string          `json:"type"`
	Actor     *AuthorResponse `json:"actor,omitempty"`
	PostID    string          `json:"postId"`
	CommentID string          `json:"commentId,omitempty"`
	Preview   string          `json:"preview,omitempty"`
	IsRead    bool            `json:"isRead"`
	CreatedAt string          `json:"createdAt"`
}

type MeNotificationListResponse struct {
	Items       []MeNotificationResponse `json:"items"`
	UnreadCount int64                    `json:"unreadCount"`
	NextCursor  string                   `json:"nextCursor,omitempty"`
}

type CommentListResponse struct {
	Items  []CommentResponse `json:"items"`
	Total  int64             `json:"total"`
	Limit  int               `json:"limit"`
	Offset int               `json:"offset"`
}

type UploadedImage struct {
	URL        string `json:"url"`
	ObjectName string `json:"objectName"`
	Width      int    `json:"width"`
	Height     int    `json:"height"`
	MimeType   string `json:"mimeType"`
}

type UploadImagesResponse struct {
	Images []UploadedImage `json:"images"`
}

type CleanupImagesRequest struct {
	ObjectNames []string `json:"objectNames" binding:"required,min=1,max=5,dive,required"`
}
