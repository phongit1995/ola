package mediasend

import (
	"context"
	"errors"
	"fmt"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/media"
	"ola-chat-server/internal/services"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

var ErrReactionInProgress = errors.New("reaction in progress, please retry")

type Helper struct {
	Cache  *services.CacheService
	S3     *services.S3Service
	Logger *zap.SugaredLogger
	Label  string
}

func AcquireUpload[T any](h Helper, key string, lookup func() (*T, error)) (*T, func(), error) {
	noRelease := func() {}
	existing, err := lookup()
	if err != nil || existing != nil {
		return existing, noRelease, err
	}

	token := uuid.NewString()
	acquired, err := h.Cache.SetNX(key, token, constants.CacheTTLMediaUploadLock*time.Second)
	if err != nil {
		return nil, noRelease, fmt.Errorf("failed to acquire %s upload lock: %w", h.Label, err)
	}
	if !acquired {
		existing, err := lookup()
		if err != nil || existing != nil {
			return existing, noRelease, err
		}
		return nil, noRelease, media.ErrUploadInProgress
	}

	release := func() {
		if _, err := h.Cache.DeleteIfValue(key, token); err != nil {
			h.Logger.Warnw(fmt.Sprintf("Failed to release %s upload lock", h.Label), "key", key, "error", err)
		}
	}
	existing, err = lookup()
	if err != nil || existing != nil {
		release()
		return existing, noRelease, err
	}
	return nil, release, nil
}

func (h Helper) Allow(key string, windowSecs, maxReqs int) bool {
	count, err := h.Cache.Increment(key)
	if err != nil {
		h.Logger.Errorw("Rate limit Redis failure, failing closed", "key", key, "error", err)
		return false
	}
	if count == 1 {
		if expErr := h.Cache.SetExpire(key, time.Duration(windowSecs)*time.Second); expErr != nil {
			h.Logger.Warnw("Failed to set rate limit expiry, deleting key to prevent permanent block", "key", key, "error", expErr)
			h.Cache.Delete(key)
		}
	}
	return count <= int64(maxReqs)
}

func (h Helper) AllowUpload(userID uuid.UUID) bool {
	key := fmt.Sprintf(constants.CacheKeyRateLimitUpload, userID.String())
	return h.Allow(key, constants.RateLimitUploadWindowSeconds, constants.RateLimitUploadMaxRequests)
}

func (h Helper) AllowReaction(userID uuid.UUID) bool {
	key := fmt.Sprintf(constants.CacheKeyRateLimitReaction, userID.String())
	return h.Allow(key, constants.RateLimitReactionWindowSeconds, constants.RateLimitReactionMaxRequests)
}

func (h Helper) Cleanup(objectName string) {
	if objectName == "" || h.S3 == nil {
		return
	}
	ctx, cancel := context.WithTimeout(context.Background(), cleanupTimeout)
	defer cancel()
	if err := h.S3.DeleteFile(ctx, objectName); err != nil {
		h.Logger.Warnw(fmt.Sprintf("Failed to clean up uploaded %s", h.Label), "object", objectName, "error", err)
	}
}

func (h Helper) LockReaction(messageID string, value any) (string, error) {
	key := fmt.Sprintf(constants.CacheKeyReactionLock, messageID)
	ttl := time.Duration(constants.ReactionLockTTLSeconds) * time.Second
	acquired, err := h.Cache.SetNX(key, value, ttl)
	if err != nil {
		h.Logger.Warnw("Reaction lock SetNX failed", "message_id", messageID, "error", err)
	}
	if acquired {
		return key, nil
	}
	time.Sleep(time.Duration(constants.ReactionLockRetryMs) * time.Millisecond)
	acquired, err = h.Cache.SetNX(key, value, ttl)
	if err != nil {
		h.Logger.Warnw("Reaction lock SetNX retry failed", "message_id", messageID, "error", err)
	}
	if !acquired {
		return "", ErrReactionInProgress
	}
	return key, nil
}
