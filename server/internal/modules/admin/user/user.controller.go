package adminuser

import (
	"ola-chat-server/internal/utils"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[admin_user_controller]")}
}

// ListUsers godoc
// @Summary      List users
// @Description  List users with pagination and optional search (admin only)
// @Tags         admin-user
// @Produce      json
// @Security     BearerAuth
// @Param        q      query string false "Search by username/full name/email"
// @Param        limit  query int    false "Page size (default 20, max 100)"
// @Param        offset query int    false "Offset (default 0)"
// @Success      200  {object}  utils.BaseResponse[ListUsersResponse]
// @Failure      401  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Router       /admin/users [get]
func (ctrl *Controller) ListUsers(c *gin.Context) (interface{}, error) {
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	q := c.Query("q")

	resp, err := ctrl.service.List(q, limit, offset)
	if err != nil {
		return nil, utils.NewHTTPError(utils.HTTPStatusFromError(err), err.Error())
	}
	return resp, nil
}

// GetUser godoc
// @Summary      Get user detail
// @Description  Get a single user by id (admin only)
// @Tags         admin-user
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "User ID"
// @Success      200  {object}  utils.BaseResponse[UserDetail]
// @Failure      401  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /admin/users/{id} [get]
func (ctrl *Controller) GetUser(c *gin.Context) (interface{}, error) {
	id, err := uuid.Parse(c.Param("id"))
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid user id")
	}

	resp, err := ctrl.service.GetByID(id)
	if err != nil {
		return nil, utils.NewHTTPError(utils.HTTPStatusFromError(err), err.Error())
	}
	return resp, nil
}

// UpdateStatus godoc
// @Summary      Ban/unban user
// @Description  Enable or disable a user account (admin only)
// @Tags         admin-user
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id      path string              true "User ID"
// @Param        request body UpdateStatusRequest true "Status Request"
// @Success      200  {object}  utils.BaseResponse[UserDetail]
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /admin/users/{id}/status [patch]
func (ctrl *Controller) UpdateStatus(c *gin.Context) (interface{}, error) {
	id, err := uuid.Parse(c.Param("id"))
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid user id")
	}

	var req UpdateStatusRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	resp, err := ctrl.service.SetStatus(id, *req.IsActive)
	if err != nil {
		return nil, utils.NewHTTPError(utils.HTTPStatusFromError(err), err.Error())
	}
	return resp, nil
}

// DeleteUser godoc
// @Summary      Delete user
// @Description  Soft-delete a user account (admin only)
// @Tags         admin-user
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "User ID"
// @Success      200  {object}  map[string]string
// @Failure      401  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /admin/users/{id} [delete]
func (ctrl *Controller) DeleteUser(c *gin.Context) (interface{}, error) {
	id, err := uuid.Parse(c.Param("id"))
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid user id")
	}

	if err := ctrl.service.Delete(id); err != nil {
		return nil, utils.NewHTTPError(utils.HTTPStatusFromError(err), err.Error())
	}
	return map[string]string{"message": "user deleted"}, nil
}
