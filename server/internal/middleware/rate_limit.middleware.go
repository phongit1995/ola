package middleware

import (
	"fmt"
	"net/http"
	"strconv"

	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis_rate/v10"
	"go.uber.org/zap"
)

const errRateLimited = "RATE_LIMITED"

type RateLimitMiddleware struct {
	limiter *redis_rate.Limiter
	logger  *zap.SugaredLogger
}

func NewRateLimitMiddleware(cache *services.CacheService, logger *zap.SugaredLogger) *RateLimitMiddleware {
	return &RateLimitMiddleware{
		limiter: redis_rate.NewLimiter(cache.GetClient()),
		logger:  logger.Named("[rate_limit]"),
	}
}

func (m *RateLimitMiddleware) Limit(name string, limit redis_rate.Limit) gin.HandlerFunc {
	return func(c *gin.Context) {
		identity := c.ClientIP()
		if v, ok := c.Get("user_id"); ok {
			identity = fmt.Sprintf("%v", v)
		}
		key := fmt.Sprintf("rl:%s:%s", name, identity)

		res, err := m.limiter.Allow(c.Request.Context(), key, limit)
		if err != nil {
			m.logger.Warnw("rate limit unavailable, allowing request", "key", key, "error", err.Error())
			c.Next()
			return
		}

		if res.Allowed == 0 {
			c.Header("Retry-After", strconv.Itoa(int(res.RetryAfter.Seconds())+1))
			utils.RespondError(c, http.StatusTooManyRequests, errRateLimited)
			c.Abort()
			return
		}

		c.Next()
	}
}
