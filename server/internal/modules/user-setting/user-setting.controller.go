package usersetting

import (
	"net/http"

	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{
		service: service,
		logger:  logger.Named("[usersetting_controller]"),
	}
}

// GetSettings godoc
// @Summary      Get user settings
// @Description  Get the authenticated user's settings (returns defaults if not set yet)
// @Tags         user-settings
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  UserSettingsResponse
// @Failure      401  {object}  utils.APIError
// @Router       /user-settings [get]
func (ctrl *Controller) GetSettings(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	settings, err := ctrl.service.GetSettings(userID)
	if err != nil {
		ctrl.logger.Errorw("Failed to get user settings",
			"user_id", userID,
			"error", err.Error(),
		)
		return nil, utils.ServiceError(err)
	}

	return settings, nil
}

// UpdateSettings godoc
// @Summary      Update user settings
// @Description  Partially update the authenticated user's settings (upsert)
// @Tags         user-settings
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body UpdateSettingsRequest true "Update Settings Request"
// @Success      200  {object}  UserSettingsResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Router       /user-settings [put]
func (ctrl *Controller) UpdateSettings(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	var req UpdateSettingsRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		ctrl.logger.Warnw("Invalid update settings request",
			"user_id", userID,
			"error", err.Error(),
		)
		return nil, utils.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	settings, err := ctrl.service.UpdateSettings(userID, &req)
	if err != nil {
		ctrl.logger.Errorw("Failed to update user settings",
			"user_id", userID,
			"error", err.Error(),
		)
		return nil, utils.ServiceError(err)
	}

	return settings, nil
}
