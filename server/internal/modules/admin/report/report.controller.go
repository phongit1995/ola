package adminreport

import (
	"context"
	"errors"
	"net/http"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/modules/report"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	alerter *report.Alerter
	logger  *zap.SugaredLogger
}

func NewController(service *Service, alerter *report.Alerter, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, alerter: alerter, logger: logger.Named("[admin_report_controller]")}
}

var reportStatuses = map[string]bool{
	constants.ReportStatusPending:   true,
	constants.ReportStatusResolved:  true,
	constants.ReportStatusDismissed: true,
}

var reportTargetTypes = map[string]bool{
	constants.ReportTargetAccount:      true,
	constants.ReportTargetPost:         true,
	constants.ReportTargetComment:      true,
	constants.ReportTargetStoryComment: true,
	constants.ReportTargetMessage:      true,
	constants.ReportTargetRoomMessage:  true,
	constants.ReportTargetMoment:       true,
}

// ListReports godoc
// @Summary      List user reports (admin)
// @Tags         admin-report
// @Produce      json
// @Security     BearerAuth
// @Param        status         query string false "pending, resolved, dismissed"
// @Param        targetType     query string false "account, post, comment, story_comment, message, room_message, moment"
// @Param        reportedUserId query string false "Filter by reported user id"
// @Param        q              query string false "Search reporter/reported username"
// @Param        limit          query int    false "Page size (default 20, max 100)"
// @Param        offset         query int    false "Offset"
// @Success      200  {object}  utils.BaseResponse[ReportListResponse]
// @Router       /admin/reports [get]
func (ctrl *Controller) ListReports(c *gin.Context) (interface{}, error) {
	filter := ListFilter{
		Query:  c.Query("q"),
		Limit:  utils.ParseLimit(c, 20, 100),
		Offset: utils.ParseOffset(c),
	}
	if status := c.Query("status"); reportStatuses[status] {
		filter.Status = status
	}
	if targetType := c.Query("targetType"); reportTargetTypes[targetType] {
		filter.TargetType = targetType
	}
	if raw := c.Query("reportedUserId"); raw != "" {
		id, err := uuid.Parse(raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid reported user id")
		}
		filter.ReportedUserID = &id
	}

	resp, err := ctrl.service.List(filter)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Summary godoc
// @Summary      Count pending reports (admin)
// @Tags         admin-report
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[ReportSummaryResponse]
// @Router       /admin/reports/summary [get]
func (ctrl *Controller) Summary(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.Summary()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// UpdateStatus godoc
// @Summary      Resolve or dismiss a report (admin)
// @Description  Áp dụng cho mọi báo cáo đang chờ xử lý của cùng nội dung bị báo cáo.
// @Tags         admin-report
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id      path string              true "Report ID"
// @Param        request body UpdateStatusRequest true "Status request"
// @Success      200  {object}  utils.BaseResponse[UpdateStatusResponse]
// @Router       /admin/reports/{id}/status [patch]
func (ctrl *Controller) UpdateStatus(c *gin.Context) (interface{}, error) {
	adminID, ok := middleware.GetAdminID(c)
	if !ok {
		return nil, utils.NewHTTPError(http.StatusUnauthorized, "unauthorized")
	}
	id, err := utils.ParseUUIDParam(c, "id", "invalid report id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[UpdateStatusRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.UpdateStatus(adminID, id, req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// TestAlert godoc
// @Summary      Gửi tin thử tới kênh nhận báo cáo vi phạm (Discord / Telegram) bằng cấu hình đã lưu (admin)
// @Tags         admin-reports
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body TestAlertRequest true "Kênh cần gửi thử"
// @Success      200  {object}  TestAlertSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /admin/reports/alert/test [post]
func (ctrl *Controller) TestAlert(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[TestAlertRequest](c)
	if err != nil {
		return nil, err
	}
	ctx, cancel := context.WithTimeout(c.Request.Context(), testAlertTimeout)
	defer cancel()
	if err := ctrl.alerter.SendTest(ctx, req.Channel); err != nil {
		if errors.Is(err, report.ErrAlertChannelNotConfigured) {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "Kênh này chưa được cấu hình, lưu cấu hình trước rồi gửi thử")
		}
		return nil, utils.NewHTTPError(http.StatusBadRequest, "Gửi thử thất bại: "+err.Error())
	}
	return TestAlertResponse{Channel: req.Channel}, nil
}
