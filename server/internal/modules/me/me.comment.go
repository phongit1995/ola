package me

import (
	"errors"
	"strings"
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

func (s *Service) AddComment(viewerID, postID uuid.UUID, req *CreateCommentRequest) (*CommentResponse, error) {
	post, err := s.viewablePost(viewerID, postID)
	if err != nil {
		return nil, err
	}

	if viewerID != post.AuthorID {
		settings, err := s.userSettingSvc.GetSettings(post.AuthorID)
		if err != nil {
			return nil, err
		}
		if settings.CommentPrivacy == models.SettingCommentPrivacyFriends && !s.isFriend(viewerID, post.AuthorID) {
			return nil, errMeCommentFriendsOnly
		}
	}

	var parent *models.MeComment
	if req.ParentID != nil {
		parentID, parseErr := uuid.Parse(*req.ParentID)
		if parseErr != nil {
			return nil, errors.New("comment not found")
		}
		parent, err = s.repo.GetCommentByID(parentID)
		if err != nil {
			if errors.Is(err, gorm.ErrRecordNotFound) {
				return nil, errors.New("comment not found")
			}
			return nil, err
		}
		if parent.PostID != postID {
			return nil, errors.New("comment not found")
		}
	}

	comment := &models.MeComment{
		PostID:   postID,
		AuthorID: viewerID,
		Content:  strings.TrimSpace(req.Content),
	}
	if parent != nil {
		comment.ParentID = &parent.ID
	}
	created, err := s.repo.CreateComment(comment)
	if err != nil {
		return nil, err
	}
	commentID := created.ID
	directRecipient := post.AuthorID
	if parent != nil {
		directRecipient = parent.AuthorID
		s.createMeNotification(parent.AuthorID, viewerID, models.MeNotificationReply, postID, &commentID, excerptText(created.Content))
	} else {
		s.createMeNotification(post.AuthorID, viewerID, models.MeNotificationComment, postID, &commentID, excerptText(created.Content))
	}
	s.notifyCommentMentions(viewerID, directRecipient, postID, commentID, created.Content)
	resp := toCommentResponse(created)
	resp.ReplyTo = replySnapshotFrom(parent)
	return &resp, nil
}

func (s *Service) ListComments(viewerID, postID uuid.UUID, limit, offset int) (*CommentListResponse, error) {
	if _, err := s.viewablePost(viewerID, postID); err != nil {
		return nil, err
	}

	comments, total, err := s.repo.ListComments(postID, limit, offset)
	if err != nil {
		return nil, err
	}

	parentIDs := make([]uuid.UUID, 0)
	for _, c := range comments {
		if c.ParentID != nil {
			parentIDs = append(parentIDs, *c.ParentID)
		}
	}
	parentByID := make(map[uuid.UUID]*models.MeComment)
	if len(parentIDs) > 0 {
		parents, perr := s.repo.GetCommentsByIDs(parentIDs)
		if perr != nil {
			return nil, perr
		}
		for _, p := range parents {
			parentByID[p.ID] = p
		}
	}

	likedCommentIDs := make([]uuid.UUID, 0, len(comments))
	for _, c := range comments {
		if c.LikeCount > 0 {
			likedCommentIDs = append(likedCommentIDs, c.ID)
		}
	}
	likedByViewer, err := s.repo.GetUserCommentLikes(viewerID, likedCommentIDs)
	if err != nil {
		return nil, err
	}
	topLikers, err := s.topLikersCached(CacheKeyMeCommentTopLikers, likedCommentIDs, func(ids []uuid.UUID) (map[uuid.UUID][]uuid.UUID, error) {
		return s.repo.TopCommentLikerIDsByComments(ids, 3)
	})
	if err != nil {
		return nil, err
	}

	items := make([]CommentResponse, 0, len(comments))
	for _, c := range comments {
		resp := toCommentResponse(c)
		resp.Liked = likedByViewer[c.ID]
		if likers, ok := topLikers[c.ID]; ok {
			resp.TopLikers = likers
		}
		if c.ParentID != nil {
			resp.ReplyTo = replySnapshotFrom(parentByID[*c.ParentID])
		}
		items = append(items, resp)
	}
	return &CommentListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) CommentLikers(viewerID, postID, commentID uuid.UUID, limit, offset int) (*LikerListResponse, error) {
	if _, err := s.viewablePost(viewerID, postID); err != nil {
		return nil, err
	}

	comment, err := s.repo.GetCommentByID(commentID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errors.New("comment not found")
		}
		return nil, err
	}
	if comment.PostID != postID {
		return nil, errors.New("comment not found")
	}

	rows, total, err := s.repo.ListCommentLikers(viewerID, commentID, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]AuthorResponse, 0, len(rows))
	for _, row := range rows {
		items = append(items, AuthorResponse{
			ID:            row.ID.String(),
			Username:      row.Username,
			FullName:      row.FullName,
			Avatar:        row.Avatar,
			AvatarFrameID: row.activeAvatarFrameID(),
			IsFriend:      row.IsFriend,
			IsSelf:        row.ID == viewerID,
		})
	}
	return &LikerListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) ToggleCommentLike(viewerID, postID, commentID uuid.UUID) (*CommentResponse, error) {
	if _, err := s.viewablePost(viewerID, postID); err != nil {
		return nil, err
	}

	comment, err := s.repo.GetCommentByID(commentID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errors.New("comment not found")
		}
		return nil, err
	}
	if comment.PostID != postID {
		return nil, errors.New("comment not found")
	}

	release, err := s.acquireLikeGuard(viewerID.String(), commentID.String())
	if err != nil {
		return nil, err
	}
	defer release()

	liked, likeCount, err := s.repo.ToggleCommentLike(commentID, viewerID)
	if err != nil {
		return nil, err
	}
	s.invalidateTopLikers(CacheKeyMeCommentTopLikers, commentID)
	if liked {
		s.createMeNotification(comment.AuthorID, viewerID, models.MeNotificationCommentLike, postID, &commentID, excerptText(comment.Content))
	} else {
		s.removeMeNotification(comment.AuthorID, viewerID, models.MeNotificationCommentLike, postID, &commentID)
	}

	resp := toCommentResponse(comment)
	resp.LikeCount = likeCount
	resp.Liked = liked
	topLikers, err := s.topLikersCached(CacheKeyMeCommentTopLikers, []uuid.UUID{commentID}, func(ids []uuid.UUID) (map[uuid.UUID][]uuid.UUID, error) {
		return s.repo.TopCommentLikerIDsByComments(ids, 3)
	})
	if err == nil {
		resp.TopLikers = topLikers[commentID]
	}
	return &resp, nil
}

func (s *Service) DeleteComment(viewerID, postID, commentID uuid.UUID) error {
	post, err := s.getPost(postID)
	if err != nil {
		return err
	}

	comment, err := s.repo.GetCommentByID(commentID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return errors.New("comment not found")
		}
		return err
	}
	if comment.PostID != postID {
		return errors.New("comment not found")
	}
	if comment.AuthorID != viewerID && post.AuthorID != viewerID {
		return errors.New("not your comment")
	}
	if err := s.repo.DeleteComment(postID, commentID); err != nil {
		return err
	}
	s.cleanupCommentNotifications(commentID)
	return nil
}

func toCommentResponse(comment *models.MeComment) CommentResponse {
	resp := CommentResponse{
		ID:        comment.ID.String(),
		PostID:    comment.PostID.String(),
		Content:   comment.Content,
		Author:    toAuthorResponse(comment.Author),
		LikeCount: comment.LikeCount,
		CreatedAt: comment.CreatedAt.UTC().Format(time.RFC3339),
	}
	if comment.ParentID != nil {
		resp.ParentID = comment.ParentID.String()
	}
	return resp
}

func commentAuthorName(comment *models.MeComment) string {
	if comment == nil || comment.Author == nil {
		return ""
	}
	if comment.Author.FullName != "" {
		return comment.Author.FullName
	}
	return comment.Author.Username
}

func replySnapshotFrom(parent *models.MeComment) *CommentReplySnapshot {
	if parent == nil {
		return nil
	}
	return &CommentReplySnapshot{
		CommentID:  parent.ID.String(),
		AuthorName: commentAuthorName(parent),
		Excerpt:    excerptText(parent.Content),
	}
}
