package push

import (
	"net/http"
	"strings"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

const maxRegisterBodyBytes = 2048

type Controller struct {
	service *Service
}

func NewController(service *Service) *Controller {
	return &Controller{service: service}
}

// RegisterToken godoc
// @Summary      Register the current device's push notification token
// @Tags         push
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body RegisterTokenRequest true "Push token"
// @Success      200  {object}  map[string]string
// @Router       /push/token [post]
func (ctrl *Controller) RegisterToken(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	v, ok := c.Get("session_id")
	if !ok {
		return nil, utils.NewHTTPError(http.StatusUnauthorized, "session required")
	}
	sessionID, ok := v.(uuid.UUID)
	if !ok {
		return nil, utils.NewHTTPError(http.StatusUnauthorized, "session required")
	}
	c.Request.Body = http.MaxBytesReader(c.Writer, c.Request.Body, maxRegisterBodyBytes)
	var req RegisterTokenRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "token is required")
	}
	token := strings.TrimSpace(req.Token)
	if len(token) < constants.PushTokenMinLength || len(token) > constants.PushTokenMaxLength {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid token length")
	}
	if err := ctrl.service.Register(userID, sessionID, token); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "push token registered"}, nil
}
