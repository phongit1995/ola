package moment

import (
	"context"
	"encoding/json"
	"errors"
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
	errStateUnavailable = utils.NewHTTPError(http.StatusServiceUnavailable, "moment state unavailable")
	errQuotaExceeded    = utils.NewHTTPErrorWithCode(http.StatusTooManyRequests, "daily moment limit reached", ErrorCodeMomentQuotaExceeded)
)

type RedisStore struct {
	cache *services.CacheService
}

func NewRedisStore(cache *services.CacheService) *RedisStore {
	return &RedisStore{cache: cache}
}

func seenKey(viewerID uuid.UUID) string {
	return fmt.Sprintf(CacheKeyMomentSeen, viewerID.String())
}

func viewersKey(momentID uuid.UUID) string {
	return fmt.Sprintf(CacheKeyMomentViewers, momentID.String())
}

func quotaKey(userID uuid.UUID, now time.Time) string {
	day := localDay(now).Format(MomentQuotaDayLayout)
	return fmt.Sprintf(CacheKeyMomentQuota, userID.String(), day)
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

func (s *RedisStore) MarkSeen(ctx context.Context, viewerID uuid.UUID, moments []*models.Moment, now time.Time) (map[uuid.UUID]int64, error) {
	viewer := viewerID.String()
	key := seenKey(viewerID)
	pipe := s.cache.GetClient().TxPipeline()
	totals := make(map[uuid.UUID]*redis.IntCmd, len(moments))
	for _, moment := range moments {
		pipe.ZAdd(ctx, key, redis.Z{Score: float64(moment.ExpiresAt.Unix()), Member: moment.ID.String()})
		pipe.ZAddNX(ctx, viewersKey(moment.ID), redis.Z{Score: float64(now.UnixMilli()), Member: viewer})
		pipe.ExpireAt(ctx, viewersKey(moment.ID), moment.ExpiresAt.Add(MomentViewerSyncGrace))
		totals[moment.ID] = pipe.ZCard(ctx, viewersKey(moment.ID))
	}
	pipe.ZRemRangeByScore(ctx, key, "-inf", strconv.FormatInt(now.Unix(), 10))
	pipe.Expire(ctx, key, MomentSeenTTL)
	if _, err := pipe.Exec(ctx); err != nil {
		return nil, err
	}
	counts := make(map[uuid.UUID]int64, len(totals))
	for id, cmd := range totals {
		counts[id] = cmd.Val()
	}
	return counts, nil
}

func (s *RedisStore) ViewerCounts(ctx context.Context, moments []*models.Moment) (map[uuid.UUID]int64, error) {
	counts := make(map[uuid.UUID]int64, len(moments))
	if len(moments) == 0 {
		return counts, nil
	}
	pipe := s.cache.GetClient().Pipeline()
	cmds := make(map[uuid.UUID]*redis.IntCmd, len(moments))
	for _, moment := range moments {
		cmds[moment.ID] = pipe.ZCard(ctx, viewersKey(moment.ID))
	}
	if _, err := pipe.Exec(ctx); err != nil && err != redis.Nil {
		return nil, err
	}
	for id, cmd := range cmds {
		counts[id] = cmd.Val()
	}
	return counts, nil
}

func (s *RedisStore) ViewerPage(ctx context.Context, momentID uuid.UUID, offset, limit int) ([]redis.Z, int64, error) {
	return s.newestFirstPage(ctx, viewersKey(momentID), offset, limit)
}

func (s *RedisStore) ReactorPage(ctx context.Context, momentID uuid.UUID, offset, limit int) ([]redis.Z, int64, error) {
	return s.newestFirstPage(ctx, reactorsKey(momentID), offset, limit)
}

func (s *RedisStore) newestFirstPage(ctx context.Context, key string, offset, limit int) ([]redis.Z, int64, error) {
	client := s.cache.GetClient()
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

func (s *RedisStore) ReserveQuota(ctx context.Context, userID uuid.UUID, count int, now time.Time) (func(), error) {
	client := s.cache.GetClient()
	key := quotaKey(userID, now)
	used, err := client.IncrBy(ctx, key, int64(count)).Result()
	if err != nil {
		return nil, err
	}
	if used == int64(count) {
		client.Expire(ctx, key, MomentQuotaTTL)
	}
	release := func() {
		client.DecrBy(context.Background(), key, int64(count))
	}
	if used > MaxMomentsPerDay {
		release()
		return nil, errQuotaExceeded
	}
	return release, nil
}

func (s *RedisStore) RecordPurgeLog(ctx context.Context, entry *MediaPurgeLog) error {
	data, err := json.Marshal(entry)
	if err != nil {
		return err
	}
	expired := "(" + strconv.FormatInt(purgeLogWindowStart(entry.StartedAt).UnixMilli(), 10)
	totalsKey := fmt.Sprintf(CacheKeyMomentPurgeTotals, localDay(entry.StartedAt).Format(MomentPurgeDayLayout))
	delta := entry.totalsDelta()
	_, err = s.cache.GetClient().TxPipelined(ctx, func(pipe redis.Pipeliner) error {
		pipe.Set(ctx, CacheKeyMomentPurgeLast, data, MomentPurgeLogRetention)
		if entry.worthKeeping() {
			pipe.ZAdd(ctx, CacheKeyMomentPurgeLogs, redis.Z{Score: float64(entry.StartedAt.UnixMilli()), Member: data})
			pipe.Expire(ctx, CacheKeyMomentPurgeLogs, MomentPurgeLogRetention)
		}
		pipe.ZRemRangeByScore(ctx, CacheKeyMomentPurgeLogs, "-inf", expired)
		for field, value := range delta {
			pipe.HIncrBy(ctx, totalsKey, field, value)
		}
		if len(delta) > 0 {
			pipe.Expire(ctx, totalsKey, MomentPurgeLogRetention+24*time.Hour)
		}
		return nil
	})
	return err
}

func (s *RedisStore) PurgeHistory(ctx context.Context, now time.Time, limit, offset int) (*MediaPurgeHistory, error) {
	client := s.cache.GetClient()
	history := &MediaPurgeHistory{}
	raw, err := client.Get(ctx, CacheKeyMomentPurgeLast).Bytes()
	switch {
	case err == nil:
		var entry MediaPurgeLog
		if json.Unmarshal(raw, &entry) == nil {
			history.Last = &entry
		}
	case !errors.Is(err, redis.Nil):
		return nil, err
	}

	since := strconv.FormatInt(purgeLogWindowStart(now).UnixMilli(), 10)
	pipe := client.Pipeline()
	itemsCmd := pipe.ZRevRangeByScore(ctx, CacheKeyMomentPurgeLogs, &redis.ZRangeBy{
		Min: since, Max: "+inf", Offset: int64(offset), Count: int64(limit),
	})
	totalCmd := pipe.ZCount(ctx, CacheKeyMomentPurgeLogs, since, "+inf")
	dayKeys := purgeTotalsKeys(now)
	dayCmds := make([]*redis.MapStringStringCmd, len(dayKeys))
	for i, key := range dayKeys {
		dayCmds[i] = pipe.HGetAll(ctx, key)
	}
	if _, err := pipe.Exec(ctx); err != nil {
		return nil, err
	}

	history.Total = totalCmd.Val()
	items := itemsCmd.Val()
	history.Items = make([]MediaPurgeLog, 0, len(items))
	for _, item := range items {
		var entry MediaPurgeLog
		if json.Unmarshal([]byte(item), &entry) == nil {
			history.Items = append(history.Items, entry)
		}
	}
	for _, cmd := range dayCmds {
		history.Totals.add(parsePurgeTotals(cmd.Val()))
	}
	return history, nil
}

func purgeLogWindowStart(now time.Time) time.Time {
	today := localDay(now).Truncate(24 * time.Hour).Add(-MomentDayUTCOffset)
	return today.AddDate(0, 0, 1-MomentPurgeLogRetentionDays)
}

func purgeTotalsKeys(now time.Time) []string {
	today := localDay(now)
	keys := make([]string, MomentPurgeLogRetentionDays)
	for i := range keys {
		keys[i] = fmt.Sprintf(CacheKeyMomentPurgeTotals, today.AddDate(0, 0, -i).Format(MomentPurgeDayLayout))
	}
	return keys
}

func parsePurgeTotals(fields map[string]string) MediaPurgeTotals {
	count := func(field string) int64 {
		value, _ := strconv.ParseInt(fields[field], 10, 64)
		return value
	}
	return MediaPurgeTotals{
		Moments: count(MomentPurgeTotalMoments),
		Files:   count(MomentPurgeTotalFiles),
		Bytes:   count(MomentPurgeTotalBytes),
	}
}

var addReactionScript = redis.NewScript(`
local current = tonumber(redis.call('HGET', KEYS[1], ARGV[1]) or '0')
local added = math.min(tonumber(ARGV[3]), tonumber(ARGV[4]) - current)
local first = 0
if added > 0 then
	current = redis.call('HINCRBY', KEYS[1], ARGV[1], added)
	redis.call('HINCRBY', KEYS[1], ARGV[2], added)
	first = redis.call('ZADD', KEYS[2], 'NX', ARGV[6], ARGV[7])
end
redis.call('EXPIREAT', KEYS[1], ARGV[5])
redis.call('EXPIREAT', KEYS[2], ARGV[5])
return {current, first}
`)

func reactionsKey(momentID uuid.UUID) string {
	return fmt.Sprintf(CacheKeyMomentReactions, momentID.String())
}

func reactorsKey(momentID uuid.UUID) string {
	return fmt.Sprintf(CacheKeyMomentReactors, momentID.String())
}

func reactionViewerField(viewerID uuid.UUID, reaction string) string {
	return fmt.Sprintf(MomentReactionViewerField, viewerID.String(), reaction)
}

func reactionTotalField(reaction string) string {
	return fmt.Sprintf(MomentReactionTotalField, reaction)
}

func (s *RedisStore) AddReaction(ctx context.Context, moment *models.Moment, viewerID uuid.UUID, reaction string, count int, now time.Time) (int, bool, error) {
	result, err := addReactionScript.Run(ctx, s.cache.GetClient(),
		[]string{reactionsKey(moment.ID), reactorsKey(moment.ID)},
		reactionViewerField(viewerID, reaction),
		reactionTotalField(reaction),
		count,
		MomentReactionMaxPerType,
		moment.ExpiresAt.Add(MomentViewerSyncGrace).Unix(),
		now.UnixMilli(),
		viewerID.String(),
	).Int64Slice()
	if err != nil {
		return 0, false, err
	}
	if len(result) != 2 {
		return 0, false, fmt.Errorf("unexpected add reaction result: %v", result)
	}
	return int(result[0]), result[1] == 1, nil
}

func (s *RedisStore) ReactionTotals(ctx context.Context, moments []*models.Moment) (map[uuid.UUID]map[string]int64, error) {
	totals := make(map[uuid.UUID]map[string]int64, len(moments))
	if len(moments) == 0 {
		return totals, nil
	}
	fields := make([]string, 0, len(constants.AllowedReactionTypes))
	for _, reaction := range constants.AllowedReactionTypes {
		fields = append(fields, reactionTotalField(reaction))
	}
	pipe := s.cache.GetClient().Pipeline()
	cmds := make(map[uuid.UUID]*redis.SliceCmd, len(moments))
	for _, moment := range moments {
		cmds[moment.ID] = pipe.HMGet(ctx, reactionsKey(moment.ID), fields...)
	}
	if _, err := pipe.Exec(ctx); err != nil {
		return nil, err
	}
	for id, cmd := range cmds {
		totals[id] = countsByReaction(cmd.Val())
	}
	return totals, nil
}

func (s *RedisStore) ViewerReactions(ctx context.Context, momentID uuid.UUID, viewerIDs []uuid.UUID) (map[uuid.UUID]map[string]int64, error) {
	byViewer := make(map[uuid.UUID]map[string]int64, len(viewerIDs))
	if len(viewerIDs) == 0 {
		return byViewer, nil
	}
	perViewer := len(constants.AllowedReactionTypes)
	fields := make([]string, 0, len(viewerIDs)*perViewer)
	for _, viewerID := range viewerIDs {
		for _, reaction := range constants.AllowedReactionTypes {
			fields = append(fields, reactionViewerField(viewerID, reaction))
		}
	}
	values, err := s.cache.GetClient().HMGet(ctx, reactionsKey(momentID), fields...).Result()
	if err != nil {
		return nil, err
	}
	for i, viewerID := range viewerIDs {
		if counts := countsByReaction(values[i*perViewer : (i+1)*perViewer]); len(counts) > 0 {
			byViewer[viewerID] = counts
		}
	}
	return byViewer, nil
}

func countsByReaction(values []interface{}) map[string]int64 {
	counts := make(map[string]int64)
	for i, value := range values {
		raw, ok := value.(string)
		if !ok || i >= len(constants.AllowedReactionTypes) {
			continue
		}
		if count, err := strconv.ParseInt(raw, 10, 64); err == nil && count > 0 {
			counts[constants.AllowedReactionTypes[i]] = count
		}
	}
	return counts
}
