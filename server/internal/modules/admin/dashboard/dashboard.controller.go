package admindashboard

import (
	"net/http"
	"time"

	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[admin_dashboard_controller]")}
}

// GetOverview godoc
// @Summary      Thống kê tổng quan (admin)
// @Description  Số liệu tổng quan cho dashboard: người dùng, doanh thu KEN/VIP, tương tác, xã hội, game và chuỗi thời gian
// @Tags         admin-dashboard
// @Produce      json
// @Security     BearerAuth
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Success      200  {object}  OverviewSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Router       /admin/dashboard/overview [get]
func (ctrl *Controller) GetOverview(c *gin.Context) (interface{}, error) {
	now := time.Now()
	q := OverviewQuery{
		From: now.AddDate(0, 0, -29),
		To:   now,
	}

	if raw := c.Query("from"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid from time")
		}
		q.From = t
	}
	if raw := c.Query("to"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid to time")
		}
		q.To = t
	}
	if q.To.Before(q.From) {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "to must be after from")
	}

	resp, err := ctrl.service.Overview(q)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
