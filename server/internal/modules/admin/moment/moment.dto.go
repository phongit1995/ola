package adminmoment

import (
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/moment"
)

type AuthorResponse struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	FullName string `json:"fullName,omitempty"`
	Avatar   string `json:"avatar,omitempty"`
}

type MomentItem struct {
	ID                 string                       `json:"id"`
	Type               string                       `json:"type"`
	Position           int                          `json:"position"`
	PageCount          int                          `json:"pageCount"`
	Background         string                       `json:"background,omitempty"`
	Overlays           []models.MomentOverlay       `json:"overlays"`
	MediaURL           string                       `json:"mediaUrl,omitempty"`
	ThumbURL           string                       `json:"thumbUrl,omitempty"`
	Width              int                          `json:"width,omitempty"`
	Height             int                          `json:"height,omitempty"`
	Duration           float64                      `json:"duration,omitempty"`
	Size               int64                        `json:"size,omitempty"`
	MimeType           string                       `json:"mimeType,omitempty"`
	Visibility         string                       `json:"visibility"`
	Status             string                       `json:"status"`
	State              string                       `json:"state"`
	Enabled            bool                         `json:"enabled"`
	MediaPurged        bool                         `json:"mediaPurged"`
	HiddenBy           string                       `json:"hiddenBy,omitempty"`
	HiddenAt           string                       `json:"hiddenAt,omitempty"`
	PurgedAt           string                       `json:"purgedAt,omitempty"`
	ViewerCount        *int64                       `json:"viewerCount"`
	ReactionCount      int64                        `json:"reactionCount"`
	Reactions          []moment.MomentReactionCount `json:"reactions"`
	CommentCount       int64                        `json:"commentCount"`
	ReportCount        int64                        `json:"reportCount"`
	PendingReportCount int64                        `json:"pendingReportCount"`
	Author             *AuthorResponse              `json:"author,omitempty"`
	CreatedAt          string                       `json:"createdAt"`
	ExpiresAt          string                       `json:"expiresAt"`
	DeletedAt          string                       `json:"deletedAt,omitempty"`
}

type MomentDetail struct {
	MomentItem
	Pages []MomentItem `json:"pages"`
}

type MomentListResponse struct {
	Items  []MomentItem `json:"items"`
	Total  int64        `json:"total"`
	Limit  int          `json:"limit"`
	Offset int          `json:"offset"`
}

type UpdateStatusRequest struct {
	Enabled *bool `json:"enabled" binding:"required" example:"false"`
}

type MediaPurgeLogsResponse struct {
	Running bool                    `json:"running"`
	Last    *moment.MediaPurgeLog   `json:"last"`
	Items   []moment.MediaPurgeLog  `json:"items"`
	Total   int64                   `json:"total"`
	Totals  moment.MediaPurgeTotals `json:"totals"`
}

type MediaPurgeRunResponse struct {
	Started bool `json:"started"`
}
