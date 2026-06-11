package websocket

import (
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/services"
	"fmt"
	"time"

	"github.com/redis/go-redis/v9"
	"go.uber.org/zap"
)

type RoomPresenceService struct {
	cache  *services.CacheService
	logger *zap.SugaredLogger
}

var roomJoinScript = redis.NewScript(`
	local counterKey = KEYS[1]
	local setKey = KEYS[2]
	local userID = ARGV[1]
	local ttl = ARGV[2]
	local count = redis.call('INCR', counterKey)
	redis.call('EXPIRE', counterKey, ttl)
	if count == 1 then
		redis.call('SADD', setKey, userID)
	end
	redis.call('EXPIRE', setKey, ttl)
	return count
`)

var roomLeaveScript = redis.NewScript(`
	local counterKey = KEYS[1]
	local setKey = KEYS[2]
	local userID = ARGV[1]
	local count = redis.call('DECR', counterKey)
	if count <= 0 then
		redis.call('DEL', counterKey)
		redis.call('SREM', setKey, userID)
		return 0
	end
	return count
`)

func NewRoomPresenceService(cache *services.CacheService, logger *zap.SugaredLogger) *RoomPresenceService {
	return &RoomPresenceService{
		cache:  cache,
		logger: logger.Named("[room_presence]"),
	}
}

func (s *RoomPresenceService) setKey(roomID string) string {
	return fmt.Sprintf(constants.CacheKeyRoomMembers, roomID)
}

func (s *RoomPresenceService) connKey(roomID, userID string) string {
	return fmt.Sprintf(constants.CacheKeyRoomUserConn, roomID, userID)
}

func (s *RoomPresenceService) Join(roomID, userID string) (int, error) {
	client := s.cache.GetClient()
	ctx := s.cache.GetContext()
	return roomJoinScript.Run(ctx, client,
		[]string{s.connKey(roomID, userID), s.setKey(roomID)},
		userID, constants.RoomPresenceTTLSeconds,
	).Int()
}

func (s *RoomPresenceService) Leave(roomID, userID string) (int, error) {
	client := s.cache.GetClient()
	ctx := s.cache.GetContext()
	return roomLeaveScript.Run(ctx, client,
		[]string{s.connKey(roomID, userID), s.setKey(roomID)},
		userID,
	).Int()
}

func (s *RoomPresenceService) Refresh(roomID, userID string) {
	client := s.cache.GetClient()
	ctx := s.cache.GetContext()
	ttl := time.Duration(constants.RoomPresenceTTLSeconds) * time.Second
	client.Expire(ctx, s.connKey(roomID, userID), ttl)
	client.Expire(ctx, s.setKey(roomID), ttl)
}

func (s *RoomPresenceService) OnlineMembers(roomID string) ([]string, error) {
	client := s.cache.GetClient()
	ctx := s.cache.GetContext()
	setKey := s.setKey(roomID)

	ids, err := client.SMembers(ctx, setKey).Result()
	if err != nil {
		return nil, err
	}
	if len(ids) == 0 {
		return []string{}, nil
	}

	pipe := client.Pipeline()
	existsCmds := make([]*redis.IntCmd, len(ids))
	for i, id := range ids {
		existsCmds[i] = pipe.Exists(ctx, s.connKey(roomID, id))
	}
	if _, err := pipe.Exec(ctx); err != nil {
		return nil, err
	}

	online := make([]string, 0, len(ids))
	var stale []interface{}
	for i, id := range ids {
		if existsCmds[i].Val() > 0 {
			online = append(online, id)
		} else {
			stale = append(stale, id)
		}
	}

	if len(stale) > 0 {
		if err := client.SRem(ctx, setKey, stale...).Err(); err != nil {
			s.logger.Warnw("Failed to prune stale room members", "room_id", roomID, "error", err)
		}
	}

	return online, nil
}

func (s *RoomPresenceService) IsMember(roomID, userID string) (bool, error) {
	client := s.cache.GetClient()
	ctx := s.cache.GetContext()
	n, err := client.Exists(ctx, s.connKey(roomID, userID)).Result()
	if err != nil {
		return false, err
	}
	return n > 0, nil
}

func (s *RoomPresenceService) MemberCount(roomID string) (int, error) {
	members, err := s.OnlineMembers(roomID)
	if err != nil {
		return 0, err
	}
	return len(members), nil
}

func (s *RoomPresenceService) MemberCounts(roomIDs []string) map[string]int {
	result := make(map[string]int, len(roomIDs))
	for _, id := range roomIDs {
		count, err := s.MemberCount(id)
		if err != nil {
			s.logger.Warnw("Failed to count room members", "room_id", id, "error", err)
			count = 0
		}
		result[id] = count
	}
	return result
}
