package user

import (
	"context"
	"errors"
	"mime/multipart"
	"time"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/relationships"
	"ola-chat-server/internal/modules/session"
	"ola-chat-server/internal/modules/setting"
	usersetting "ola-chat-server/internal/modules/user-setting"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/websocket"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type Service struct {
	repo           *Repository
	relRepo        *relationships.Repository
	userSettingSvc *usersetting.Service
	settingSvc     *setting.Service
	sessionSvc     *session.Service
	cache          *CacheService
	s3Service      *services.S3Service
	cacheService   *services.CacheService
	presence       *websocket.PresenceService
	logger         *zap.SugaredLogger
}

func NewService(
	repo *Repository,
	relRepo *relationships.Repository,
	userSettingSvc *usersetting.Service,
	settingSvc *setting.Service,
	sessionSvc *session.Service,
	cache *CacheService,
	s3Service *services.S3Service,
	cacheService *services.CacheService,
	presence *websocket.PresenceService,
	logger *zap.SugaredLogger,
) *Service {
	return &Service{
		repo:           repo,
		relRepo:        relRepo,
		userSettingSvc: userSettingSvc,
		settingSvc:     settingSvc,
		sessionSvc:     sessionSvc,
		cache:          cache,
		s3Service:      s3Service,
		cacheService:   cacheService,
		presence:       presence,
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
			ID:            user.ID.String(),
			Username:      user.Username,
			FullName:      user.FullName,
			Avatar:        user.Avatar,
			Bio:           user.Bio,
			IsOnline:      presenceMap[user.ID.String()].IsOnline,
			Relationship:  rel.status,
			RequestID:     rel.requestID,
			VipUsed:       user.VipUsed,
			VipEndTime:    formatOptionalTime(user.VipEndTime),
			AvatarFrameID: user.ActiveAvatarFrameID(time.Now()),
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

func (s *Service) invalidateUsers(ids ...uuid.UUID) {
	for _, id := range ids {
		if err := s.cache.InvalidateUser(id); err != nil {
			s.logger.Warnw("Failed to invalidate user cache",
				"user_id", id, "error", err.Error())
		}
	}
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
		AvatarFrameID:  user.ActiveAvatarFrameID(time.Now()),
		FollowerCount:  user.FollowerCount,
		FollowingCount: user.FollowingCount,
		CoverPhoto:     user.CoverPhoto,
		BioImage:       user.BioImage,
		Verified:       user.Verified,
		EmailVerified:  user.EmailVerified,
		Kisses:         user.Kisses,
		Charm:          user.Charm,
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

func (s *Service) resolveSpouse(user *models.User) *UserBrief {
	if user.SpouseID == nil {
		return nil
	}
	spouse, err := s.cache.GetUserCache(*user.SpouseID, true)
	if err != nil || spouse == nil {
		return nil
	}
	return &UserBrief{
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

	result, err := s.s3Service.UploadFile(ctx, file, filename, UploadFolderAvatar)
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
