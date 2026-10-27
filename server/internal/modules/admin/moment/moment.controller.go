package adminmoment

import (
	"net/http"

	"ola-chat-server/internal/modules/moment"
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
	return &Controller{service: service, logger: logger.Named("[admin_moment_controller]")}
}

// ListMoments godoc
// @Summary      List moments (admin, includes expired and deleted)
// @Tags         admin-moment
// @Produce      json
// @Security     BearerAuth
// @Param        q                 query string false "Search overlay text"
// @Param        authorId          query string false "Filter by author id"
// @Param        type              query string false "text, image, video"
// @Param        visibility        query string false "public, friend"
// @Param        state             query string false "live, processing, failed, expired, deleted"
// @Param        enabled           query bool   false "Filter by status (true=shown, false=hidden by admin or author)"
// @Param        hasPendingReports query bool   false "Filter moments with/without pending reports"
// @Param        sortBy            query string false "createdAt, reportCount"
// @Param        sortDir           query string false "asc, desc"
// @Param        limit             query int    false "Page size (default 20, max 100)"
// @Param        offset            query int    false "Offset"
// @Success      200  {object}  utils.BaseResponse[MomentListResponse]
// @Router       /admin/moments [get]
func (ctrl *Controller) ListMoments(c *gin.Context) (interface{}, error) {
	filter := ListFilter{
		Query:             c.Query("q"),
		Type:              oneOf(c.Query("type"), moment.MomentTypeText, moment.MomentTypeImage, moment.MomentTypeVideo),
		Visibility:        oneOf(c.Query("visibility"), moment.MomentVisibilityPublic, moment.MomentVisibilityFriend),
		State:             parseState(c.Query("state")),
		Enabled:           utils.ParseOptionalBool(c, "enabled"),
		HasPendingReports: utils.ParseOptionalBool(c, "hasPendingReports"),
		SortBy:            c.Query("sortBy"),
		SortDir:           c.Query("sortDir"),
		Limit:             utils.ParseLimit(c, moment.AdminMomentDefaultPageSize, moment.AdminMomentMaxPageSize),
		Offset:            utils.ParseOffset(c),
	}

	if raw := c.Query("authorId"); raw != "" {
		id, err := uuid.Parse(raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid author id")
		}
		filter.AuthorID = &id
	}

	resp, err := ctrl.service.List(c.Request.Context(), filter)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

func oneOf(value string, allowed ...string) string {
	for _, option := range allowed {
		if value == option {
			return value
		}
	}
	return ""
}

func parseState(value string) string {
	return oneOf(value,
		moment.AdminMomentStateLive,
		moment.AdminMomentStateProcessing,
		moment.AdminMomentStateFailed,
		moment.AdminMomentStateExpired,
		moment.AdminMomentStateDeleted,
	)
}

// GetMoment godoc
// @Summary      Get moment detail (admin)
// @Tags         admin-moment
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Moment ID"
// @Success      200  {object}  utils.BaseResponse[MomentDetail]
// @Router       /admin/moments/{id} [get]
func (ctrl *Controller) GetMoment(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid moment id")
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.GetByID(c.Request.Context(), id)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// UpdateStatus godoc
// @Summary      Show/hide a moment (admin)
// @Tags         admin-moment
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id      path string              true "Moment ID"
// @Param        request body UpdateStatusRequest true "Status Request"
// @Success      200  {object}  utils.BaseResponse[MomentDetail]
// @Router       /admin/moments/{id}/status [patch]
func (ctrl *Controller) UpdateStatus(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid moment id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[UpdateStatusRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.SetEnabled(c.Request.Context(), id, *req.Enabled)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// PurgeMedia godoc
// @Summary      Delete image/video files of a moment from storage, keep the record (admin)
// @Tags         admin-moment
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Moment ID"
// @Success      200  {object}  utils.BaseResponse[MomentDetail]
// @Router       /admin/moments/{id}/purge-media [post]
func (ctrl *Controller) PurgeMedia(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid moment id")
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.PurgeMedia(c.Request.Context(), id)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListViewers godoc
// @Summary      List viewers of a moment (admin)
// @Tags         admin-moment
// @Produce      json
// @Security     BearerAuth
// @Param        id     path  string true  "Moment ID"
// @Param        limit  query int    false "Page size"
// @Param        offset query int    false "Offset"
// @Success      200  {object}  utils.BaseResponse[moment.MomentViewersResponse]
// @Router       /admin/moments/{id}/viewers [get]
func (ctrl *Controller) ListViewers(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid moment id")
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, moment.MomentViewersDefaultPageSize, moment.MomentViewersMaxPageSize)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListViewers(c.Request.Context(), id, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// MediaPurgeLogs godoc
// @Summary      Moment media auto-purge run logs of the last 30 days (admin)
// @Tags         admin-moment
// @Produce      json
// @Security     BearerAuth
// @Param        limit  query int false "Page size (default 20, max 100)"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[MediaPurgeLogsResponse]
// @Router       /admin/moment-media-purge/logs [get]
func (ctrl *Controller) MediaPurgeLogs(c *gin.Context) (interface{}, error) {
	limit := utils.ParseLimit(c, moment.MomentPurgeLogsDefaultPage, moment.MomentPurgeLogsMaxPage)
	resp, err := ctrl.service.MediaPurgeLogs(c.Request.Context(), limit, utils.ParseOffset(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// RunMediaPurge godoc
// @Summary      Start a moment media purge run now, in the background (admin)
// @Tags         admin-moment
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[MediaPurgeRunResponse]
// @Failure      409  {object}  utils.APIError
// @Router       /admin/moment-media-purge/run [post]
func (ctrl *Controller) RunMediaPurge(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.StartMediaPurge()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
