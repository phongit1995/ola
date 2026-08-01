package adminauth

import (
	"net/http"
	"strings"
	"time"

	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

const (
	AdminRefreshCookieName = "ola_admin_refresh"
	adminAuthCookiePath    = "/api/v1/admin/auth"
)

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{
		service: service,
		logger:  logger.Named("[admin_auth_controller]"),
	}
}

// Login godoc
// @Summary      Admin login
// @Description  Authenticate an admin account, return an access token, and set the refresh token in an HttpOnly cookie
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

	resp, err := ctrl.service.Login(&req, c.ClientIP(), c.GetHeader("User-Agent"))
	if err != nil {
		return nil, ctrl.httpError(err)
	}
	ctrl.setRefreshCookie(c, resp.RefreshToken, resp.RefreshTokenExpiresAt)

	return utils.NewHandlerResult(resp, http.StatusOK), nil
}

// Refresh godoc
// @Summary      Refresh admin token
// @Description  Rotate the admin refresh token from its HttpOnly cookie and return a new access token
// @Tags         admin-auth
// @Produce      json
// @Success      200  {object}  utils.BaseResponse[RefreshTokenResponse]
// @Failure      401  {object}  utils.APIError
// @Router       /admin/auth/refresh [post]
func (ctrl *Controller) Refresh(c *gin.Context) (interface{}, error) {
	refreshToken, err := c.Cookie(AdminRefreshCookieName)
	if err != nil || refreshToken == "" {
		ctrl.clearRefreshCookie(c)
		return nil, utils.NewHTTPError(http.StatusUnauthorized, "refresh token cookie required")
	}

	resp, err := ctrl.service.RefreshToken(refreshToken, c.ClientIP(), c.GetHeader("User-Agent"))
	if err != nil {
		httpErr := ctrl.httpError(err)
		if httpErr.Status < http.StatusInternalServerError {
			ctrl.clearRefreshCookie(c)
		}
		return nil, httpErr
	}
	ctrl.setRefreshCookie(c, resp.RefreshToken, resp.RefreshTokenExpiresAt)

	return utils.NewHandlerResult(resp, http.StatusOK), nil
}

// Logout godoc
// @Summary      Admin logout
// @Description  Revoke the authenticated admin session
// @Tags         admin-auth
// @Produce      json
// @Security     BearerAuth
// @Success      200 {object} map[string]string
// @Failure      401 {object} utils.APIError
// @Router       /admin/auth/logout [post]
func (ctrl *Controller) Logout(c *gin.Context) (interface{}, error) {
	adminID, ok := middleware.GetAdminID(c)
	if !ok {
		return nil, utils.NewHTTPError(http.StatusUnauthorized, "unauthorized")
	}
	sessionID, ok := middleware.GetAdminSessionID(c)
	if !ok {
		return nil, utils.NewHTTPError(http.StatusUnauthorized, "unauthorized")
	}

	if err := ctrl.service.Logout(adminID, sessionID); err != nil {
		ctrl.clearRefreshCookie(c)
		return nil, ctrl.httpError(err)
	}
	ctrl.clearRefreshCookie(c)

	return map[string]string{"message": "logged out successfully"}, nil
}

// ChangePassword godoc
// @Summary      Change admin password
// @Description  Change the authenticated admin's password; revokes existing sessions
// @Tags         admin-auth
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body ChangePasswordRequest true "Change Password Request"
// @Success      200  {object}  map[string]string
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Router       /admin/auth/change-password [post]
func (ctrl *Controller) ChangePassword(c *gin.Context) (interface{}, error) {
	adminID, ok := middleware.GetAdminID(c)
	if !ok {
		return nil, utils.NewHTTPError(http.StatusUnauthorized, "unauthorized")
	}

	var req ChangePasswordRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	if err := ctrl.service.ChangePassword(adminID, &req); err != nil {
		return nil, ctrl.httpError(err)
	}
	ctrl.clearRefreshCookie(c)

	return map[string]string{"message": "password changed successfully"}, nil
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
		return nil, ctrl.httpError(err)
	}

	return resp, nil
}

func (ctrl *Controller) setRefreshCookie(c *gin.Context, token string, expiresAt time.Time) {
	maxAge := int(time.Until(expiresAt).Seconds())
	if maxAge < 1 {
		maxAge = 1
	}
	http.SetCookie(c.Writer, &http.Cookie{
		Name:     AdminRefreshCookieName,
		Value:    token,
		Path:     adminAuthCookiePath,
		Expires:  expiresAt,
		MaxAge:   maxAge,
		HttpOnly: true,
		Secure:   requestUsesHTTPS(c),
		SameSite: http.SameSiteStrictMode,
	})
}

func (ctrl *Controller) clearRefreshCookie(c *gin.Context) {
	http.SetCookie(c.Writer, &http.Cookie{
		Name:     AdminRefreshCookieName,
		Value:    "",
		Path:     adminAuthCookiePath,
		Expires:  time.Unix(1, 0),
		MaxAge:   -1,
		HttpOnly: true,
		Secure:   requestUsesHTTPS(c),
		SameSite: http.SameSiteStrictMode,
	})
}

func (ctrl *Controller) httpError(err error) *utils.HTTPError {
	if status, known := utils.KnownHTTPStatusFromMessage(err.Error()); known {
		return utils.NewHTTPError(status, err.Error())
	}
	ctrl.logger.Errorw("Admin auth operation failed", "error", err.Error())
	return utils.NewHTTPError(http.StatusInternalServerError, "internal server error")
}

func requestUsesHTTPS(c *gin.Context) bool {
	if c.Request == nil {
		return false
	}
	if c.Request.TLS != nil {
		return true
	}
	forwardedProto := strings.TrimSpace(strings.Split(c.GetHeader("X-Forwarded-Proto"), ",")[0])
	return strings.EqualFold(forwardedProto, "https")
}
