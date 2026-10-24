package reel

import (
	"mime/multipart"

	"ola-chat-server/internal/models"
)

type CreateReelItem struct {
	Background string               `json:"background"`
	Overlays   []models.ReelOverlay `json:"overlays"`
}

type CreateReelInput struct {
	Type       string
	Visibility string
	Items      []CreateReelItem
	Images     []*multipart.FileHeader
	Thumbs     []*multipart.FileHeader
	Video      *multipart.FileHeader
	Thumb      *multipart.FileHeader
}

type ReelAuthorResponse struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	FullName string `json:"fullName,omitempty"`
	Avatar   string `json:"avatar,omitempty"`
}

type ReelResponse struct {
	ID          string               `json:"id"`
	Author      ReelAuthorResponse   `json:"author"`
	Type        string               `json:"type"`
	Status      string               `json:"status"`
	Position    int                  `json:"position"`
	Background  string               `json:"background,omitempty"`
	Overlays    []models.ReelOverlay `json:"overlays"`
	MediaURL    string               `json:"mediaUrl,omitempty"`
	ThumbURL    string               `json:"thumbUrl,omitempty"`
	Width       int                  `json:"width,omitempty"`
	Height      int                  `json:"height,omitempty"`
	Duration    float64              `json:"duration,omitempty"`
	Visibility  string               `json:"visibility"`
	ViewerCount *int64               `json:"viewerCount,omitempty"`
	CreatedAt   string               `json:"createdAt"`
	ExpiresAt   string               `json:"expiresAt"`
}

type CreateReelsResponse struct {
	Reels []ReelResponse `json:"reels"`
}

type ReelGroupResponse struct {
	Author ReelAuthorResponse `json:"author"`
	Reels  []ReelResponse     `json:"reels"`
}

type ReelTrayResponse struct {
	Mine       []ReelResponse      `json:"mine"`
	Groups     []ReelGroupResponse `json:"groups"`
	NextCursor string              `json:"nextCursor,omitempty"`
}

type MyReelsResponse struct {
	Reels []ReelResponse `json:"reels"`
}

type MarkSeenRequest struct {
	IDs []string `json:"ids" binding:"required,min=1,max=50,dive,uuid"`
}

type MarkSeenResponse struct {
	IDs []string `json:"ids"`
}

type ReelViewerResponse struct {
	User     ReelAuthorResponse `json:"user"`
	ViewedAt string             `json:"viewedAt"`
}

type ReelViewersResponse struct {
	Items      []ReelViewerResponse `json:"items"`
	Total      int64                `json:"total"`
	Limit      int                  `json:"limit"`
	Offset     int                  `json:"offset"`
	NextOffset *int                 `json:"nextOffset"`
}
