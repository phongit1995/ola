package auth

import (
	"net/http"
	"ola-chat-server/internal/utils"
	"strings"

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
		logger:  logger.Named("[auth_controller]"),
	}
}

// Register godoc
// @Summary      Register a new user
// @Description  Register a new user account
// @Tags         auth
// @Accept       json
// @Produce      json
// @Param        request body RegisterRequest true "Register Request"
// @Success      201  {object}  RegisterSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      409  {object}  utils.APIError
// @Router       /auth/register [post]
func (ctrl *Controller) Register(c *gin.Context) (interface{}, error) {
	var req RegisterRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		ctrl.logger.Warnw("Invalid register request",
			"error", err.Error(),
			"ip", c.ClientIP(),
		)
		return nil, utils.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	ctrl.logger.Infow("User registration attempt",
		"username", req.Username,
		"ip", c.ClientIP(),
	)

	resp, err := ctrl.service.Register(&req)
	if err != nil {
		ctrl.logger.Warnw("Registration failed",
			"username", req.Username,
			"error", err.Error(),
		)
		return nil, utils.ServiceError(err)
	}

	ctrl.logger.Infow("User registered successfully",
		"user_id", resp.User.ID,
		"username", resp.User.Username,
	)

	return resp, nil
}

// ChangePassword godoc
// @Summary      Change password
// @Description  Change the authenticated user's password
// @Tags         auth
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body ChangePasswordRequest true "Change Password Request"
// @Success      200  {object}  ChangePasswordSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Router       /auth/change-password [post]
func (ctrl *Controller) ChangePassword(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	req, err := utils.BindJSON[ChangePasswordRequest](c)
	if err != nil {
		return nil, err
	}

	if err := ctrl.service.ChangePassword(userID, req); err != nil {
		return nil, utils.ServiceError(err)
	}

	return &ChangePasswordResponse{Message: "Password changed successfully"}, nil
}

// Login godoc
// @Summary      Login user
// @Description  Authenticate user and get access token
// @Tags         auth
// @Accept       json
// @Produce      json
// @Param        request body LoginRequest true "Login Request"
// @Success      200  {object}  AuthSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Router       /auth/login [post]
func (ctrl *Controller) Login(c *gin.Context) (interface{}, error) {
	var req LoginRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		ctrl.logger.Warnw("Invalid login request",
			"error", err.Error(),
			"ip", c.ClientIP(),
		)
		return nil, utils.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	ctrl.logger.Infow("User login attempt",
		"username", req.Username,
		"ip", c.ClientIP(),
	)

	resp, err := ctrl.service.Login(&req, c.ClientIP(), c.GetHeader("User-Agent"))
	if err != nil {
		ctrl.logger.Warnw("Login failed",
			"username", req.Username,
			"error", err.Error(),
			"ip", c.ClientIP(),
		)
		return nil, utils.ServiceError(err)
	}

	ctrl.logger.Infow("User logged in successfully",
		"user_id", resp.User.ID,
		"username", resp.User.Username,
		"ip", c.ClientIP(),
	)

	return resp, nil
}

// Refresh godoc
// @Summary      Refresh access token
// @Description  Exchange a valid refresh token for a new access token (rotates the refresh token)
// @Tags         auth
// @Accept       json
// @Produce      json
// @Param        request body RefreshTokenRequest true "Refresh Token Request"
// @Success      200 {object} utils.BaseResponse[RefreshTokenResponse]
// @Failure      400 {object} utils.APIError
// @Failure      401 {object} utils.APIError
// @Router       /auth/refresh [post]
func (ctrl *Controller) Refresh(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[RefreshTokenRequest](c)
	if err != nil {
		return nil, err
	}

	resp, err := ctrl.service.RefreshToken(req.RefreshToken, c.ClientIP(), c.GetHeader("User-Agent"))
	if err != nil {
		ctrl.logger.Warnw("Refresh failed", "error", err.Error(), "ip", c.ClientIP())
		return nil, utils.ServiceError(err)
	}

	return resp, nil
}

// Logout godoc
// @Summary      Logout (invalidate token)
// @Description  Blacklist the caller's JWT so it cannot be used again before its natural expiry
// @Tags         auth
// @Produce      json
// @Security     BearerAuth
// @Success      200 {object} map[string]string
// @Failure      401 {object} utils.APIError
// @Router       /auth/logout [post]
func (ctrl *Controller) Logout(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	authHeader := c.GetHeader("Authorization")
	parts := strings.Split(authHeader, " ")
	token := authHeader
	if len(parts) == 2 && parts[0] == "Bearer" {
		token = parts[1]
	}

	if err := ctrl.service.Logout(token); err != nil {
		return nil, utils.ServiceError(err)
	}

	ctrl.logger.Infow("User logged out", "user_id", userID)
	return map[string]string{"message": "Logged out successfully"}, nil
}
