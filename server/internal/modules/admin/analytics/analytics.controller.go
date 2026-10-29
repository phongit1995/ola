package adminanalytics

import (
	"context"
	"net/http"
	"time"

	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
)

const (
	defaultRangeDays = 30
	maxRangeDays     = 366
	requestTimeout   = 20 * time.Second
)

type Controller struct {
	service *Service
}

func NewController(service *Service) *Controller {
	return &Controller{service: service}
}

func parsePlatform(c *gin.Context) (string, error) {
	switch platform := c.DefaultQuery("platform", PlatformAll); platform {
	case PlatformAll, PlatformAndroid, PlatformIOS, PlatformWeb:
		return platform, nil
	}
	return "", utils.NewHTTPError(http.StatusBadRequest, "invalid platform")
}

func parseDate(c *gin.Context, name string, fallback time.Time) (time.Time, error) {
	raw := c.Query(name)
	if raw == "" {
		return fallback, nil
	}
	t, err := time.Parse(dateLayout, raw)
	if err != nil {
		return time.Time{}, utils.NewHTTPError(http.StatusBadRequest, "invalid "+name+" date, expected YYYY-MM-DD")
	}
	return t, nil
}

// GetOverview godoc
// @Summary      Thống kê Google Analytics gộp Android, iOS và web (admin)
// @Tags         admin-analytics
// @Produce      json
// @Security     BearerAuth
// @Param        from query string false "Từ ngày (YYYY-MM-DD)"
// @Param        to query string false "Đến ngày (YYYY-MM-DD)"
// @Param        platform query string false "all | android | ios | web"
// @Param        refresh query bool false "Bỏ qua bộ nhớ đệm"
// @Success      200  {object}  OverviewSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /admin/analytics/overview [get]
func (ctrl *Controller) GetOverview(c *gin.Context) (interface{}, error) {
	platform, err := parsePlatform(c)
	if err != nil {
		return nil, err
	}
	today := time.Now()
	to, err := parseDate(c, "to", today)
	if err != nil {
		return nil, err
	}
	from, err := parseDate(c, "from", to.AddDate(0, 0, 1-defaultRangeDays))
	if err != nil {
		return nil, err
	}
	if to.Before(from) {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "to must be after from")
	}
	if to.Sub(from) > maxRangeDays*24*time.Hour {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "khoảng thời gian tối đa 366 ngày")
	}

	ctx, cancel := context.WithTimeout(c.Request.Context(), requestTimeout)
	defer cancel()
	resp, err := ctrl.service.Overview(ctx, OverviewQuery{
		From:     from.Format(dateLayout),
		To:       to.Format(dateLayout),
		Platform: platform,
		Refresh:  c.Query("refresh") == "true",
	})
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// GetRealtime godoc
// @Summary      Số người đang dùng trong 30 phút gần nhất (admin)
// @Tags         admin-analytics
// @Produce      json
// @Security     BearerAuth
// @Param        platform query string false "all | android | ios | web"
// @Param        refresh query bool false "Bỏ qua bộ nhớ đệm"
// @Success      200  {object}  RealtimeSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /admin/analytics/realtime [get]
func (ctrl *Controller) GetRealtime(c *gin.Context) (interface{}, error) {
	platform, err := parsePlatform(c)
	if err != nil {
		return nil, err
	}
	ctx, cancel := context.WithTimeout(c.Request.Context(), requestTimeout)
	defer cancel()
	resp, err := ctrl.service.Realtime(ctx, RealtimeQuery{Platform: platform, Refresh: c.Query("refresh") == "true"})
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
