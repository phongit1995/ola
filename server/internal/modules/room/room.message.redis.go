package room

import (
	"context"
	"encoding/json"
	"fmt"
	"ola-chat-server/internal/config"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/services"
	"strconv"
	"time"

	"github.com/redis/go-redis/v9"
	"go.uber.org/zap"
)

type RedisMessageRepository struct {
	cache         *services.CacheService
	retentionDays int
	logger        *zap.SugaredLogger
}

func NewRedisMessageRepository(cache *services.CacheService, cfg *config.Config, logger *zap.SugaredLogger) *RedisMessageRepository {
	days := cfg.RoomMessageRetentionDays
	if days <= 0 {
		days = 90
	}
	return &RedisMessageRepository{
		cache:         cache,
		retentionDays: days,
		logger:        logger.Named("[room_msg_redis]"),
	}
}

func (r *RedisMessageRepository) indexKey(roomID string) string {
	return fmt.Sprintf(constants.CacheKeyRoomMsgIndex, roomID)
}

func (r *RedisMessageRepository) dataKey(roomID string) string {
	return fmt.Sprintf(constants.CacheKeyRoomMsgData, roomID)
}

func (r *RedisMessageRepository) clientMessageKey(roomID, senderID, clientMsgID string) string {
	return fmt.Sprintf(constants.CacheKeyRoomClientMessage, roomID, senderID, clientMsgID)
}

func (r *RedisMessageRepository) ttl() time.Duration {
	return time.Duration(r.retentionDays+1) * 24 * time.Hour
}

func (r *RedisMessageRepository) Append(ctx context.Context, roomID, msgID string, createdAt time.Time, data []byte) error {
	client := r.cache.GetClient()
	indexKey := r.indexKey(roomID)
	dataKey := r.dataKey(roomID)
	score := float64(createdAt.UnixMicro())

	pipe := client.TxPipeline()
	pipe.HSet(ctx, dataKey, msgID, data)
	pipe.ZAdd(ctx, indexKey, redis.Z{Score: score, Member: msgID})
	pipe.Expire(ctx, indexKey, r.ttl())
	pipe.Expire(ctx, dataKey, r.ttl())
	if _, err := pipe.Exec(ctx); err != nil {
		return err
	}

	r.pruneOld(ctx, roomID)
	return nil
}

func (r *RedisMessageRepository) AppendIdempotent(ctx context.Context, roomID, senderID, clientMsgID, msgID string, createdAt time.Time, data []byte) (string, error) {
	if clientMsgID == "" {
		return msgID, r.Append(ctx, roomID, msgID, createdAt, data)
	}

	const appendMessage = `
		local existing = redis.call("GET", KEYS[3])
		if existing then
			return existing
		end
		redis.call("HSET", KEYS[2], ARGV[1], ARGV[3])
		redis.call("ZADD", KEYS[1], ARGV[2], ARGV[1])
		redis.call("PEXPIRE", KEYS[1], ARGV[4])
		redis.call("PEXPIRE", KEYS[2], ARGV[4])
		redis.call("SET", KEYS[3], ARGV[1], "PX", ARGV[4])
		return ARGV[1]
	`
	result, err := r.cache.GetClient().Eval(ctx, appendMessage, []string{
		r.indexKey(roomID),
		r.dataKey(roomID),
		r.clientMessageKey(roomID, senderID, clientMsgID),
	}, msgID, createdAt.UnixMicro(), data, r.ttl().Milliseconds()).Text()
	if err != nil {
		return "", err
	}
	if result == msgID {
		r.pruneOld(ctx, roomID)
	}
	return result, nil
}

func (r *RedisMessageRepository) pruneOld(ctx context.Context, roomID string) {
	client := r.cache.GetClient()
	indexKey := r.indexKey(roomID)
	dataKey := r.dataKey(roomID)
	cutoff := time.Now().Add(-time.Duration(r.retentionDays) * 24 * time.Hour).UnixMicro()
	maxExclusive := "(" + strconv.FormatInt(cutoff, 10)

	oldIDs, err := client.ZRangeByScore(ctx, indexKey, &redis.ZRangeBy{Min: "-inf", Max: maxExclusive}).Result()
	if err != nil || len(oldIDs) == 0 {
		return
	}
	pipe := client.TxPipeline()
	pipe.HDel(ctx, dataKey, oldIDs...)
	pipe.ZRemRangeByScore(ctx, indexKey, "-inf", maxExclusive)
	if _, err := pipe.Exec(ctx); err != nil {
		r.logger.Warnw("Failed to prune old room messages", "room_id", roomID, "error", err)
	}
}

func (r *RedisMessageRepository) List(ctx context.Context, roomID string, limit int, beforeID string) ([]json.RawMessage, error) {
	client := r.cache.GetClient()
	indexKey := r.indexKey(roomID)
	dataKey := r.dataKey(roomID)

	start := int64(0)
	if beforeID != "" {
		rank, err := client.ZRevRank(ctx, indexKey, beforeID).Result()
		if err == redis.Nil {
			return []json.RawMessage{}, nil
		}
		if err != nil {
			return nil, err
		}
		start = rank + 1
	}

	ids, err := client.ZRevRange(ctx, indexKey, start, start+int64(limit)-1).Result()
	if err != nil {
		return nil, err
	}
	if len(ids) == 0 {
		return []json.RawMessage{}, nil
	}

	vals, err := client.HMGet(ctx, dataKey, ids...).Result()
	if err != nil {
		return nil, err
	}

	out := make([]json.RawMessage, 0, len(vals))
	for _, v := range vals {
		if s, ok := v.(string); ok {
			out = append(out, json.RawMessage(s))
		}
	}
	return out, nil
}

func (r *RedisMessageRepository) GetByClientMessageID(ctx context.Context, roomID, senderID, clientMsgID string) ([]byte, error) {
	if clientMsgID == "" {
		return nil, nil
	}
	client := r.cache.GetClient()
	key := r.clientMessageKey(roomID, senderID, clientMsgID)
	msgID, err := client.Get(ctx, key).Result()
	if err == redis.Nil {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	data, err := r.Get(ctx, roomID, msgID)
	if err != nil || data != nil {
		return data, err
	}
	const deleteStaleKey = `
		if redis.call("GET", KEYS[1]) == ARGV[1] then
			return redis.call("DEL", KEYS[1])
		end
		return 0
	`
	if err := client.Eval(ctx, deleteStaleKey, []string{key}, msgID).Err(); err != nil {
		return nil, err
	}
	return nil, nil
}

func (r *RedisMessageRepository) Get(ctx context.Context, roomID, msgID string) ([]byte, error) {
	client := r.cache.GetClient()
	data, err := client.HGet(ctx, r.dataKey(roomID), msgID).Bytes()
	if err == redis.Nil {
		return nil, nil
	}
	return data, err
}

func (r *RedisMessageRepository) Update(ctx context.Context, roomID, msgID string, data []byte) error {
	client := r.cache.GetClient()
	return client.HSet(ctx, r.dataKey(roomID), msgID, data).Err()
}

func (r *RedisMessageRepository) Delete(ctx context.Context, roomID, msgID string) error {
	client := r.cache.GetClient()
	pipe := client.TxPipeline()
	pipe.HDel(ctx, r.dataKey(roomID), msgID)
	pipe.ZRem(ctx, r.indexKey(roomID), msgID)
	_, err := pipe.Exec(ctx)
	return err
}
