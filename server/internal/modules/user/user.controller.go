package user

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
	return &Controller{
		service: service,
		logger:  logger.Named("[user_controller]"),
	}
}

// GetUserInfo godoc
// @Summary      Get user public info
// @Description  Get public profile by user ID (UUID) or username, including online status and relationship
// @Tags         user
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "User ID (UUID) or username"
// @Success      200  {object}  UserPublicProfileSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /user/{id} [get]
func (ctrl *Controller) GetUserInfo(c *gin.Context) (interface{}, error) {
	callerID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	identifier := c.Param("id")

	var profile *UserPublicProfileResponse
	if targetID, parseErr := uuid.Parse(identifier); parseErr == nil {
		profile, err = ctrl.service.GetPublicProfile(callerID, targetID)
	} else {
		profile, err = ctrl.service.GetPublicProfileByUsername(callerID, identifier)
	}
	if err != nil {
		return nil, utils.ServiceError(err)
	}

	return profile, nil
}

// Kiss godoc
// @Summary      Send a kiss to a user
// @Description  Increment the target user's kiss count by one and return the new total
// @Tags         user
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "User ID (UUID)"
// @Success      200  {object}  KissSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /user/{id}/kiss [post]
func (ctrl *Controller) Kiss(c *gin.Context) (interface{}, error) {
	callerID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	targetID, err := utils.ParseUUIDParam(c, "id", "invalid user ID")
	if err != nil {
		return nil, err
	}

	result, err := ctrl.service.Kiss(callerID, targetID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}

	return result, nil
}

// Follow godoc
// @Summary      Follow a user
// @Description  Follow the target user (idempotent) and return the new follower count
// @Tags         user
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "User ID (UUID)"
// @Success      200  {object}  FollowSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /user/{id}/follow [post]
func (ctrl *Controller) Follow(c *gin.Context) (interface{}, error) {
	callerID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	targetID, err := utils.ParseUUIDParam(c, "id", "invalid user ID")
	if err != nil {
		return nil, err
	}

	result, err := ctrl.service.Follow(callerID, targetID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}

	return result, nil
}

// Unfollow godoc
// @Summary      Unfollow a user
// @Description  Stop following the target user (idempotent) and return the new follower count
// @Tags         user
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "User ID (UUID)"
// @Success      200  {object}  FollowSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Router       /user/{id}/follow [delete]
func (ctrl *Controller) Unfollow(c *gin.Context) (interface{}, error) {
	callerID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	targetID, err := utils.ParseUUIDParam(c, "id", "invalid user ID")
	if err != nil {
		return nil, err
	}

	result, err := ctrl.service.Unfollow(callerID, targetID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}

	return result, nil
}

// GetFollowers godoc
// @Summary      List a user's followers
// @Description  Paginated list of users that follow the target user
// @Tags         user
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "User ID (UUID)"
// @Param        limit query int false "Limit results" default(20)
// @Param        offset query int false "Offset" default(0)
// @Success      200  {object}  FollowListSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Router       /user/{id}/followers [get]
func (ctrl *Controller) GetFollowers(c *gin.Context) (interface{}, error) {
	callerID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	targetID, err := utils.ParseUUIDParam(c, "id", "invalid user ID")
	if err != nil {
		return nil, err
	}

	var q FollowListQuery
	if err := c.ShouldBindQuery(&q); err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, err.Error())
	}
	if q.Limit == 0 {
		q.Limit = 20
	}

	result, err := ctrl.service.ListFollowers(callerID, targetID, q.Limit, q.Offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}

	return result, nil
}

// GetFollowing godoc
// @Summary      List users a user is following
// @Description  Paginated list of users that the target user follows
// @Tags         user
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "User ID (UUID)"
// @Param        limit query int false "Limit results" default(20)
// @Param        offset query int false "Offset" default(0)
// @Success      200  {object}  FollowListSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Router       /user/{id}/following [get]
func (ctrl *Controller) GetFollowing(c *gin.Context) (interface{}, error) {
	callerID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	targetID, err := utils.ParseUUIDParam(c, "id", "invalid user ID")
	if err != nil {
		return nil, err
	}

	var q FollowListQuery
	if err := c.ShouldBindQuery(&q); err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, err.Error())
	}
	if q.Limit == 0 {
		q.Limit = 20
	}

	result, err := ctrl.service.ListFollowing(callerID, targetID, q.Limit, q.Offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}

	return result, nil
}

// GetMyVisitors godoc
// @Summary      List users who viewed my profile
// @Description  Paginated list of users who recently viewed the authenticated user's profile, most recent first
// @Tags         user
// @Produce      json
// @Security     BearerAuth
// @Param        limit query int false "Limit results" default(20)
// @Param        offset query int false "Offset" default(0)
// @Success      200  {object}  VisitorListSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Router       /user/me/visitors [get]
func (ctrl *Controller) GetMyVisitors(c *gin.Context) (interface{}, error) {
	meID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	var q FollowListQuery
	if err := c.ShouldBindQuery(&q); err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, err.Error())
	}
	if q.Limit == 0 {
		q.Limit = 20
	}

	result, err := ctrl.service.GetMyVisitors(meID, q.Limit, q.Offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}

	return result, nil
}

// GetPresenceBatch godoc
// @Summary      Get presence status for multiple users
// @Description  Returns online status and last active time for the given user IDs (reads from Redis cache, no DB hit)
// @Tags         user
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body PresenceBatchRequest true "User IDs"
// @Success      200  {object}  PresenceBatchSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Router       /user/presence [post]
func (ctrl *Controller) GetPresenceBatch(c *gin.Context) (interface{}, error) {
	if _, err := utils.RequireUserID(c); err != nil {
		return nil, err
	}

	req, err := utils.BindJSON[PresenceBatchRequest](c)
	if err != nil {
		return nil, err
	}

	return ctrl.service.GetPresenceBatch(req.UserIds), nil
}

// GetProfile godoc
// @Summary      Get user profile
// @Description  Get authenticated user's profile information
// @Tags         user
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  UserProfileSuccessResponse
// @Failure      401  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /user/me [get]
func (ctrl *Controller) GetProfile(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		ctrl.logger.Warnw("User not authenticated",
			"path", c.Request.URL.Path,
			"method", c.Request.Method,
			"ip", c.ClientIP(),
		)
		return nil, err
	}

	ctrl.logger.Infow("Getting user profile",
		"user_id", userID,
		"path", c.Request.URL.Path,
	)

	profile, err := ctrl.service.GetProfile(userID)
	if err != nil {
		ctrl.logger.Errorw("Failed to get user profile",
			"user_id", userID,
			"error", err.Error(),
		)
		return nil, utils.ServiceError(err)
	}

	ctrl.logger.Infow("User profile retrieved successfully",
		"user_id", userID,
		"username", profile.Username,
	)

	return profile, nil
}

// UpdateProfile godoc
// @Summary      Update user profile
// @Description  Update authenticated user's profile information
// @Tags         user
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body UpdateProfileRequest true "Update Profile Request"
// @Success      200  {object}  UserProfileSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /user/me [put]
func (ctrl *Controller) UpdateProfile(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		ctrl.logger.Warnw("User not authenticated",
			"path", c.Request.URL.Path,
			"method", c.Request.Method,
			"ip", c.ClientIP(),
		)
		return nil, err
	}

	var req UpdateProfileRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		ctrl.logger.Warnw("Invalid update profile request",
			"user_id", userID,
			"error", err.Error(),
		)
		return nil, utils.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	ctrl.logger.Infow("Updating user profile",
		"user_id", userID,
	)

	profile, err := ctrl.service.UpdateProfile(userID, &req)
	if err != nil {
		ctrl.logger.Errorw("Failed to update user profile",
			"user_id", userID,
			"error", err.Error(),
		)
		return nil, utils.ServiceError(err)
	}

	ctrl.logger.Infow("User profile updated successfully",
		"user_id", userID,
		"username", profile.Username,
	)

	return profile, nil
}

// SearchUsers godoc
// @Summary      Search users
// @Description  Search users by username or full name
// @Tags         user
// @Produce      json
// @Security     BearerAuth
// @Param        q query string true "Search query"
// @Param        limit query int false "Limit results" default(20)
// @Success      200  {object}  SearchUsersSuccessResponse
// @Failure      401  {object}  utils.APIError
// @Router       /user/search [get]
func (ctrl *Controller) SearchUsers(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		ctrl.logger.Warnw("User not authenticated",
			"path", c.Request.URL.Path,
			"method", c.Request.Method,
			"ip", c.ClientIP(),
		)
		return nil, err
	}

	var q SearchUsersQuery
	if err := c.ShouldBindQuery(&q); err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, err.Error())
	}
	if q.Limit == 0 {
		q.Limit = 20
	}

	ctrl.logger.Infow("Searching users",
		"user_id", userID,
		"query", q.Q,
		"limit", q.Limit,
	)

	results, err := ctrl.service.SearchUsers(q.Q, q.Limit, userID)
	if err != nil {
		ctrl.logger.Errorw("Failed to search users",
			"user_id", userID,
			"query", q.Q,
			"error", err.Error(),
		)
		return nil, utils.ServiceError(err)
	}

	ctrl.logger.Infow("User search completed",
		"user_id", userID,
		"query", q.Q,
		"results_count", results.Total,
	)

	return results, nil
}

// Upload godoc
// @Summary      Upload image
// @Description  Upload image to MinIO and get URL (does not update user profile)
// @Tags         upload
// @Accept       multipart/form-data
// @Produce      json
// @Security     BearerAuth
// @Param        file formData file true "Image file (jpg, png, gif, webp)"
// @Success      200  {object}  UploadAvatarSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      401  {object}  utils.APIError
// @Failure      413  {object}  utils.APIError "File too large"
// @Failure      500  {object}  utils.APIError
// @Router       /user/upload [post]
func (ctrl *Controller) Upload(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		ctrl.logger.Warnw("User not authenticated",
			"path", c.Request.URL.Path,
			"method", c.Request.Method,
			"ip", c.ClientIP(),
		)
		return nil, err
	}

	file, header, err := c.Request.FormFile("file")
	if err != nil {
		ctrl.logger.Warnw("Failed to get file from request",
			"user_id", userID,
			"error", err.Error(),
		)
		return nil, utils.NewHTTPError(http.StatusBadRequest, "file is required")
	}
	defer file.Close()

	const maxFileSize = 5 * 1024 * 1024
	if header.Size > maxFileSize {
		ctrl.logger.Warnw("File too large",
			"user_id", userID,
			"size", header.Size,
			"max_size", maxFileSize,
		)
		return nil, utils.NewHTTPError(http.StatusRequestEntityTooLarge, "file size must not exceed 5MB")
	}

	ctrl.logger.Infow("Uploading image",
		"user_id", userID,
		"filename", header.Filename,
		"size", header.Size,
	)

	result, err := ctrl.service.UploadImage(c.Request.Context(), userID, file, header.Filename)
	if err != nil {
		ctrl.logger.Errorw("Failed to upload image",
			"user_id", userID,
			"error", err.Error(),
		)
		return nil, utils.ServiceError(err)
	}

	ctrl.logger.Infow("Image uploaded successfully",
		"user_id", userID,
		"url", result.SecureURL,
	)

	return result, nil
}
