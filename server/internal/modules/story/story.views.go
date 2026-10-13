package story

import (
	"context"
	"fmt"
	"math/rand/v2"

	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"github.com/redis/go-redis/v9"
	"go.uber.org/zap"
)

var addViewScript = redis.NewScript(`
if not redis.call('SET', KEYS[1], 1, 'NX', 'PX', ARGV[1]) then
	return 0
end
local count = redis.call('HINCRBY', KEYS[2], ARGV[2], 1)
if count < tonumber(ARGV[3]) then
	return 0
end
redis.call('HDEL', KEYS[2], ARGV[2])
return count
`)

type viewStore interface {
	AddViews(ctx context.Context, storyID uuid.UUID, views int64) error
}

type ViewCounter struct {
	store   viewStore
	cache   *services.CacheService
	logger  *zap.SugaredLogger
	flushAt func() int
}

func NewViewCounter(repo *Repository, cache *services.CacheService, logger *zap.SugaredLogger) *ViewCounter {
	return newViewCounter(repo, cache, logger)
}

func newViewCounter(store viewStore, cache *services.CacheService, logger *zap.SugaredLogger) *ViewCounter {
	return &ViewCounter{store: store, cache: cache, logger: logger.Named("[story_views]"), flushAt: randomFlushAt}
}

func randomFlushAt() int {
	return StoryViewFlushMin + rand.IntN(StoryViewFlushMax-StoryViewFlushMin+1)
}

func (v *ViewCounter) Track(viewerID, storyID uuid.UUID) {
	if v == nil {
		return
	}
	utils.SafeGo(v.logger, func() {
		ctx, cancel := context.WithTimeout(context.Background(), StoryViewTrackTimeout)
		defer cancel()
		if err := v.track(ctx, viewerID, storyID); err != nil {
			v.logger.Warnw("track story view failed", "storyId", storyID, "error", err)
		}
	})
}

func (v *ViewCounter) track(ctx context.Context, viewerID, storyID uuid.UUID) error {
	client := v.cache.GetClient()
	guard := fmt.Sprintf(CacheKeyStoryViewGuard, storyID.String(), viewerID.String())
	views, err := addViewScript.Run(ctx, client,
		[]string{guard, CacheKeyStoryViewsPending},
		StoryViewGuardTTL.Milliseconds(), storyID.String(), v.flushAt(),
	).Int64()
	if err != nil || views == 0 {
		return err
	}
	if err := v.store.AddViews(ctx, storyID, views); err != nil {
		restoreCtx, cancel := context.WithTimeout(context.Background(), StoryViewTrackTimeout)
		defer cancel()
		if restoreErr := client.HIncrBy(restoreCtx, CacheKeyStoryViewsPending, storyID.String(), views).Err(); restoreErr != nil {
			v.logger.Errorw("restore pending story views failed", "storyId", storyID, "views", views, "error", restoreErr)
		}
		return err
	}
	return nil
}
