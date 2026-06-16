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
// @Param        q        query string false "Search by content"
// @Param        authorId query string false "Filter by author id"
// @Param        limit    query int    false "Page size (default 20, max 100)"
// @Param        offset   query int    false "Offset"
// @Success      200  {object}  utils.BaseResponse[PostListResponse]
// @Router       /admin/me [get]
func (ctrl *Controller) ListPosts(c *gin.Context) (interface{}, error) {
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)

	var authorID *uuid.UUID
	if raw := c.Query("authorId"); raw != "" {
		id, err := uuid.Parse(raw)
		if err != nil {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid author id")
		}
		authorID = &id
	}

	resp, err := ctrl.service.List(c.Query("q"), authorID, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// GetPost godoc
// @Summary      Get post detail (admin)
// @Tags         admin-me
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Post ID"
// @Success      200  {object}  utils.BaseResponse[PostDetail]
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
// @Success      200  {object}  utils.BaseResponse[PostDetail]
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
