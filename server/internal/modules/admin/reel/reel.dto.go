package adminreel

import "ola-chat-server/internal/models"

type AuthorResponse struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	FullName string `json:"fullName,omitempty"`
	Avatar   string `json:"avatar,omitempty"`
}

type ReelItem struct {
	ID                 string               `json:"id"`
	Type               string               `json:"type"`
	Background         string               `json:"background,omitempty"`
	Overlays           []models.ReelOverlay `json:"overlays"`
	MediaURL           string               `json:"mediaUrl,omitempty"`
	ThumbURL           string               `json:"thumbUrl,omitempty"`
	Width              int                  `json:"width,omitempty"`
	Height             int                  `json:"height,omitempty"`
	Duration           float64              `json:"duration,omitempty"`
	Size               int64                `json:"size,omitempty"`
	MimeType           string               `json:"mimeType,omitempty"`
	Visibility         string               `json:"visibility"`
	Status             string               `json:"status"`
	State              string               `json:"state"`
	Enabled            bool                 `json:"enabled"`
	MediaPurged        bool                 `json:"mediaPurged"`
	ViewerCount        *int64               `json:"viewerCount"`
	ReportCount        int64                `json:"reportCount"`
	PendingReportCount int64                `json:"pendingReportCount"`
	Author             *AuthorResponse      `json:"author,omitempty"`
	CreatedAt          string               `json:"createdAt"`
	ExpiresAt          string               `json:"expiresAt"`
	DeletedAt          string               `json:"deletedAt,omitempty"`
}

type ReelListResponse struct {
	Items  []ReelItem `json:"items"`
	Total  int64      `json:"total"`
	Limit  int        `json:"limit"`
	Offset int        `json:"offset"`
}

type UpdateStatusRequest struct {
	Enabled *bool `json:"enabled" binding:"required" example:"false"`
}
