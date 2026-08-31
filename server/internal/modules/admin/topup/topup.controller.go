package admintopup

import (
	"net/http"
	"time"

	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[admin_topup_controller]")}
}

func parseListFilter(c *gin.Context) (ListFilter, error) {
	f := ListFilter{
		Status: c.Query("status"),
		Type:   c.Query("type"),
		Search: c.Query("search"),
	}
	if raw := c.Query("from"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return f, utils.NewHTTPError(http.StatusBadRequest, "invalid from time")
		}
		f.From = &t
	}
	if raw := c.Query("to"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return f, utils.NewHTTPError(http.StatusBadRequest, "invalid to time")
		}
		f.To = &t
	}
	return f, nil
}

// Stats godoc
// @Summary      Thống kê tiền nạp KEN theo ngày/tháng (admin)
// @Tags         admin-topup
// @Produce      json
// @Security     BearerAuth
// @Param        from query string false "Từ thời gian (RFC3339, mặc định 30 ngày trước)"
// @Param        to query string false "Đến thời gian (RFC3339, mặc định hiện tại)"
// @Success      200  {object}  StatsSuccessResponse
// @Router       /admin/topup/stats [get]
func (ctrl *Controller) Stats(c *gin.Context) (interface{}, error) {
	now := time.Now()
	from := now.AddDate(0, 0, -29).Truncate(24 * time.Hour)
	to := now
	if raw := c.Query("from"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid from time")
		}
		from = t
	}
	if raw := c.Query("to"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid to time")
		}
		to = t
	}
	if to.Before(from) {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "to must be after from")
	}

	resp, err := ctrl.service.Stats(from, to)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// List godoc
// @Summary      Lịch sử giao dịch nạp KEN qua webhook ngân hàng (admin)
// @Tags         admin-topup
// @Produce      json
// @Security     BearerAuth
// @Param        status query string false "CREDITED|NO_MATCH|BELOW_MIN|SKIPPED_OUT|SKIPPED_DISABLED|FAILED"
// @Param        type query string false "IN|OUT"
// @Param        search query string false "Tìm theo mã giao dịch, nội dung, username"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  TransactionListSuccessResponse
// @Router       /admin/topup/transactions [get]
func (ctrl *Controller) List(c *gin.Context) (interface{}, error) {
	f, err := parseListFilter(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)

	resp, err := ctrl.service.List(f, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ManualCredit godoc
// @Summary      Cộng KEN thủ công cho giao dịch nạp chưa khớp user (admin)
// @Tags         admin-topup
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Topup transaction ID"
// @Param        request body ManualCreditRequest true "Username nhận KEN"
// @Success      200  {object}  ManualCreditSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Failure      409  {object}  utils.APIError
// @Router       /admin/topup/transactions/{id}/credit [post]
func (ctrl *Controller) ManualCredit(c *gin.Context) (interface{}, error) {
	rowID, err := utils.ParseUUIDParam(c, "id", "invalid transaction id")
	if err != nil {
		return nil, err
	}

	adminID, ok := middleware.GetAdminID(c)
	if !ok {
		return nil, utils.NewHTTPError(http.StatusUnauthorized, "admin not authenticated")
	}

	req, err := utils.BindJSON[ManualCreditRequest](c)
	if err != nil {
		return nil, err
	}

	resp, err := ctrl.service.ManualCredit(rowID, adminID, *req)
	if err != nil {
		switch err {
		case ErrTopupTxNotFound:
			return nil, utils.NewHTTPError(http.StatusNotFound, "topup transaction not found")
		case ErrTopupTxNotPending:
			return nil, utils.NewHTTPError(http.StatusConflict, "topup transaction cannot be credited")
		case ErrUserNotFound:
			return nil, utils.NewHTTPError(http.StatusNotFound, "user not found")
		}
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
