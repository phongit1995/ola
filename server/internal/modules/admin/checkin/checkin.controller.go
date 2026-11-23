package admincheckin

import (
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
)

const (
	historyDefaultLimit = 20
	historyMaxLimit     = 100
)

type Controller struct {
	service *Service
}

func NewController(service *Service) *Controller {
	return &Controller{service: service}
}

// @Summary      Danh sách lịch điểm danh các tháng
// @Tags         admin-checkin
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[MonthListResponse]
// @Router       /admin/checkin/months [get]
func (ctrl *Controller) ListMonths(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.ListMonths()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Tạo lịch tháng (nháp)
// @Description  source=copy chép ô k sang ô k từ tháng copyFrom, ô dư bỏ, ô thiếu để trống. source=empty mọi ô chỉ điểm danh.
// @Tags         admin-checkin
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body CreateMonthRequest true "Tháng"
// @Success      200  {object}  utils.BaseResponse[MonthDetailDTO]
// @Router       /admin/checkin/months [post]
func (ctrl *Controller) CreateMonth(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[CreateMonthRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.CreateMonth(*req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Lịch một tháng kèm cấu hình các ô
// @Tags         admin-checkin
// @Produce      json
// @Security     BearerAuth
// @Param        month path string true "YYYY-MM"
// @Success      200  {object}  utils.BaseResponse[MonthDetailDTO]
// @Router       /admin/checkin/months/{month} [get]
func (ctrl *Controller) GetMonth(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.GetMonth(c.Param("month"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Đổi số ô của tháng
// @Description  Tháng đang chạy chỉ được tăng.
// @Tags         admin-checkin
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        month path string true "YYYY-MM"
// @Param        request body UpdateMonthRequest true "Số ô"
// @Success      200  {object}  utils.BaseResponse[MonthDetailDTO]
// @Router       /admin/checkin/months/{month} [patch]
func (ctrl *Controller) UpdateMonth(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[UpdateMonthRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.UpdateSlotCount(c.Param("month"), *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Phát hành lịch nháp
// @Description  Không quay lại nháp được. Tháng đang chạy thì chạy ngay, ô khoá tính từ ngày phát hành.
// @Tags         admin-checkin
// @Produce      json
// @Security     BearerAuth
// @Param        month path string true "YYYY-MM"
// @Success      200  {object}  utils.BaseResponse[MonthDetailDTO]
// @Router       /admin/checkin/months/{month}/publish [post]
func (ctrl *Controller) PublishMonth(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.Publish(c.Param("month"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Xoá lịch nháp hoặc lịch tháng chưa bắt đầu
// @Tags         admin-checkin
// @Produce      json
// @Security     BearerAuth
// @Param        month path string true "YYYY-MM"
// @Success      200  {object}  utils.BaseResponse[any]
// @Router       /admin/checkin/months/{month} [delete]
func (ctrl *Controller) DeleteMonth(c *gin.Context) (interface{}, error) {
	if err := ctrl.service.DeleteMonth(c.Param("month")); err != nil {
		return nil, utils.ServiceError(err)
	}
	return gin.H{"deleted": true}, nil
}

// @Summary      Lưu một hoặc nhiều ô
// @Description  Ô đã khoá của tháng đang chạy bị từ chối. Mỗi ô tối đa 5 quà, mỗi quà 1–10 món, tổng tỉ lệ 100. Gửi kèm updatedAt đã đọc của ô: ô đã bị sửa ở nơi khác thì trả 409, không ghi.
// @Tags         admin-checkin
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        month path string true "YYYY-MM"
// @Param        request body SaveSlotsRequest true "Các ô"
// @Success      200  {object}  utils.BaseResponse[MonthDetailDTO]
// @Router       /admin/checkin/months/{month}/slots [put]
func (ctrl *Controller) SaveSlots(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[SaveSlotsRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.SaveSlots(c.Param("month"), *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Đổi chỗ hai ô
// @Description  Server đổi nội dung hai ô trên dữ liệu mới nhất trong cùng transaction. Ô đã khoá của tháng đang chạy bị từ chối.
// @Tags         admin-checkin
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        month path string true "YYYY-MM"
// @Param        request body SwapSlotsRequest true "Hai ô"
// @Success      200  {object}  utils.BaseResponse[MonthDetailDTO]
// @Router       /admin/checkin/months/{month}/slots/swap [post]
func (ctrl *Controller) SwapSlots(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[SwapSlotsRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.SwapSlots(c.Param("month"), *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Thống kê điểm danh của tháng
// @Tags         admin-checkin
// @Produce      json
// @Security     BearerAuth
// @Param        month query string true "YYYY-MM"
// @Success      200  {object}  utils.BaseResponse[StatsResponse]
// @Router       /admin/checkin/stats [get]
func (ctrl *Controller) Stats(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.Stats(c.Query("month"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// @Summary      Lịch sử lượt điểm danh
// @Description  status: claimed | pending | missed | none. Lý do mất hộp tính lại lúc xem.
// @Tags         admin-checkin
// @Produce      json
// @Security     BearerAuth
// @Param        month query string true "YYYY-MM"
// @Param        q query string false "Tên đăng nhập, tên hoặc ID"
// @Param        userId query string false "ID người dùng"
// @Param        status query string false "claimed | pending | missed | none"
// @Param        slot query int false "Ô"
// @Param        limit query int false "Mặc định 20"
// @Param        offset query int false "Bắt đầu từ"
// @Success      200  {object}  utils.BaseResponse[utils.Page[HistoryItem]]
// @Router       /admin/checkin/history [get]
func (ctrl *Controller) History(c *gin.Context) (interface{}, error) {
	userID, err := utils.ParseUUIDQuery(c, "userId")
	if err != nil {
		return nil, err
	}
	query := HistoryQuery{
		Month:  c.Query("month"),
		Q:      c.Query("q"),
		UserID: userID,
		Status: c.Query("status"),
		Limit:  utils.ParseLimit(c, historyDefaultLimit, historyMaxLimit),
		Offset: utils.ParseOffset(c),
	}
	if slot := utils.ParseIntQuery(c, "slot"); slot != nil {
		query.Slot = *slot
	}
	items, total, err := ctrl.service.History(query)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return utils.Page[HistoryItem]{Total: total, Limit: query.Limit, Offset: query.Offset, Items: items}, nil
}

// @Summary      Lịch điểm danh một tháng của một người
// @Tags         admin-checkin
// @Produce      json
// @Security     BearerAuth
// @Param        userId path string true "ID người dùng"
// @Param        month query string true "YYYY-MM"
// @Success      200  {object}  utils.BaseResponse[UserMonthResponse]
// @Router       /admin/checkin/users/{userId} [get]
func (ctrl *Controller) UserMonth(c *gin.Context) (interface{}, error) {
	userID, err := utils.ParseUUIDParam(c, "userId", "user")
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.UserMonth(userID, c.Query("month"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
