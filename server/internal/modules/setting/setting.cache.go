package setting

import (
	"encoding/json"
	"errors"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/services"

	"github.com/redis/go-redis/v9"
	"go.uber.org/zap"
	"golang.org/x/sync/singleflight"
)

const (
	settingsCacheKey      = "app_settings:cache"
	settingsGenerationKey = "app_settings:generation"
	settingsCacheTTL      = time.Hour
	settingsLoadedField   = "_loaded"
	settingsUncachedLoad  = "uncached"
)

// Stores a freshly loaded table only if no write bumped the generation since the load began, so a slow
// reader cannot replace a newer copy with the one it read before the write.
var storeSettingsScript = redis.NewScript(`
local current = redis.call('GET', KEYS[2]) or '0'
if current ~= ARGV[1] then
	return 0
end
redis.call('DEL', KEYS[1])
redis.call('HSET', KEYS[1], unpack(ARGV, 3))
redis.call('EXPIRE', KEYS[1], ARGV[2])
return 1
`)

type cachedSetting struct {
	Raw       json.RawMessage `json:"raw,omitempty"`
	UpdatedAt time.Time       `json:"updatedAt"`
}

// The whole app_settings table is cached as one Redis hash shared by every process (api, chat), loaded with
// one query, so a write only has to drop that hash. The TTL bounds staleness when a row is edited by hand.
type settingsCache struct {
	redis  *services.CacheService
	load   func() ([]models.AppSetting, error)
	logger *zap.SugaredLogger
	group  singleflight.Group
}

func newSettingsCache(redis *services.CacheService, load func() ([]models.AppSetting, error), logger *zap.SugaredLogger) *settingsCache {
	return &settingsCache{redis: redis, load: load, logger: logger}
}

func (c *settingsCache) get(key string) (cachedSetting, bool, error) {
	if item, found, cached := c.fromRedis(key); cached {
		return item, found, nil
	}

	generation, storable := c.generation()
	flight := settingsUncachedLoad
	if storable {
		// Keyed by generation so a caller arriving after a write never joins a load that began before it.
		flight = generation
	}
	value, err, _ := c.group.Do(flight, func() (interface{}, error) {
		return c.reload(generation, storable)
	})
	if err != nil {
		return cachedSetting{}, false, err
	}
	item, found := value.(map[string]cachedSetting)[key]
	return item, found, nil
}

func (c *settingsCache) fromRedis(key string) (item cachedSetting, found bool, cached bool) {
	if c.redis == nil {
		return cachedSetting{}, false, false
	}
	values, err := c.redis.GetClient().HMGet(c.redis.GetContext(), settingsCacheKey, settingsLoadedField, key).Result()
	if err != nil {
		c.logger.Warnw("Failed to read cached app settings, loading from database", "error", err.Error())
		return cachedSetting{}, false, false
	}
	if values[0] == nil {
		return cachedSetting{}, false, false
	}
	encoded, ok := values[1].(string)
	if !ok {
		return cachedSetting{}, false, true
	}
	if err := json.Unmarshal([]byte(encoded), &item); err != nil {
		c.logger.Warnw("Failed to decode cached app setting, loading from database", "key", key, "error", err.Error())
		return cachedSetting{}, false, false
	}
	return item, true, true
}

func (c *settingsCache) generation() (string, bool) {
	if c.redis == nil {
		return "", false
	}
	generation, err := c.redis.GetClient().Get(c.redis.GetContext(), settingsGenerationKey).Result()
	if errors.Is(err, redis.Nil) {
		return "0", true
	}
	if err != nil {
		c.logger.Warnw("Failed to read app settings generation, loading without caching", "error", err.Error())
		return "", false
	}
	return generation, true
}

func (c *settingsCache) reload(generation string, storable bool) (map[string]cachedSetting, error) {
	rows, err := c.load()
	if err != nil {
		return nil, err
	}
	items := make(map[string]cachedSetting, len(rows))
	args := []interface{}{generation, int(settingsCacheTTL.Seconds()), settingsLoadedField, "1"}
	for _, row := range rows {
		item := cachedSetting{UpdatedAt: row.UpdatedAt}
		if row.Value != nil {
			if item.Raw, err = json.Marshal(row.Value); err != nil {
				c.logger.Warnw("Failed to encode app setting, using defaults", "key", row.Key, "error", err.Error())
			}
		}
		items[row.Key] = item
		if encoded, err := json.Marshal(item); err == nil {
			args = append(args, row.Key, string(encoded))
		}
	}

	if storable {
		keys := []string{settingsCacheKey, settingsGenerationKey}
		if err := storeSettingsScript.Run(c.redis.GetContext(), c.redis.GetClient(), keys, args...).Err(); err != nil {
			c.logger.Warnw("Failed to cache app settings", "error", err.Error())
		}
	}
	return items, nil
}

func (c *settingsCache) invalidate() {
	if c.redis == nil {
		return
	}
	ctx := c.redis.GetContext()
	pipe := c.redis.GetClient().TxPipeline()
	pipe.Incr(ctx, settingsGenerationKey)
	pipe.Del(ctx, settingsCacheKey)
	if _, err := pipe.Exec(ctx); err != nil {
		c.logger.Warnw("Failed to drop cached app settings, readers catch up after the cache TTL", "error", err.Error())
	}
}
