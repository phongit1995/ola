package user

import (
	"errors"
	"time"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

func (s *Service) Follow(followerID, followeeID uuid.UUID) (*FollowResponse, error) {
	if followerID == followeeID {
		return nil, errors.New("cannot follow yourself")
	}

	target, err := s.repo.FindByID(followeeID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, apperr.ErrUserNotFound
		}
		return nil, err
	}

	blocked, err := s.isEitherBlocked(followerID, followeeID)
	if err != nil {
		return nil, err
	}
	if blocked {
		return nil, errors.New("cannot follow this user")
	}

	if _, err := s.repo.FollowTx(followerID, followeeID); err != nil {
		s.logger.Errorw("Failed to follow user",
			"follower_id", followerID, "followee_id", followeeID, "error", err.Error())
		return nil, err
	}

	s.invalidateUsers(followerID, followeeID)

	followerCount := target.FollowerCount + 1
	if updated, err := s.repo.FindByID(followeeID); err == nil && updated != nil {
		followerCount = updated.FollowerCount
	}
	return &FollowResponse{Following: true, FollowerCount: followerCount}, nil
}

func (s *Service) Unfollow(followerID, followeeID uuid.UUID) (*FollowResponse, error) {
	if followerID == followeeID {
		return nil, errors.New("cannot unfollow yourself")
	}

	if _, err := s.repo.UnfollowTx(followerID, followeeID); err != nil {
		s.logger.Errorw("Failed to unfollow user",
			"follower_id", followerID, "followee_id", followeeID, "error", err.Error())
		return nil, err
	}

	s.invalidateUsers(followerID, followeeID)

	followerCount := 0
	if updated, err := s.repo.FindByID(followeeID); err == nil && updated != nil {
		followerCount = updated.FollowerCount
	}
	return &FollowResponse{Following: false, FollowerCount: followerCount}, nil
}

func (s *Service) ListFollowers(callerID, userID uuid.UUID, limit, offset int) (*FollowListResponse, error) {
	if err := s.ensureNotBlockedByTarget(callerID, userID); err != nil {
		return nil, err
	}
	if callerID != userID {
		settings, err := s.userSettingSvc.GetSettings(userID)
		if err != nil {
			return nil, err
		}
		if !settings.ShowInterested {
			return s.buildFollowList(nil, 0, limit, offset), nil
		}
	}
	users, total, err := s.repo.ListFollowers(userID, limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildFollowList(users, total, limit, offset), nil
}

func (s *Service) ListFollowing(callerID, userID uuid.UUID, limit, offset int) (*FollowListResponse, error) {
	if err := s.ensureNotBlockedByTarget(callerID, userID); err != nil {
		return nil, err
	}
	if callerID != userID {
		settings, err := s.userSettingSvc.GetSettings(userID)
		if err != nil {
			return nil, err
		}
		if !settings.ShowInterested {
			return s.buildFollowList(nil, 0, limit, offset), nil
		}
	}
	users, total, err := s.repo.ListFollowing(userID, limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildFollowList(users, total, limit, offset), nil
}

func (s *Service) buildFollowList(users []*models.User, total int64, limit, offset int) *FollowListResponse {
	items := make([]FollowUser, len(users))
	ids := make([]string, len(users))
	now := time.Now()
	for i, u := range users {
		ids[i] = u.ID.String()
		items[i] = FollowUser{
			ID:            u.ID.String(),
			Username:      u.Username,
			FullName:      u.FullName,
			Avatar:        u.Avatar,
			Bio:           u.Bio,
			AvatarFrameID: u.ActiveAvatarFrameID(now),
		}
	}

	if len(ids) > 0 {
		presenceMap := s.presence.GetPresenceBatch(ids)
		for i, id := range ids {
			info := presenceMap[id]
			items[i].IsOnline = info.IsOnline
			items[i].LastActiveAt = info.LastActiveAt
		}
	}

	return &FollowListResponse{
		Users:  items,
		Total:  total,
		Limit:  limit,
		Offset: offset,
	}
}

func (s *Service) Kiss(callerID, targetUserID uuid.UUID) (*KissResponse, error) {
	if callerID == targetUserID {
		return nil, errors.New("cannot kiss yourself")
	}

	kisses, err := s.repo.IncrementKisses(targetUserID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, apperr.ErrUserNotFound
		}
		s.logger.Errorw("Failed to increment kisses",
			"target_user_id", targetUserID,
			"error", err.Error(),
		)
		return nil, err
	}

	if err := s.cache.InvalidateUser(targetUserID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after kiss",
			"target_user_id", targetUserID,
			"error", err.Error(),
		)
	}

	return &KissResponse{Kisses: kisses}, nil
}
