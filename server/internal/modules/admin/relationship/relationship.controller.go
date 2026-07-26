package adminrelationship

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

var relationshipStatuses = map[string]bool{
	string(models.RelationshipStatusPending):  true,
	string(models.RelationshipStatusAccepted): true,
	string(models.RelationshipStatusRejected): true,
	string(models.RelationshipStatusBlocked):  true,
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

// GetStats godoc
// @Summary      Thống kê quan hệ bạn bè & theo dõi (admin)
// @Tags         admin-relationship
// @Produce      json
// @Security     BearerAuth
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Success      200  {object}  StatsSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /admin/relationships/stats [get]
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

// ListRelationships godoc
// @Summary      Danh sách quan hệ kết bạn/chặn (admin)
// @Tags         admin-relationship
// @Produce      json
// @Security     BearerAuth
// @Param        status query string false "pending|accepted|rejected|blocked"
// @Param        userId query string false "Lọc theo user (gửi hoặc nhận)"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  RelationshipListSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /admin/relationships [get]
func (ctrl *Controller) ListRelationships(c *gin.Context) (interface{}, error) {
	var f ListFilter
	if status := c.Query("status"); status != "" {
		if !relationshipStatuses[status] {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid status")
		}
		f.Status = status
	}

	userID, err := parseUUIDQuery(c, "userId")
	if err != nil {
		return nil, err
	}
	f.UserID = userID

	f.From, f.To, err = parseTimeRange(c)
	if err != nil {
		return nil, err
	}

	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)

	resp, err := ctrl.service.ListRelationships(f, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListFollows godoc
// @Summary      Danh sách theo dõi giữa các user (admin)
// @Tags         admin-relationship
// @Produce      json
// @Security     BearerAuth
// @Param        followerId query string false "Lọc theo người theo dõi"
// @Param        followeeId query string false "Lọc theo người được theo dõi"
// @Param        userId query string false "Lọc theo user (theo dõi hoặc được theo dõi)"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  FollowListSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /admin/relationships/follows [get]
func (ctrl *Controller) ListFollows(c *gin.Context) (interface{}, error) {
	var f FollowFilter

	followerID, err := parseUUIDQuery(c, "followerId")
	if err != nil {
		return nil, err
	}
	f.FollowerID = followerID

	followeeID, err := parseUUIDQuery(c, "followeeId")
	if err != nil {
		return nil, err
	}
	f.FolloweeID = followeeID

	userID, err := parseUUIDQuery(c, "userId")
	if err != nil {
		return nil, err
	}
	f.UserID = userID

	f.From, f.To, err = parseTimeRange(c)
	if err != nil {
		return nil, err
	}

	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)

	resp, err := ctrl.service.ListFollows(f, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// UserStats godoc
// @Summary      Thống kê bạn bè/chặn/theo dõi theo từng user (admin)
// @Tags         admin-relationship
// @Produce      json
// @Security     BearerAuth
// @Param        userId query string false "Lọc theo user"
// @Param        from query string false "Từ thời gian (RFC3339)"
// @Param        to query string false "Đến thời gian (RFC3339)"
// @Param        sortBy query string false "friends|blocked|followers|following (mặc định friends)"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  UserStatsSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /admin/relationships/users [get]
func (ctrl *Controller) UserStats(c *gin.Context) (interface{}, error) {
	var f UserStatsFilter

	userID, err := parseUUIDQuery(c, "userId")
	if err != nil {
		return nil, err
	}
	f.UserID = userID

	f.From, f.To, err = parseTimeRange(c)
	if err != nil {
		return nil, err
	}

	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)

	resp, err := ctrl.service.UserStats(f, c.Query("sortBy"), limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
