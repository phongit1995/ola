package middleware

import (
	"errors"
	"net/http"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type AuthMiddleware struct {
	jwtService *services.JWTService
	cache      *services.CacheService
	db         *gorm.DB
	logger     *zap.SugaredLogger
}

func NewAuthMiddleware(jwtService *services.JWTService, cache *services.CacheService, db *gorm.DB, logger *zap.SugaredLogger) *AuthMiddleware {
	return &AuthMiddleware{
		jwtService: jwtService,
		cache:      cache,
		db:         db,
		logger:     logger.Named("[auth_middleware]"),
	}
}

func (m *AuthMiddleware) isAdminSessionActive(adminID, sessionID uuid.UUID) (bool, error) {
	var count int64
	err := m.db.Model(&models.AdminSession{}).
		Joins("JOIN admin_users ON admin_users.id = admin_sessions.admin_id").
		Where(
			"admin_sessions.id = ? AND admin_sessions.admin_id = ? AND admin_sessions.revoked_at IS NULL AND admin_sessions.expires_at > NOW() AND admin_users.is_active = ? AND admin_users.deleted_at IS NULL",
			sessionID,
			adminID,
			true,
		).
		Count(&count).Error
	return count == 1, err
}

func (m *AuthMiddleware) RequireAuth() gin.HandlerFunc {
	return func(c *gin.Context) {
		authHeader := c.GetHeader("Authorization")
		if authHeader == "" {
			utils.RespondError(c, http.StatusUnauthorized, "authorization header required")
			c.Abort()
			return
		}

		var token string
		parts := strings.Split(authHeader, " ")
		if len(parts) == 2 && parts[0] == "Bearer" {
			token = parts[1]
		} else if len(parts) == 1 {
			token = parts[0]
		} else {
			utils.RespondError(c, http.StatusUnauthorized, "invalid authorization header format")
			c.Abort()
			return
		}

		identity, err := services.AuthenticateUserAccessToken(m.jwtService, m.cache, token)
		if err != nil {
			status := http.StatusUnauthorized
			if errors.Is(err, services.ErrAuthUnavailable) {
				m.logger.Errorw("Failed to check token revocation", "error", err.Error())
				status = http.StatusServiceUnavailable
			}
			utils.RespondError(c, status, err.Error())
			c.Abort()
			return
		}

		if identity.SessionID != uuid.Nil {
			c.Set("session_id", identity.SessionID)
		}
		c.Set("user_id", identity.UserID)
		c.Next()
	}
}
