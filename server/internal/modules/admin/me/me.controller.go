package adminme

import (
	"net/http"

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
	return &Controller{service: service, logger: logger.Named("[admin_me_controller]")}
}

// ListPosts godoc
// @Summary      List posts (admin, all visibilities)
// @Tags         admin-me
// @Produce      json
// @Security     BearerAuth
// @Param        q          query string false "Search by content"
// @Param        authorId   query string false "Filter by author id"
// @Param        enabled    query bool   false "Filter by status (true=shown, false=hidden)"
// @Param        visibility query string false "Filter by visibility (public, friend, private)"
// @Param        hasImages  query bool   false "Filter posts with/without images"
// @Param        hasCheckin query bool   false "Filter posts with/without check-in"
// @Param        sortBy     query string false "Sort field (createdAt, likeCount, commentCount, dislikeCount)"
// @Param        sortDir    query string false "Sort direction (asc, desc)"
// @Param        limit      query int    false "Page size (default 20, max 100)"
// @Param        offset     query int    false "Offset"
// @Success      200  {object}  utils.BaseResponse[MeListResponse]
// @Router       /admin/me [get]
func (ctrl *Controller) ListPosts(c *gin.Context) (interface{}, error) {
	filter := ListFilter{
		Query:      c.Query("q"),
		Enabled:    parseBoolQuery(c, "enabled"),
		Visibility: parseVisibilityQuery(c.Query("visibility")),
		HasImages:  parseBoolQuery(c, "hasImages"),
		HasCheckin: parseBoolQuery(c, "hasCheckin"),
		SortBy:     c.Query("sortBy"),
		SortDir:    c.Query("sortDir"),
		Limit:      utils.ParseLimit(c, 20, 100),
		Offset:     utils.ParseOffset(c),
	}

	if raw := c.Query("authorId"); raw != "" {
		id, err := uuid.Parse(raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid author id")
		}
		filter.AuthorID = &id
	}

	resp, err := ctrl.service.List(filter)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

func parseBoolQuery(c *gin.Context, key string) *bool {
	switch c.Query(key) {
	case "true":
		t := true
		return &t
	case "false":
		f := false
		return &f
	default:
		return nil
	}
}

func parseVisibilityQuery(v string) string {
	switch v {
	case "public", "friend", "private":
		return v
	default:
		return ""
	}
}

// GetPost godoc
// @Summary      Get post detail (admin)
// @Tags         admin-me
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Post ID"
// @Success      200  {object}  utils.BaseResponse[MeDetail]
// @Router       /admin/me/{id} [get]
func (ctrl *Controller) GetPost(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid post id")
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.GetByID(id)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// UpdateStatus godoc
// @Summary      Enable/disable a post (admin)
// @Tags         admin-me
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id      path string              true "Post ID"
// @Param        request body UpdateStatusRequest true "Status Request"
// @Success      200  {object}  utils.BaseResponse[MeDetail]
// @Router       /admin/me/{id}/status [patch]
func (ctrl *Controller) UpdateStatus(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid post id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[UpdateStatusRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.SetEnabled(id, *req.Enabled)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListComments godoc
// @Summary      List comments of a post (admin)
// @Tags         admin-me
// @Produce      json
// @Security     BearerAuth
// @Param        id     path  string true "Post ID"
// @Param        limit  query int    false "Page size"
// @Param        offset query int    false "Offset"
// @Success      200  {object}  utils.BaseResponse[CommentListResponse]
// @Router       /admin/me/{id}/comments [get]
func (ctrl *Controller) ListComments(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid post id")
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListComments(id, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// DeleteComment godoc
// @Summary      Delete a comment (admin)
// @Tags         admin-me
// @Produce      json
// @Security     BearerAuth
// @Param        id        path string true "Post ID"
// @Param        commentId path string true "Comment ID"
// @Success      200  {object}  map[string]string
// @Router       /admin/me/{id}/comments/{commentId} [delete]
func (ctrl *Controller) DeleteComment(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid post id")
	if err != nil {
		return nil, err
	}
	commentID, err := utils.ParseUUIDParam(c, "commentId", "invalid comment id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.DeleteComment(id, commentID); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "comment deleted"}, nil
}
