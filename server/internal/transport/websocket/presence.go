package websocket

import (
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"
	"fmt"
	"strconv"
	"time"

	"github.com/redis/go-redis/v9"
	"go.uber.org/zap"
)

type PresenceInfo struct {
	IsOnline     bool
	LastActiveAt string
	DeviceType   string
}

type PresenceService struct {
	cache  *services.CacheService
	logger *zap.SugaredLogger
}

var addConnectionScript = redis.NewScript(`
	local key = KEYS[1]
	local ttl = ARGV[1]
	local count = redis.call('INCR', key)
	redis.call('EXPIRE', key, ttl)
	return count
`)

var removeConnectionScript = redis.NewScript(`
	local key = KEYS[1]
	local count = redis.call('DECR', key)
	if count <= 0 then
		redis.call('DEL', key)
		return 0
	end
	return count
`)

func NewPresenceService(cache *services.CacheService, logger *zap.SugaredLogger) *PresenceService {
	return &PresenceService{
		cache:  cache,
		logger: logger.Named("[presence_service]"),
	}
}

func (s *PresenceService) getPresenceKey(userID string) string {
	return fmt.Sprintf(constants.CacheKeyPresence, userID)
}

func (s *PresenceService) AddConnection(userID string) (bool, error) {
	key := s.getPresenceKey(userID)
	client := s.cache.GetClient()
	ctx := s.cache.GetContext()

	count, err := addConnectionScript.Run(ctx, client, []string{key}, constants.PresenceTTLSeconds).Int()
	if err != nil {
		s.logger.Errorw("Failed to add connection", "user_id", userID, "error", err)
		return false, err
	}

	if err := s.SetLastActive(userID); err != nil {
		s.logger.Warnw("Failed to set last_active on connect", "user_id", userID, "error", err)
	}

	isFirstConnection := count == 1
	s.logger.Debugw("Added connection",
		"user_id", userID,
		"connection_count", count,
		"is_first_connection", isFirstConnection)

	return isFirstConnection, nil
}

func (s *PresenceService) RemoveConnection(userID string) (bool, error) {
	key := s.getPresenceKey(userID)
	client := s.cache.GetClient()
	ctx := s.cache.GetContext()

	count, err := removeConnectionScript.Run(ctx, client, []string{key}).Int()
	if err != nil {
		s.logger.Errorw("Failed to remove connection", "user_id", userID, "error", err)
		return false, err
	}

	isLastConnection := count == 0
	if isLastConnection {
		if err := s.SetLastActive(userID); err != nil {
			s.logger.Warnw("Failed to set last_active on disconnect", "user_id", userID, "error", err)
		}
	}

	s.logger.Debugw("Removed connection",
		"user_id", userID,
		"remaining_connections", count,
		"is_last_connection", isLastConnection)

	return isLastConnection, nil
}

func (s *PresenceService) RefreshPresence(userID string) error {
	ttl := time.Duration(constants.PresenceTTLSeconds) * time.Second
	if err := s.cache.SetExpire(s.getDeviceKey(userID), ttl); err != nil {
		s.logger.Debugw("Failed to refresh device ttl", "user_id", userID, "error", err)
	}
	return s.cache.SetExpire(s.getPresenceKey(userID), ttl)
}

func (s *PresenceService) getDeviceKey(userID string) string {
	return fmt.Sprintf(constants.CacheKeyPresenceDevice, userID)
}

func (s *PresenceService) SetDevice(userID, deviceType string) error {
	if deviceType == "" {
		return nil
	}
	key := s.getDeviceKey(userID)
	client := s.cache.GetClient()
	ctx := s.cache.GetContext()
	ttl := time.Duration(constants.PresenceTTLSeconds) * time.Second
	if err := client.Set(ctx, key, deviceType, ttl).Err(); err != nil {
		s.logger.Warnw("Failed to set device", "user_id", userID, "error", err)
		return err
	}
	return nil
}

func parseOnlineRaw(val interface{}) bool {
	str, ok := val.(string)
	if !ok {
		return false
	}
	count, _ := strconv.Atoi(str)
	return count > 0
}

func parsePresenceString(val interface{}) string {
	str, ok := val.(string)
	if !ok {
		return ""
	}
	return str
}

func buildPresenceInfo(onlineRaw bool, lastActiveRaw, deviceRaw string) PresenceInfo {
	isOnline, lastActiveOut := utils.ApplyOnlineGrace(onlineRaw, lastActiveRaw)
	deviceType := ""
	if isOnline {
		deviceType = deviceRaw
	}
	return PresenceInfo{IsOnline: isOnline, LastActiveAt: lastActiveOut, DeviceType: deviceType}
}

func (s *PresenceService) GetPresence(userID string) PresenceInfo {
	client := s.cache.GetClient()
	ctx := s.cache.GetContext()

	values, err := client.MGet(ctx,
		s.getPresenceKey(userID),
		s.getLastActiveKey(userID),
		s.getDeviceKey(userID),
	).Result()
	if err != nil || len(values) < 3 {
		if err != nil {
			s.logger.Errorw("Failed to get presence", "user_id", userID, "error", err)
		}
		return PresenceInfo{}
	}

	return buildPresenceInfo(parseOnlineRaw(values[0]), parsePresenceString(values[1]), parsePresenceString(values[2]))
}

func (s *PresenceService) GetPresenceBatch(userIDs []string) map[string]PresenceInfo {
	result := make(map[string]PresenceInfo, len(userIDs))
	if len(userIDs) == 0 {
		return result
	}

	keys := make([]string, 0, len(userIDs)*3)
	for _, userID := range userIDs {
		keys = append(keys, s.getPresenceKey(userID), s.getLastActiveKey(userID), s.getDeviceKey(userID))
	}

	client := s.cache.GetClient()
	ctx := s.cache.GetContext()

	values, err := client.MGet(ctx, keys...).Result()
	if err != nil || len(values) < len(keys) {
		if err != nil {
			s.logger.Errorw("Failed to batch get presence", "error", err)
		}
		return result
	}

	for i, userID := range userIDs {
		base := i * 3
		result[userID] = buildPresenceInfo(
			parseOnlineRaw(values[base]),
			parsePresenceString(values[base+1]),
			parsePresenceString(values[base+2]),
		)
	}

	return result
}

func (s *PresenceService) getLastActiveKey(userID string) string {
	return fmt.Sprintf(constants.CacheKeyLastActive, userID)
}

func (s *PresenceService) SetLastActive(userID string) error {
	key := s.getLastActiveKey(userID)
	client := s.cache.GetClient()
	ctx := s.cache.GetContext()
	now := time.Now().UTC().Format(time.RFC3339)
	if err := client.Set(ctx, key, now, time.Duration(constants.LastActiveTTLSeconds)*time.Second).Err(); err != nil {
		s.logger.Errorw("Failed to set last_active", "user_id", userID, "error", err)
		return err
	}
	return nil
}

func (s *PresenceService) getBackgroundKey(userID string) string {
	return fmt.Sprintf(constants.CacheKeyPresenceBackground, userID)
}

func (s *PresenceService) SetBackground(userID string, background bool) error {
	key := s.getBackgroundKey(userID)
	client := s.cache.GetClient()
	ctx := s.cache.GetContext()
	if background {
		ttl := time.Duration(constants.PresenceBackgroundTTLSeconds) * time.Second
		if err := client.Set(ctx, key, "1", ttl).Err(); err != nil {
			s.logger.Warnw("Failed to set background state", "user_id", userID, "error", err)
			return err
		}
		return nil
	}
	if err := client.Del(ctx, key).Err(); err != nil {
		s.logger.Warnw("Failed to clear background state", "user_id", userID, "error", err)
		return err
	}
	return nil
}

func (s *PresenceService) RefreshBackground(userID string) {
	key := s.getBackgroundKey(userID)
	client := s.cache.GetClient()
	ctx := s.cache.GetContext()
	ttl := time.Duration(constants.PresenceBackgroundTTLSeconds) * time.Second
	if err := client.Expire(ctx, key, ttl).Err(); err != nil {
		s.logger.Debugw("Failed to refresh background ttl", "user_id", userID, "error", err)
	}
}

func (s *PresenceService) IsBackground(userID string) bool {
	key := s.getBackgroundKey(userID)
	client := s.cache.GetClient()
	ctx := s.cache.GetContext()
	exists, err := client.Exists(ctx, key).Result()
	if err != nil {
		s.logger.Warnw("Failed to check background state", "user_id", userID, "error", err)
		return false
	}
	return exists > 0
}

func (s *PresenceService) GetConnectionCount(userID string) int {
	key := s.getPresenceKey(userID)
	client := s.cache.GetClient()
	ctx := s.cache.GetContext()

	count, err := client.Get(ctx, key).Int()
	if err != nil {
		return 0
	}
	return count
}
