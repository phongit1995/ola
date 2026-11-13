package me

import (
	"time"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

func (s *Service) Feed(viewerID uuid.UUID, filter, cursor string, limit int) (*MeFeedResponse, error) {
	cursorTime, cursorID, err := utils.DecodeTimeCursor(cursor)
	if err != nil {
		return nil, err
	}
	posts, hasMore, err := s.repo.FeedPage(viewerID, filter, cursorTime, cursorID, limit)
	if err != nil {
		return nil, err
	}
	items, err := s.enrich(viewerID, posts)
	if err != nil {
		return nil, err
	}
	var nextCursor string
	if hasMore && len(posts) > 0 {
		last := posts[len(posts)-1]
		nextCursor = utils.EncodeTimeCursor(last.CreatedAt, last.ID)
	}
	return &MeFeedResponse{Items: items, NextCursor: nextCursor}, nil
}

func (s *Service) ClanFeed(viewerID, clanID uuid.UUID, excludeID *uuid.UUID, cursor string, limit int) (*MeFeedResponse, error) {
	cursorTime, cursorID, err := utils.DecodeTimeCursor(cursor)
	if err != nil {
		return nil, err
	}
	posts, hasMore, err := s.repo.ListByClanPage(clanID, viewerID, excludeID, cursorTime, cursorID, limit)
	if err != nil {
		return nil, err
	}
	items, err := s.enrich(viewerID, posts)
	if err != nil {
		return nil, err
	}
	var nextCursor string
	if hasMore && len(posts) > 0 {
		last := posts[len(posts)-1]
		nextCursor = utils.EncodeTimeCursor(last.CreatedAt, last.ID)
	}
	return &MeFeedResponse{Items: items, NextCursor: nextCursor}, nil
}

func (s *Service) ListMine(userID uuid.UUID, limit, offset int) (*MeListResponse, error) {
	all := []models.MeVisibility{models.MeVisibilityPublic, models.MeVisibilityFriend, models.MeVisibilityPrivate}
	posts, total, err := s.repo.ListByAuthor(userID, all, limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildList(userID, posts, total, limit, offset)
}

func (s *Service) ListMyPhotos(userID uuid.UUID, limit, offset int) (*MePhotoListResponse, error) {
	all := []models.MeVisibility{models.MeVisibilityPublic, models.MeVisibilityFriend, models.MeVisibilityPrivate}
	rows, total, err := s.repo.ListPhotosByAuthor(userID, all, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]MePhotoResponse, 0, len(rows))
	for _, row := range rows {
		items = append(items, MePhotoResponse{
			URL:       row.URL,
			Width:     row.Width,
			Height:    row.Height,
			MimeType:  row.MimeType,
			PostID:    row.PostID.String(),
			CreatedAt: row.CreatedAt.UTC().Format(time.RFC3339),
		})
	}
	return &MePhotoListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) ListLiked(userID uuid.UUID, limit, offset int) (*MeListResponse, error) {
	posts, total, err := s.repo.ListLikedByUser(userID, limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildList(userID, posts, total, limit, offset)
}

func (s *Service) ListByUser(viewerID, authorID uuid.UUID, limit, offset int) (*MeListResponse, error) {
	scopes := []models.MeVisibility{models.MeVisibilityPublic, models.MeVisibilityFriend, models.MeVisibilityPrivate}
	if viewerID != authorID {
		blocked, err := s.relRepo.IsBlocked(authorID, viewerID)
		if err != nil {
			return nil, err
		}
		if blocked {
			return nil, apperr.ErrUserNotFound
		}
		friends, err := s.relRepo.AreFriends(viewerID, authorID)
		if err != nil {
			return nil, err
		}
		if friends {
			scopes = []models.MeVisibility{models.MeVisibilityPublic, models.MeVisibilityFriend}
		} else {
			settings, err := s.userSettingSvc.GetSettings(authorID)
			if err != nil {
				return nil, err
			}
			if settings.MeVisibility == models.SettingMeVisibilityFriends {
				return nil, errMeFriendsOnly
			}
			scopes = []models.MeVisibility{models.MeVisibilityPublic}
		}
	}
	posts, total, err := s.repo.ListByAuthor(authorID, scopes, limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildList(viewerID, posts, total, limit, offset)
}

func (s *Service) buildList(viewerID uuid.UUID, posts []*models.Me, total int64, limit, offset int) (*MeListResponse, error) {
	items, err := s.enrich(viewerID, posts)
	if err != nil {
		return nil, err
	}
	return &MeListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) enrich(viewerID uuid.UUID, posts []*models.Me) ([]MeResponse, error) {
	ids := make([]uuid.UUID, 0, len(posts))
	likedPostIDs := make([]uuid.UUID, 0, len(posts))
	for _, p := range posts {
		ids = append(ids, p.ID)
		if p.LikeCount > 0 {
			likedPostIDs = append(likedPostIDs, p.ID)
		}
	}

	reactions, err := s.repo.GetUserReactions(viewerID, ids)
	if err != nil {
		return nil, err
	}

	topLikers, err := s.topLikersCached(CacheKeyMePostTopLikers, likedPostIDs, func(missIDs []uuid.UUID) (map[uuid.UUID][]uuid.UUID, error) {
		return s.repo.TopLikerIDsByPosts(missIDs, 3)
	})
	if err != nil {
		return nil, err
	}

	items := make([]MeResponse, 0, len(posts))
	for _, p := range posts {
		var mr *models.MeReactionType
		if t, ok := reactions[p.ID]; ok {
			rt := t
			mr = &rt
		}
		resp := toMeResponse(p, mr)
		if likers, ok := topLikers[p.ID]; ok {
			resp.TopLikers = likers
		}
		items = append(items, resp)
	}
	return items, nil
}
