package user

import (
	"context"
	"encoding/base64"
	"errors"
	"mime/multipart"
	"strings"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/relationships"
	usersetting "ola-chat-server/internal/modules/user-setting"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/websocket"
	"time"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type Service struct {
	repo           *Repository
	relRepo        *relationships.Repository
	userSettingSvc *usersetting.Service
	cache          *CacheService
	s3Service      *services.S3Service
	cacheService   *services.CacheService
	presence       *websocket.PresenceService
	db             *gorm.DB
	logger         *zap.SugaredLogger
}

func NewService(
	repo *Repository,
	relRepo *relationships.Repository,
	userSettingSvc *usersetting.Service,
	cache *CacheService,
	s3Service *services.S3Service,
	cacheService *services.CacheService,
	presence *websocket.PresenceService,
	db *gorm.DB,
	logger *zap.SugaredLogger,
) *Service {
	return &Service{
		repo:           repo,
		relRepo:        relRepo,
		userSettingSvc: userSettingSvc,
		cache:          cache,
		s3Service:      s3Service,
		cacheService:   cacheService,
		presence:       presence,
		db:             db,
		logger:         logger.Named("[user_service]"),
	}
}

func (s *Service) GetProfile(userID uuid.UUID) (*UserProfileResponse, error) {
	s.logger.Debugw("Fetching user profile",
		"user_id", userID,
	)

	user, err := s.repo.FindByID(userID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			s.logger.Warnw("User not found",
				"user_id", userID,
			)
			return nil, apperr.ErrUserNotFound
		}
		s.logger.Errorw("Database error while fetching user",
			"user_id", userID,
			"error", err.Error(),
		)
		return nil, err
	}

	if err := s.cache.SetUser(user.ID, user); err != nil {
		s.logger.Warnw("Failed to refresh user profile cache",
			"user_id", userID,
			"error", err.Error(),
		)
	}

	s.logger.Debugw("User profile fetched successfully",
		"user_id", userID,
		"username", user.Username,
	)

	return s.buildProfileResponse(user), nil
}

func applyProfileUpdates(user *models.User, req *UpdateProfileRequest) error {
	if req.Avatar != "" {
		user.Avatar = req.Avatar
	}
	if req.Phone != "" {
		user.Phone = req.Phone
	}
	if req.FullName != "" {
		user.FullName = req.FullName
	}
	if req.Gender != "" {
		user.Gender = req.Gender
	}
	if req.Bio != nil {
		user.Bio = *req.Bio
	}
	if req.DateOfBirth != "" {
		dob, err := time.Parse("2006-01-02", req.DateOfBirth)
		if err != nil {
			return errors.New("invalid date format, use YYYY-MM-DD")
		}
		user.DateOfBirth = &dob
	}
	if req.CoverPhoto != "" {
		user.CoverPhoto = req.CoverPhoto
	}
	if req.BioImage != nil {
		if *req.BioImage == "" {
			user.BioImage = nil
		} else {
			user.BioImage = req.BioImage
		}
	}
	if req.CustomInfo != nil {
		user.CustomInfo = models.JSONB(req.CustomInfo)
	}
	return nil
}

func (s *Service) UpdateProfile(userID uuid.UUID, req *UpdateProfileRequest) (*UserProfileResponse, error) {
	s.logger.Debugw("Updating user profile",
		"user_id", userID,
	)

	user, err := s.repo.FindByID(userID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			s.logger.Warnw("User not found",
				"user_id", userID,
			)
			return nil, apperr.ErrUserNotFound
		}
		s.logger.Errorw("Database error while fetching user",
			"user_id", userID,
			"error", err.Error(),
		)
		return nil, err
	}

	if err := applyProfileUpdates(user, req); err != nil {
		s.logger.Warnw("Invalid profile update", "user_id", userID, "error", err.Error())
		return nil, err
	}

	if err := s.repo.Update(user); err != nil {
		s.logger.Errorw("Failed to update user profile",
			"user_id", userID,
			"error", err.Error(),
		)
		return nil, err
	}

	if err := s.cache.InvalidateUser(user.ID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache",
			"user_id", userID,
			"error", err.Error(),
		)
	}

	if err := s.cache.SetUser(user.ID, user); err != nil {
		s.logger.Warnw("Failed to update user cache",
			"user_id", userID,
			"error", err.Error(),
		)
	}

	s.logger.Infow("User profile updated successfully",
		"user_id", userID,
		"username", user.Username,
	)

	return s.buildProfileResponse(user), nil
}

func (s *Service) SearchUsers(query string, limit int, currentUserID uuid.UUID) (*SearchUsersResponse, error) {
	s.logger.Debugw("Searching users",
		"query", query,
		"limit", limit,
		"current_user_id", currentUserID,
	)

	if query == "" {
		return &SearchUsersResponse{Users: []UserSearchResult{}, Total: 0}, nil
	}

	if limit <= 0 || limit > 50 {
		limit = 20
	}

	users, err := s.repo.Search(query, limit, &currentUserID)
	if err != nil {
		s.logger.Errorw("Failed to search users",
			"query", query,
			"error", err.Error(),
		)
		return nil, err
	}

	userIDs := make([]string, len(users))
	userUUIDs := make([]uuid.UUID, len(users))
	for i, u := range users {
		userIDs[i] = u.ID.String()
		userUUIDs[i] = u.ID
	}
	presenceMap := s.presence.GetPresenceBatch(userIDs)
	relMap := s.relationshipMap(currentUserID, userUUIDs)

	results := make([]UserSearchResult, 0, len(users))
	for _, user := range users {
		rel := relMap[user.ID]
		results = append(results, UserSearchResult{
			ID:           user.ID.String(),
			Username:     user.Username,
			FullName:     user.FullName,
			Avatar:       user.Avatar,
			Bio:          user.Bio,
			IsOnline:     presenceMap[user.ID.String()].IsOnline,
			Relationship: rel.status,
			RequestID:    rel.requestID,
			VipUsed:      user.VipUsed,
			VipEndTime:   formatOptionalTime(user.VipEndTime),
		})
	}

	s.logger.Debugw("User search completed",
		"query", query,
		"results_count", len(results),
	)

	return &SearchUsersResponse{
		Users: results,
		Total: len(results),
	}, nil
}

type searchRelation struct {
	status    string
	requestID string
}

func (s *Service) relationshipMap(meID uuid.UUID, otherIDs []uuid.UUID) map[uuid.UUID]searchRelation {
	out := map[uuid.UUID]searchRelation{}
	rels, err := s.repo.RelationshipsBetween(meID, otherIDs)
	if err != nil {
		s.logger.Warnw("Failed to load relationships for search", "error", err.Error())
		return out
	}
	for _, rel := range rels {
		iSent := rel.RequesterID == meID
		var status string
		switch rel.Status {
		case models.RelationshipStatusAccepted:
			status = RelationshipStatusFriend
		case models.RelationshipStatusPending:
			status = RelationshipStatusPendingOutgoing
			if !iSent {
				status = RelationshipStatusPendingIncoming
			}
		case models.RelationshipStatusBlocked:
			status = RelationshipStatusBlockedByMe
			if !iSent {
				status = RelationshipStatusBlockedByThem
			}
		default:
			continue
		}
		other := rel.AddresseeID
		if !iSent {
			other = rel.RequesterID
		}
		out[other] = searchRelation{status: status, requestID: rel.ID.String()}
	}
	return out
}

func (s *Service) GetPresenceBatch(userIDs []string) *PresenceBatchResponse {
	presenceMap := s.presence.GetPresenceBatch(userIDs)

	users := make([]UserPresence, 0, len(userIDs))
	for _, id := range userIDs {
		info := presenceMap[id]
		users = append(users, UserPresence{
			UserID:       id,
			IsOnline:     info.IsOnline,
			LastActiveAt: info.LastActiveAt,
		})
	}

	return &PresenceBatchResponse{Users: users}
}

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
	s.recordProfileView(callerID, user.ID)
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
	s.recordProfileView(callerID, user.ID)
	return s.buildPublicProfile(callerID, user), nil
}

func (s *Service) recordProfileView(viewerID, ownerID uuid.UUID) {
	if viewerID == uuid.Nil || viewerID == ownerID {
		return
	}
	go func() {
		if err := s.repo.RecordProfileView(viewerID, ownerID); err != nil {
			s.logger.Warnw("Failed to record profile view",
				"viewer_id", viewerID, "owner_id", ownerID, "error", err.Error())
		}
	}()
}

func (s *Service) GetMyVisitors(meID uuid.UUID, cursor string, limit int) (*VisitorListResponse, error) {
	cursorTime, cursorID, err := decodeVisitorCursor(cursor)
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
			ID:         row.ID.String(),
			Username:   row.Username,
			FullName:   row.FullName,
			Avatar:     row.Avatar,
			VipUsed:    row.VipUsed,
			VipEndTime: formatOptionalTime(row.VipEndTime),
			ViewedAt:   row.ViewedAt.Format(time.RFC3339),
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
		nextCursor = encodeVisitorCursor(last.ViewedAt, last.ID)
	}

	return &VisitorListResponse{
		Users:      items,
		NextCursor: nextCursor,
	}, nil
}

func encodeVisitorCursor(t time.Time, id uuid.UUID) string {
	raw := t.UTC().Format(time.RFC3339Nano) + "|" + id.String()
	return base64.RawURLEncoding.EncodeToString([]byte(raw))
}

func decodeVisitorCursor(cursor string) (*time.Time, *uuid.UUID, error) {
	if cursor == "" {
		return nil, nil, nil
	}
	data, err := base64.RawURLEncoding.DecodeString(cursor)
	if err != nil {
		return nil, nil, errors.New("invalid cursor")
	}
	parts := strings.SplitN(string(data), "|", 2)
	if len(parts) != 2 {
		return nil, nil, errors.New("invalid cursor")
	}
	t, err := time.Parse(time.RFC3339Nano, parts[0])
	if err != nil {
		return nil, nil, errors.New("invalid cursor")
	}
	id, err := uuid.Parse(parts[1])
	if err != nil {
		return nil, nil, errors.New("invalid cursor")
	}
	return &t, &id, nil
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

func (s *Service) canSeeVipStore(callerID, ownerID uuid.UUID, rel *RelationshipInfo) bool {
	if callerID == ownerID {
		return true
	}
	settings, err := s.userSettingSvc.GetSettings(ownerID)
	if err != nil {
		return true
	}
	switch settings.VipStorePrivacy {
	case 2:
		return false
	case 1:
		return rel != nil && rel.Status == RelationshipStatusFriend
	default:
		return true
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
		Kisses:         user.Kisses,
		VipUsed:        user.VipUsed,
		VipEndTime:     formatOptionalTime(user.VipEndTime),
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

	response.CanViewVipStore = s.canSeeVipStore(callerID, user.ID, response.Relationship)

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
	for i, u := range users {
		ids[i] = u.ID.String()
		items[i] = FollowUser{
			ID:       u.ID.String(),
			Username: u.Username,
			FullName: u.FullName,
			Avatar:   u.Avatar,
			Bio:      u.Bio,
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

func (s *Service) invalidateUsers(ids ...uuid.UUID) {
	for _, id := range ids {
		if err := s.cache.InvalidateUser(id); err != nil {
			s.logger.Warnw("Failed to invalidate user cache",
				"user_id", id, "error", err.Error())
		}
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

func (s *Service) resolveRelationship(callerID, targetID uuid.UUID) *RelationshipInfo {
	if callerID == uuid.Nil {
		return nil
	}
	if callerID == targetID {
		return &RelationshipInfo{Status: RelationshipStatusSelf}
	}
	rel, err := s.relRepo.FindByUsers(callerID, targetID)
	if err != nil {
		if !errors.Is(err, gorm.ErrRecordNotFound) {
			s.logger.Warnw("resolveRelationship lookup failed", "err", err)
		}
		return &RelationshipInfo{Status: RelationshipStatusNone}
	}

	info := &RelationshipInfo{RequestID: rel.ID.String()}
	if rel.ActionedAt != nil {
		info.Since = rel.ActionedAt.Format(time.RFC3339)
	} else {
		info.Since = rel.CreatedAt.Format(time.RFC3339)
	}

	switch rel.Status {
	case models.RelationshipStatusAccepted:
		info.Status = RelationshipStatusFriend
	case models.RelationshipStatusPending:
		if rel.RequesterID == callerID {
			info.Status = RelationshipStatusPendingOutgoing
		} else {
			info.Status = RelationshipStatusPendingIncoming
		}
	case models.RelationshipStatusBlocked:
		if rel.RequesterID == callerID {
			info.Status = RelationshipStatusBlockedByMe
		} else {
			info.Status = RelationshipStatusBlockedByThem
		}
	default:
		info.Status = RelationshipStatusNone
	}
	return info
}

func (s *Service) buildProfileResponse(user *models.User) *UserProfileResponse {
	response := &UserProfileResponse{
		ID:             user.ID.String(),
		Username:       user.Username,
		Email:          user.Email,
		Avatar:         user.Avatar,
		Phone:          user.Phone,
		FullName:       user.FullName,
		Gender:         user.Gender,
		Bio:            user.Bio,
		CustomInfo:     user.CustomInfo,
		Ken:            user.Ken,
		VipUsed:        user.VipUsed,
		FollowerCount:  user.FollowerCount,
		FollowingCount: user.FollowingCount,
		CoverPhoto:     user.CoverPhoto,
		BioImage:       user.BioImage,
		Verified:       user.Verified,
		EmailVerified:  user.EmailVerified,
		Kisses:         user.Kisses,
		CreatedAt:      user.CreatedAt.Format(time.RFC3339),
		UpdatedAt:      user.UpdatedAt.Format(time.RFC3339),
	}

	if user.DateOfBirth != nil {
		response.DateOfBirth = user.DateOfBirth.Format("2006-01-02")
	}

	if user.VipEndTime != nil {
		vipEndTime := user.VipEndTime.Format(time.RFC3339)
		response.VipEndTime = &vipEndTime
	}

	response.Spouse = s.resolveSpouse(user)

	return response
}

func (s *Service) resolveSpouse(user *models.User) *SpouseInfo {
	if user.SpouseID == nil {
		return nil
	}
	spouse, err := s.cache.GetUserCache(*user.SpouseID, true)
	if err != nil || spouse == nil {
		return nil
	}
	return &SpouseInfo{
		ID:       user.SpouseID.String(),
		Username: spouse.Username,
		FullName: spouse.FullName,
		Avatar:   spouse.Avatar,
	}
}

func (s *Service) UploadImage(ctx context.Context, userID uuid.UUID, file multipart.File, filename string) (*UploadAvatarResponse, error) {
	s.logger.Infow("Uploading image",
		"user_id", userID,
		"filename", filename,
	)

	result, err := s.s3Service.UploadFile(ctx, file, filename, constants.UploadFolderAvatar)
	if err != nil {
		s.logger.Errorw("Failed to upload image to S3",
			"user_id", userID,
			"error", err.Error(),
		)
		return nil, err
	}

	s.logger.Infow("Image uploaded successfully",
		"user_id", userID,
		"url", result.SecureURL,
	)

	return &UploadAvatarResponse{
		URL:       result.URL,
		SecureURL: result.SecureURL,
		PublicID:  result.PublicID,
		Format:    result.Format,
		Width:     result.Width,
		Height:    result.Height,
	}, nil
}
