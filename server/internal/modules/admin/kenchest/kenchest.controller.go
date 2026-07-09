package adminkenchest

import (
	"strings"

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
// @Param        q query string false "Tìm theo username/tên người mở"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  kenchest.ClaimListResponse
// @Router       /admin/ken/chests/{id}/claims [get]
func (ctrl *Controller) ListClaims(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid chest id")
	if err != nil {
		return nil, err
	}
	search := strings.TrimSpace(c.Query("q"))
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListClaims(id, search, limit, offset)
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

// ListAutoJobs godoc
// @Summary      Danh sách lịch rương ken tự động (admin)
// @Tags         admin-ken-chest
// @Produce      json
// @Security     BearerAuth
// @Success      200  {array}  kenchest.AutoJobView
// @Router       /admin/ken/auto-jobs [get]
func (ctrl *Controller) ListAutoJobs(c *gin.Context) (interface{}, error) {
	items, err := ctrl.service.ListAutoJobs()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return items, nil
}

// CreateAutoJob godoc
// @Summary      Tạo lịch rương ken tự động (admin)
// @Tags         admin-ken-chest
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body kenchest.AutoJobRequest true "Auto job"
// @Success      201  {object}  kenchest.AutoJobView
// @Router       /admin/ken/auto-jobs [post]
func (ctrl *Controller) CreateAutoJob(c *gin.Context) (interface{}, error) {
	adminID, _ := middleware.GetAdminID(c)
	req, err := utils.BindJSON[kenchest.AutoJobRequest](c)
	if err != nil {
		return nil, err
	}
	job, err := ctrl.service.CreateAutoJob(adminID, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return job, nil
}

// UpdateAutoJob godoc
// @Summary      Sửa lịch rương ken tự động (admin)
// @Tags         admin-ken-chest
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Auto job ID"
// @Param        request body kenchest.AutoJobRequest true "Auto job"
// @Success      200  {object}  kenchest.AutoJobView
// @Router       /admin/ken/auto-jobs/{id} [put]
func (ctrl *Controller) UpdateAutoJob(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid auto job id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[kenchest.AutoJobRequest](c)
	if err != nil {
		return nil, err
	}
	job, err := ctrl.service.UpdateAutoJob(id, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return job, nil
}

// DeleteAutoJob godoc
// @Summary      Xoá lịch rương ken tự động (admin)
// @Tags         admin-ken-chest
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Auto job ID"
// @Success      200  {object}  map[string]string
// @Router       /admin/ken/auto-jobs/{id} [delete]
func (ctrl *Controller) DeleteAutoJob(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid auto job id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.DeleteAutoJob(id); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "ken chest auto job deleted"}, nil
}

// GetAutoSettings godoc
// @Summary      Trạng thái công tắc tổng rương ken tự động (admin)
// @Tags         admin-ken-chest
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  kenchest.AutoSettingsView
// @Router       /admin/ken/auto-settings [get]
func (ctrl *Controller) GetAutoSettings(c *gin.Context) (interface{}, error) {
	settings, err := ctrl.service.GetAutoSettings()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return settings, nil
}

// UpdateAutoSettings godoc
// @Summary      Bật/tắt tất cả rương ken tự động (admin)
// @Tags         admin-ken-chest
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body kenchest.UpdateAutoSettingsRequest true "Settings"
// @Success      200  {object}  kenchest.AutoSettingsView
// @Router       /admin/ken/auto-settings [put]
func (ctrl *Controller) UpdateAutoSettings(c *gin.Context) (interface{}, error) {
	adminID, _ := middleware.GetAdminID(c)
	req, err := utils.BindJSON[kenchest.UpdateAutoSettingsRequest](c)
	if err != nil {
		return nil, err
	}
	settings, err := ctrl.service.UpdateAutoSettings(adminID, req.Enabled)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return settings, nil
}
