package adminvip

import (
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

// ListShopItems godoc
// @Summary      Danh sách VIP trong shop (admin, gồm cả mục tắt)
// @Tags         admin-vip
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  vip.ShopListSuccessResponse
// @Router       /admin/vip/shop [get]
func (ctrl *Controller) ListShopItems(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.ListAllShopItems()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// CreateShopItem godoc
// @Summary      Thêm VIP vào shop để bán (admin)
// @Tags         admin-vip
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body vip.CreateShopItemRequest true "Shop item"
// @Success      201  {object}  vip.ShopItemSuccessResponse
// @Failure      409  {object}  utils.APIError
// @Router       /admin/vip/shop [post]
func (ctrl *Controller) CreateShopItem(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[vip.CreateShopItemRequest](c)
	if err != nil {
		return nil, err
	}
	item, err := ctrl.service.CreateShopItem(*req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return item, nil
}

// UpdateShopItem godoc
// @Summary      Cập nhật giá / trạng thái VIP trong shop (admin)
// @Tags         admin-vip
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Shop item ID"
// @Param        request body vip.UpdateShopItemRequest true "Shop item"
// @Success      200  {object}  vip.ShopItemSuccessResponse
// @Failure      404  {object}  utils.APIError
// @Router       /admin/vip/shop/{id} [patch]
func (ctrl *Controller) UpdateShopItem(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid shop item id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[vip.UpdateShopItemRequest](c)
	if err != nil {
		return nil, err
	}
	item, err := ctrl.service.UpdateShopItem(id, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return item, nil
}

// DeleteShopItem godoc
// @Summary      Xoá VIP khỏi shop (admin)
// @Tags         admin-vip
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Shop item ID"
// @Success      200  {object}  map[string]string
// @Failure      404  {object}  utils.APIError
// @Router       /admin/vip/shop/{id} [delete]
func (ctrl *Controller) DeleteShopItem(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid shop item id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.DeleteShopItem(id); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "shop item deleted"}, nil
}
