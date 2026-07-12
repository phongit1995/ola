package adminaudit

import (
	"net/http"
	"time"

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
	return &Controller{service: service, logger: logger.Named("[admin_audit_controller]")}
}

// List godoc
// @Summary      Nhật ký thao tác admin
// @Description  Danh sách các thay đổi do admin thực hiện (tự động ghi mọi thao tác POST/PUT/PATCH/DELETE)
// @Tags         admin-audit
// @Produce      json
// @Security     BearerAuth
// @Param        adminId query string false "Lọc theo admin"
// @Param        resource query string false "Lọc theo nhóm chức năng (users, rooms, vip...)"
// @Param        method query string false "Lọc theo method (POST/PUT/PATCH/DELETE)"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[AuditLogListResponse]
// @Router       /admin/logs [get]
func (ctrl *Controller) List(c *gin.Context) (interface{}, error) {
	f := ListFilter{
		Resource: c.Query("resource"),
		Method:   c.Query("method"),
		Limit:    utils.ParseLimit(c, 30, 100),
		Offset:   utils.ParseOffset(c),
	}

	if raw := c.Query("adminId"); raw != "" {
		id, err := uuid.Parse(raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid admin id")
		}
		f.AdminID = &id
	}
	if raw := c.Query("from"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid from time")
		}
		f.From = &t
	}
	if raw := c.Query("to"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid to time")
		}
		f.To = &t
	}

	resp, err := ctrl.service.List(f)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
