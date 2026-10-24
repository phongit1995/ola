package reel

import (
	"context"
	"fmt"
	"net/http"
	"strconv"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"github.com/redis/go-redis/v9"
)

var (
	errStateUnavailable = utils.NewHTTPError(http.StatusServiceUnavailable, "reel state unavailable")
	errQuotaExceeded    = utils.NewHTTPErrorWithCode(http.StatusTooManyRequests, "daily reel limit reached", constants.ErrorCodeReelQuotaExceeded)
)

type RedisStore struct {
	cache *services.CacheService
}

func NewRedisStore(cache *services.CacheService) *RedisStore {
	return &RedisStore{cache: cache}
}

func seenKey(viewerID uuid.UUID) string {
	return fmt.Sprintf(constants.CacheKeyReelSeen, viewerID.String())
}

func viewersKey(reelID uuid.UUID) string {
	return fmt.Sprintf(constants.CacheKeyReelViewers, reelID.String())
}

func quotaKey(userID uuid.UUID, now time.Time) string {
	day := now.UTC().Add(constants.ReelQuotaUTCOffset).Format(constants.ReelQuotaDayLayout)
	return fmt.Sprintf(constants.CacheKeyReelQuota, userID.String(), day)
}

func (s *RedisStore) SeenIDs(ctx context.Context, viewerID uuid.UUID, now time.Time) ([]uuid.UUID, error) {
	members, err := s.cache.GetClient().ZRangeByScore(ctx, seenKey(viewerID), &redis.ZRangeBy{
		Min: "(" + strconv.FormatInt(now.Unix(), 10),
		Max: "+inf",
	}).Result()
	if err != nil {
		return nil, err
	}
	seen := make([]uuid.UUID, 0, len(members))
	for _, member := range members {
		if id, err := uuid.Parse(member); err == nil {
			seen = append(seen, id)
		}
	}
	return seen, nil
}

func (s *RedisStore) MarkSeen(ctx context.Context, viewerID uuid.UUID, reels []*models.Reel, now time.Time) error {
	viewer := viewerID.String()
	key := seenKey(viewerID)
	pipe := s.cache.GetClient().TxPipeline()
	for _, reel := range reels {
		pipe.ZAdd(ctx, key, redis.Z{Score: float64(reel.ExpiresAt.Unix()), Member: reel.ID.String()})
		pipe.ZAddNX(ctx, viewersKey(reel.ID), redis.Z{Score: float64(now.UnixMilli()), Member: viewer})
		pipe.ExpireAt(ctx, viewersKey(reel.ID), reel.ExpiresAt)
	}
	pipe.ZRemRangeByScore(ctx, key, "-inf", strconv.FormatInt(now.Unix(), 10))
	pipe.Expire(ctx, key, constants.ReelSeenTTL)
	_, err := pipe.Exec(ctx)
	return err
}

func (s *RedisStore) ViewerCounts(ctx context.Context, reels []*models.Reel) (map[uuid.UUID]int64, error) {
	counts := make(map[uuid.UUID]int64, len(reels))
	if len(reels) == 0 {
		return counts, nil
	}
	pipe := s.cache.GetClient().Pipeline()
	cmds := make(map[uuid.UUID]*redis.IntCmd, len(reels))
	for _, reel := range reels {
		cmds[reel.ID] = pipe.ZCard(ctx, viewersKey(reel.ID))
	}
	if _, err := pipe.Exec(ctx); err != nil && err != redis.Nil {
		return nil, err
	}
	for id, cmd := range cmds {
		counts[id] = cmd.Val()
	}
	return counts, nil
}

func (s *RedisStore) ViewerPage(ctx context.Context, reelID uuid.UUID, offset, limit int) ([]redis.Z, int64, error) {
	client := s.cache.GetClient()
	key := viewersKey(reelID)
	total, err := client.ZCard(ctx, key).Result()
	if err != nil {
		return nil, 0, err
	}
	if total == 0 || int64(offset) >= total {
		return []redis.Z{}, total, nil
	}
	page, err := client.ZRevRangeWithScores(ctx, key, int64(offset), int64(offset+limit-1)).Result()
	if err != nil {
		return nil, 0, err
	}
	return page, total, nil
}

func (s *RedisStore) DropViewers(ctx context.Context, reelIDs []uuid.UUID) error {
	if len(reelIDs) == 0 {
		return nil
	}
	keys := make([]string, 0, len(reelIDs))
	for _, id := range reelIDs {
		keys = append(keys, viewersKey(id))
	}
	return s.cache.GetClient().Del(ctx, keys...).Err()
}

func (s *RedisStore) ReserveQuota(ctx context.Context, userID uuid.UUID, count int, now time.Time) (func(), error) {
	client := s.cache.GetClient()
	key := quotaKey(userID, now)
	used, err := client.IncrBy(ctx, key, int64(count)).Result()
	if err != nil {
		return nil, err
	}
	if used == int64(count) {
		client.Expire(ctx, key, constants.ReelQuotaTTL)
	}
	release := func() {
		client.DecrBy(context.Background(), key, int64(count))
	}
	if used > constants.MaxReelsPerDay {
		release()
		return nil, errQuotaExceeded
	}
	return release, nil
}
