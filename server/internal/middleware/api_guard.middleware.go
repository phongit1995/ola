package middleware

import (
	"net/http"
	"strconv"
	"strings"
	"sync"
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
	headerBypass    = "admin"

	signingMaxSkew     = 5 * time.Minute
	nonceCleanupPeriod = time.Minute

	errSignatureInvalid = "REQUEST_SIGNATURE_INVALID"
	statusSignature     = http.StatusLocked // 423 — single code for any signing failure
)

// nonceStore rejects nonce reuse within the signing window so a captured
// request cannot be replayed. In-memory: with multiple API instances each
// keeps its own set, so move this to Redis before scaling out.
type nonceStore struct {
	mu      sync.Mutex
	entries map[string]time.Time
}

func newNonceStore() *nonceStore {
	s := &nonceStore{entries: make(map[string]time.Time)}
	go s.cleanupLoop()
	return s
}

func (s *nonceStore) cleanupLoop() {
	for range time.Tick(nonceCleanupPeriod) {
		now := time.Now()
		s.mu.Lock()
		for nonce, expiresAt := range s.entries {
			if now.After(expiresAt) {
				delete(s.entries, nonce)
			}
		}
		s.mu.Unlock()
	}
}

func (s *nonceStore) markUsed(nonce string, expiresAt time.Time) bool {
	s.mu.Lock()
	defer s.mu.Unlock()
	if _, used := s.entries[nonce]; used {
		return false
	}
	s.entries[nonce] = expiresAt
	return true
}

type ApiGuardMiddleware struct {
	cfg     *config.Config
	enabled bool
	logger  *zap.SugaredLogger
	nonces  *nonceStore
}

func NewApiGuardMiddleware(cfg *config.Config, logger *zap.SugaredLogger) *ApiGuardMiddleware {
	return &ApiGuardMiddleware{
		cfg:     cfg,
		enabled: cfg.APIGuardSecret != "",
		logger:  logger.Named("[api_guard]"),
		nonces:  newNonceStore(),
	}
}

func (m *ApiGuardMiddleware) Verify() gin.HandlerFunc {
	return func(c *gin.Context) {
		if !m.enabled {
			c.Next()
			return
		}
		if m.cfg.APIGuardBypassKey != "" && c.GetHeader(headerBypass) == m.cfg.APIGuardBypassKey {
			c.Next()
			return
		}
		path := c.Request.URL.Path
		if strings.HasPrefix(path, "/api/v1/auth") ||
			strings.HasPrefix(path, "/api/v1/health") ||
			path == "/api/v1/calls/webhook" {
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

	ms, err := strconv.ParseInt(timestamp, 10, 64)
	if err != nil {
		return false
	}
	if !m.nonces.markUsed(nonce, time.UnixMilli(ms).Add(signingMaxSkew)) {
		m.logger.Debugw("nonce replayed", "path", path)
		return false
	}

	return true
}
