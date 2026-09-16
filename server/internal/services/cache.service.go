package services

import (
	"context"
	"encoding/json"
	"fmt"
	"time"

	"ola-chat-server/internal/config"

	"github.com/redis/go-redis/v9"
	"go.uber.org/zap"
)

type CacheService struct {
	client *redis.Client
	logger *zap.SugaredLogger
	ctx    context.Context
}

func NewCacheService(cfg *config.Config, logger *zap.SugaredLogger) (*CacheService, error) {
	ctx := context.Background()

	client := redis.NewClient(&redis.Options{
		Addr:         fmt.Sprintf("%s:%d", cfg.RedisHost, cfg.RedisPort),
		Password:     cfg.RedisPassword,
		DB:           cfg.RedisDB,
		DialTimeout:  5 * time.Second,
		ReadTimeout:  3 * time.Second,
		WriteTimeout: 3 * time.Second,
		PoolSize:     10,
		MinIdleConns: 5,
	})

	// Test connection
	if err := client.Ping(ctx).Err(); err != nil {
		return nil, fmt.Errorf("failed to connect to Redis: %w", err)
	}

	logger.Info(" Connected to Redis successfully")

	return &CacheService{
		client: client,
		logger: logger.Named("[cache_service]"),
		ctx:    ctx,
	}, nil
}

// Set stores a value in cache with expiration
func (s *CacheService) Set(key string, value interface{}, expiration time.Duration) error {
	data, err := json.Marshal(value)
	if err != nil {
		return fmt.Errorf("failed to marshal value: %w", err)
	}

	return s.client.Set(s.ctx, key, data, expiration).Err()
}

// Get retrieves a value from cache
func (s *CacheService) Get(key string, dest interface{}) error {
	data, err := s.client.Get(s.ctx, key).Bytes()
	if err == redis.Nil {
		return fmt.Errorf("key not found")
	}
	if err != nil {
		return err
	}

	return json.Unmarshal(data, dest)
}

// Delete removes a key from cache
func (s *CacheService) Delete(key string) error {
	return s.client.Del(s.ctx, key).Err()
}

func (s *CacheService) GetDel(key string, dest interface{}) error {
	data, err := s.client.GetDel(s.ctx, key).Bytes()
	if err == redis.Nil {
		return fmt.Errorf("key not found")
	}
	if err != nil {
		return err
	}
	return json.Unmarshal(data, dest)
}

// GetMany retrieves multiple keys in one MGET round trip; missing keys are nil
func (s *CacheService) GetMany(keys []string) ([]interface{}, error) {
	if len(keys) == 0 {
		return nil, nil
	}
	return s.client.MGet(s.ctx, keys...).Result()
}

// DeletePattern deletes all keys matching a pattern
func (s *CacheService) DeletePattern(pattern string) error {
	iter := s.client.Scan(s.ctx, 0, pattern, 0).Iterator()
	for iter.Next(s.ctx) {
		if err := s.client.Del(s.ctx, iter.Val()).Err(); err != nil {
			s.logger.Warnw("Failed to delete key", "key", iter.Val(), "error", err)
		}
	}
	return iter.Err()
}

// Exists checks if a key exists
func (s *CacheService) Exists(key string) (bool, error) {
	result, err := s.client.Exists(s.ctx, key).Result()
	if err != nil {
		return false, err
	}
	return result > 0, nil
}

// SetNX sets a value only if the key does not exist (for distributed locks)
func (s *CacheService) SetNX(key string, value interface{}, expiration time.Duration) (bool, error) {
	data, err := json.Marshal(value)
	if err != nil {
		return false, fmt.Errorf("failed to marshal value: %w", err)
	}

	return s.client.SetNX(s.ctx, key, data, expiration).Result()
}

// A lock owner must not delete a newer owner's value after expiration.
func (s *CacheService) DeleteIfValue(key string, value interface{}) (bool, error) {
	data, err := json.Marshal(value)
	if err != nil {
		return false, fmt.Errorf("failed to marshal value: %w", err)
	}
	const compareAndDelete = `
		if redis.call("GET", KEYS[1]) == ARGV[1] then
			return redis.call("DEL", KEYS[1])
		end
		return 0
	`
	deleted, err := s.client.Eval(s.ctx, compareAndDelete, []string{key}, data).Int64()
	return deleted == 1, err
}

type ConsumeCodeStatus string

const (
	ConsumeCodeOK      ConsumeCodeStatus = "OK"
	ConsumeCodeMissing ConsumeCodeStatus = "MISSING"
	ConsumeCodeInvalid ConsumeCodeStatus = "INVALID"
	ConsumeCodeTooMany ConsumeCodeStatus = "TOO_MANY"
)

// ConsumeCode atomically checks an OTP entry: counts the attempt, enforces the
// attempt cap, and deletes (single-use) the entry when the code matches.
func (s *CacheService) ConsumeCode(entryKey, attemptsKey, code string, maxAttempts int, dest interface{}) (ConsumeCodeStatus, error) {
	const script = `
		local entry = redis.call("GET", KEYS[1])
		if not entry then return {"MISSING", ""} end
		local attempts = redis.call("INCR", KEYS[2])
		if attempts == 1 then
			local ttl = redis.call("PTTL", KEYS[1])
			if ttl > 0 then redis.call("PEXPIRE", KEYS[2], ttl) end
		end
		if attempts > tonumber(ARGV[2]) then
			redis.call("DEL", KEYS[1], KEYS[2])
			return {"TOO_MANY", ""}
		end
		local decoded = cjson.decode(entry)
		if decoded.code ~= ARGV[1] then return {"INVALID", ""} end
		redis.call("DEL", KEYS[1], KEYS[2])
		return {"OK", entry}
	`
	res, err := s.client.Eval(s.ctx, script, []string{entryKey, attemptsKey}, code, maxAttempts).Slice()
	if err != nil {
		return "", err
	}
	if len(res) < 2 {
		return "", fmt.Errorf("unexpected consume code reply")
	}
	status, _ := res[0].(string)
	if ConsumeCodeStatus(status) == ConsumeCodeOK {
		entry, _ := res[1].(string)
		if err := json.Unmarshal([]byte(entry), dest); err != nil {
			return "", err
		}
	}
	return ConsumeCodeStatus(status), nil
}

// Increment increments a counter
func (s *CacheService) Increment(key string) (int64, error) {
	return s.client.Incr(s.ctx, key).Result()
}

// IncrementBy increments a counter by n
func (s *CacheService) IncrementBy(key string, n int64) (int64, error) {
	return s.client.IncrBy(s.ctx, key, n).Result()
}

// Decrement decrements a counter
func (s *CacheService) Decrement(key string) (int64, error) {
	return s.client.Decr(s.ctx, key).Result()
}

// SetHash stores a hash field
func (s *CacheService) SetHash(key, field string, value interface{}) error {
	data, err := json.Marshal(value)
	if err != nil {
		return fmt.Errorf("failed to marshal value: %w", err)
	}
	return s.client.HSet(s.ctx, key, field, data).Err()
}

// GetHash retrieves a hash field
func (s *CacheService) GetHash(key, field string, dest interface{}) error {
	data, err := s.client.HGet(s.ctx, key, field).Bytes()
	if err == redis.Nil {
		return fmt.Errorf("field not found")
	}
	if err != nil {
		return err
	}
	return json.Unmarshal(data, dest)
}

// DeleteHash deletes a hash field
func (s *CacheService) DeleteHash(key, field string) error {
	return s.client.HDel(s.ctx, key, field).Err()
}

// GetAllHash retrieves all fields from a hash
func (s *CacheService) GetAllHash(key string) (map[string]string, error) {
	return s.client.HGetAll(s.ctx, key).Result()
}

// SetList adds items to a list
func (s *CacheService) SetList(key string, values ...interface{}) error {
	return s.client.RPush(s.ctx, key, values...).Err()
}

// GetList retrieves all items from a list
func (s *CacheService) GetList(key string, start, stop int64) ([]string, error) {
	return s.client.LRange(s.ctx, key, start, stop).Result()
}

// GetListLength gets the length of a list
func (s *CacheService) GetListLength(key string) (int64, error) {
	return s.client.LLen(s.ctx, key).Result()
}

// SetExpire sets expiration on an existing key
func (s *CacheService) SetExpire(key string, expiration time.Duration) error {
	return s.client.Expire(s.ctx, key, expiration).Err()
}

// GetTTL gets the remaining TTL of a key
func (s *CacheService) GetTTL(key string) (time.Duration, error) {
	return s.client.TTL(s.ctx, key).Result()
}

// Close closes the Redis connection
func (s *CacheService) Close() error {
	return s.client.Close()
}

// GetClient returns the underlying Redis client for advanced operations
func (s *CacheService) GetClient() *redis.Client {
	return s.client
}

func (s *CacheService) GetContext() context.Context {
	return s.ctx
}
