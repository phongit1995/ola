package adminminigame

import (
	minigame "ola-chat-server/internal/modules/mini-game"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *minigame.Service
	logger  *zap.SugaredLogger
}

func NewController(service *minigame.Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[admin_mini_game_controller]")}
}

// List godoc
// @Summary      Danh sách mini game (admin)
// @Tags         admin-mini-game
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  minigame.MiniGameListResponse
// @Router       /admin/mini-games [get]
func (ctrl *Controller) List(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.ListAll()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Create godoc
// @Summary      Tạo mini game (admin)
// @Tags         admin-mini-game
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body minigame.CreateMiniGameRequest true "Mini game"
// @Success      200  {object}  minigame.MiniGameResponse
// @Router       /admin/mini-games [post]
func (ctrl *Controller) Create(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[minigame.CreateMiniGameRequest](c)
	if err != nil {
		return nil, err
	}
	game, err := ctrl.service.Create(*req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return game, nil
}

// Update godoc
// @Summary      Cập nhật mini game (admin)
// @Tags         admin-mini-game
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Mini game ID"
// @Param        request body minigame.UpdateMiniGameRequest true "Mini game"
// @Success      200  {object}  minigame.MiniGameResponse
// @Failure      404  {object}  utils.APIError
// @Router       /admin/mini-games/{id} [patch]
func (ctrl *Controller) Update(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid mini game id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[minigame.UpdateMiniGameRequest](c)
	if err != nil {
		return nil, err
	}
	game, err := ctrl.service.Update(id, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return game, nil
}

// Delete godoc
// @Summary      Xoá mini game (admin)
// @Tags         admin-mini-game
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Mini game ID"
// @Success      200  {object}  map[string]string
// @Failure      404  {object}  utils.APIError
// @Router       /admin/mini-games/{id} [delete]
func (ctrl *Controller) Delete(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid mini game id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Delete(id); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "mini game deleted"}, nil
}
