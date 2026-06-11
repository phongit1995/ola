package websocket

import (
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/services"
	"context"
	"fmt"
	"time"

	"github.com/redis/go-redis/v9"
	"go.uber.org/zap"
)

type RoomPresenceService struct {
	cache  *services.CacheService
	logger *zap.SugaredLogger
}

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

func (s *RoomPresenceService) Join(ctx context.Context, roomID, userID string) (bool, error) {
	client := s.cache.GetClient()
	ttl := time.Duration(constants.RoomPresenceTTLSeconds) * time.Second
	pipe := client.Pipeline()
	added := pipe.SAdd(ctx, s.setKey(roomID), userID)
	pipe.Expire(ctx, s.setKey(roomID), ttl)
	pipe.Set(ctx, s.connKey(roomID, userID), 1, ttl)
	if _, err := pipe.Exec(ctx); err != nil {
		return false, err
	}
	return added.Val() == 1, nil
}

func (s *RoomPresenceService) Leave(ctx context.Context, roomID, userID string) (bool, error) {
	client := s.cache.GetClient()
	pipe := client.Pipeline()
	removed := pipe.SRem(ctx, s.setKey(roomID), userID)
	pipe.Del(ctx, s.connKey(roomID, userID))
	if _, err := pipe.Exec(ctx); err != nil {
		return false, err
	}
	return removed.Val() == 1, nil
}

func (s *RoomPresenceService) Refresh(ctx context.Context, roomID, userID string) {
	client := s.cache.GetClient()
	ttl := time.Duration(constants.RoomPresenceTTLSeconds) * time.Second
	client.Expire(ctx, s.connKey(roomID, userID), ttl)
	client.Expire(ctx, s.setKey(roomID), ttl)
}

func (s *RoomPresenceService) OnlineMembers(ctx context.Context, roomID string) ([]string, error) {
	client := s.cache.GetClient()
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

func (s *RoomPresenceService) IsMember(ctx context.Context, roomID, userID string) (bool, error) {
	n, err := s.cache.GetClient().Exists(ctx, s.connKey(roomID, userID)).Result()
	if err != nil {
		return false, err
	}
	return n > 0, nil
}

func (s *RoomPresenceService) MemberCount(ctx context.Context, roomID string) (int, error) {
	members, err := s.OnlineMembers(ctx, roomID)
	if err != nil {
		return 0, err
	}
	return len(members), nil
}

func (s *RoomPresenceService) MemberCounts(ctx context.Context, roomIDs []string) map[string]int {
	result := make(map[string]int, len(roomIDs))
	if len(roomIDs) == 0 {
		return result
	}
	for _, id := range roomIDs {
		result[id] = 0
	}
	client := s.cache.GetClient()

	membersPipe := client.Pipeline()
	membersCmds := make([]*redis.StringSliceCmd, len(roomIDs))
	for i, roomID := range roomIDs {
		membersCmds[i] = membersPipe.SMembers(ctx, s.setKey(roomID))
	}
	if _, err := membersPipe.Exec(ctx); err != nil {
		s.logger.Warnw("Failed to fetch room member sets", "error", err)
		return result
	}

	type member struct {
		roomIdx int
		userID  string
	}
	existsPipe := client.Pipeline()
	var members []member
	var existsCmds []*redis.IntCmd
	for i, roomID := range roomIDs {
		for _, uid := range membersCmds[i].Val() {
			members = append(members, member{roomIdx: i, userID: uid})
			existsCmds = append(existsCmds, existsPipe.Exists(ctx, s.connKey(roomID, uid)))
		}
	}
	if len(members) == 0 {
		return result
	}
	if _, err := existsPipe.Exec(ctx); err != nil {
		s.logger.Warnw("Failed to check room member liveness", "error", err)
		return result
	}

	stale := make(map[int][]interface{})
	for i, m := range members {
		if existsCmds[i].Val() > 0 {
			result[roomIDs[m.roomIdx]]++
		} else {
			stale[m.roomIdx] = append(stale[m.roomIdx], m.userID)
		}
	}

	if len(stale) > 0 {
		prunePipe := client.Pipeline()
		for roomIdx, ids := range stale {
			prunePipe.SRem(ctx, s.setKey(roomIDs[roomIdx]), ids...)
		}
		if _, err := prunePipe.Exec(ctx); err != nil {
			s.logger.Warnw("Failed to prune stale room members", "error", err)
		}
	}

	return result
}
