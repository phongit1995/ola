package moment

import (
	"context"
	"net/http"
	"strings"
	"time"
	"unicode/utf8"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

var (
	errCommentEmpty   = utils.NewHTTPError(http.StatusBadRequest, "comment is empty")
	errCommentTooLong = utils.NewHTTPError(http.StatusBadRequest, "comment is too long")
	errCommentExists  = utils.NewHTTPErrorWithCode(http.StatusConflict, "already commented on this moment", ErrorCodeMomentCommentExists)
)

func (s *Service) Comment(ctx context.Context, viewerID, momentID uuid.UUID, content string) (*MomentMyCommentResponse, error) {
	text, err := normalizeComment(content)
	if err != nil {
		return nil, err
	}
	now := s.now()
	moments, err := s.repo.FindSeenable(viewerID, now, []uuid.UUID{momentID})
	if err != nil {
		return nil, err
	}
	if len(moments) == 0 {
		return nil, errMomentNotFound
	}
	comment, err := s.repo.CreateComment(momentID, viewerID, text)
	if err != nil {
		return nil, err
	}
	if s.notifier != nil {
		s.notifier.MomentCommented(moments[0].AuthorID, viewerID, momentID, text)
	}
	if err := s.recordViews(ctx, viewerID, moments, now); err != nil {
		s.logger.Warnw("Moment comment saved without a view", "moment_id", momentID, "viewer_id", viewerID, "error", err)
	}
	return toMyCommentResponse(comment), nil
}

func (s *Service) Comments(userID, momentID uuid.UUID, limit, offset int) (*MomentCommentsResponse, error) {
	moment, err := s.ownedMoment(userID, momentID)
	if err != nil {
		return nil, err
	}
	return s.CommentsOf(moment, limit, offset)
}

func (s *Service) CommentsOf(moment *models.Moment, limit, offset int) (*MomentCommentsResponse, error) {
	rows, err := s.repo.ListComments(moment.ID, limit+1, offset)
	if err != nil {
		return nil, err
	}
	next := nextCommentOffset(offset, len(rows), limit)
	rows = rows[:min(len(rows), limit)]
	resp := &MomentCommentsResponse{
		Items:      make([]MomentCommentResponse, 0, len(rows)),
		Total:      max(moment.CommentCount, int64(offset+len(rows))),
		Limit:      limit,
		Offset:     offset,
		NextOffset: next,
	}
	for i := range rows {
		if rows[i].Author == nil {
			continue
		}
		resp.Items = append(resp.Items, MomentCommentResponse{
			ID:        rows[i].ID.String(),
			User:      toAuthorResponse(rows[i].Author),
			Content:   rows[i].Content,
			CreatedAt: rows[i].CreatedAt.Format(time.RFC3339),
		})
	}
	return resp, nil
}

func (s *Service) myComments(viewerID uuid.UUID, momentIDs []uuid.UUID) map[uuid.UUID]*MomentMyCommentResponse {
	comments, err := s.repo.MyComments(viewerID, momentIDs)
	if err != nil {
		s.logger.Warnw("Failed to read my moment comments", "viewer_id", viewerID, "error", err)
		return map[uuid.UUID]*MomentMyCommentResponse{}
	}
	byMoment := make(map[uuid.UUID]*MomentMyCommentResponse, len(comments))
	for momentID, comment := range comments {
		byMoment[momentID] = toMyCommentResponse(&comment)
	}
	return byMoment
}

func normalizeComment(content string) (string, error) {
	text := strings.TrimSpace(content)
	if text == "" {
		return "", errCommentEmpty
	}
	if utf8.RuneCountInString(text) > MaxMomentCommentRunes {
		return "", errCommentTooLong
	}
	return text, nil
}

func nextCommentOffset(offset, fetched, limit int) *int {
	if fetched <= limit {
		return nil
	}
	next := offset + limit
	return &next
}

func toMyCommentResponse(comment *models.MomentComment) *MomentMyCommentResponse {
	return &MomentMyCommentResponse{
		ID:        comment.ID.String(),
		Content:   comment.Content,
		CreatedAt: comment.CreatedAt.Format(time.RFC3339),
	}
}
