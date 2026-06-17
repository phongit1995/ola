package middleware

import (
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"
	"fmt"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type AuthMiddleware struct {
	jwtService *services.JWTService
	cache      *services.CacheService
	logger     *zap.SugaredLogger
}

func NewAuthMiddleware(jwtService *services.JWTService, cache *services.CacheService, logger *zap.SugaredLogger) *AuthMiddleware {
	return &AuthMiddleware{
		jwtService: jwtService,
		cache:      cache,
		logger:     logger.Named("[auth_middleware]"),
	}
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

		claims, err := m.jwtService.VerifyToken(token)
		if err != nil {
			utils.RespondError(c, http.StatusUnauthorized, "invalid or expired token")
			c.Abort()
			return
		}

		if claims.ID != "" {
			key := fmt.Sprintf(constants.CacheKeyTokenBlacklist, claims.ID)
			if exists, _ := m.cache.Exists(key); exists {
				utils.RespondError(c, http.StatusUnauthorized, "token has been revoked")
				c.Abort()
				return
			}
		}

		dataMap, ok := claims.Data.(map[string]interface{})
		if !ok {
			utils.RespondError(c, http.StatusUnauthorized, "invalid token payload")
			c.Abort()
			return
		}

		if isAdmin, _ := dataMap["isAdmin"].(bool); isAdmin {
			utils.RespondError(c, http.StatusUnauthorized, "invalid token")
			c.Abort()
			return
		}
		if tokenType, _ := dataMap["type"].(string); tokenType == "admin" {
			utils.RespondError(c, http.StatusUnauthorized, "invalid token")
			c.Abort()
			return
		}

		userIDStr, ok := dataMap["id"].(string)
		if !ok {
			utils.RespondError(c, http.StatusUnauthorized, "id missing from token")
			c.Abort()
			return
		}
		userID, err := uuid.Parse(userIDStr)
		if err != nil {
			utils.RespondError(c, http.StatusUnauthorized, "invalid id in token")
			c.Abort()
			return
		}

		if sidStr, ok := dataMap["sid"].(string); ok && sidStr != "" {
			if sessionID, err := uuid.Parse(sidStr); err == nil {
				revokedKey := fmt.Sprintf(constants.CacheKeySessionRevoked, sessionID.String())
				if exists, _ := m.cache.Exists(revokedKey); exists {
					utils.RespondError(c, http.StatusUnauthorized, "session revoked")
					c.Abort()
					return
				}
				c.Set("session_id", sessionID)
			}
		}

		c.Set("user_id", userID)
		c.Next()
	}
}

func GetUserID(c *gin.Context) (uuid.UUID, bool) {
	userID, exists := c.Get("user_id")
	if !exists {
		return uuid.Nil, false
	}

	id, ok := userID.(uuid.UUID)
	return id, ok
}
