package adminauth

import (
	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/utils"
	"net/http"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{
		service: service,
		logger:  logger.Named("[admin_auth_controller]"),
	}
}

// Login godoc
// @Summary      Admin login
// @Description  Authenticate an admin account and return access + refresh tokens
// @Tags         admin-auth
// @Accept       json
// @Produce      json
// @Param        request body LoginRequest true "Admin Login Request"
// @Success      200  {object}  utils.BaseResponse[LoginResponse]
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Router       /admin/auth/login [post]
func (ctrl *Controller) Login(c *gin.Context) (interface{}, error) {
	var req LoginRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	resp, err := ctrl.service.Login(&req, c.ClientIP())
	if err != nil {
		return nil, utils.NewHTTPError(utils.HTTPStatusFromError(err), err.Error())
	}

	return utils.NewHandlerResult(resp, http.StatusOK), nil
}

// Refresh godoc
// @Summary      Refresh admin token
// @Description  Exchange a valid admin refresh token for a new token pair
// @Tags         admin-auth
// @Accept       json
// @Produce      json
// @Param        request body RefreshTokenRequest true "Refresh Token Request"
// @Success      200  {object}  utils.BaseResponse[RefreshTokenResponse]
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Router       /admin/auth/refresh [post]
func (ctrl *Controller) Refresh(c *gin.Context) (interface{}, error) {
	var req RefreshTokenRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	resp, err := ctrl.service.RefreshToken(req.RefreshToken, c.ClientIP())
	if err != nil {
		return nil, utils.NewHTTPError(utils.HTTPStatusFromError(err), err.Error())
	}

	return utils.NewHandlerResult(resp, http.StatusOK), nil
}

// Me godoc
// @Summary      Current admin profile
// @Description  Return the authenticated admin's profile
// @Tags         admin-auth
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[AdminDTO]
// @Failure      401  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Router       /admin/auth/me [get]
func (ctrl *Controller) Me(c *gin.Context) (interface{}, error) {
	adminID, ok := middleware.GetAdminID(c)
	if !ok {
		return nil, utils.NewHTTPError(http.StatusUnauthorized, "unauthorized")
	}

	resp, err := ctrl.service.GetByID(adminID)
	if err != nil {
		return nil, utils.NewHTTPError(utils.HTTPStatusFromError(err), err.Error())
	}

	return resp, nil
}
