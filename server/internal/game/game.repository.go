package game

import (
	"math"
	"time"

	"ola-chat-server/internal/game/protocol"
	"ola-chat-server/internal/modules/user"

	"github.com/google/uuid"
)

type Repository struct {
	users *user.CacheService
}

func NewRepository(users *user.CacheService) *Repository {
	return &Repository{users: users}
}

func (r *Repository) GetUserInfo(userID string) (*protocol.UserInfoData, error) {
	uid, err := uuid.Parse(userID)
	if err != nil {
		return nil, err
	}

	u, err := r.users.GetUserCache(uid, true)
	if err != nil {
		return nil, err
	}

	info := &protocol.UserInfoData{
		Username: u.Username,
		Ken:      u.Ken,
	}

	if u.VipUsed != nil && u.VipEndTime != nil {
		left := time.Until(*u.VipEndTime)
		if left > 0 {
			info.VipType = u.VipUsed
			info.VipDays = int(math.Ceil(left.Hours() / 24))
		}
	}

	return info, nil
}
