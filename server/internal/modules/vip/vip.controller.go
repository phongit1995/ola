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

// Transfer godoc
// @Summary      Tặng/chuyển một VIP cho người khác (chặn nếu đang khoá)
// @Tags         vip
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "VIP instance ID"
// @Param        request body TransferRequest true "Receiver"
// @Success      200  {object}  MessageSuccessResponse
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
	if err := ctrl.service.Transfer(userID, instanceID, toUserID); err != nil {
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
// @Success      201  {object}  VipItemSuccessResponse
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
	item, err := ctrl.service.Buy(userID, req.TypeID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return item, nil
}

// Extend godoc
// @Summary      Gia hạn VIP (cộng số ngày vào thời hạn tài khoản)
// @Tags         vip
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body ExtendRequest true "Days"
// @Success      200  {object}  MessageSuccessResponse
// @Router       /vip/extend [post]
func (ctrl *Controller) Extend(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[ExtendRequest](c)
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Extend(userID, req.Days); err != nil {
		return nil, utils.ServiceError(err)
	}
	return MessageResponse{Message: "vip extended"}, nil
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
