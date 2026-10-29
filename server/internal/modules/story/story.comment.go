package story

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
	ErrCommentNotFound  = utils.NewHTTPError(http.StatusNotFound, "comment not found")
	ErrCommentForbidden = utils.NewHTTPError(http.StatusForbidden, "only the author can delete this comment")
	ErrCommentEmpty     = utils.NewHTTPError(http.StatusBadRequest, "comment content is required")
	ErrCommentTooLong   = utils.NewHTTPError(http.StatusBadRequest, "comment is too long")
	ErrCommentParent    = utils.NewHTTPError(http.StatusBadRequest, "invalid parent comment")
	ErrCommentCursor    = utils.NewHTTPError(http.StatusBadRequest, "invalid cursor")
)

func encodeCommentCursor(item models.StoryComment) string {
	return utils.EncodeTimeCursor(item.CreatedAt, item.ID)
}

func decodeCommentCursor(cursor string) (*commentCursor, error) {
	createdAt, id, err := utils.DecodeTimeCursor(cursor)
	if err != nil {
		return nil, ErrCommentCursor
	}
	if createdAt == nil {
		return nil, nil
	}
	return &commentCursor{CreatedAt: *createdAt, ID: *id}, nil
}

func commentExcerpt(content string) string {
	runes := []rune(strings.TrimSpace(content))
	if len(runes) <= StoryCommentExcerptRunes {
		return string(runes)
	}
	return string(runes[:StoryCommentExcerptRunes]) + "…"
}

func toCommentAuthor(user *models.User) *StoryCommentAuthor {
	if user == nil {
		return nil
	}
	author := &StoryCommentAuthor{
		ID:       user.ID.String(),
		Username: user.Username,
		FullName: user.FullName,
		Avatar:   user.Avatar,
		VipUsed:  user.VipUsed,
	}
	if user.VipEndTime != nil {
		formatted := user.VipEndTime.UTC().Format(time.RFC3339)
		author.VipEndTime = &formatted
	}
	return author
}

func commentAuthorName(user *models.User) string {
	if user == nil {
		return ""
	}
	return user.Username
}

func parseCommentID(raw string) (uuid.UUID, error) {
	id, ok := parseID(raw)
	if !ok {
		return uuid.Nil, ErrCommentNotFound
	}
	return id, nil
}

func (s *Service) commentResponses(ctx context.Context, viewerID uuid.UUID, rows []models.StoryComment) ([]StoryCommentResponse, error) {
	items := make([]StoryCommentResponse, 0, len(rows))
	if len(rows) == 0 {
		return items, nil
	}
	ids := make([]uuid.UUID, 0, len(rows))
	parentIDs := make([]uuid.UUID, 0)
	for _, row := range rows {
		ids = append(ids, row.ID)
		if row.ParentID != nil {
			parentIDs = append(parentIDs, *row.ParentID)
		}
	}
	parents, err := s.comments.CommentsByIDs(ctx, parentIDs)
	if err != nil {
		return nil, err
	}
	parentByID := make(map[uuid.UUID]models.StoryComment, len(parents))
	userIDs := make([]uuid.UUID, 0, len(rows)+len(parents))
	for _, parent := range parents {
		parentByID[parent.ID] = parent
		userIDs = append(userIDs, parent.AuthorID)
	}
	for _, row := range rows {
		userIDs = append(userIDs, row.AuthorID)
	}
	users := s.users.GetUsersBatch(userIDs, true)
	liked, err := s.comments.LikedComments(ctx, viewerID, ids)
	if err != nil {
		return nil, err
	}
	for _, row := range rows {
		item := StoryCommentResponse{
			ID:        row.ID.String(),
			StoryID:   row.StoryID.String(),
			Content:   row.Content,
			Author:    toCommentAuthor(users[row.AuthorID]),
			LikeCount: row.LikeCount,
			Liked:     liked[row.ID],
			Mine:      row.AuthorID == viewerID,
			CreatedAt: row.CreatedAt,
		}
		if row.ParentID != nil {
			item.ParentID = row.ParentID.String()
			if parent, ok := parentByID[*row.ParentID]; ok {
				item.ReplyTo = &StoryCommentReply{
					CommentID:  parent.ID.String(),
					AuthorName: commentAuthorName(users[parent.AuthorID]),
					Excerpt:    commentExcerpt(parent.Content),
				}
			}
		}
		items = append(items, item)
	}
	return items, nil
}

func toCommentStory(id uuid.UUID, title string, coverURL *string) *StoryCommentStory {
	return &StoryCommentStory{ID: id.String(), Title: title, CoverURL: coverURL}
}

func commentPageLimit(limit int) int {
	if limit <= 0 {
		return StoryCommentPageSize
	}
	return min(limit, StoryCommentPageMax)
}

func (s *Service) Comments(ctx context.Context, viewerID uuid.UUID, rawID, cursor string, limit int) (*StoryCommentListResponse, error) {
	item, err := s.findStory(ctx, rawID)
	if err != nil {
		return nil, err
	}
	after, err := decodeCommentCursor(cursor)
	if err != nil {
		return nil, err
	}
	limit = commentPageLimit(limit)
	rows, err := s.comments.ListComments(ctx, item.ID, after, limit+1)
	if err != nil {
		return nil, err
	}
	resp := &StoryCommentListResponse{}
	if len(rows) > limit {
		rows = rows[:limit]
		resp.NextCursor = encodeCommentCursor(rows[len(rows)-1])
	}
	resp.Items, err = s.commentResponses(ctx, viewerID, rows)
	if err != nil {
		return nil, err
	}
	return resp, nil
}

func (s *Service) RecentComments(ctx context.Context, viewerID uuid.UUID, cursor string, limit int) (*StoryCommentListResponse, error) {
	after, err := decodeCommentCursor(cursor)
	if err != nil {
		return nil, err
	}
	limit = commentPageLimit(limit)
	rows, err := s.comments.RecentComments(ctx, after, limit+1)
	if err != nil {
		return nil, err
	}
	resp := &StoryCommentListResponse{}
	if len(rows) > limit {
		rows = rows[:limit]
		resp.NextCursor = encodeCommentCursor(rows[len(rows)-1].StoryComment)
	}
	comments := make([]models.StoryComment, len(rows))
	for i, row := range rows {
		comments[i] = row.StoryComment
	}
	resp.Items, err = s.commentResponses(ctx, viewerID, comments)
	if err != nil {
		return nil, err
	}
	for i, row := range rows {
		resp.Items[i].Story = toCommentStory(row.StoryID, row.StoryTitle, row.StoryCoverURL)
	}
	return resp, nil
}

func (s *Service) CreateComment(ctx context.Context, viewerID uuid.UUID, rawID string, req CreateStoryCommentRequest) (*CreateStoryCommentResponse, error) {
	item, err := s.findStory(ctx, rawID)
	if err != nil {
		return nil, err
	}
	content := strings.TrimSpace(req.Content)
	runes := utf8.RuneCountInString(content)
	if runes == 0 {
		return nil, ErrCommentEmpty
	}
	if runes > StoryCommentMaxRunes {
		return nil, ErrCommentTooLong
	}
	comment := &models.StoryComment{StoryID: item.ID, AuthorID: viewerID, Content: content}
	if req.ParentID != "" {
		parentID, ok := parseID(req.ParentID)
		if !ok {
			return nil, ErrCommentParent
		}
		parent, err := s.comments.FindComment(ctx, item.ID, parentID)
		if err != nil {
			return nil, err
		}
		if parent == nil {
			return nil, ErrCommentParent
		}
		comment.ParentID = &parent.ID
	}
	unlock := runes >= s.readingConfig().CommentUnlockMinChars
	written, err := s.comments.CreateComment(ctx, comment, unlock)
	if err != nil {
		return nil, err
	}
	items, err := s.commentResponses(ctx, viewerID, []models.StoryComment{*comment})
	if err != nil {
		return nil, err
	}
	items[0].Story = toCommentStory(item.ID, item.Title, item.CoverURL)
	return &CreateStoryCommentResponse{Comment: items[0], CommentCount: written.CommentCount, Unlocked: written.Unlocked}, nil
}

func (s *Service) visibleComment(ctx context.Context, rawID, rawCommentID string) (*models.Story, *models.StoryComment, error) {
	item, err := s.findStory(ctx, rawID)
	if err != nil {
		return nil, nil, err
	}
	commentID, err := parseCommentID(rawCommentID)
	if err != nil {
		return nil, nil, err
	}
	comment, err := s.comments.FindComment(ctx, item.ID, commentID)
	if err != nil {
		return nil, nil, err
	}
	if comment == nil {
		return nil, nil, ErrCommentNotFound
	}
	return item, comment, nil
}

func (s *Service) DeleteComment(ctx context.Context, viewerID uuid.UUID, rawID, rawCommentID string) (*DeleteStoryCommentResponse, error) {
	item, comment, err := s.visibleComment(ctx, rawID, rawCommentID)
	if err != nil {
		return nil, err
	}
	if comment.AuthorID != viewerID {
		return nil, ErrCommentForbidden
	}
	return s.removeComment(ctx, item.ID, comment.ID)
}

func (s *Service) removeComment(ctx context.Context, storyID, commentID uuid.UUID) (*DeleteStoryCommentResponse, error) {
	count, deleted, err := s.comments.DeleteComment(ctx, storyID, commentID)
	if err != nil {
		return nil, err
	}
	if !deleted {
		return nil, ErrCommentNotFound
	}
	return &DeleteStoryCommentResponse{CommentCount: count}, nil
}

func (s *Service) LikeComment(ctx context.Context, viewerID uuid.UUID, rawID, rawCommentID string) (*StoryCommentLikeResponse, error) {
	_, comment, err := s.visibleComment(ctx, rawID, rawCommentID)
	if err != nil {
		return nil, err
	}
	liked, count, err := s.comments.ToggleCommentLike(ctx, comment.ID, viewerID)
	if err != nil {
		return nil, err
	}
	return &StoryCommentLikeResponse{Liked: liked, LikeCount: count}, nil
}

func (s *Service) AdminComments(ctx context.Context, rawID string, offset, limit int) (*AdminStoryCommentListResponse, error) {
	item, err := s.findAnyStory(ctx, rawID)
	if err != nil {
		return nil, err
	}
	if offset < 0 {
		offset = 0
	}
	rows, total, err := s.comments.AdminComments(ctx, item.ID, offset, limit)
	if err != nil {
		return nil, err
	}
	responses, err := s.commentResponses(ctx, uuid.Nil, rows)
	if err != nil {
		return nil, err
	}
	items := make([]AdminStoryCommentResponse, len(rows))
	for i, row := range rows {
		items[i] = AdminStoryCommentResponse{StoryCommentResponse: responses[i]}
		if row.DeletedAt.Valid {
			deletedAt := row.DeletedAt.Time
			items[i].DeletedAt = &deletedAt
		}
	}
	return &AdminStoryCommentListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) AdminDeleteComment(ctx context.Context, rawID, rawCommentID string) (*DeleteStoryCommentResponse, error) {
	item, err := s.findAnyStory(ctx, rawID)
	if err != nil {
		return nil, err
	}
	commentID, err := parseCommentID(rawCommentID)
	if err != nil {
		return nil, err
	}
	return s.removeComment(ctx, item.ID, commentID)
}
