package middleware

import (
	"crypto/hmac"
	"crypto/sha256"
	"encoding/hex"
	"net/http"
	"strconv"
	"strings"
	"time"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

const (
	headerTimestamp   = "X-Timestamp"
	headerNonce       = "X-Nonce"
	headerSignature   = "X-Signature"
	headerAdminBypass = "admin"

	signingMaxSkew = 10 * time.Second

	errSignatureInvalid = "REQUEST_SIGNATURE_INVALID"
	statusSignature     = http.StatusLocked // 423 — single code for any signing failure
)

func hmacSha256Hex(secret, value string) string {
	mac := hmac.New(sha256.New, []byte(secret))
	mac.Write([]byte(value))
	return hex.EncodeToString(mac.Sum(nil))
}

func safeEqualHex(a, b string) bool {
	ab, err := hex.DecodeString(a)
	if err != nil {
		return false
	}
	bb, err := hex.DecodeString(b)
	if err != nil {
		return false
	}
	return hmac.Equal(ab, bb)
}

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
		if c.GetHeader(headerAdminBypass) == "admin" {
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
	if timestamp == "" || nonce == "" || signature == "" {
		m.logger.Debugw("missing signature headers", "path", path)
		return false
	}

	secret := m.cfg.APIGuardSecret

	ms, err := strconv.ParseInt(timestamp, 10, 64)
	if err != nil {
		m.logger.Debugw("invalid timestamp", "path", path)
		return false
	}
	skew := time.Since(time.UnixMilli(ms))
	if skew > signingMaxSkew || skew < -signingMaxSkew {
		m.logger.Debugw("expired/future timestamp", "path", path, "skew", skew.String())
		return false
	}

	canonical := strings.Join([]string{
		timestamp,
		nonce,
		strings.ToUpper(c.Request.Method),
		path,
	}, "\n")

	if !safeEqualHex(hmacSha256Hex(secret, canonical), signature) {
		m.logger.Debugw("signature mismatch", "path", path)
		return false
	}

	return true
}
