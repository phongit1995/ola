package adminegg

import (
	"ola-chat-server/internal/modules/egg"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *egg.Service
	logger  *zap.SugaredLogger
}

func NewController(service *egg.Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[admin_egg_controller]")}
}

// ListPacks godoc
// @Summary      Danh sách gói đập trứng + cấu hình (admin)
// @Tags         admin-egg
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  egg.PackListResponse
// @Router       /admin/egg/packs [get]
func (ctrl *Controller) ListPacks(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.ListAllPacks()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// CreatePack godoc
// @Summary      Tạo gói đập trứng (admin)
// @Tags         admin-egg
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body egg.CreatePackRequest true "Pack"
// @Success      201  {object}  egg.PackView
// @Router       /admin/egg/packs [post]
func (ctrl *Controller) CreatePack(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[egg.CreatePackRequest](c)
	if err != nil {
		return nil, err
	}
	pack, err := ctrl.service.CreatePack(*req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return pack, nil
}

// UpdatePack godoc
// @Summary      Cập nhật gói đập trứng (admin)
// @Tags         admin-egg
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Pack ID"
// @Param        request body egg.UpdatePackRequest true "Pack"
// @Success      200  {object}  egg.PackView
// @Failure      404  {object}  utils.APIError
// @Router       /admin/egg/packs/{id} [patch]
func (ctrl *Controller) UpdatePack(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid pack id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[egg.UpdatePackRequest](c)
	if err != nil {
		return nil, err
	}
	pack, err := ctrl.service.UpdatePack(id, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return pack, nil
}

// DeletePack godoc
// @Summary      Xoá gói đập trứng (admin)
// @Tags         admin-egg
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Pack ID"
// @Success      200  {object}  map[string]string
// @Failure      404  {object}  utils.APIError
// @Router       /admin/egg/packs/{id} [delete]
func (ctrl *Controller) DeletePack(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid pack id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.DeletePack(id); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "egg pack deleted"}, nil
}

// SaveConfig godoc
// @Summary      Lưu cả cây nhóm + phần thưởng của gói (admin)
// @Tags         admin-egg
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Pack ID"
// @Param        request body egg.SaveConfigRequest true "Config"
// @Success      200  {object}  egg.PackView
// @Failure      404  {object}  utils.APIError
// @Router       /admin/egg/packs/{id}/config [put]
func (ctrl *Controller) SaveConfig(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid pack id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[egg.SaveConfigRequest](c)
	if err != nil {
		return nil, err
	}
	pack, err := ctrl.service.SaveConfig(id, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return pack, nil
}

// UserHistory godoc
// @Summary      Lịch sử đập trứng của một user (admin)
// @Tags         admin-egg
// @Produce      json
// @Security     BearerAuth
// @Param        userId path string true "User ID"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  egg.DrawListResponse
// @Router       /admin/egg/users/{userId}/history [get]
func (ctrl *Controller) UserHistory(c *gin.Context) (interface{}, error) {
	userID, err := utils.ParseUUIDParam(c, "userId", "invalid user id")
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 50, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListHistory(userID, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
