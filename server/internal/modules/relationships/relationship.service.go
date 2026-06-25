package relationships

import (
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"
	"bytes"
	"errors"
	"fmt"
	"hash/fnv"
	"time"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

func nowPtr() *time.Time {
	t := time.Now()
	return &t
}

func addFollowTx(tx *gorm.DB, followerID, followeeID uuid.UUID) error {
	follow := models.Follow{FollowerID: followerID, FolloweeID: followeeID}
	res := tx.Clauses(clause.OnConflict{DoNothing: true}).Create(&follow)
	if res.Error != nil {
		return res.Error
	}
	if res.RowsAffected == 0 {
		return nil
	}
	if err := tx.Model(&models.User{}).Where("id = ?", followeeID).
		UpdateColumn("follower_count", gorm.Expr("follower_count + 1")).Error; err != nil {
		return err
	}
	return tx.Model(&models.User{}).Where("id = ?", followerID).
		UpdateColumn("following_count", gorm.Expr("following_count + 1")).Error
}

func addMutualFollowTx(tx *gorm.DB, a, b uuid.UUID) error {
	if err := addFollowTx(tx, a, b); err != nil {
		return err
	}
	return addFollowTx(tx, b, a)
}

func removeFollowTx(tx *gorm.DB, followerID, followeeID uuid.UUID) error {
	res := tx.Where("follower_id = ? AND followee_id = ?", followerID, followeeID).
		Delete(&models.Follow{})
	if res.Error != nil {
		return res.Error
	}
	if res.RowsAffected == 0 {
		return nil
	}
	if err := tx.Model(&models.User{}).Where("id = ? AND follower_count > 0", followeeID).
		UpdateColumn("follower_count", gorm.Expr("follower_count - 1")).Error; err != nil {
		return err
	}
	return tx.Model(&models.User{}).Where("id = ? AND following_count > 0", followerID).
		UpdateColumn("following_count", gorm.Expr("following_count - 1")).Error
}

func addAntiTx(tx *gorm.DB, blockedID uuid.UUID) error {
	return tx.Model(&models.User{}).Where("id = ?", blockedID).
		UpdateColumn("anti_count", gorm.Expr("anti_count + 1")).Error
}

func removeAntiTx(tx *gorm.DB, blockedID uuid.UUID) error {
	return tx.Model(&models.User{}).Where("id = ? AND anti_count > 0", blockedID).
		UpdateColumn("anti_count", gorm.Expr("anti_count - 1")).Error
}

func pairLockKey(a, b uuid.UUID) int64 {
	lo, hi := a, b
	if bytes.Compare(a[:], b[:]) > 0 {
		lo, hi = b, a
	}
	h := fnv.New64a()
	_, _ = h.Write(lo[:])
	_, _ = h.Write(hi[:])
	return int64(h.Sum64())
}

func lockPair(tx *gorm.DB, a, b uuid.UUID) error {
	return tx.Exec("SELECT pg_advisory_xact_lock(?)", pairLockKey(a, b)).Error
}

func checkFriendCap(repo *Repository, userID uuid.UUID, self bool) error {
	count, err := repo.CountFriends(userID)
	if err != nil {
		return err
	}
	if count >= constants.MaxFriendsPerUser {
		if self {
			return errors.New("you have reached the maximum number of friends")
		}
		return errors.New("this user has reached the maximum number of friends")
	}
	return nil
}

type Service struct {
	repo     *Repository
	presence *websocket.PresenceService
	cache    *services.CacheService
	db       *gorm.DB
	logger   *zap.SugaredLogger
}

func NewService(repo *Repository, presence *websocket.PresenceService, cache *services.CacheService, db *gorm.DB, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:     repo,
		presence: presence,
		cache:    cache,
		db:       db,
		logger:   logger.Named("[relationship_service]"),
	}
}

func (s *Service) SendFriendRequest(requesterID, addresseeID uuid.UUID) (*RelationshipResponse, error) {
	if requesterID == addresseeID {
		return nil, errors.New("cannot send friend request to yourself")
	}

	var result *RelationshipResponse
	var autoAcceptedA, autoAcceptedB uuid.UUID
	var didAutoAccept bool
	err := s.db.Transaction(func(tx *gorm.DB) error {
		if err := lockPair(tx, requesterID, addresseeID); err != nil {
			return err
		}
		txRepo := &Repository{db: tx}

		existing, err := txRepo.FindByUsers(requesterID, addresseeID)
		if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
			s.logger.Errorw("Failed to load existing relationship",
				"requester_id", requesterID, "addressee_id", addresseeID, "error", err.Error())
			return err
		}

		if existing != nil {
			switch existing.Status {
			case models.RelationshipStatusBlocked:
				if existing.RequesterID == requesterID {
					return errors.New("you have blocked this user, unblock first")
				}
				return errors.New("unable to send friend request")

			case models.RelationshipStatusAccepted:
				return errors.New("you are already friends")

			case models.RelationshipStatusPending:
				if existing.RequesterID == requesterID {
					return errors.New("friend request already sent")
				}
				if err := checkFriendCap(txRepo, requesterID, true); err != nil {
					return err
				}
				if err := checkFriendCap(txRepo, existing.RequesterID, false); err != nil {
					return err
				}
				existing.Status = models.RelationshipStatusAccepted
				existing.ActionedAt = nowPtr()
				if err := txRepo.Update(existing); err != nil {
					return err
				}
				if err := addMutualFollowTx(tx, existing.RequesterID, existing.AddresseeID); err != nil {
					return err
				}
				s.logger.Infow("Friend request auto-accepted (mutual pending)",
					"relationship_id", existing.ID, "requester_id", existing.RequesterID, "addressee_id", existing.AddresseeID)
				autoAcceptedA, autoAcceptedB = existing.RequesterID, existing.AddresseeID
				didAutoAccept = true
				result = s.buildRelationshipResponse(reloadOr(txRepo, existing))
				return nil

			case models.RelationshipStatusRejected:
				if err := txRepo.Delete(existing); err != nil {
					return err
				}
			}
		}

		if err := checkFriendCap(txRepo, requesterID, true); err != nil {
			return err
		}
		pendingSent, err := txRepo.CountPendingSent(requesterID)
		if err != nil {
			return err
		}
		if pendingSent >= constants.MaxPendingSentRequests {
			return errors.New("you have reached the maximum number of pending friend requests")
		}

		relationship := &models.Relationship{
			RequesterID: requesterID,
			AddresseeID: addresseeID,
			Status:      models.RelationshipStatusPending,
		}
		if err := txRepo.Create(relationship); err != nil {
			s.logger.Errorw("Failed to create friend request",
				"requester_id", requesterID, "addressee_id", addresseeID, "error", err.Error())
			return err
		}

		s.logger.Infow("Friend request sent",
			"relationship_id", relationship.ID, "requester_id", requesterID, "addressee_id", addresseeID)
		result = s.buildRelationshipResponse(reloadOr(txRepo, relationship))
		return nil
	})
	if err != nil {
		return nil, err
	}
	if didAutoAccept {
		s.invalidateFriendList(autoAcceptedA, autoAcceptedB)
	}
	return result, nil
}

func reloadOr(repo *Repository, rel *models.Relationship) *models.Relationship {
	reloaded, err := repo.FindByID(rel.ID)
	if err != nil || reloaded == nil {
		return rel
	}
	return reloaded
}

func (s *Service) AcceptFriendRequest(relationshipID, userID uuid.UUID) (*RelationshipResponse, error) {
	var result *RelationshipResponse
	var friendA, friendB uuid.UUID
	err := s.db.Transaction(func(tx *gorm.DB) error {
		txRepo := &Repository{db: tx}

		relationship, err := txRepo.FindByID(relationshipID)
		if err != nil {
			if errors.Is(err, gorm.ErrRecordNotFound) {
				return errors.New("friend request not found")
			}
			return err
		}

		if relationship.AddresseeID != userID {
			s.logger.Warnw("Unauthorized accept attempt",
				"relationship_id", relationshipID,
				"user_id", userID,
				"addressee_id", relationship.AddresseeID,
			)
			return errors.New("only the addressee can accept this request")
		}

		if relationship.Status != models.RelationshipStatusPending {
			return fmt.Errorf("cannot accept request with status: %s", relationship.Status)
		}

		if err := checkFriendCap(txRepo, userID, true); err != nil {
			return err
		}
		if err := checkFriendCap(txRepo, relationship.RequesterID, false); err != nil {
			return err
		}

		relationship.Status = models.RelationshipStatusAccepted
		relationship.ActionedAt = nowPtr()
		if err := txRepo.Update(relationship); err != nil {
			s.logger.Errorw("Failed to accept friend request",
				"relationship_id", relationshipID,
				"error", err.Error(),
			)
			return err
		}

		if err := addMutualFollowTx(tx, relationship.RequesterID, relationship.AddresseeID); err != nil {
			return err
		}

		s.logger.Infow("Friend request accepted",
			"relationship_id", relationshipID,
			"requester_id", relationship.RequesterID,
			"addressee_id", relationship.AddresseeID,
		)
		friendA, friendB = relationship.RequesterID, relationship.AddresseeID
		result = s.buildRelationshipResponse(reloadOr(txRepo, relationship))
		return nil
	})
	if err != nil {
		return nil, err
	}
	s.invalidateFriendList(friendA, friendB)
	return result, nil
}

func (s *Service) RejectFriendRequest(relationshipID, userID uuid.UUID) error {
	relationship, err := s.repo.FindByID(relationshipID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return errors.New("friend request not found")
		}
		return err
	}

	if relationship.AddresseeID != userID {
		s.logger.Warnw("Unauthorized reject attempt",
			"relationship_id", relationshipID,
			"user_id", userID,
			"addressee_id", relationship.AddresseeID,
		)
		return errors.New("only the addressee can reject this request")
	}

	if relationship.Status != models.RelationshipStatusPending {
		return fmt.Errorf("cannot reject request with status: %s", relationship.Status)
	}

	if err := s.repo.Delete(relationship); err != nil {
		s.logger.Errorw("Failed to reject friend request",
			"relationship_id", relationshipID, "error", err.Error())
		return err
	}

	s.logger.Infow("Friend request rejected",
		"relationship_id", relationshipID, "requester_id", relationship.RequesterID, "addressee_id", relationship.AddresseeID)

	return nil
}

func (s *Service) CancelFriendRequest(relationshipID, userID uuid.UUID) error {
	relationship, err := s.repo.FindByID(relationshipID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return errors.New("friend request not found")
		}
		return err
	}

	if relationship.RequesterID != userID {
		return errors.New("only the requester can cancel this request")
	}

	if relationship.Status != models.RelationshipStatusPending {
		return fmt.Errorf("cannot cancel request with status: %s", relationship.Status)
	}

	if err := s.repo.Delete(relationship); err != nil {
		s.logger.Errorw("Failed to cancel friend request",
			"relationship_id", relationshipID,
			"error", err.Error(),
		)
		return err
	}

	s.logger.Infow("Friend request cancelled",
		"relationship_id", relationshipID,
		"requester_id", relationship.RequesterID,
		"addressee_id", relationship.AddresseeID,
	)

	return nil
}

func (s *Service) Unfriend(relationshipID, userID uuid.UUID) error {
	relationship, err := s.repo.FindByID(relationshipID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return errors.New("friendship not found")
		}
		return err
	}

	if relationship.RequesterID != userID && relationship.AddresseeID != userID {
		return errors.New("you are not part of this friendship")
	}

	if relationship.Status != models.RelationshipStatusAccepted {
		return errors.New("can only unfriend accepted friendships")
	}

	if err := s.repo.Delete(relationship); err != nil {
		s.logger.Errorw("Failed to unfriend",
			"relationship_id", relationshipID,
			"error", err.Error(),
		)
		return err
	}

	s.invalidateFriendList(relationship.RequesterID, relationship.AddresseeID)

	s.logger.Infow("Unfriended successfully",
		"relationship_id", relationshipID,
		"user_id", userID,
	)

	return nil
}

func (s *Service) BlockUser(blockerID, blockedID uuid.UUID) (*RelationshipResponse, error) {
	if blockerID == blockedID {
		return nil, errors.New("cannot block yourself")
	}

	var result *RelationshipResponse
	err := s.db.Transaction(func(tx *gorm.DB) error {
		if err := lockPair(tx, blockerID, blockedID); err != nil {
			return err
		}
		txRepo := &Repository{db: tx}

		existing, err := txRepo.FindByUsers(blockerID, blockedID)
		if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
			return err
		}

		if existing != nil &&
			existing.Status == models.RelationshipStatusBlocked &&
			existing.RequesterID == blockedID {
			return errors.New("unable to block this user")
		}

		if existing != nil {
			if existing.Status == models.RelationshipStatusBlocked && existing.RequesterID == blockerID {
				result = s.buildRelationshipResponse(existing)
				return nil
			}
			if err := txRepo.Delete(existing); err != nil {
				return err
			}
		}

		relationship := &models.Relationship{
			RequesterID: blockerID,
			AddresseeID: blockedID,
			Status:      models.RelationshipStatusBlocked,
			ActionedAt:  nowPtr(),
		}
		if err := txRepo.Create(relationship); err != nil {
			return err
		}

		if err := removeFollowTx(tx, blockerID, blockedID); err != nil {
			return err
		}

		if err := addAntiTx(tx, blockedID); err != nil {
			return err
		}

		s.logger.Infow("User blocked successfully",
			"blocker_id", blockerID,
			"blocked_id", blockedID,
		)
		result = s.buildRelationshipResponse(reloadOr(txRepo, relationship))
		return nil
	})
	if err != nil {
		return nil, err
	}
	s.invalidateFriendList(blockerID, blockedID)
	return result, nil
}

func (s *Service) UnblockUser(relationshipID, userID uuid.UUID) error {
	var blockerID, blockedID uuid.UUID
	err := s.db.Transaction(func(tx *gorm.DB) error {
		txRepo := &Repository{db: tx}

		relationship, err := txRepo.FindByID(relationshipID)
		if err != nil {
			if errors.Is(err, gorm.ErrRecordNotFound) {
				return errors.New("block relationship not found")
			}
			return err
		}

		if relationship.RequesterID != userID {
			return errors.New("only the blocker can unblock this user")
		}

		if relationship.Status != models.RelationshipStatusBlocked {
			return errors.New("can only unblock blocked relationships")
		}

		if err := txRepo.Delete(relationship); err != nil {
			s.logger.Errorw("Failed to unblock user",
				"relationship_id", relationshipID,
				"error", err.Error(),
			)
			return err
		}

		if err := removeAntiTx(tx, relationship.AddresseeID); err != nil {
			return err
		}

		blockerID, blockedID = relationship.RequesterID, relationship.AddresseeID
		return nil
	})
	if err != nil {
		return err
	}

	s.invalidateFriendList(blockerID, blockedID)

	s.logger.Infow("User unblocked successfully",
		"relationship_id", relationshipID,
		"blocker_id", blockerID,
		"blocked_id", blockedID,
	)

	return nil
}

func (s *Service) GetPendingRequests(userID uuid.UUID, limit, offset int) (*RelationshipListResponse, error) {
	relationships, total, err := s.repo.GetPendingRequests(userID, limit, offset)
	if err != nil {
		return nil, err
	}

	responses := make([]RelationshipResponse, len(relationships))
	for i, rel := range relationships {
		responses[i] = *s.buildRelationshipResponse(&rel)
	}

	return &RelationshipListResponse{
		Relationships: responses,
		Total:         total,
		Limit:         limit,
		Offset:        offset,
	}, nil
}

func (s *Service) GetSentRequests(userID uuid.UUID, limit, offset int) (*RelationshipListResponse, error) {
	relationships, total, err := s.repo.GetSentRequests(userID, limit, offset)
	if err != nil {
		return nil, err
	}

	responses := make([]RelationshipResponse, len(relationships))
	for i, rel := range relationships {
		responses[i] = *s.buildRelationshipResponse(&rel)
	}

	return &RelationshipListResponse{
		Relationships: responses,
		Total:         total,
		Limit:         limit,
		Offset:        offset,
	}, nil
}

func (s *Service) GetFriends(userID uuid.UUID) (*FriendListResponse, error) {
	friends, err := s.getFriendBase(userID)
	if err != nil {
		return nil, err
	}

	if len(friends) > 0 {
		friendIDs := make([]string, len(friends))
		for i := range friends {
			friendIDs[i] = friends[i].ID
		}
		online := s.presence.GetOnlineUsers(friendIDs)
		lastActive := s.presence.GetLastActiveBatch(friendIDs)
		for i, id := range friendIDs {
			isOnline, lastActiveStr := utils.ApplyOnlineGrace(online[id], lastActive[id])
			friends[i].IsOnline = isOnline
			friends[i].LastActiveAt = lastActiveStr
		}
	}

	return &FriendListResponse{
		Friends: friends,
		Total:   int64(len(friends)),
	}, nil
}

func (s *Service) getFriendBase(userID uuid.UUID) ([]FriendResponse, error) {
	key := fmt.Sprintf(constants.CacheKeyFriendList, userID.String())

	if s.cache != nil {
		var cached []FriendResponse
		if err := s.cache.Get(key, &cached); err == nil {
			return cached, nil
		}
	}

	relationships, err := s.repo.GetAllFriends(userID)
	if err != nil {
		return nil, err
	}

	friends := make([]FriendResponse, 0, len(relationships))
	for _, rel := range relationships {
		var friend *models.User
		if rel.RequesterID == userID {
			friend = rel.Addressee
		} else {
			friend = rel.Requester
		}
		if friend == nil {
			continue
		}
		friends = append(friends, s.buildFriendBase(friend, rel.ActionedAt))
	}

	if s.cache != nil {
		if err := s.cache.Set(key, friends, constants.CacheTTLFriendList*time.Second); err != nil {
			s.logger.Warnw("Failed to cache friend list", "user_id", userID, "error", err.Error())
		}
	}

	return friends, nil
}

func (s *Service) buildFriendBase(u *models.User, actionedAt *time.Time) FriendResponse {
	friend := FriendResponse{
		ID:         u.ID.String(),
		Username:   u.Username,
		Email:      u.Email,
		Avatar:     u.Avatar,
		FullName:   u.FullName,
		Bio:        u.Bio,
		BioImage:   u.BioImage,
		DeviceType: "android",
		VipUsed:    u.VipUsed,
	}
	if u.DateOfBirth != nil {
		friend.DateOfBirth = u.DateOfBirth.Format("2006-01-02")
	}
	if u.VipEndTime != nil {
		vipEnd := u.VipEndTime.Format(time.RFC3339)
		friend.VipEndTime = &vipEnd
	}
	if actionedAt != nil {
		friend.FriendAt = actionedAt.Format("2006-01-02T15:04:05Z07:00")
	}
	return friend
}

func (s *Service) invalidateFriendList(userIDs ...uuid.UUID) {
	if s.cache == nil {
		return
	}
	for _, id := range userIDs {
		key := fmt.Sprintf(constants.CacheKeyFriendList, id.String())
		if err := s.cache.Delete(key); err != nil {
			s.logger.Warnw("Failed to invalidate friend list cache", "user_id", id, "error", err.Error())
		}
	}
}

func (s *Service) GetBlockedUsers(userID uuid.UUID, limit, offset int) (*RelationshipListResponse, error) {
	relationships, total, err := s.repo.GetBlockedUsers(userID, limit, offset)
	if err != nil {
		return nil, err
	}

	responses := make([]RelationshipResponse, len(relationships))
	for i, rel := range relationships {
		responses[i] = *s.buildRelationshipResponse(&rel)
	}

	return &RelationshipListResponse{
		Relationships: responses,
		Total:         total,
		Limit:         limit,
		Offset:        offset,
	}, nil
}

func (s *Service) buildRelationshipResponse(rel *models.Relationship) *RelationshipResponse {
	response := &RelationshipResponse{
		ID:          rel.ID.String(),
		RequesterID: rel.RequesterID.String(),
		AddresseeID: rel.AddresseeID.String(),
		Status:      string(rel.Status),
		CreatedAt:   rel.CreatedAt.Format("2006-01-02T15:04:05Z07:00"),
	}

	if rel.ActionedAt != nil {
		response.ActionedAt = rel.ActionedAt.Format("2006-01-02T15:04:05Z07:00")
	}

	if rel.Requester != nil {
		response.Requester = &UserInfo{
			ID:         rel.Requester.ID.String(),
			Username:   rel.Requester.Username,
			Email:      rel.Requester.Email,
			Avatar:     rel.Requester.Avatar,
			FullName:   rel.Requester.FullName,
			VipUsed:    rel.Requester.VipUsed,
			VipEndTime: formatVipEndTime(rel.Requester.VipEndTime),
		}
	}

	if rel.Addressee != nil {
		response.Addressee = &UserInfo{
			ID:         rel.Addressee.ID.String(),
			Username:   rel.Addressee.Username,
			Email:      rel.Addressee.Email,
			Avatar:     rel.Addressee.Avatar,
			FullName:   rel.Addressee.FullName,
			VipUsed:    rel.Addressee.VipUsed,
			VipEndTime: formatVipEndTime(rel.Addressee.VipEndTime),
		}
	}

	return response
}

func formatVipEndTime(t *time.Time) *string {
	if t == nil {
		return nil
	}
	formatted := t.Format(time.RFC3339)
	return &formatted
}
