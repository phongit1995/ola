package avatarframe

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
	return &Controller{service: service, logger: logger.Named("[avatar_frame_controller]")}
}

// @Summary      Khung avatar đang bán, kèm cờ đã sở hữu
// @Tags         avatar-frame
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  ShopResponse
// @Router       /avatar-frames/shop [get]
func (ctrl *Controller) ListShop(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.ListShop(userID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Mua khung avatar bằng KEN
// @Tags         avatar-frame
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        body body BuyRequest true "Mặt hàng"
// @Success      200  {object}  BuyResponse
// @Router       /avatar-frames/buy [post]
func (ctrl *Controller) Buy(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[BuyRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Buy(userID, uuid.MustParse(req.ShopItemID), *req.ExpectedKenPrice)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Mua khung avatar tặng người khác
// @Tags         avatar-frame
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        body body GiftRequest true "Mặt hàng, người nhận, mật khẩu"
// @Success      200  {object}  GiftResponse
// @Router       /avatar-frames/gift [post]
func (ctrl *Controller) Gift(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[GiftRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Gift(userID, uuid.MustParse(req.ShopItemID), *req.ExpectedKenPrice, req.ToUsername, req.Password)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Kho khung avatar của tôi
// @Tags         avatar-frame
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  StoreResponse
// @Router       /avatar-frames/mine [get]
func (ctrl *Controller) GetMyStore(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.GetStore(userID, userID, utils.ParseLimit(c, DefaultStoreLimit, MaxStoreLimit), utils.ParseOffset(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Kho khung avatar của người khác (theo quyền xem)
// @Tags         avatar-frame
// @Produce      json
// @Security     BearerAuth
// @Param        userId path string true "User ID"
// @Success      200  {object}  StoreResponse
// @Router       /avatar-frames/users/{userId}/store [get]
func (ctrl *Controller) GetUserStore(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	targetID, err := utils.ParseUUIDParam(c, "userId", "invalid user id")
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.GetStore(userID, targetID, utils.ParseLimit(c, DefaultStoreLimit, MaxStoreLimit), utils.ParseOffset(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Đeo khung avatar (cần còn VIP), frameId rỗng để tháo
// @Tags         avatar-frame
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        body body EquipRequest true "Khung"
// @Success      200  {object}  EquipResponse
// @Router       /avatar-frames/equip [put]
func (ctrl *Controller) Equip(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[EquipRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Equip(userID, req.FrameID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Chuyển khung avatar đã sở hữu cho người khác
// @Tags         avatar-frame
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        frameId path string true "Frame ID"
// @Param        body body TransferRequest true "Người nhận, mật khẩu"
// @Success      200  {object}  MessageResponse
// @Router       /avatar-frames/mine/{frameId}/transfer [post]
func (ctrl *Controller) Transfer(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[TransferRequest](c)
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Transfer(userID, c.Param("frameId"), uuid.MustParse(req.ToUserID), req.Password); err != nil {
		return nil, utils.ServiceError(err)
	}
	return MessageResponse{Message: "avatar frame transferred"}, nil
}

// @Summary      Đổi quyền xem Kho khung avatar (0 mọi người, 1 bạn bè, 2 chỉ mình tôi)
// @Tags         avatar-frame
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        body body PrivacyRequest true "Quyền xem"
// @Success      200  {object}  MessageResponse
// @Router       /avatar-frames/store/privacy [put]
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

// @Summary      Lịch sử mua và được tặng khung avatar của tôi
// @Tags         avatar-frame
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  PurchaseHistoryResponse
// @Router       /avatar-frames/history [get]
func (ctrl *Controller) GetHistory(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.ListPurchases(PurchaseFilter{UserID: &userID}, utils.ParseLimit(c, DefaultHistoryLimit, MaxHistoryLimit), utils.ParseOffset(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Lịch sử chuyển khung avatar của tôi
// @Tags         avatar-frame
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  TransferHistoryResponse
// @Router       /avatar-frames/transfers [get]
func (ctrl *Controller) GetTransfers(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.ListTransfers(&userID, "", utils.ParseLimit(c, DefaultHistoryLimit, MaxHistoryLimit), utils.ParseOffset(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
