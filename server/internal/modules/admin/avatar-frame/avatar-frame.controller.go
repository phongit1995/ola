package adminavatarframe

import (
	"net/http"
	"strings"
	"time"

	avatarframe "ola-chat-server/internal/modules/avatar-frame"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

const (
	defaultStatsDays = 30
	topFramesLimit   = 20
)

type StatsResponse struct {
	Today     avatarframe.PurchaseTotals  `json:"today"`
	ThisMonth avatarframe.PurchaseTotals  `json:"thisMonth"`
	Range     avatarframe.PurchaseTotals  `json:"range"`
	TopFrames []avatarframe.FrameSalesRow `json:"topFrames"`
}

type Controller struct {
	service *avatarframe.Service
	logger  *zap.SugaredLogger
}

func NewController(service *avatarframe.Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[admin_avatar_frame_controller]")}
}

// @Summary      Khung avatar trong cửa hàng, gồm cả khung đang tắt (admin)
// @Tags         admin-avatar-frame
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  avatarframe.ShopResponse
// @Router       /admin/avatar-frames/shop [get]
func (ctrl *Controller) ListShopItems(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.ListAllShopItems()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Thêm một hoặc nhiều khung vào cửa hàng cùng một giá (admin)
// @Tags         admin-avatar-frame
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        body body avatarframe.CreateShopItemsRequest true "Danh sách khung và giá"
// @Success      200  {object}  avatarframe.CreateShopItemsResponse
// @Router       /admin/avatar-frames/shop [post]
func (ctrl *Controller) CreateShopItems(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[avatarframe.CreateShopItemsRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.CreateShopItems(req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Sửa giá, bật tắt, thứ tự một khung trong cửa hàng (admin)
// @Tags         admin-avatar-frame
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Shop item ID"
// @Param        body body avatarframe.UpdateShopItemRequest true "Trường cần sửa"
// @Success      200  {object}  avatarframe.ShopItem
// @Router       /admin/avatar-frames/shop/{id} [patch]
func (ctrl *Controller) UpdateShopItem(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid shop item id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[avatarframe.UpdateShopItemRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.UpdateShopItem(id, req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Gỡ một khung khỏi cửa hàng, khung user đã có vẫn giữ (admin)
// @Tags         admin-avatar-frame
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Shop item ID"
// @Success      200  {object}  avatarframe.MessageResponse
// @Router       /admin/avatar-frames/shop/{id} [delete]
func (ctrl *Controller) DeleteShopItem(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid shop item id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.DeleteShopItem(id); err != nil {
		return nil, utils.ServiceError(err)
	}
	return avatarframe.MessageResponse{Message: "shop item deleted"}, nil
}

// @Summary      Lịch sử mua và tặng khung avatar toàn hệ thống (admin)
// @Tags         admin-avatar-frame
// @Produce      json
// @Security     BearerAuth
// @Param        mode query string false "purchase|gift"
// @Param        search query string false "Username, tên hoặc mã khung"
// @Param        userId query string false "Lọc theo user"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  avatarframe.PurchaseHistoryResponse
// @Router       /admin/avatar-frames/purchases [get]
func (ctrl *Controller) ListPurchases(c *gin.Context) (interface{}, error) {
	from, err := utils.ParseTimeQuery(c, "from")
	if err != nil {
		return nil, err
	}
	to, err := utils.ParseTimeQuery(c, "to")
	if err != nil {
		return nil, err
	}
	userID, err := utils.ParseUUIDQuery(c, "userId")
	if err != nil {
		return nil, err
	}
	f := avatarframe.PurchaseFilter{
		UserID: userID,
		Mode:   c.Query("mode"),
		Search: strings.TrimSpace(c.Query("search")),
		From:   from,
		To:     to,
	}
	resp, err := ctrl.service.ListPurchases(f, utils.ParseLimit(c, avatarframe.DefaultHistoryLimit, avatarframe.MaxHistoryLimit), utils.ParseOffset(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Thống kê bán khung avatar: hôm nay, tháng này, khoảng chọn, khung bán chạy (admin)
// @Tags         admin-avatar-frame
// @Produce      json
// @Security     BearerAuth
// @Param        from query string false "Từ thời gian (RFC3339), mặc định 30 ngày trước"
// @Param        to query string false "Đến thời gian (RFC3339), mặc định bây giờ"
// @Success      200  {object}  StatsResponse
// @Router       /admin/avatar-frames/purchases/stats [get]
func (ctrl *Controller) PurchaseStats(c *gin.Context) (interface{}, error) {
	now := time.Now().In(utils.VietnamTime)
	startOfDay := time.Date(now.Year(), now.Month(), now.Day(), 0, 0, 0, 0, utils.VietnamTime)
	from := startOfDay.AddDate(0, 0, -(defaultStatsDays - 1))
	to := now
	if t, err := utils.ParseTimeQuery(c, "from"); err != nil {
		return nil, err
	} else if t != nil {
		from = *t
	}
	if t, err := utils.ParseTimeQuery(c, "to"); err != nil {
		return nil, err
	} else if t != nil {
		to = *t
	}
	if to.Before(from) {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "to must be after from")
	}

	startOfMonth := time.Date(now.Year(), now.Month(), 1, 0, 0, 0, 0, utils.VietnamTime)
	today, err := ctrl.service.PurchaseTotals(&startOfDay, nil)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	month, err := ctrl.service.PurchaseTotals(&startOfMonth, nil)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	inRange, err := ctrl.service.PurchaseTotals(&from, &to)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	top, err := ctrl.service.TopFrames(from, to, topFramesLimit)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	if top == nil {
		top = []avatarframe.FrameSalesRow{}
	}
	return StatsResponse{Today: today, ThisMonth: month, Range: inRange, TopFrames: top}, nil
}

// @Summary      Lịch sử chuyển khung avatar toàn hệ thống (admin)
// @Tags         admin-avatar-frame
// @Produce      json
// @Security     BearerAuth
// @Param        search query string false "Username, tên hoặc mã khung"
// @Param        userId query string false "Lọc theo user"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  avatarframe.TransferHistoryResponse
// @Router       /admin/avatar-frames/transfers [get]
func (ctrl *Controller) ListTransfers(c *gin.Context) (interface{}, error) {
	userID, err := utils.ParseUUIDQuery(c, "userId")
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.ListTransfers(userID, strings.TrimSpace(c.Query("search")), utils.ParseLimit(c, avatarframe.DefaultHistoryLimit, avatarframe.MaxHistoryLimit), utils.ParseOffset(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Lưu thứ tự toàn bộ khung trong cửa hàng (admin), gán lại thành 1..N
// @Tags         admin-avatar-frame
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body utils.ReorderRequest true "Toàn bộ id theo thứ tự mới"
// @Success      200  {object}  map[string]string
// @Failure      409  {object}  utils.APIError
// @Router       /admin/avatar-frames/shop/order [put]
func (ctrl *Controller) ReorderShopItems(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[utils.ReorderRequest](c)
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.ReorderShopItems(req.IDs); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "order updated"}, nil
}

// @Summary      Kho khung avatar của một user, kể cả khi user để riêng tư (admin)
// @Tags         admin-avatar-frame
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "User ID"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  avatarframe.StoreResponse
// @Failure      404  {object}  utils.APIError
// @Router       /admin/users/{id}/avatar-frames [get]
func (ctrl *Controller) ListUserFrames(c *gin.Context) (interface{}, error) {
	userID, err := utils.ParseUUIDParam(c, "id", "user id")
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.AdminStore(userID, utils.ParseLimit(c, avatarframe.DefaultStoreLimit, avatarframe.MaxStoreLimit), utils.ParseOffset(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Tặng một khung avatar vào kho của user (admin)
// @Tags         admin-avatar-frame
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id   path string                true "User ID"
// @Param        body body GrantUserFrameRequest true "Mã khung"
// @Success      200  {object}  map[string]string
// @Failure      400  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Failure      409  {object}  utils.APIError
// @Router       /admin/users/{id}/avatar-frames [post]
func (ctrl *Controller) GrantUserFrame(c *gin.Context) (interface{}, error) {
	userID, err := utils.ParseUUIDParam(c, "id", "user id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[GrantUserFrameRequest](c)
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.AdminGrant(userID, strings.TrimSpace(req.FrameID)); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"frameId": strings.TrimSpace(req.FrameID)}, nil
}

// @Summary      Thu hồi một khung avatar khỏi kho của user, tự gỡ nếu đang đeo (admin)
// @Tags         admin-avatar-frame
// @Produce      json
// @Security     BearerAuth
// @Param        id      path string true "User ID"
// @Param        frameId path string true "Mã khung"
// @Success      200  {object}  map[string]string
// @Failure      400  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /admin/users/{id}/avatar-frames/{frameId} [delete]
func (ctrl *Controller) RevokeUserFrame(c *gin.Context) (interface{}, error) {
	userID, err := utils.ParseUUIDParam(c, "id", "user id")
	if err != nil {
		return nil, err
	}
	frameID := strings.TrimSpace(c.Param("frameId"))
	if err := ctrl.service.AdminRevoke(userID, frameID); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"frameId": frameID}, nil
}
