package minigame

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
	return &Controller{service: service, logger: logger.Named("[mini_game_controller]")}
}

// List godoc
// @Summary      Danh sách mini game đang bật
// @Tags         mini-game
// @Produce      json
// @Security     BearerAuth
// @Success      200  {array}  models.MiniGame
// @Router       /mini-games [get]
func (ctrl *Controller) List(c *gin.Context) (interface{}, error) {
	games, err := ctrl.service.ListEnabled()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return games, nil
}
