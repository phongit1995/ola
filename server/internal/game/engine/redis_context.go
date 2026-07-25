package engine

import (
	"context"
	"time"

	"ola-chat-server/internal/services"
)

const gameRedisOperationTimeout = 2 * time.Second

func gameRedisContext(cache *services.CacheService) (context.Context, context.CancelFunc) {
	return context.WithTimeout(cache.GetContext(), gameRedisOperationTimeout)
}
