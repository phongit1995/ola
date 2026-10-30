package moment

import (
	"mime/multipart"
	"time"

	"ola-chat-server/internal/models"
)

type CreateMomentItem struct {
	Type       string                 `json:"type"`
	Background string                 `json:"background"`
	Overlays   []models.MomentOverlay `json:"overlays"`
}

type CreateMomentInput struct {
	Type       string
	Visibility string
	Items      []CreateMomentItem
	Images     []*multipart.FileHeader
	Thumbs     []*multipart.FileHeader
	Video      *multipart.FileHeader
	Thumb      *multipart.FileHeader
}

type MomentAuthorResponse struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	FullName string `json:"fullName,omitempty"`
	Avatar   string `json:"avatar,omitempty"`
}

type MomentResponse struct {
	ID                string                   `json:"id"`
	Author            MomentAuthorResponse     `json:"author"`
	Type              string                   `json:"type"`
	Status            string                   `json:"status"`
	Position          int                      `json:"position"`
	Background        string                   `json:"background,omitempty"`
	Overlays          []models.MomentOverlay   `json:"overlays"`
	MediaURL          string                   `json:"mediaUrl,omitempty"`
	ThumbURL          string                   `json:"thumbUrl,omitempty"`
	Width             int                      `json:"width,omitempty"`
	Height            int                      `json:"height,omitempty"`
	Duration          float64                  `json:"duration,omitempty"`
	Visibility        string                   `json:"visibility"`
	ViewerCount       *int64                   `json:"viewerCount,omitempty"`
	ReactionCount     *int64                   `json:"reactionCount,omitempty"`
	Reactions         []MomentReactionCount    `json:"reactions,omitempty"`
	CommentCount      *int64                   `json:"commentCount,omitempty"`
	ViewersAvailable  *bool                    `json:"viewersAvailable,omitempty"`
	ReactorsAvailable *bool                    `json:"reactorsAvailable,omitempty"`
	MyComment         *MomentMyCommentResponse `json:"myComment,omitempty"`
	Hidden            bool                     `json:"hidden,omitempty"`
	HiddenBy          string                   `json:"hiddenBy,omitempty"`
	MediaPurged       bool                     `json:"mediaPurged,omitempty"`
	Seen              bool                     `json:"seen,omitempty"`
	CreatedAt         string                   `json:"createdAt"`
	ExpiresAt         string                   `json:"expiresAt"`
}

type CreateMomentsResponse struct {
	Moments []MomentResponse `json:"moments"`
}

type MomentGroupResponse struct {
	Author  MomentAuthorResponse `json:"author"`
	Moments []MomentResponse     `json:"moments"`
}

type MomentTrayResponse struct {
	Mine       []MomentResponse      `json:"mine"`
	Groups     []MomentGroupResponse `json:"groups"`
	NextCursor string                `json:"nextCursor,omitempty"`
}

type MyMomentsResponse struct {
	Moments []MomentResponse `json:"moments"`
}

type MomentHistoryResponse struct {
	Moments    []MomentResponse `json:"moments"`
	NextOffset *int             `json:"nextOffset"`
}

type SetHiddenRequest struct {
	Hidden *bool `json:"hidden" binding:"required" example:"true"`
}

type MarkSeenRequest struct {
	IDs []string `json:"ids" binding:"required,min=1,max=50,dive,uuid"`
}

type MarkSeenResponse struct {
	IDs []string `json:"ids"`
}

type MomentViewerResponse struct {
	User      MomentAuthorResponse  `json:"user"`
	ViewedAt  string                `json:"viewedAt"`
	Reactions []MomentReactionCount `json:"reactions,omitempty"`
}

type MomentReactorResponse struct {
	User      MomentAuthorResponse  `json:"user"`
	ReactedAt string                `json:"reactedAt"`
	Reactions []MomentReactionCount `json:"reactions"`
}

type MomentReactorsResponse struct {
	Items      []MomentReactorResponse `json:"items"`
	Total      int64                   `json:"total"`
	Limit      int                     `json:"limit"`
	Offset     int                     `json:"offset"`
	NextOffset *int                    `json:"nextOffset"`
}

type MomentReactionCount struct {
	Type  string `json:"type" example:"LOVE"`
	Count int64  `json:"count" example:"3"`
}

type ReactMomentRequest struct {
	Type  string `json:"type" binding:"required" example:"LOVE"`
	Count int    `json:"count" binding:"omitempty,min=1,max=20" example:"1"`
}

type ReactMomentResponse struct {
	Type  string `json:"type" example:"LOVE"`
	Count int    `json:"count" example:"4"`
}

type MomentViewersResponse struct {
	Items      []MomentViewerResponse `json:"items"`
	Total      int64                  `json:"total"`
	Limit      int                    `json:"limit"`
	Offset     int                    `json:"offset"`
	NextOffset *int                   `json:"nextOffset"`
}

type CommentMomentRequest struct {
	Content string `json:"content" binding:"required" example:"Đẹp quá!"`
}

type MomentMyCommentResponse struct {
	ID        string `json:"id"`
	Content   string `json:"content"`
	CreatedAt string `json:"createdAt"`
}

type MomentCommentResponse struct {
	ID        string               `json:"id"`
	User      MomentAuthorResponse `json:"user"`
	Content   string               `json:"content"`
	CreatedAt string               `json:"createdAt"`
}

type MomentCommentsResponse struct {
	Items      []MomentCommentResponse `json:"items"`
	Total      int64                   `json:"total"`
	Limit      int                     `json:"limit"`
	Offset     int                     `json:"offset"`
	NextOffset *int                    `json:"nextOffset"`
}

type MediaPurgeLog struct {
	ID         string    `json:"id"`
	Trigger    string    `json:"trigger"`
	Status     string    `json:"status"`
	Message    string    `json:"message,omitempty"`
	AfterHours int       `json:"afterHours"`
	Cutoff     time.Time `json:"cutoff"`
	Purged     int       `json:"purged"`
	Files      int       `json:"files"`
	Bytes      int64     `json:"bytes"`
	Failed     int       `json:"failed"`
	HasMore    bool      `json:"hasMore"`
	StartedAt  time.Time `json:"startedAt"`
	FinishedAt time.Time `json:"finishedAt"`
	DurationMs int64     `json:"durationMs"`
}

func (l *MediaPurgeLog) settle(err error, finishedAt time.Time) {
	l.FinishedAt = finishedAt
	l.DurationMs = finishedAt.Sub(l.StartedAt).Milliseconds()
	switch {
	case err != nil && l.Purged == 0:
		l.Status = MomentPurgeStatusFailed
		l.Message = err.Error()
	case err != nil:
		l.Status = MomentPurgeStatusPartial
		l.Message = err.Error()
	case l.Failed > 0 && l.Purged == 0:
		l.Status = MomentPurgeStatusFailed
	case l.Failed > 0:
		l.Status = MomentPurgeStatusPartial
	default:
		l.Status = MomentPurgeStatusSuccess
	}
}

func (l *MediaPurgeLog) totalsDelta() map[string]int64 {
	delta := make(map[string]int64, 3)
	if l.Purged > 0 {
		delta[MomentPurgeTotalMoments] = int64(l.Purged)
	}
	if l.Files > 0 {
		delta[MomentPurgeTotalFiles] = int64(l.Files)
		delta[MomentPurgeTotalBytes] = l.Bytes
	}
	return delta
}

func (l *MediaPurgeLog) worthKeeping() bool {
	return l.Trigger == MomentPurgeTriggerManual || l.Purged > 0 || l.Failed > 0 ||
		l.Status == MomentPurgeStatusFailed
}

type MediaPurgeTotals struct {
	Moments int64 `json:"moments"`
	Files   int64 `json:"files"`
	Bytes   int64 `json:"bytes"`
}

func (t *MediaPurgeTotals) add(other MediaPurgeTotals) {
	t.Moments += other.Moments
	t.Files += other.Files
	t.Bytes += other.Bytes
}

type MediaPurgeHistory struct {
	Last   *MediaPurgeLog
	Items  []MediaPurgeLog
	Total  int64
	Totals MediaPurgeTotals
}
