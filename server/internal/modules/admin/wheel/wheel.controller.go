package adminwheel

import (
	"net/http"
	"strings"
	"time"

	"ola-chat-server/internal/modules/wheel"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Controller struct {
	service *wheel.Service
	logger  *zap.SugaredLogger
}

func NewController(service *wheel.Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[admin_wheel_controller]")}
}

// ListWheels godoc
// @Summary      Danh sách vòng quay + cấu hình (admin)
// @Tags         admin-wheel
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  wheel.WheelListResponse
// @Router       /admin/wheel/wheels [get]
func (ctrl *Controller) ListWheels(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.ListAllWheels()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// CreateWheel godoc
// @Summary      Tạo vòng quay (admin)
// @Tags         admin-wheel
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body wheel.CreateWheelRequest true "Wheel"
// @Success      201  {object}  wheel.WheelView
// @Router       /admin/wheel/wheels [post]
func (ctrl *Controller) CreateWheel(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[wheel.CreateWheelRequest](c)
	if err != nil {
		return nil, err
	}
	view, err := ctrl.service.CreateWheel(*req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return view, nil
}

// UpdateWheel godoc
// @Summary      Cập nhật vòng quay (admin)
// @Tags         admin-wheel
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Wheel ID"
// @Param        request body wheel.UpdateWheelRequest true "Wheel"
// @Success      200  {object}  wheel.WheelView
// @Failure      404  {object}  utils.APIError
// @Router       /admin/wheel/wheels/{id} [patch]
func (ctrl *Controller) UpdateWheel(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid wheel id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[wheel.UpdateWheelRequest](c)
	if err != nil {
		return nil, err
	}
	view, err := ctrl.service.UpdateWheel(id, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return view, nil
}

// DeleteWheel godoc
// @Summary      Xoá vòng quay (admin)
// @Tags         admin-wheel
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Wheel ID"
// @Success      200  {object}  map[string]string
// @Failure      404  {object}  utils.APIError
// @Router       /admin/wheel/wheels/{id} [delete]
func (ctrl *Controller) DeleteWheel(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid wheel id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.DeleteWheel(id); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "wheel deleted"}, nil
}

// SaveConfig godoc
// @Summary      Lưu cấu hình ô + lựa chọn của vòng quay (admin)
// @Tags         admin-wheel
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Wheel ID"
// @Param        request body wheel.SaveConfigRequest true "Config"
// @Success      200  {object}  wheel.WheelView
// @Failure      404  {object}  utils.APIError
// @Router       /admin/wheel/wheels/{id}/config [put]
func (ctrl *Controller) SaveConfig(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid wheel id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[wheel.SaveConfigRequest](c)
	if err != nil {
		return nil, err
	}
	view, err := ctrl.service.SaveConfig(id, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return view, nil
}

// ListSpins godoc
// @Summary      Lịch sử quay toàn hệ thống (admin)
// @Tags         admin-wheel
// @Produce      json
// @Security     BearerAuth
// @Param        userId query string false "Lọc theo user"
// @Param        q query string false "Tìm theo username/tên người chơi"
// @Param        segmentKind query string false "Lọc theo loại ô"
// @Param        outcome query string false "Lọc trúng/trượt (win|miss)"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  wheel.AdminSpinListResponse
// @Router       /admin/wheel/spins [get]
func (ctrl *Controller) ListSpins(c *gin.Context) (interface{}, error) {
	var filter wheel.AdminSpinFilter
	if raw := c.Query("userId"); raw != "" {
		parsed, err := uuid.Parse(raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid user id")
		}
		filter.UserID = &parsed
	}
	if raw := c.Query("segmentKind"); raw != "" {
		switch raw {
		case "miss", "ken_fixed", "ken_random", "vip_days", "vip_item", "vip_random":
			filter.SegmentKind = raw
		default:
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid segment kind")
		}
	}
	if raw := c.Query("outcome"); raw == "win" || raw == "miss" {
		filter.Outcome = raw
	}
	filter.Query = strings.TrimSpace(c.Query("q"))
	if raw := c.Query("from"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid from time")
		}
		filter.From = &t
	}
	if raw := c.Query("to"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid to time")
		}
		filter.To = &t
	}
	limit := utils.ParseLimit(c, 50, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListAllSpins(filter, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// GetStats godoc
// @Summary      Thống kê vòng quay (admin)
// @Tags         admin-wheel
// @Produce      json
// @Security     BearerAuth
// @Param        wheelId query string false "Lọc theo vòng quay"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Success      200  {object}  wheel.StatsResponse
// @Router       /admin/wheel/stats [get]
func (ctrl *Controller) GetStats(c *gin.Context) (interface{}, error) {
	var filter wheel.AdminSpinFilter
	if raw := c.Query("wheelId"); raw != "" {
		parsed, err := uuid.Parse(raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid wheel id")
		}
		filter.WheelID = &parsed
	}
	if raw := c.Query("from"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid from time")
		}
		filter.From = &t
	}
	if raw := c.Query("to"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid to time")
		}
		filter.To = &t
	}
	resp, err := ctrl.service.Stats(filter)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
