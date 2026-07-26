package adminmarriage

import (
	"net/http"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

type Controller struct {
	service *Service
}

func NewController(service *Service) *Controller {
	return &Controller{service: service}
}

var marriageStatuses = map[string]bool{
	models.MarriageStatusActive:   true,
	models.MarriageStatusDivorced: true,
}

var proposalStatuses = map[string]bool{
	models.MarriageProposalPending:   true,
	models.MarriageProposalAccepted:  true,
	models.MarriageProposalRejected:  true,
	models.MarriageProposalCancelled: true,
}

func parseUUIDQuery(c *gin.Context, key string) (*uuid.UUID, error) {
	raw := c.Query(key)
	if raw == "" {
		return nil, nil
	}
	id, err := uuid.Parse(raw)
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid "+key)
	}
	return &id, nil
}

func parseTimeRange(c *gin.Context) (*time.Time, *time.Time, error) {
	var from, to *time.Time
	if raw := c.Query("from"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return nil, nil, utils.NewHTTPError(http.StatusBadRequest, "invalid from time")
		}
		from = &t
	}
	if raw := c.Query("to"); raw != "" {
		t, err := time.Parse(time.RFC3339, raw)
		if err != nil {
			return nil, nil, utils.NewHTTPError(http.StatusBadRequest, "invalid to time")
		}
		to = &t
	}
	return from, to, nil
}

func parseListFilter(c *gin.Context, statuses map[string]bool) (ListFilter, error) {
	var f ListFilter
	if status := c.Query("status"); status != "" {
		if !statuses[status] {
			return f, utils.NewHTTPError(http.StatusBadRequest, "invalid status")
		}
		f.Status = status
	}

	userID, err := parseUUIDQuery(c, "userId")
	if err != nil {
		return f, err
	}
	f.UserID = userID

	f.From, f.To, err = parseTimeRange(c)
	if err != nil {
		return f, err
	}
	return f, nil
}

// GetStats godoc
// @Summary      Thống kê kết hôn & cầu hôn (admin)
// @Tags         admin-marriage
// @Produce      json
// @Security     BearerAuth
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Success      200  {object}  StatsSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /admin/marriages/stats [get]
func (ctrl *Controller) GetStats(c *gin.Context) (interface{}, error) {
	from, to, err := parseTimeRange(c)
	if err != nil {
		return nil, err
	}

	resp, err := ctrl.service.GetStats(StatsFilter{From: from, To: to})
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListMarriages godoc
// @Summary      Danh sách cặp đôi kết hôn (admin)
// @Tags         admin-marriage
// @Produce      json
// @Security     BearerAuth
// @Param        status query string false "active|divorced"
// @Param        userId query string false "Lọc theo user"
// @Param        from query string false "Cưới từ thời gian (RFC3339)"
// @Param        to query string false "Cưới đến thời gian (RFC3339)"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  MarriageListSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /admin/marriages [get]
func (ctrl *Controller) ListMarriages(c *gin.Context) (interface{}, error) {
	f, err := parseListFilter(c, marriageStatuses)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)

	resp, err := ctrl.service.ListMarriages(f, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListProposals godoc
// @Summary      Danh sách lời cầu hôn (admin)
// @Tags         admin-marriage
// @Produce      json
// @Security     BearerAuth
// @Param        status query string false "pending|accepted|rejected|cancelled"
// @Param        userId query string false "Lọc theo user (cầu hôn hoặc được cầu hôn)"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  ProposalListSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /admin/marriages/proposals [get]
func (ctrl *Controller) ListProposals(c *gin.Context) (interface{}, error) {
	f, err := parseListFilter(c, proposalStatuses)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)

	resp, err := ctrl.service.ListProposals(f, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
