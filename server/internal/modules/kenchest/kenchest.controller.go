package kenchest

import (
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[ken_chest_controller]")}
}

// Open godoc
// @Summary      Mở rương ken
// @Tags         ken-chest
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Chest ID"
// @Success      200  {object}  OpenChestResult
// @Failure      400  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /ken/chests/{id}/open [post]
func (ctrl *Controller) Open(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	chestID, err := utils.ParseUUIDParam(c, "id", "invalid chest id")
	if err != nil {
		return nil, err
	}
	result, err := ctrl.service.Open(userID, chestID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return result, nil
}
