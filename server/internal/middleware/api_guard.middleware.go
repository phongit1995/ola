package middleware

import (
	"net/http"
	"strings"
	"time"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

const (
	headerTimestamp = "X-Timestamp"
	headerNonce     = "X-Nonce"
	headerSignature = "X-Signature"

	signingMaxSkew = 10 * time.Second

	errSignatureInvalid = "REQUEST_SIGNATURE_INVALID"
	statusSignature     = http.StatusLocked // 423 — single code for any signing failure
)

type ApiGuardMiddleware struct {
	cfg     *config.Config
	enabled bool
	logger  *zap.SugaredLogger
}

func NewApiGuardMiddleware(cfg *config.Config, logger *zap.SugaredLogger) *ApiGuardMiddleware {
	return &ApiGuardMiddleware{
		cfg:     cfg,
		enabled: cfg.APIGuardSecret != "",
		logger:  logger.Named("[api_guard]"),
	}
}

func (m *ApiGuardMiddleware) Verify() gin.HandlerFunc {
	return func(c *gin.Context) {
		if !m.enabled {
			c.Next()
			return
		}
		path := c.Request.URL.Path
		if strings.HasPrefix(path, "/api/v1/auth") || strings.HasPrefix(path, "/api/v1/health") {
			c.Next()
			return
		}
		if !m.valid(c, path) {
			utils.RespondError(c, statusSignature, errSignatureInvalid)
			c.Abort()
			return
		}
		c.Next()
	}
}

// valid reports whether the request carries a correct signature. The specific
// failure reason is only logged (debug) — clients always get one code (423).
func (m *ApiGuardMiddleware) valid(c *gin.Context, path string) bool {
	timestamp := c.GetHeader(headerTimestamp)
	nonce := c.GetHeader(headerNonce)
	signature := c.GetHeader(headerSignature)

	if !utils.APIGuardVerify(m.cfg.APIGuardSecret, timestamp, nonce, signature, c.Request.Method, path, signingMaxSkew) {
		m.logger.Debugw("invalid request signature", "path", path)
		return false
	}

	return true
}
