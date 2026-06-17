package session

import (
	"net/http"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[session_controller]")}
}

func currentSessionID(c *gin.Context) uuid.UUID {
	if v, ok := c.Get("session_id"); ok {
		if id, ok := v.(uuid.UUID); ok {
			return id
		}
	}
	return uuid.Nil
}

func toSessionResponse(s models.UserSession, current uuid.UUID) SessionResponse {
	return SessionResponse{
		ID:           s.ID.String(),
		DeviceName:   s.DeviceName,
		Platform:     s.Platform,
		DeviceID:     s.DeviceID,
		AppVersion:   s.AppVersion,
		IPAddress:    s.IPAddress,
		IsCurrent:    s.ID == current,
		CreatedAt:    s.CreatedAt.Format(time.RFC3339),
		LastActiveAt: s.LastActiveAt.Format(time.RFC3339),
	}
}

// List godoc
// @Summary      List active login sessions
// @Description  Trả về các phiên đăng nhập đang hoạt động của người dùng hiện tại (đánh dấu phiên hiện tại)
// @Tags         sessions
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  ListSessionsSuccessResponse
// @Router       /sessions [get]
func (ctrl *Controller) List(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	sessions, err := ctrl.service.List(userID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	current := currentSessionID(c)
	items := make([]SessionResponse, 0, len(sessions))
	for _, s := range sessions {
		items = append(items, toSessionResponse(s, current))
	}
	return ListSessionsResponse{Sessions: items, Total: len(items)}, nil
}

// Revoke godoc
// @Summary      Revoke a specific session
// @Description  Đăng xuất một thiết bị/phiên cụ thể của chính mình
// @Tags         sessions
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Session ID"
// @Success      200  {object}  RevokeSuccessResponse
// @Failure      404  {object}  utils.APIError
// @Router       /sessions/{id} [delete]
func (ctrl *Controller) Revoke(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	sessionID, err := utils.ParseUUIDParam(c, "id", "invalid session id")
	if err != nil {
		return nil, err
	}
	found, err := ctrl.service.RevokeForUser(userID, sessionID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	if !found {
		return nil, utils.NewHTTPError(http.StatusNotFound, "session not found")
	}
	return RevokeResponse{Message: "session revoked"}, nil
}

// RevokeOthers godoc
// @Summary      Revoke all other sessions
// @Description  Đăng xuất tất cả thiết bị khác, giữ lại phiên hiện tại
// @Tags         sessions
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  RevokeOthersSuccessResponse
// @Router       /sessions/others [delete]
func (ctrl *Controller) RevokeOthers(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	revoked, err := ctrl.service.RevokeOthers(userID, currentSessionID(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return RevokeOthersResponse{Message: "other sessions revoked", Revoked: revoked}, nil
}
