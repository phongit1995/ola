package giftcode

import (
	"context"
	"time"

	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Cleaner struct {
	service *Service
	cache   *services.CacheService
	logger  *zap.SugaredLogger
}

func NewCleaner(service *Service, cache *services.CacheService, logger *zap.SugaredLogger) *Cleaner {
	return &Cleaner{service: service, cache: cache, logger: logger.Named("[gift_code_cleaner]")}
}

func (c *Cleaner) Start(ctx context.Context) {
	utils.SafeGo(c.logger, func() { c.loop(ctx) })
}

func (c *Cleaner) loop(ctx context.Context) {
	timer := time.NewTimer(CleanupStartDelay)
	defer timer.Stop()
	for {
		select {
		case <-ctx.Done():
			return
		case <-timer.C:
		}
		c.runOnce()
		timer.Reset(CleanupInterval)
	}
}

func (c *Cleaner) runOnce() {
	token := uuid.NewString()
	acquired, err := c.cache.SetNX(CacheKeyGiftCodeCleanupLock, token, CleanupLockTTL)
	if err != nil || !acquired {
		return
	}
	defer func() {
		if _, err := c.cache.DeleteIfValue(CacheKeyGiftCodeCleanupLock, token); err != nil {
			c.logger.Warnw("Failed to release gift code cleanup lock", "error", err)
		}
	}()
	deleted, err := c.service.PurgeAttempts()
	if err != nil {
		c.logger.Warnw("Gift code attempt cleanup failed", "deleted", deleted, "error", err)
		return
	}
	if deleted > 0 {
		c.logger.Infow("Purged old gift code attempts", "deleted", deleted)
	}
}
