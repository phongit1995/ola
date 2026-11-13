package room

import (
	"fmt"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

func (s *Service) ListBlockedUsers(userID uuid.UUID) (*RoomBlockedUsersResponse, error) {
	rows, err := s.blockRepo.ListBlocked(userID)
	if err != nil {
		return nil, err
	}
	return toRoomBlockedUsersResponse(rows), nil
}

func (s *Service) BlockUser(userID, blockedUserID uuid.UUID, migration bool) (*RoomBlockedUsersResponse, error) {
	if userID == blockedUserID {
		return nil, ErrRoomBlockSelf
	}
	exists, err := s.blockRepo.Exists(userID, blockedUserID)
	if err != nil {
		return nil, err
	}
	if exists {
		return s.ListBlockedUsers(userID)
	}
	unblockedKey := fmt.Sprintf(CacheKeyRoomUnblocked, userID.String(), blockedUserID.String())
	if migration {
		if unblocked, err := s.cache.Exists(unblockedKey); err == nil && unblocked {
			return s.ListBlockedUsers(userID)
		}
	}
	if target, err := s.userCache.GetUserCache(blockedUserID, true); err != nil || target == nil {
		return nil, ErrRoomBlockUserNotFound
	}
	count, err := s.blockRepo.CountBlocked(userID)
	if err != nil {
		return nil, err
	}
	if count >= RoomMaxBlockedUsers {
		return nil, ErrRoomBlockLimit
	}
	if err := s.blockRepo.Create(userID, blockedUserID); err != nil {
		return nil, err
	}
	if err := s.cache.Delete(unblockedKey); err != nil {
		s.logger.Warnw("Failed to clear room unblock marker", "user_id", userID, "blocked_user_id", blockedUserID, "error", err.Error())
	}
	s.emitBlockListChanged(userID, blockedUserID, true)
	return s.ListBlockedUsers(userID)
}

func (s *Service) UnblockUser(userID, blockedUserID uuid.UUID) (*RoomBlockedUsersResponse, error) {
	changed, err := s.blockRepo.Delete(userID, blockedUserID)
	if err != nil {
		return nil, err
	}
	if changed {
		unblockedKey := fmt.Sprintf(CacheKeyRoomUnblocked, userID.String(), blockedUserID.String())
		if err := s.cache.Set(unblockedKey, "1", CacheTTLRoomUnblocked*time.Second); err != nil {
			s.logger.Warnw("Failed to set room unblock marker", "user_id", userID, "blocked_user_id", blockedUserID, "error", err.Error())
		}
		s.emitBlockListChanged(userID, blockedUserID, false)
	}
	return s.ListBlockedUsers(userID)
}

func (s *Service) emitBlockListChanged(userID, blockedUserID uuid.UUID, blocked bool) {
	if s.wsServer == nil {
		return
	}
	payload := utils.WrapWebSocketMessage(constants.WebSocketEventRoomBlockListChanged, map[string]interface{}{
		"userId":  blockedUserID.String(),
		"blocked": blocked,
	})
	s.wsServer.EmitToUser(userID.String(), constants.WebSocketMessageEvent, payload)
}

func toRoomBlockedUsersResponse(rows []BlockedUserRow) *RoomBlockedUsersResponse {
	userIDs := make([]string, 0, len(rows))
	users := make([]RoomBlockedUser, 0, len(rows))
	now := time.Now()
	for _, row := range rows {
		id := row.UserID.String()
		userIDs = append(userIDs, id)
		frameOwner := models.User{AvatarFrameID: row.AvatarFrameID, VipEndTime: row.VipEndTime}
		users = append(users, RoomBlockedUser{
			UserID:        id,
			Username:      row.Username,
			FullName:      row.FullName,
			Avatar:        row.Avatar,
			AvatarFrameID: frameOwner.ActiveAvatarFrameID(now),
		})
	}
	return &RoomBlockedUsersResponse{UserIDs: userIDs, Users: users}
}
