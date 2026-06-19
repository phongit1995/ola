package adminvip

import (
	"strconv"

	"ola-chat-server/internal/modules/vip"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Controller struct {
	service *vip.Service
	logger  *zap.SugaredLogger
}

func NewController(service *vip.Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[admin_vip_controller]")}
}

// CreatePackage godoc
// @Summary      Tạo gói VIP (admin)
// @Tags         admin-vip
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body vip.CreatePackageRequest true "Package"
// @Success      201  {object}  vip.PackageItemSuccessResponse
// @Router       /admin/vip/packages [post]
func (ctrl *Controller) CreatePackage(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[vip.CreatePackageRequest](c)
	if err != nil {
		return nil, err
	}
	item, err := ctrl.service.CreatePackage(*req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return item, nil
}

// ListPackages godoc
// @Summary      Danh sách gói VIP (admin, gồm cả gói tắt)
// @Tags         admin-vip
// @Produce      json
// @Security     BearerAuth
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  vip.PackageListSuccessResponse
// @Router       /admin/vip/packages [get]
func (ctrl *Controller) ListPackages(c *gin.Context) (interface{}, error) {
	limit := utils.ParseLimit(c, 50, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListAllPackages(limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// UpdatePackage godoc
// @Summary      Cập nhật gói VIP (admin)
// @Tags         admin-vip
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Package ID"
// @Param        request body vip.UpdatePackageRequest true "Package"
// @Success      200  {object}  vip.PackageItemSuccessResponse
// @Failure      404  {object}  utils.APIError
// @Router       /admin/vip/packages/{id} [patch]
func (ctrl *Controller) UpdatePackage(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid package id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[vip.UpdatePackageRequest](c)
	if err != nil {
		return nil, err
	}
	item, err := ctrl.service.UpdatePackage(id, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return item, nil
}

// DeletePackage godoc
// @Summary      Xoá gói VIP (admin)
// @Tags         admin-vip
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Package ID"
// @Success      200  {object}  map[string]string
// @Failure      404  {object}  utils.APIError
// @Router       /admin/vip/packages/{id} [delete]
func (ctrl *Controller) DeletePackage(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid package id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.DeletePackage(id); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "package deleted"}, nil
}

// ListHistory godoc
// @Summary      Lịch sử mua gói VIP toàn hệ thống (admin)
// @Tags         admin-vip
// @Produce      json
// @Security     BearerAuth
// @Param        userId query string false "Filter theo user"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  vip.HistoryListSuccessResponse
// @Router       /admin/vip/history [get]
func (ctrl *Controller) ListHistory(c *gin.Context) (interface{}, error) {
	limit := utils.ParseLimit(c, 50, 100)
	offset := utils.ParseOffset(c)

	var userIDPtr *uuid.UUID
	if q := c.Query("userId"); q != "" {
		uid, err := uuid.Parse(q)
		if err != nil {
			return nil, utils.NewHTTPError(400, "invalid user id")
		}
		userIDPtr = &uid
	}

	resp, err := ctrl.service.ListHistory(userIDPtr, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListIconTypes godoc
// @Summary      Danh sách loại VIP icon (admin, gồm cả loại tắt)
// @Tags         admin-vip
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  vip.IconTypeListSuccessResponse
// @Router       /admin/vip/icon-types [get]
func (ctrl *Controller) ListIconTypes(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.ListAllIconTypes()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// UpdateIconType godoc
// @Summary      Cập nhật giá / trạng thái bán loại VIP icon (admin)
// @Tags         admin-vip
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        typeId path int true "VIP type ID"
// @Param        request body vip.UpdateIconTypeRequest true "Icon type"
// @Success      200  {object}  vip.IconTypeItemSuccessResponse
// @Failure      404  {object}  utils.APIError
// @Router       /admin/vip/icon-types/{typeId} [patch]
func (ctrl *Controller) UpdateIconType(c *gin.Context) (interface{}, error) {
	n, err := strconv.Atoi(c.Param("typeId"))
	if err != nil || n < 1 || n > 120 {
		return nil, utils.NewHTTPError(400, "invalid vip type id")
	}
	req, err := utils.BindJSON[vip.UpdateIconTypeRequest](c)
	if err != nil {
		return nil, err
	}
	item, err := ctrl.service.UpdateIconType(int16(n), *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return item, nil
}
