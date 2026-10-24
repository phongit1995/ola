package reel

import (
	"context"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Cleaner struct {
	repo   *Repository
	store  *RedisStore
	cache  *services.CacheService
	s3     *services.S3Service
	logger *zap.SugaredLogger
}

func NewCleaner(repo *Repository, store *RedisStore, cache *services.CacheService, s3 *services.S3Service, logger *zap.SugaredLogger) *Cleaner {
	return &Cleaner{repo: repo, store: store, cache: cache, s3: s3, logger: logger.Named("[reel_cleaner]")}
}

func (c *Cleaner) Start(ctx context.Context) {
	utils.SafeGo(c.logger, func() { c.loop(ctx) })
}

func (c *Cleaner) loop(ctx context.Context) {
	timer := time.NewTimer(constants.ReelCleanupStartDelay)
	defer timer.Stop()
	for {
		select {
		case <-ctx.Done():
			return
		case <-timer.C:
		}
		if _, err := c.RunOnce(ctx); err != nil {
			c.logger.Warnw("Reel cleanup failed", "error", err)
		}
		timer.Reset(constants.ReelCleanupInterval)
	}
}

func (c *Cleaner) RunOnce(ctx context.Context) (int, error) {
	token := uuid.NewString()
	acquired, err := c.cache.SetNX(constants.CacheKeyReelCleanupLock, token, constants.ReelCleanupLockTTL)
	if err != nil || !acquired {
		return 0, err
	}
	defer func() {
		if _, err := c.cache.DeleteIfValue(constants.CacheKeyReelCleanupLock, token); err != nil {
			c.logger.Warnw("Failed to release reel cleanup lock", "error", err)
		}
	}()

	purged := 0
	for batch := 0; batch < constants.ReelCleanupMaxBatches && ctx.Err() == nil; batch++ {
		rows, err := c.repo.ClaimPurge(time.Now().UTC(), constants.ReelCleanupBatchSize)
		if err != nil {
			return purged, err
		}
		if len(rows) == 0 {
			break
		}
		emptied := make([]uuid.UUID, 0, len(rows))
		for _, row := range rows {
			if c.deleteObjects(ctx, row.objects()...) {
				emptied = append(emptied, row.ID)
			}
		}
		if err := c.repo.MarkPurged(emptied, time.Now().UTC()); err != nil {
			return purged, err
		}
		if err := c.store.DropViewers(ctx, emptied); err != nil {
			c.logger.Warnw("Failed to drop reel viewers", "error", err)
		}
		purged += len(emptied)
		if len(rows) < constants.ReelCleanupBatchSize || len(emptied) == 0 {
			break
		}
	}
	if purged > 0 {
		c.logger.Infow("Expired reel media removed", "count", purged)
	}
	if cleared := c.clearSourceLeftovers(ctx); cleared > 0 {
		c.logger.Infow("Leftover reel video sources removed", "count", cleared)
	}
	return purged, nil
}

func (c *Cleaner) clearSourceLeftovers(ctx context.Context) int {
	rows, err := c.repo.SourceLeftovers(constants.ReelSourceCleanupBatchSize)
	if err != nil {
		c.logger.Warnw("Failed to list leftover reel sources", "error", err)
		return 0
	}
	cleared := 0
	for _, row := range rows {
		if ctx.Err() != nil || !c.deleteObjects(ctx, row.SourceObject) {
			continue
		}
		if err := c.repo.ClearSource(row.ID, row.SourceObject); err != nil {
			c.logger.Warnw("Failed to forget deleted reel source", "reel_id", row.ID, "error", err)
			continue
		}
		cleared++
	}
	return cleared
}

func (c *Cleaner) deleteObjects(ctx context.Context, objectNames ...string) bool {
	for _, objectName := range objectNames {
		if objectName == "" {
			continue
		}
		deleteCtx, cancel := context.WithTimeout(ctx, constants.ReelObjectDeleteTimeout)
		err := c.s3.DeleteFile(deleteCtx, objectName)
		cancel()
		if err != nil {
			c.logger.Warnw("Failed to delete reel object", "object", objectName, "error", err)
			return false
		}
	}
	return true
}
