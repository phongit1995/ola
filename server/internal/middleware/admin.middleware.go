package middleware

import (
	"fmt"
	"net/http"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/utils"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

func (m *AuthMiddleware) RequireAdmin() gin.HandlerFunc {
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

		isAdmin, _ := dataMap["isAdmin"].(bool)
		tokenType, _ := dataMap["type"].(string)
		if !isAdmin || tokenType != constants.TokenTypeAdmin {
			utils.RespondError(c, http.StatusForbidden, "admin access required")
			c.Abort()
			return
		}
		if tokenUse, _ := dataMap["token_use"].(string); tokenUse != constants.TokenUseAccess {
			utils.RespondError(c, http.StatusUnauthorized, "invalid token type")
			c.Abort()
			return
		}

		adminIDStr, ok := dataMap["id"].(string)
		if !ok {
			utils.RespondError(c, http.StatusUnauthorized, "id missing from token")
			c.Abort()
			return
		}
		adminID, err := uuid.Parse(adminIDStr)
		if err != nil {
			utils.RespondError(c, http.StatusUnauthorized, "invalid id in token")
			c.Abort()
			return
		}

		sessionIDStr, ok := dataMap["sid"].(string)
		if !ok || sessionIDStr == "" {
			utils.RespondError(c, http.StatusUnauthorized, "session id missing from token")
			c.Abort()
			return
		}
		sessionID, err := uuid.Parse(sessionIDStr)
		if err != nil {
			utils.RespondError(c, http.StatusUnauthorized, "invalid session id in token")
			c.Abort()
			return
		}

		active, err := m.isAdminSessionActive(adminID, sessionID)
		if err != nil {
			m.logger.Errorw("Failed to validate admin session", "admin_id", adminID, "session_id", sessionID, "error", err.Error())
			utils.RespondError(c, http.StatusServiceUnavailable, "authentication service unavailable")
			c.Abort()
			return
		}
		if !active {
			utils.RespondError(c, http.StatusUnauthorized, "admin session has been revoked")
			c.Abort()
			return
		}

		role, _ := dataMap["role"].(string)
		c.Set("admin_id", adminID)
		c.Set("admin_role", role)
		c.Set("admin_session_id", sessionID)
		c.Next()
	}
}

func GetAdminSessionID(c *gin.Context) (uuid.UUID, bool) {
	sessionID, exists := c.Get("admin_session_id")
	if !exists {
		return uuid.Nil, false
	}
	id, ok := sessionID.(uuid.UUID)
	return id, ok
}

func GetAdminID(c *gin.Context) (uuid.UUID, bool) {
	adminID, exists := c.Get("admin_id")
	if !exists {
		return uuid.Nil, false
	}
	id, ok := adminID.(uuid.UUID)
	return id, ok
}
