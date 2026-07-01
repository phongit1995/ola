package adminkenchest

import (
	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/modules/kenchest"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *kenchest.Service
	logger  *zap.SugaredLogger
}

func NewController(service *kenchest.Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[admin_ken_chest_controller]")}
}

// Create godoc
// @Summary      Tạo & phát rương ken cho toàn bộ user online (admin)
// @Tags         admin-ken-chest
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body kenchest.CreateChestRequest true "Chest"
// @Success      201  {object}  kenchest.ChestView
// @Router       /admin/ken/chests [post]
func (ctrl *Controller) Create(c *gin.Context) (interface{}, error) {
	adminID, _ := middleware.GetAdminID(c)
	req, err := utils.BindJSON[kenchest.CreateChestRequest](c)
	if err != nil {
		return nil, err
	}
	chest, err := ctrl.service.CreateAndBroadcast(c.Request.Context(), adminID, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return chest, nil
}

// List godoc
// @Summary      Lịch sử rương ken (admin)
// @Tags         admin-ken-chest
// @Produce      json
// @Security     BearerAuth
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  kenchest.ChestListResponse
// @Router       /admin/ken/chests [get]
func (ctrl *Controller) List(c *gin.Context) (interface{}, error) {
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListChests(limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Detail godoc
// @Summary      Chi tiết rương ken (admin)
// @Tags         admin-ken-chest
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Chest ID"
// @Success      200  {object}  kenchest.ChestView
// @Failure      404  {object}  utils.APIError
// @Router       /admin/ken/chests/{id} [get]
func (ctrl *Controller) Detail(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid chest id")
	if err != nil {
		return nil, err
	}
	chest, err := ctrl.service.GetChest(id)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return chest, nil
}

// ListClaims godoc
// @Summary      Danh sách người đã mở 1 rương ken (admin)
// @Tags         admin-ken-chest
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Chest ID"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  kenchest.ClaimListResponse
// @Router       /admin/ken/chests/{id}/claims [get]
func (ctrl *Controller) ListClaims(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid chest id")
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListClaims(id, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Delete godoc
// @Summary      Huỷ rương ken (admin)
// @Tags         admin-ken-chest
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Chest ID"
// @Success      200  {object}  map[string]string
// @Failure      404  {object}  utils.APIError
// @Router       /admin/ken/chests/{id} [delete]
func (ctrl *Controller) Delete(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid chest id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.DeleteChest(c.Request.Context(), id); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "ken chest deleted"}, nil
}
