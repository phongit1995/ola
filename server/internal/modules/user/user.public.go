package user

import (
	"errors"
	"time"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

func (s *Service) GetPublicProfile(callerID, targetUserID uuid.UUID) (*UserPublicProfileResponse, error) {
	user, err := s.repo.FindByID(targetUserID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, apperr.ErrUserNotFound
		}
		return nil, err
	}
	if err := s.ensureNotBlockedByTarget(callerID, user.ID); err != nil {
		return nil, err
	}
	return s.buildPublicProfile(callerID, user), nil
}

func (s *Service) GetPublicProfileByUsername(callerID uuid.UUID, username string) (*UserPublicProfileResponse, error) {
	user, err := s.repo.FindByUsername(username)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, apperr.ErrUserNotFound
		}
		return nil, err
	}
	if err := s.ensureNotBlockedByTarget(callerID, user.ID); err != nil {
		return nil, err
	}
	return s.buildPublicProfile(callerID, user), nil
}

func (s *Service) RecordProfileView(viewerID, ownerID uuid.UUID) (*ProfileViewResponse, error) {
	owner, err := s.repo.FindByID(ownerID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, apperr.ErrUserNotFound
		}
		return nil, err
	}
	if err := s.ensureNotBlockedByTarget(viewerID, owner.ID); err != nil {
		return nil, err
	}
	if viewerID == uuid.Nil || viewerID == ownerID {
		return &ProfileViewResponse{Recorded: false}, nil
	}
	if err := s.repo.RecordProfileView(viewerID, ownerID); err != nil {
		return nil, err
	}
	return &ProfileViewResponse{Recorded: true}, nil
}

func (s *Service) GetMyVisitors(meID uuid.UUID, cursor string, limit int) (*VisitorListResponse, error) {
	cursorTime, cursorID, err := utils.DecodeTimeCursor(cursor)
	if err != nil {
		return nil, err
	}
	rows, hasMore, err := s.repo.ListVisitors(meID, cursorTime, cursorID, limit)
	if err != nil {
		return nil, err
	}

	items := make([]VisitorUser, len(rows))
	ids := make([]string, len(rows))
	otherIDs := make([]uuid.UUID, len(rows))
	for i, row := range rows {
		ids[i] = row.ID.String()
		otherIDs[i] = row.ID
		items[i] = VisitorUser{
			ID:            row.ID.String(),
			Username:      row.Username,
			FullName:      row.FullName,
			Avatar:        row.Avatar,
			VipUsed:       row.VipUsed,
			VipEndTime:    formatOptionalTime(row.VipEndTime),
			AvatarFrameID: (&models.User{AvatarFrameID: row.AvatarFrameID, VipEndTime: row.VipEndTime}).ActiveAvatarFrameID(time.Now()),
			ViewedAt:      row.ViewedAt.Format(time.RFC3339),
		}
	}

	if len(otherIDs) > 0 {
		relMap := s.relationshipMap(meID, otherIDs)
		presenceMap := s.presence.GetPresenceBatch(ids)
		for i, id := range ids {
			items[i].IsOnline = presenceMap[id].IsOnline
			if rel, ok := relMap[otherIDs[i]]; ok {
				items[i].Relationship = &RelationshipInfo{Status: rel.status, RequestID: rel.requestID}
			} else {
				items[i].Relationship = &RelationshipInfo{Status: RelationshipStatusNone}
			}
		}
	}

	var nextCursor string
	if hasMore && len(rows) > 0 {
		last := rows[len(rows)-1]
		nextCursor = utils.EncodeTimeCursor(last.ViewedAt, last.ID)
	}

	return &VisitorListResponse{
		Users:      items,
		NextCursor: nextCursor,
	}, nil
}

func (s *Service) ensureNotBlockedByTarget(callerID, targetID uuid.UUID) error {
	if callerID == uuid.Nil || callerID == targetID {
		return nil
	}
	blocked, err := s.relRepo.IsBlocked(targetID, callerID)
	if err != nil {
		return err
	}
	if blocked {
		return apperr.ErrUserNotFound
	}
	return nil
}

func (s *Service) canSeeBirthday(callerID, ownerID uuid.UUID) bool {
	if callerID == ownerID {
		return true
	}
	settings, err := s.userSettingSvc.GetSettings(ownerID)
	if err != nil {
		return true
	}
	return settings.ShowBirthday
}

func (s *Service) canSeeInterested(callerID, ownerID uuid.UUID) bool {
	if callerID == ownerID {
		return true
	}
	settings, err := s.userSettingSvc.GetSettings(ownerID)
	if err != nil {
		return true
	}
	return settings.ShowInterested
}

type storeVisibility struct {
	vipStore         bool
	giftWall         bool
	avatarFrameStore bool
}

func privacyAllows(privacy int16, rel *RelationshipInfo) bool {
	switch privacy {
	case models.SettingGiftWallPrivacyOnlyMe:
		return false
	case models.SettingGiftWallPrivacyFriends:
		return rel != nil && rel.Status == RelationshipStatusFriend
	default:
		return true
	}
}

func (s *Service) resolveStoreVisibility(callerID, ownerID uuid.UUID, rel *RelationshipInfo) storeVisibility {
	if callerID == ownerID {
		return storeVisibility{vipStore: true, giftWall: true, avatarFrameStore: true}
	}
	settings, err := s.userSettingSvc.GetSettings(ownerID)
	if err != nil {
		return storeVisibility{vipStore: true, giftWall: true, avatarFrameStore: true}
	}
	return storeVisibility{
		vipStore:         privacyAllows(settings.VipStorePrivacy, rel),
		giftWall:         privacyAllows(settings.GiftWallPrivacy, rel),
		avatarFrameStore: privacyAllows(settings.AvatarFrameStorePrivacy, rel),
	}
}

func (s *Service) buildPublicProfile(callerID uuid.UUID, user *models.User) *UserPublicProfileResponse {
	idStr := user.ID.String()
	presence := s.presence.GetPresence(idStr)

	response := &UserPublicProfileResponse{
		ID:             idStr,
		Username:       user.Username,
		FullName:       user.FullName,
		Avatar:         user.Avatar,
		CoverPhoto:     user.CoverPhoto,
		BioImage:       user.BioImage,
		Bio:            user.Bio,
		Gender:         user.Gender,
		Verified:       user.Verified,
		EmailVerified:  user.EmailVerified,
		Kisses:         user.Kisses,
		Charm:          user.Charm,
		VipUsed:        user.VipUsed,
		VipEndTime:     formatOptionalTime(user.VipEndTime),
		AvatarFrameID:  user.ActiveAvatarFrameID(time.Now()),
		FollowerCount:  user.FollowerCount,
		FollowingCount: user.FollowingCount,
		AntiCount:      user.AntiCount,
		IsOnline:       presence.IsOnline,
		LastActiveAt:   presence.LastActiveAt,
		CreatedAt:      user.CreatedAt.Format(time.RFC3339),
		Relationship:   s.resolveRelationship(callerID, user.ID),
	}

	if user.DateOfBirth != nil && s.canSeeBirthday(callerID, user.ID) {
		response.DateOfBirth = user.DateOfBirth.Format("2006-01-02")
	}

	response.Spouse = s.resolveSpouse(user)

	s.applyFollowFlags(callerID, user.ID, response.Relationship)

	response.CanViewInterested = s.canSeeInterested(callerID, user.ID)
	if !response.CanViewInterested {
		response.FollowerCount = 0
		response.FollowingCount = 0
	}

	visibility := s.resolveStoreVisibility(callerID, user.ID, response.Relationship)
	response.CanViewVipStore = visibility.vipStore
	response.CanViewGiftWall = visibility.giftWall
	response.CanViewAvatarFrameStore = visibility.avatarFrameStore

	return response
}

func (s *Service) applyFollowFlags(callerID, targetID uuid.UUID, rel *RelationshipInfo) {
	if rel == nil || callerID == uuid.Nil || callerID == targetID {
		return
	}
	if isFollowing, err := s.repo.IsFollowing(callerID, targetID); err == nil {
		rel.IsFollowing = isFollowing
	}
	if followsMe, err := s.repo.IsFollowing(targetID, callerID); err == nil {
		rel.FollowsMe = followsMe
	}
}

func formatOptionalTime(t *time.Time) *string {
	if t == nil {
		return nil
	}
	formatted := t.Format(time.RFC3339)
	return &formatted
}

func (s *Service) isEitherBlocked(a, b uuid.UUID) (bool, error) {
	blocked, err := s.relRepo.IsBlocked(a, b)
	if err != nil {
		return false, err
	}
	if blocked {
		return true, nil
	}
	return s.relRepo.IsBlocked(b, a)
}
