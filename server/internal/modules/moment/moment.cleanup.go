package moment

import (
	"context"
	"errors"
	"net/http"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

var ErrMediaPurgeDisabled = utils.NewHTTPErrorWithCode(http.StatusConflict,
	"Tự động xoá file đang tắt, bật và lưu cài đặt trước khi chạy", ErrorCodeMomentPurgeDisabled)

type Cleaner struct {
	repo     *Repository
	store    *RedisStore
	cache    *services.CacheService
	s3       *services.S3Service
	settings *setting.Service
	logger   *zap.SugaredLogger
}

func NewCleaner(repo *Repository, store *RedisStore, cache *services.CacheService, s3 *services.S3Service, settings *setting.Service, logger *zap.SugaredLogger) *Cleaner {
	return &Cleaner{repo: repo, store: store, cache: cache, s3: s3, settings: settings, logger: logger.Named("[moment_cleaner]")}
}

func (c *Cleaner) Start(ctx context.Context) {
	utils.SafeGo(c.logger, func() { c.loop(ctx) })
}

func (c *Cleaner) loop(ctx context.Context) {
	timer := time.NewTimer(MomentCleanupStartDelay)
	defer timer.Stop()
	for {
		select {
		case <-ctx.Done():
			return
		case <-timer.C:
		}
		if _, err := c.RunOnce(ctx); err != nil {
			c.logger.Warnw("Moment cleanup failed", "error", err)
		}
		timer.Reset(MomentCleanupInterval)
	}
}

func (c *Cleaner) RunOnce(ctx context.Context) (int, error) {
	token := uuid.NewString()
	acquired, err := c.cache.SetNX(CacheKeyMomentCleanupLock, token, MomentCleanupLockTTL)
	if err != nil || !acquired {
		return 0, err
	}
	defer func() {
		if _, err := c.cache.DeleteIfValue(CacheKeyMomentCleanupLock, token); err != nil {
			c.logger.Warnw("Failed to release moment cleanup lock", "error", err)
		}
	}()

	if err := c.syncCounts(ctx); err != nil {
		c.logger.Warnw("Failed to sync moment viewer and reaction counts", "error", err)
	}
	cleared := c.clearSourceLeftovers(ctx)
	if cleared > 0 {
		c.logger.Infow("Leftover moment video sources removed", "count", cleared)
	}
	c.autoPurge(ctx)
	return cleared, nil
}

func (c *Cleaner) autoPurge(ctx context.Context) {
	cfg, err := c.settings.GetMomentMediaPurge()
	if err != nil {
		c.logger.Warnw("Failed to read moment media purge setting", "error", err)
		return
	}
	if !cfg.Enabled {
		return
	}
	token, ok, err := c.lockPurge()
	if err != nil {
		c.logger.Warnw("Failed to take moment media purge lock", "error", err)
		return
	}
	if !ok {
		return
	}
	defer c.unlockPurge(token)
	runCtx, cancel := context.WithTimeout(ctx, MomentPurgeRunTimeout)
	defer cancel()
	c.runPurge(runCtx, MomentPurgeTriggerAuto, cfg.AfterHours)
}

func (c *Cleaner) StartMediaPurge() (bool, error) {
	cfg, err := c.settings.GetMomentMediaPurge()
	if err != nil {
		return false, err
	}
	if !cfg.Enabled {
		return false, ErrMediaPurgeDisabled
	}
	token, ok, err := c.lockPurge()
	if err != nil || !ok {
		return false, err
	}
	utils.SafeGo(c.logger, func() {
		defer c.unlockPurge(token)
		ctx, cancel := context.WithTimeout(context.Background(), MomentPurgeRunTimeout)
		defer cancel()
		c.runPurge(ctx, MomentPurgeTriggerManual, cfg.AfterHours)
	})
	return true, nil
}

func (c *Cleaner) MediaPurgeRunning() (bool, error) {
	return c.cache.Exists(CacheKeyMomentPurgeLock)
}

func (c *Cleaner) MediaPurgeHistory(ctx context.Context, limit, offset int) (*MediaPurgeHistory, error) {
	return c.store.PurgeHistory(ctx, time.Now().UTC(), limit, offset)
}

func (c *Cleaner) lockPurge() (string, bool, error) {
	token := uuid.NewString()
	acquired, err := c.cache.SetNX(CacheKeyMomentPurgeLock, token, MomentPurgeLockTTL)
	return token, acquired, err
}

func (c *Cleaner) unlockPurge(token string) {
	if _, err := c.cache.DeleteIfValue(CacheKeyMomentPurgeLock, token); err != nil {
		c.logger.Warnw("Failed to release moment media purge lock", "error", err)
	}
}

func (c *Cleaner) runPurge(ctx context.Context, trigger string, afterHours int) {
	startedAt := time.Now().UTC()
	entry := &MediaPurgeLog{
		ID:         uuid.NewString(),
		Trigger:    trigger,
		AfterHours: afterHours,
		Cutoff:     startedAt.Add(-time.Duration(afterHours) * time.Hour),
		StartedAt:  startedAt,
	}
	err := c.purgeAged(ctx, entry)
	entry.settle(err, time.Now().UTC())
	if err != nil {
		c.logger.Warnw("Moment media purge failed", "trigger", trigger, "error", err)
	}
	if entry.Purged > 0 || entry.Failed > 0 {
		c.logger.Infow("Moment media purge finished", "trigger", trigger, "purged", entry.Purged, "files", entry.Files, "bytes", entry.Bytes, "failed", entry.Failed, "has_more", entry.HasMore)
	}
	writeCtx, cancel := context.WithTimeout(context.WithoutCancel(ctx), MomentPurgeLogWriteTimeout)
	defer cancel()
	if err := c.store.RecordPurgeLog(writeCtx, entry); err != nil {
		c.logger.Warnw("Failed to save moment media purge log", "error", err)
	}
}

func (c *Cleaner) purgeAged(ctx context.Context, entry *MediaPurgeLog) error {
	cursor := purgeCursor{CreatedAt: time.Unix(0, 0).UTC()}
	for batch := 0; batch < MomentPurgeMaxBatches; batch++ {
		if ctx.Err() != nil {
			return stopPurge(ctx, entry)
		}
		rows, err := c.repo.ClaimAgedPurge(ctx, entry.Cutoff, cursor, MomentPurgeBatchSize)
		if err != nil {
			if ctx.Err() != nil {
				return stopPurge(ctx, entry)
			}
			return err
		}
		if len(rows) == 0 {
			return nil
		}
		emptied, interrupted := c.purgeBatch(ctx, entry, rows, &cursor)
		if err := c.markPurged(ctx, emptied); err != nil {
			return err
		}
		entry.Purged += len(emptied)
		if interrupted {
			return stopPurge(ctx, entry)
		}
		if len(rows) < MomentPurgeBatchSize {
			return nil
		}
		if len(emptied) == 0 {
			entry.HasMore = true
			return nil
		}
	}
	entry.HasMore = true
	return nil
}

func (c *Cleaner) purgeBatch(ctx context.Context, entry *MediaPurgeLog, rows []cleanupCandidate, cursor *purgeCursor) ([]uuid.UUID, bool) {
	emptied := make([]uuid.UUID, 0, len(rows))
	for i, row := range rows {
		if ctx.Err() != nil {
			c.restorePurge(ctx, rows[i:]...)
			return emptied, true
		}
		if cursor.after(row) {
			*cursor = purgeCursor{CreatedAt: row.CreatedAt, ID: row.ID}
		}
		filesBefore := entry.Files
		if c.purgeObjects(ctx, entry, row.objects()...) {
			emptied = append(emptied, row.ID)
			continue
		}
		interrupted := ctx.Err() != nil
		if !interrupted {
			entry.Failed++
		}
		if entry.Files == filesBefore {
			c.restorePurge(ctx, row)
		}
		if interrupted {
			c.restorePurge(ctx, rows[i+1:]...)
			return emptied, true
		}
	}
	return emptied, false
}

func stopPurge(ctx context.Context, entry *MediaPurgeLog) error {
	if errors.Is(ctx.Err(), context.DeadlineExceeded) {
		entry.HasMore = true
		return nil
	}
	return ctx.Err()
}

func (c *Cleaner) restorePurge(ctx context.Context, rows ...cleanupCandidate) {
	if len(rows) == 0 {
		return
	}
	settleCtx, cancel := settleContext(ctx)
	defer cancel()
	for _, row := range rows {
		if err := c.repo.RestoreStatus(settleCtx, row.ID, row.Status); err != nil {
			c.logger.Warnw("Failed to restore moment status after purge failure", "moment_id", row.ID, "error", err)
		}
	}
}

func (c *Cleaner) markPurged(ctx context.Context, ids []uuid.UUID) error {
	settleCtx, cancel := settleContext(ctx)
	defer cancel()
	return c.repo.MarkPurged(settleCtx, ids, time.Now().UTC())
}

func settleContext(ctx context.Context) (context.Context, context.CancelFunc) {
	return context.WithTimeout(context.WithoutCancel(ctx), MomentPurgeSettleTimeout)
}

func (c *Cleaner) syncCounts(ctx context.Context) error {
	since := time.Now().UTC().Add(-MomentViewerSyncGrace)
	moments, err := c.repo.ViewerSyncCandidates(since, MomentViewerSyncLimit)
	if err != nil || len(moments) == 0 {
		return err
	}
	live, err := c.store.ViewerCounts(ctx, moments)
	if err != nil {
		return err
	}
	if err := c.repo.RaiseViewerCounts(staleViewerCounts(moments, live)); err != nil {
		return err
	}
	reactions, err := c.store.ReactionTotals(ctx, moments)
	if err != nil {
		return err
	}
	return c.repo.RaiseReactionCounts(staleReactionCounts(moments, reactions))
}

func staleViewerCounts(moments []*models.Moment, live map[uuid.UUID]int64) map[uuid.UUID]int64 {
	stale := make(map[uuid.UUID]int64)
	for _, moment := range moments {
		if count := live[moment.ID]; count > moment.ViewerCount {
			stale[moment.ID] = count
		}
	}
	return stale
}

func (c *Cleaner) PurgeMedia(ctx context.Context, id uuid.UUID) (bool, error) {
	row, err := c.repo.ClaimMediaPurge(ctx, id)
	if err != nil || row == nil {
		return false, err
	}
	var removed MediaPurgeLog
	if !c.purgeObjects(ctx, &removed, row.objects()...) {
		if removed.Files == 0 {
			c.restorePurge(ctx, *row)
		}
		return false, errMediaPurgeFailed
	}
	if err := c.markPurged(ctx, []uuid.UUID{row.ID}); err != nil {
		return false, err
	}
	c.logger.Infow("Moment media removed by admin", "moment_id", row.ID)
	return true, nil
}

func (c *Cleaner) clearSourceLeftovers(ctx context.Context) int {
	rows, err := c.repo.SourceLeftovers(MomentSourceCleanupBatchSize)
	if err != nil {
		c.logger.Warnw("Failed to list leftover moment sources", "error", err)
		return 0
	}
	cleared := 0
	for _, row := range rows {
		if ctx.Err() != nil || !c.deleteObjects(ctx, row.SourceObject) {
			continue
		}
		if err := c.repo.ClearSource(row.ID, row.SourceObject); err != nil {
			c.logger.Warnw("Failed to forget deleted moment source", "moment_id", row.ID, "error", err)
			continue
		}
		cleared++
	}
	return cleared
}

func (c *Cleaner) purgeObjects(ctx context.Context, entry *MediaPurgeLog, objectNames ...string) bool {
	for _, objectName := range objectNames {
		if objectName == "" {
			continue
		}
		statCtx, cancel := context.WithTimeout(ctx, MomentObjectStatTimeout)
		size, found, err := c.s3.ObjectSize(statCtx, objectName)
		cancel()
		if err != nil {
			c.logger.Warnw("Failed to read moment object size", "object", objectName, "error", err)
			return false
		}
		if !found {
			continue
		}
		if !c.deleteObjects(ctx, objectName) {
			return false
		}
		entry.Files++
		entry.Bytes += size
	}
	return true
}

func (c *Cleaner) deleteObjects(ctx context.Context, objectNames ...string) bool {
	for _, objectName := range objectNames {
		if objectName == "" {
			continue
		}
		deleteCtx, cancel := context.WithTimeout(ctx, MomentObjectDeleteTimeout)
		err := c.s3.DeleteFile(deleteCtx, objectName)
		cancel()
		if err != nil {
			c.logger.Warnw("Failed to delete moment object", "object", objectName, "error", err)
			return false
		}
	}
	return true
}
