package admingift

import (
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
)

type Controller struct {
	service *Service
}

func NewController(service *Service) *Controller {
	return &Controller{service: service}
}

// @Summary      Danh sách quà (admin, gồm cả quà tắt)
// @Tags         admin-gifts
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  GiftListSuccessResponse
// @Router       /admin/gifts [get]
func (ctrl *Controller) List(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.List()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Thêm quà (admin)
// @Tags         admin-gifts
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body CreateGiftRequest true "Gift"
// @Success      200  {object}  GiftItemSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /admin/gifts [post]
func (ctrl *Controller) Create(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[CreateGiftRequest](c)
	if err != nil {
		return nil, err
	}
	item, err := ctrl.service.Create(*req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return item, nil
}

// @Summary      Sửa quà (admin)
// @Tags         admin-gifts
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Gift ID"
// @Param        request body UpdateGiftRequest true "Gift"
// @Success      200  {object}  GiftItemSuccessResponse
// @Failure      404  {object}  utils.APIError
// @Router       /admin/gifts/{id} [patch]
func (ctrl *Controller) Update(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid gift id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[UpdateGiftRequest](c)
	if err != nil {
		return nil, err
	}
	item, err := ctrl.service.Update(id, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return item, nil
}

// @Summary      Lưu thứ tự toàn bộ quà (admin), gán lại thành 1..N theo danh sách gửi lên
// @Tags         admin-gifts
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body utils.ReorderRequest true "Toàn bộ id quà theo thứ tự mới"
// @Success      200  {object}  map[string]string
// @Failure      409  {object}  utils.APIError
// @Router       /admin/gifts/order [put]
func (ctrl *Controller) Reorder(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[utils.ReorderRequest](c)
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Reorder(req.IDs); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "order updated"}, nil
}

// @Summary      Xoá quà (admin, xoá mềm — tường quà và lịch sử vẫn giữ)
// @Tags         admin-gifts
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Gift ID"
// @Success      200  {object}  map[string]string
// @Failure      404  {object}  utils.APIError
// @Router       /admin/gifts/{id} [delete]
func (ctrl *Controller) Delete(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid gift id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Delete(id); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "gift deleted"}, nil
}

// @Summary      Sổ quà đã tặng (admin)
// @Tags         admin-gifts
// @Produce      json
// @Security     BearerAuth
// @Param        userId     query string false "Người tặng hoặc người nhận"
// @Param        senderId   query string false "Người tặng"
// @Param        receiverId query string false "Người nhận"
// @Param        giftId     query string false "Loại quà"
// @Param        from       query string false "Từ thời gian (RFC3339)"
// @Param        to         query string false "Đến thời gian (RFC3339)"
// @Param        limit      query int    false "Page size"
// @Param        offset     query int    false "Offset"
// @Success      200  {object}  TransactionListSuccessResponse
// @Router       /admin/gifts/transactions [get]
func (ctrl *Controller) ListTransactions(c *gin.Context) (interface{}, error) {
	var f TransactionFilter
	var err error
	if f.UserID, err = utils.ParseUUIDQuery(c, "userId"); err != nil {
		return nil, err
	}
	if f.SenderID, err = utils.ParseUUIDQuery(c, "senderId"); err != nil {
		return nil, err
	}
	if f.ReceiverID, err = utils.ParseUUIDQuery(c, "receiverId"); err != nil {
		return nil, err
	}
	if f.GiftID, err = utils.ParseUUIDQuery(c, "giftId"); err != nil {
		return nil, err
	}
	if f.From, f.To, err = utils.ParseTimeRange(c); err != nil {
		return nil, err
	}
	resp, err := ctrl.service.ListTransactions(f, utils.ParseLimit(c, 20, 100), utils.ParseOffset(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
