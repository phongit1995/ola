package me

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
	return &Controller{service: service, logger: logger.Named("[post_controller]")}
}

func parseID(c *gin.Context) (uuid.UUID, error) {
	return utils.ParseUUIDParam(c, "id", "invalid post id")
}

// UploadImages godoc
// @Summary      Upload post images (max 5)
// @Tags         me
// @Accept       multipart/form-data
// @Produce      json
// @Security     BearerAuth
// @Param        images formData file true "Image files (jpg, png, gif, webp), max 5"
// @Success      201  {object}  utils.BaseResponse[UploadImagesResponse]
// @Router       /me/images [post]
func (ctrl *Controller) UploadImages(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	form, err := c.MultipartForm()
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid multipart form")
	}
	resp, err := ctrl.service.UploadImages(c.Request.Context(), userID, form.File["images"])
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Create godoc
// @Summary      Create a post
// @Tags         me
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body CreatePostRequest true "Create Post"
// @Success      201  {object}  utils.BaseResponse[PostResponse]
// @Router       /me [post]
func (ctrl *Controller) Create(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[CreatePostRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Create(userID, req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Feed godoc
// @Summary      Feed: public posts + own posts + friends' friend-only posts (keyset cursor)
// @Tags         me
// @Produce      json
// @Security     BearerAuth
// @Param        limit query int false "Page size"
// @Param        cursor query string false "Opaque keyset cursor from previous page's nextCursor"
// @Param        filter query string false "Set to 'tagged' (posts with any @mention), 'mentions' (posts mentioning viewer) or 'media' (posts with images)"
// @Success      200  {object}  utils.BaseResponse[PostFeedResponse]
// @Router       /me [get]
func (ctrl *Controller) Feed(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	cursor := c.Query("cursor")
	filter := c.Query("filter")

	resp, err := ctrl.service.Feed(userID, filter, cursor, limit)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListMine godoc
// @Summary      List my own posts (public + private)
// @Tags         me
// @Produce      json
// @Security     BearerAuth
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[PostListResponse]
// @Router       /me/mine [get]
func (ctrl *Controller) ListMine(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListMine(userID, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListByUser godoc
// @Summary      List a user's posts (visibility-aware)
// @Tags         me
// @Produce      json
// @Security     BearerAuth
// @Param        userId path string true "User ID"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[PostListResponse]
// @Router       /me/users/{userId} [get]
func (ctrl *Controller) ListByUser(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	authorID, err := utils.ParseUUIDParam(c, "userId", "invalid user id")
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListByUser(userID, authorID, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// GetPost godoc
// @Summary      Get post detail
// @Tags         me
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Post ID"
// @Success      200  {object}  utils.BaseResponse[PostResponse]
// @Router       /me/{id} [get]
func (ctrl *Controller) GetPost(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	id, err := parseID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.GetByID(userID, id)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// UpdatePost godoc
// @Summary      Update own post
// @Tags         me
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Post ID"
// @Param        request body UpdatePostRequest true "Update Post"
// @Success      200  {object}  utils.BaseResponse[PostResponse]
// @Router       /me/{id} [put]
func (ctrl *Controller) UpdatePost(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	id, err := parseID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[UpdatePostRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Update(userID, id, req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// DeletePost godoc
// @Summary      Delete own post (hide via enabled flag)
// @Tags         me
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Post ID"
// @Success      200  {object}  map[string]string
// @Router       /me/{id} [delete]
func (ctrl *Controller) DeletePost(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	id, err := parseID(c)
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Delete(userID, id); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "post deleted"}, nil
}

// AddComment godoc
// @Summary      Add a comment to a post
// @Tags         me
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Post ID"
// @Param        request body CreateCommentRequest true "Comment"
// @Success      201  {object}  utils.BaseResponse[CommentResponse]
// @Router       /me/{id}/comments [post]
func (ctrl *Controller) AddComment(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	id, err := parseID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[CreateCommentRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.AddComment(userID, id, req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListComments godoc
// @Summary      List comments of a post
// @Tags         me
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Post ID"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[CommentListResponse]
// @Router       /me/{id}/comments [get]
func (ctrl *Controller) ListComments(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	id, err := parseID(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListComments(userID, id, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// DeleteComment godoc
// @Summary      Delete a comment (comment author or post author)
// @Tags         me
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Post ID"
// @Param        commentId path string true "Comment ID"
// @Success      200  {object}  map[string]string
// @Router       /me/{id}/comments/{commentId} [delete]
func (ctrl *Controller) DeleteComment(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	id, err := parseID(c)
	if err != nil {
		return nil, err
	}
	commentID, err := utils.ParseUUIDParam(c, "commentId", "invalid comment id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.DeleteComment(userID, id, commentID); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "comment deleted"}, nil
}

// React godoc
// @Summary      Like or dislike a post (same reaction again removes it)
// @Tags         me
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Post ID"
// @Param        request body ReactRequest true "Reaction"
// @Success      200  {object}  utils.BaseResponse[PostResponse]
// @Router       /me/{id}/react [post]
func (ctrl *Controller) React(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	id, err := parseID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[ReactRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.React(userID, id, req.Type)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return utils.NewHandlerResult(resp, http.StatusOK), nil
}

// RemoveReaction godoc
// @Summary      Remove your reaction from a post
// @Tags         me
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Post ID"
// @Success      200  {object}  utils.BaseResponse[PostResponse]
// @Router       /me/{id}/react [delete]
func (ctrl *Controller) RemoveReaction(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	id, err := parseID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.RemoveReaction(userID, id)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return utils.NewHandlerResult(resp, http.StatusOK), nil
}

// Likers godoc
// @Summary      List users who liked a post
// @Tags         me
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Post ID"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[LikerListResponse]
// @Router       /me/{id}/likers [get]
func (ctrl *Controller) Likers(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	id, err := parseID(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.Likers(userID, id, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
