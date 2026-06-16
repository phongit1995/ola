package adminme

import (
	"errors"
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var (
	errPostNotFound    = errors.New("post not found")
	errCommentNotFound = errors.New("comment not found")
)

type Service struct {
	repo   *Repository
	logger *zap.SugaredLogger
}

func NewService(repo *Repository, logger *zap.SugaredLogger) *Service {
	return &Service{repo: repo, logger: logger.Named("[admin_me_service]")}
}

type ListFilter struct {
	Query      string
	AuthorID   *uuid.UUID
	Enabled    *bool
	Visibility string
	HasImages  *bool
	HasCheckin *bool
	SortBy     string
	SortDir    string
	Limit      int
	Offset     int
}

func (s *Service) List(f ListFilter) (*PostListResponse, error) {
	posts, total, err := s.repo.List(f)
	if err != nil {
		return nil, err
	}
	items := make([]PostListItem, 0, len(posts))
	for _, p := range posts {
		items = append(items, toListItem(p))
	}
	return &PostListResponse{Items: items, Total: total, Limit: f.Limit, Offset: f.Offset}, nil
}

func (s *Service) GetByID(id uuid.UUID) (*PostDetail, error) {
	post, err := s.getPost(id)
	if err != nil {
		return nil, err
	}
	return toDetail(post), nil
}

func (s *Service) SetEnabled(id uuid.UUID, enabled bool) (*PostDetail, error) {
	if _, err := s.getPost(id); err != nil {
		return nil, err
	}
	if err := s.repo.SetEnabled(id, enabled); err != nil {
		return nil, err
	}
	s.logger.Infow("Admin updated post status", "post_id", id, "enabled", enabled)
	post, err := s.repo.GetByID(id)
	if err != nil {
		return nil, err
	}
	return toDetail(post), nil
}

func (s *Service) ListComments(postID uuid.UUID, limit, offset int) (*CommentListResponse, error) {
	if _, err := s.getPost(postID); err != nil {
		return nil, err
	}
	comments, total, err := s.repo.ListComments(postID, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]CommentResponse, 0, len(comments))
	for _, c := range comments {
		items = append(items, toComment(c))
	}
	return &CommentListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) DeleteComment(postID, commentID uuid.UUID) error {
	if _, err := s.getPost(postID); err != nil {
		return err
	}
	comment, err := s.repo.GetCommentByID(commentID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return errCommentNotFound
		}
		return err
	}
	if comment.PostID != postID {
		return errCommentNotFound
	}
	if err := s.repo.DeleteComment(postID, commentID); err != nil {
		return err
	}
	s.logger.Infow("Admin deleted post comment", "post_id", postID, "comment_id", commentID)
	return nil
}

func (s *Service) getPost(id uuid.UUID) (*models.Post, error) {
	post, err := s.repo.GetByID(id)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errPostNotFound
		}
		return nil, err
	}
	return post, nil
}

func toListItem(p *models.Post) PostListItem {
	return PostListItem{
		ID:           p.ID.String(),
		Content:      p.Content,
		Images:       toImages(p.Images),
		CheckIn:      toCheckIn(p.CheckIn),
		Sticker:      p.Sticker,
		Visibility:   string(p.Visibility),
		Enabled:      p.Enabled,
		LikeCount:    p.LikeCount,
		DislikeCount: p.DislikeCount,
		CommentCount: p.CommentCount,
		Author:       toAuthor(p.Author),
		CreatedAt:    p.CreatedAt.UTC().Format(time.RFC3339),
	}
}

func toDetail(p *models.Post) *PostDetail {
	return &PostDetail{
		ID:           p.ID.String(),
		Content:      p.Content,
		Images:       toImages(p.Images),
		Mentions:     []string(p.Mentions),
		CheckIn:      toCheckIn(p.CheckIn),
		Sticker:      p.Sticker,
		Visibility:   string(p.Visibility),
		Enabled:      p.Enabled,
		LikeCount:    p.LikeCount,
		DislikeCount: p.DislikeCount,
		CommentCount: p.CommentCount,
		Author:       toAuthor(p.Author),
		CreatedAt:    p.CreatedAt.UTC().Format(time.RFC3339),
		UpdatedAt:    p.UpdatedAt.UTC().Format(time.RFC3339),
	}
}

func toImages(imgs models.PostImages) []PostImageResponse {
	images := make([]PostImageResponse, 0, len(imgs))
	for _, img := range imgs {
		images = append(images, PostImageResponse{
			URL:      img.URL,
			Width:    img.Width,
			Height:   img.Height,
			MimeType: img.MimeType,
		})
	}
	return images
}

func toCheckIn(checkIn *models.CheckIn) *CheckInResponse {
	if checkIn == nil {
		return nil
	}
	return &CheckInResponse{
		Name:       checkIn.Name,
		Address:    checkIn.Address,
		Lat:        checkIn.Lat,
		Lng:        checkIn.Lng,
		Action:     checkIn.Action,
		ActionIcon: checkIn.ActionIcon,
	}
}

func toComment(c *models.PostComment) CommentResponse {
	return CommentResponse{
		ID:        c.ID.String(),
		PostID:    c.PostID.String(),
		Content:   c.Content,
		Author:    toAuthor(c.Author),
		CreatedAt: c.CreatedAt.UTC().Format(time.RFC3339),
	}
}

func toAuthor(u *models.User) *AuthorResponse {
	if u == nil {
		return nil
	}
	return &AuthorResponse{
		ID:       u.ID.String(),
		Username: u.Username,
		FullName: u.FullName,
		Avatar:   u.Avatar,
	}
}
