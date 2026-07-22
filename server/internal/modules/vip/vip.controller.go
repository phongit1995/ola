package vip

import (
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[vip_controller]")}
}

func parseStoreQuery(c *gin.Context) (int, int, error) {
	var q StoreQuery
	if err := c.ShouldBindQuery(&q); err != nil {
		return 0, 0, utils.NewHTTPError(400, err.Error())
	}
	if q.Limit == 0 {
		q.Limit = 50
	}
	return q.Limit, q.Offset, nil
}

// GetMyStore godoc
// @Summary      Kho VIP của tôi
// @Tags         vip
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  StoreSuccessResponse
// @Router       /vip/store [get]
func (ctrl *Controller) GetMyStore(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	limit, offset, err := parseStoreQuery(c)
	if err != nil {
		return nil, err
	}
	store, err := ctrl.service.GetStore(userID, userID, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return store, nil
}

// GetUserStore godoc
// @Summary      Kho VIP của người khác (theo quyền xem)
// @Tags         vip
// @Produce      json
// @Security     BearerAuth
// @Param        userId path string true "User ID"
// @Success      200  {object}  StoreSuccessResponse
// @Failure      403  {object}  utils.APIError
// @Router       /vip/users/{userId}/store [get]
func (ctrl *Controller) GetUserStore(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	targetID, err := utils.ParseUUIDParam(c, "userId", "invalid user id")
	if err != nil {
		return nil, err
	}
	limit, offset, err := parseStoreQuery(c)
	if err != nil {
		return nil, err
	}
	store, err := ctrl.service.GetStore(userID, targetID, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return store, nil
}

func (ctrl *Controller) instanceParam(c *gin.Context) (uuid.UUID, uuid.UUID, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return uuid.Nil, uuid.Nil, err
	}
	instanceID, err := utils.ParseUUIDParam(c, "id", "invalid vip id")
	if err != nil {
		return uuid.Nil, uuid.Nil, err
	}
	return userID, instanceID, nil
}

// Use godoc
// @Summary      Dùng (đeo) một VIP, tốn 1 ngày VIP
// @Tags         vip
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "VIP instance ID"
// @Success      200  {object}  MessageSuccessResponse
// @Router       /vip/icons/{id}/use [post]
func (ctrl *Controller) Use(c *gin.Context) (interface{}, error) {
	userID, instanceID, err := ctrl.instanceParam(c)
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Use(userID, instanceID); err != nil {
		return nil, utils.ServiceError(err)
	}
	return MessageResponse{Message: "vip activated"}, nil
}

// Lock godoc
// @Summary      Khoá một VIP
// @Tags         vip
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "VIP instance ID"
// @Success      200  {object}  MessageSuccessResponse
// @Router       /vip/icons/{id}/lock [post]
func (ctrl *Controller) Lock(c *gin.Context) (interface{}, error) {
	userID, instanceID, err := ctrl.instanceParam(c)
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.SetLock(userID, instanceID, true); err != nil {
		return nil, utils.ServiceError(err)
	}
	return MessageResponse{Message: "vip locked"}, nil
}

// Unlock godoc
// @Summary      Mở khoá một VIP
// @Tags         vip
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "VIP instance ID"
// @Success      200  {object}  MessageSuccessResponse
// @Router       /vip/icons/{id}/unlock [post]
func (ctrl *Controller) Unlock(c *gin.Context) (interface{}, error) {
	userID, instanceID, err := ctrl.instanceParam(c)
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.SetLock(userID, instanceID, false); err != nil {
		return nil, utils.ServiceError(err)
	}
	return MessageResponse{Message: "vip unlocked"}, nil
}

// Delete godoc
// @Summary      Xoá một VIP (chặn nếu đang khoá)
// @Tags         vip
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "VIP instance ID"
// @Success      200  {object}  MessageSuccessResponse
// @Failure      403  {object}  utils.APIError
// @Router       /vip/icons/{id} [delete]
func (ctrl *Controller) Delete(c *gin.Context) (interface{}, error) {
	userID, instanceID, err := ctrl.instanceParam(c)
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Delete(userID, instanceID); err != nil {
		return nil, utils.ServiceError(err)
	}
	return MessageResponse{Message: "vip deleted"}, nil
}

// BatchDelete godoc
// @Summary      Xoá nhiều VIP cùng lúc (nguyên tử; chặn nếu có cái đang khoá hoặc đang dùng)
// @Tags         vip
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body BatchDeleteRequest true "Danh sách instance ID"
// @Success      200  {object}  BatchDeleteSuccessResponse
// @Failure      403  {object}  utils.APIError
// @Router       /vip/icons/batch-delete [post]
func (ctrl *Controller) BatchDelete(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[BatchDeleteRequest](c)
	if err != nil {
		return nil, err
	}
	seen := make(map[uuid.UUID]struct{}, len(req.IDs))
	ids := make([]uuid.UUID, 0, len(req.IDs))
	for _, raw := range req.IDs {
		id, err := uuid.Parse(raw)
		if err != nil {
			return nil, utils.NewHTTPError(400, "invalid vip id")
		}
		if _, ok := seen[id]; ok {
			continue
		}
		seen[id] = struct{}{}
		ids = append(ids, id)
	}
	deleted, err := ctrl.service.BatchDelete(userID, ids)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return BatchDeleteResponse{Deleted: deleted}, nil
}

// Transfer godoc
// @Summary      Tặng/chuyển một VIP cho người khác (cần mật khẩu; chặn nếu đang dùng hoặc đã khoá)
// @Tags         vip
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "VIP instance ID"
// @Param        request body TransferRequest true "Receiver + password"
// @Success      200  {object}  MessageSuccessResponse
// @Failure      401  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Router       /vip/icons/{id}/transfer [post]
func (ctrl *Controller) Transfer(c *gin.Context) (interface{}, error) {
	userID, instanceID, err := ctrl.instanceParam(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[TransferRequest](c)
	if err != nil {
		return nil, err
	}
	toUserID, err := uuid.Parse(req.ToUserID)
	if err != nil {
		return nil, utils.NewHTTPError(400, "invalid receiver id")
	}
	if err := ctrl.service.Transfer(userID, instanceID, toUserID, req.Password); err != nil {
		return nil, utils.ServiceError(err)
	}
	return MessageResponse{Message: "vip transferred"}, nil
}

// Buy godoc
// @Summary      Thêm một VIP vào kho
// @Tags         vip
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body BuyRequest true "VIP type"
// @Success      201  {object}  BuyIconSuccessResponse
// @Router       /vip/buy [post]
func (ctrl *Controller) Buy(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[BuyRequest](c)
	if err != nil {
		return nil, err
	}
	shopItemID, err := uuid.Parse(req.ShopItemID)
	if err != nil {
		return nil, utils.NewHTTPError(400, "invalid shop item id")
	}
	resp, err := ctrl.service.Buy(userID, shopItemID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// IconCatalog godoc
// @Summary      Danh sách VIP đang bán trong shop
// @Tags         vip
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  ShopCatalogSuccessResponse
// @Router       /vip/icons/catalog [get]
func (ctrl *Controller) IconCatalog(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.ListShopCatalog()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListPackages godoc
// @Summary      Danh sách gói ngày VIP đang bán
// @Tags         vip
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  PackageListSuccessResponse
// @Router       /vip/packages [get]
func (ctrl *Controller) ListPackages(c *gin.Context) (interface{}, error) {
	if _, err := utils.RequireUserID(c); err != nil {
		return nil, err
	}
	items, err := ctrl.service.ListActivePackages()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return PackageListResponse{
		Total:  len(items),
		Limit:  len(items),
		Offset: 0,
		Items:  items,
	}, nil
}

// BuyPackage godoc
// @Summary      Mua gói ngày VIP (trừ KEN, cộng ngày vào thời hạn)
// @Tags         vip
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Package ID"
// @Success      201  {object}  BuyPackageSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /vip/packages/{id}/buy [post]
func (ctrl *Controller) BuyPackage(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	packageID, err := utils.ParseUUIDParam(c, "id", "invalid package id")
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.BuyPackage(userID, packageID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

func (ctrl *Controller) GiftPackage(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	packageID, err := utils.ParseUUIDParam(c, "id", "invalid package id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[GiftPackageRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.GiftPackage(userID, packageID, req.ToUsername, req.Password)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

func (ctrl *Controller) GiftIcon(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[GiftIconRequest](c)
	if err != nil {
		return nil, err
	}
	shopItemID, err := uuid.Parse(req.ShopItemID)
	if err != nil {
		return nil, utils.NewHTTPError(400, "invalid shop item id")
	}
	resp, err := ctrl.service.GiftIcon(userID, shopItemID, req.ToUsername, req.Password)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// GetHistory godoc
// @Summary      Lịch sử mua gói VIP của tôi
// @Tags         vip
// @Produce      json
// @Security     BearerAuth
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  HistoryListSuccessResponse
// @Router       /vip/history [get]
func (ctrl *Controller) GetHistory(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 50, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListHistory(&userID, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// GetTransfers godoc
// @Summary      Lịch sử chuyển/nhận icon VIP của tôi
// @Tags         vip
// @Produce      json
// @Security     BearerAuth
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  TransferHistoryListSuccessResponse
// @Router       /vip/transfers [get]
func (ctrl *Controller) GetTransfers(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 50, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListTransfers(&userID, "", limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// SetPrivacy godoc
// @Summary      Đổi quyền xem kho VIP (0 public, 1 friends, 2 private)
// @Tags         vip
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body PrivacyRequest true "Privacy"
// @Success      200  {object}  MessageSuccessResponse
// @Router       /vip/store/privacy [put]
func (ctrl *Controller) SetPrivacy(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[PrivacyRequest](c)
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.SetPrivacy(userID, req.Privacy); err != nil {
		return nil, utils.ServiceError(err)
	}
	return MessageResponse{Message: "privacy updated"}, nil
}
