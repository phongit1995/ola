package adminreel

import (
	"net/http"

	"ola-chat-server/internal/constants"
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
	return &Controller{service: service, logger: logger.Named("[admin_reel_controller]")}
}

// ListReels godoc
// @Summary      List reels (admin, includes expired and deleted)
// @Tags         admin-reel
// @Produce      json
// @Security     BearerAuth
// @Param        q                 query string false "Search overlay text"
// @Param        authorId          query string false "Filter by author id"
// @Param        type              query string false "text, image, video"
// @Param        visibility        query string false "public, friend"
// @Param        state             query string false "live, processing, failed, expired, deleted"
// @Param        enabled           query bool   false "Filter by admin status (true=shown, false=hidden)"
// @Param        hasPendingReports query bool   false "Filter reels with/without pending reports"
// @Param        sortBy            query string false "createdAt, reportCount"
// @Param        sortDir           query string false "asc, desc"
// @Param        limit             query int    false "Page size (default 20, max 100)"
// @Param        offset            query int    false "Offset"
// @Success      200  {object}  utils.BaseResponse[ReelListResponse]
// @Router       /admin/reels [get]
func (ctrl *Controller) ListReels(c *gin.Context) (interface{}, error) {
	filter := ListFilter{
		Query:             c.Query("q"),
		Type:              oneOf(c.Query("type"), constants.ReelTypeText, constants.ReelTypeImage, constants.ReelTypeVideo),
		Visibility:        oneOf(c.Query("visibility"), constants.ReelVisibilityPublic, constants.ReelVisibilityFriend),
		State:             parseState(c.Query("state")),
		Enabled:           utils.ParseOptionalBool(c, "enabled"),
		HasPendingReports: utils.ParseOptionalBool(c, "hasPendingReports"),
		SortBy:            c.Query("sortBy"),
		SortDir:           c.Query("sortDir"),
		Limit:             utils.ParseLimit(c, constants.AdminReelDefaultPageSize, constants.AdminReelMaxPageSize),
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
		constants.AdminReelStateLive,
		constants.AdminReelStateProcessing,
		constants.AdminReelStateFailed,
		constants.AdminReelStateExpired,
		constants.AdminReelStateDeleted,
	)
}

// GetReel godoc
// @Summary      Get reel detail (admin)
// @Tags         admin-reel
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Reel ID"
// @Success      200  {object}  utils.BaseResponse[ReelItem]
// @Router       /admin/reels/{id} [get]
func (ctrl *Controller) GetReel(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid reel id")
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
// @Summary      Show/hide a reel (admin)
// @Tags         admin-reel
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id      path string              true "Reel ID"
// @Param        request body UpdateStatusRequest true "Status Request"
// @Success      200  {object}  utils.BaseResponse[ReelItem]
// @Router       /admin/reels/{id}/status [patch]
func (ctrl *Controller) UpdateStatus(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid reel id")
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

// ListViewers godoc
// @Summary      List viewers of a reel (admin)
// @Tags         admin-reel
// @Produce      json
// @Security     BearerAuth
// @Param        id     path  string true  "Reel ID"
// @Param        limit  query int    false "Page size"
// @Param        offset query int    false "Offset"
// @Success      200  {object}  utils.BaseResponse[reel.ReelViewersResponse]
// @Router       /admin/reels/{id}/viewers [get]
func (ctrl *Controller) ListViewers(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid reel id")
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, constants.ReelViewersDefaultPageSize, constants.ReelViewersMaxPageSize)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListViewers(c.Request.Context(), id, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
