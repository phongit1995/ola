package user

import (
	"encoding/json"
	"fmt"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"
	"time"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type cachedUser struct {
	ID              string                 `json:"id"`
	Username        string                 `json:"username"`
	Email           string                 `json:"email"`
	EmailVerified   bool                   `json:"emailVerified"`
	EmailVerifiedAt *time.Time             `json:"emailVerifiedAt"`
	Avatar          string                 `json:"avatar"`
	Phone           string                 `json:"phone"`
	FullName        string                 `json:"fullName"`
	Gender          string                 `json:"gender"`
	Bio             string                 `json:"bio"`
	BioImage        *string                `json:"bioImage"`
	DateOfBirth     *time.Time             `json:"dateOfBirth"`
	CustomInfo      map[string]interface{} `json:"customInfo"`
	Ken             int                    `json:"ken"`
	VipUsed         *string                `json:"vipUsed"`
	VipEndTime      *time.Time             `json:"vipEndTime"`
	FollowerCount   int                    `json:"followerCount"`
	FollowingCount  int                    `json:"followingCount"`
	CreatedAt       time.Time              `json:"createdAt"`
	UpdatedAt       time.Time              `json:"updatedAt"`
}

func toCachedUser(u *models.User) *cachedUser {
	return &cachedUser{
		ID:              u.ID.String(),
		Username:        u.Username,
		Email:           u.Email,
		EmailVerified:   u.EmailVerified,
		EmailVerifiedAt: u.EmailVerifiedAt,
		Avatar:          u.Avatar,
		Phone:           u.Phone,
		FullName:        u.FullName,
		Gender:          u.Gender,
		Bio:             u.Bio,
		BioImage:        u.BioImage,
		DateOfBirth:     u.DateOfBirth,
		CustomInfo:      u.CustomInfo,
		Ken:             u.Ken,
		VipUsed:         u.VipUsed,
		VipEndTime:      u.VipEndTime,
		FollowerCount:   u.FollowerCount,
		FollowingCount:  u.FollowingCount,
		CreatedAt:       u.CreatedAt,
		UpdatedAt:       u.UpdatedAt,
	}
}

func (cu *cachedUser) toModel() *models.User {
	return &models.User{
		Username:        cu.Username,
		Email:           cu.Email,
		EmailVerified:   cu.EmailVerified,
		EmailVerifiedAt: cu.EmailVerifiedAt,
		Avatar:          cu.Avatar,
		Phone:           cu.Phone,
		FullName:        cu.FullName,
		Gender:          cu.Gender,
		Bio:             cu.Bio,
		BioImage:        cu.BioImage,
		DateOfBirth:     cu.DateOfBirth,
		CustomInfo:      models.JSONB(cu.CustomInfo),
		Ken:             cu.Ken,
		VipUsed:         cu.VipUsed,
		VipEndTime:      cu.VipEndTime,
		FollowerCount:   cu.FollowerCount,
		FollowingCount:  cu.FollowingCount,
	}
}

type CacheService struct {
	cache  *services.CacheService
	db     *gorm.DB
	logger *zap.SugaredLogger
}

func NewCacheService(cache *services.CacheService, db *gorm.DB, logger *zap.SugaredLogger) *CacheService {
	return &CacheService{
		cache:  cache,
		db:     db,
		logger: logger.Named("[user_cache]"),
	}
}

func (c *CacheService) GetUser(userID uuid.UUID) (*models.User, error) {
	key := fmt.Sprintf(constants.CacheKeyUserProfile, userID.String())
	var cu cachedUser
	if err := c.cache.Get(key, &cu); err != nil {
		return nil, err
	}
	u := cu.toModel()
	u.ID = userID
	u.CreatedAt = cu.CreatedAt
	u.UpdatedAt = cu.UpdatedAt
	return u, nil
}

func (c *CacheService) SetUser(userID uuid.UUID, user *models.User) error {
	key := fmt.Sprintf(constants.CacheKeyUserProfile, userID.String())
	return c.cache.Set(key, toCachedUser(user), constants.CacheTTLUserProfile*time.Second)
}

func (c *CacheService) DeleteUser(userID uuid.UUID) error {
	key := fmt.Sprintf(constants.CacheKeyUserProfile, userID.String())
	return c.cache.Delete(key)
}

func (c *CacheService) SetUserSession(userID uuid.UUID, token string, expiry time.Duration) error {
	key := fmt.Sprintf(constants.CacheKeyUserSession, userID.String())
	return c.cache.Set(key, token, expiry)
}

func (c *CacheService) DeleteUserSession(userID uuid.UUID, token string) error {
	key := fmt.Sprintf(constants.CacheKeyUserSession, userID.String())
	return c.cache.Delete(key)
}

func (c *CacheService) DeleteAllUserSessions(userID uuid.UUID) error {
	pattern := fmt.Sprintf(constants.CacheKeyUserSession, userID.String())
	return c.cache.DeletePattern(pattern)
}

func (c *CacheService) InvalidateUser(userID uuid.UUID) error {
	if err := c.DeleteUser(userID); err != nil {
		c.logger.Warnw("Failed to delete user cache", "user_id", userID, "error", err)
	}
	return nil
}

func (c *CacheService) GetUsersBatch(userIDs []uuid.UUID, fallbackToDB bool) map[uuid.UUID]*models.User {
	result := make(map[uuid.UUID]*models.User, len(userIDs))
	if len(userIDs) == 0 {
		return result
	}

	keys := make([]string, len(userIDs))
	for i, id := range userIDs {
		keys[i] = fmt.Sprintf(constants.CacheKeyUserProfile, id.String())
	}

	var missing []uuid.UUID
	values, err := c.cache.GetMany(keys)
	if err != nil || len(values) != len(userIDs) {
		if err != nil {
			c.logger.Warnw("Batch user fetch from cache failed", "error", err, "count", len(userIDs))
		}
		missing = userIDs
	} else {
		for i, id := range userIDs {
			raw, ok := values[i].(string)
			if !ok {
				missing = append(missing, id)
				continue
			}
			var cu cachedUser
			if err := json.Unmarshal([]byte(raw), &cu); err != nil {
				missing = append(missing, id)
				continue
			}
			u := cu.toModel()
			u.ID = id
			u.CreatedAt = cu.CreatedAt
			u.UpdatedAt = cu.UpdatedAt
			result[id] = u
		}
	}

	if len(missing) == 0 || !fallbackToDB {
		return result
	}

	var users []models.User
	if err := c.db.Where("id IN ?", missing).Find(&users).Error; err != nil {
		c.logger.Warnw("Batch user fetch from DB failed", "error", err, "count", len(missing))
		return result
	}

	for i := range users {
		result[users[i].ID] = &users[i]
	}
	utils.SafeGo(c.logger, func() {
		for i := range users {
			if err := c.SetUser(users[i].ID, &users[i]); err != nil {
				c.logger.Warnw("Failed to cache user after batch fetch", "user_id", users[i].ID, "error", err)
			}
		}
	})

	return result
}

func (c *CacheService) GetUserCache(userID uuid.UUID, fallbackToDB bool) (*models.User, error) {
	if cachedUser, err := c.GetUser(userID); err == nil && cachedUser != nil {
		c.logger.Debugw("User cache HIT", "user_id", userID, "fallback_enabled", fallbackToDB)
		return cachedUser, nil
	}

	if !fallbackToDB {
		c.logger.Debugw("User cache MISS (no fallback)", "user_id", userID)
		return nil, fmt.Errorf("user not found in cache")
	}

	c.logger.Debugw("User cache MISS, fetching from DB", "user_id", userID)
	var user models.User
	if err := c.db.First(&user, "id = ?", userID).Error; err != nil {
		return nil, err
	}

	cached := &user
	utils.SafeGo(c.logger, func() {
		if setErr := c.SetUser(userID, cached); setErr != nil {
			c.logger.Warnw("Failed to cache user after DB fetch", "user_id", userID, "error", setErr)
		}
	})

	return &user, nil
}
