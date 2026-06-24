package adminpen

import (
	"net/http"
	"strconv"
	"time"

	"ola-chat-server/internal/modules/pen"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Controller struct {
	service *pen.Service
	logger  *zap.SugaredLogger
}

func NewController(service *pen.Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[admin_pen_controller]")}
}

func parseIntQuery(c *gin.Context, key string) *int {
	s := c.Query(key)
	if s == "" {
		return nil
	}
	n, err := strconv.Atoi(s)
	if err != nil {
		return nil
	}
	return &n
}

func parseTimeQuery(c *gin.Context, key string) (*time.Time, error) {
	raw := c.Query(key)
	if raw == "" {
		return nil, nil
	}
	t, err := time.Parse(time.RFC3339, raw)
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid "+key+" time")
	}
	return &t, nil
}

// ListShots godoc
// @Summary      Danh sách lượt PEN toàn hệ thống (admin)
// @Tags         admin-pen
// @Produce      json
// @Security     BearerAuth
// @Param        shooterId query string false "Lọc người sút"
// @Param        keeperId query string false "Lọc người chụp"
// @Param        status query string false "open|settled|cancelled"
// @Param        result query string false "saved|goal"
// @Param        minBet query int false "Cược tối thiểu"
// @Param        maxBet query int false "Cược tối đa"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  pen.AdminShotListSuccessResponse
// @Router       /admin/pen/shots [get]
func (ctrl *Controller) ListShots(c *gin.Context) (interface{}, error) {
	var f pen.AdminShotFilter
	if raw := c.Query("shooterId"); raw != "" {
		id, err := uuid.Parse(raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid shooter id")
		}
		f.ShooterID = &id
	}
	if raw := c.Query("keeperId"); raw != "" {
		id, err := uuid.Parse(raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid keeper id")
		}
		f.KeeperID = &id
	}
	if raw := c.Query("status"); raw == "open" || raw == "settled" || raw == "cancelled" {
		f.Status = raw
	}
	if raw := c.Query("result"); raw == "saved" || raw == "goal" {
		f.Result = raw
	}
	f.MinBet = parseIntQuery(c, "minBet")
	f.MaxBet = parseIntQuery(c, "maxBet")

	from, err := parseTimeQuery(c, "from")
	if err != nil {
		return nil, err
	}
	f.From = from
	to, err := parseTimeQuery(c, "to")
	if err != nil {
		return nil, err
	}
	f.To = to

	limit := utils.ParseLimit(c, 50, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListAllShots(f, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// GetStats godoc
// @Summary      Thống kê PEN (admin)
// @Tags         admin-pen
// @Produce      json
// @Security     BearerAuth
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Success      200  {object}  pen.PenStatsSuccessResponse
// @Router       /admin/pen/stats [get]
func (ctrl *Controller) GetStats(c *gin.Context) (interface{}, error) {
	var f pen.AdminShotFilter
	from, err := parseTimeQuery(c, "from")
	if err != nil {
		return nil, err
	}
	f.From = from
	to, err := parseTimeQuery(c, "to")
	if err != nil {
		return nil, err
	}
	f.To = to

	resp, err := ctrl.service.Stats(f)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
