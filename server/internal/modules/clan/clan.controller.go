package clan

import (
	"net/http"

	"ola-chat-server/internal/modules/me"
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
	return &Controller{service: service, logger: logger.Named("[clan_controller]")}
}

func parseClanID(c *gin.Context) (uuid.UUID, error) {
	return utils.ParseUUIDParam(c, "id", "invalid clan id")
}

// CheckName godoc
// @Summary      Check if a clan name is available (returns preview when taken)
// @Tags         clan
// @Produce      json
// @Security     BearerAuth
// @Param        name query string true "Clan name (lowercase letters and digits, 2-32 chars, optional # prefix)"
// @Success      200  {object}  utils.BaseResponse[CheckNameResponse]
// @Router       /clans/check-name [get]
func (ctrl *Controller) CheckName(c *gin.Context) (interface{}, error) {
	if _, err := utils.RequireUserID(c); err != nil {
		return nil, err
	}
	resp, err := ctrl.service.CheckName(c.Query("name"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Create godoc
// @Summary      Create a clan (costs Ken)
// @Tags         clan
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body CreateClanRequest true "Create clan"
// @Success      201  {object}  utils.BaseResponse[ClanResponse]
// @Router       /clans [post]
func (ctrl *Controller) Create(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[CreateClanRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Create(userID, req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Mine godoc
// @Summary      List clans the current user has joined
// @Tags         clan
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[[]ClanResponse]
// @Router       /clans/mine [get]
func (ctrl *Controller) Mine(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Mine(userID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// GetByID godoc
// @Summary      Get clan info by id (increments visit count once per viewer per 6h)
// @Tags         clan
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Success      200  {object}  utils.BaseResponse[ClanResponse]
// @Router       /clans/{id} [get]
func (ctrl *Controller) GetByID(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	clanID, err := parseClanID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.GetByID(userID, clanID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// GetByHandle godoc
// @Summary      Get clan info by handle (#name without the #)
// @Tags         clan
// @Produce      json
// @Security     BearerAuth
// @Param        handle path string true "Clan handle"
// @Success      200  {object}  utils.BaseResponse[ClanResponse]
// @Router       /clans/by-handle/{handle} [get]
func (ctrl *Controller) GetByHandle(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.GetByHandle(userID, c.Param("handle"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Update godoc
// @Summary      Update clan description/policy (owner only)
// @Tags         clan
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Param        request body UpdateClanRequest true "Update clan"
// @Success      200  {object}  utils.BaseResponse[ClanResponse]
// @Router       /clans/{id} [patch]
func (ctrl *Controller) Update(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	clanID, err := parseClanID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[UpdateClanRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Update(userID, clanID, req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// UploadAvatar godoc
// @Summary      Upload clan avatar (owner only)
// @Tags         clan
// @Accept       multipart/form-data
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Param        image formData file true "Image file (jpg, png, gif, webp)"
// @Success      200  {object}  utils.BaseResponse[UploadClanImageResponse]
// @Router       /clans/{id}/avatar [post]
func (ctrl *Controller) UploadAvatar(c *gin.Context) (interface{}, error) {
	return ctrl.uploadImage(c, "avatar")
}

// UploadCover godoc
// @Summary      Upload clan cover (owner only)
// @Tags         clan
// @Accept       multipart/form-data
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Param        image formData file true "Image file (jpg, png, gif, webp)"
// @Success      200  {object}  utils.BaseResponse[UploadClanImageResponse]
// @Router       /clans/{id}/cover [post]
func (ctrl *Controller) UploadCover(c *gin.Context) (interface{}, error) {
	return ctrl.uploadImage(c, "cover")
}

func (ctrl *Controller) uploadImage(c *gin.Context, field string) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	clanID, err := parseClanID(c)
	if err != nil {
		return nil, err
	}
	fileHeader, err := c.FormFile("image")
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "image file is required")
	}

	var resp *UploadClanImageResponse
	if field == "avatar" {
		resp, err = ctrl.service.UploadAvatar(c.Request.Context(), userID, clanID, fileHeader)
	} else {
		resp, err = ctrl.service.UploadCover(c.Request.Context(), userID, clanID, fileHeader)
	}
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Join godoc
// @Summary      Join (follow) a clan
// @Tags         clan
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Success      200  {object}  utils.BaseResponse[ClanResponse]
// @Router       /clans/{id}/join [post]
func (ctrl *Controller) Join(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	clanID, err := parseClanID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Join(userID, clanID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Leave godoc
// @Summary      Leave a clan (owner cannot leave)
// @Tags         clan
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Success      200  {object}  utils.BaseResponse[ClanResponse]
// @Router       /clans/{id}/join [delete]
func (ctrl *Controller) Leave(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	clanID, err := parseClanID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Leave(userID, clanID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Members godoc
// @Summary      List clan members (staff first)
// @Tags         clan
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Param        verified query bool false "Only verified members"
// @Success      200  {object}  utils.BaseResponse[MemberListResponse]
// @Router       /clans/{id}/members [get]
func (ctrl *Controller) Members(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	clanID, err := parseClanID(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	verifiedOnly := c.Query("verified") == "true"
	resp, err := ctrl.service.Members(userID, clanID, verifiedOnly, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// AssignRole godoc
// @Summary      Assign deputy/ambassador by username (owner only)
// @Tags         clan
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Param        request body AssignRoleRequest true "Assign role"
// @Success      200  {object}  utils.BaseResponse[ClanResponse]
// @Router       /clans/{id}/roles [put]
func (ctrl *Controller) AssignRole(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	clanID, err := parseClanID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[AssignRoleRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.AssignRole(userID, clanID, req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// RevokeRole godoc
// @Summary      Revoke current deputy/ambassador (owner only)
// @Tags         clan
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Param        role path string true "Role (deputy | ambassador)"
// @Success      200  {object}  utils.BaseResponse[ClanResponse]
// @Router       /clans/{id}/roles/{role} [delete]
func (ctrl *Controller) RevokeRole(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	clanID, err := parseClanID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.RevokeRole(userID, clanID, c.Param("role"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Verify godoc
// @Summary      Verify a member by username (owner only)
// @Tags         clan
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Param        request body UsernameRequest true "Member username"
// @Success      200  {object}  utils.BaseResponse[MessageResponse]
// @Router       /clans/{id}/verify [post]
func (ctrl *Controller) Verify(c *gin.Context) (interface{}, error) {
	return ctrl.setVerified(c, true)
}

// Unverify godoc
// @Summary      Unverify a member by username (owner only)
// @Tags         clan
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Param        request body UsernameRequest true "Member username"
// @Success      200  {object}  utils.BaseResponse[MessageResponse]
// @Router       /clans/{id}/verify [delete]
func (ctrl *Controller) Unverify(c *gin.Context) (interface{}, error) {
	return ctrl.setVerified(c, false)
}

func (ctrl *Controller) setVerified(c *gin.Context, verified bool) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	clanID, err := parseClanID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[UsernameRequest](c)
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.SetVerified(userID, clanID, req.Username, verified); err != nil {
		return nil, utils.ServiceError(err)
	}
	return MessageResponse{Message: "ok"}, nil
}

// Bans godoc
// @Summary      List banned users (owner/deputy only)
// @Tags         clan
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[BanListResponse]
// @Router       /clans/{id}/bans [get]
func (ctrl *Controller) Bans(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	clanID, err := parseClanID(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.Bans(userID, clanID, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Ban godoc
// @Summary      Ban a user from the clan by username (owner/deputy only, also kicks)
// @Tags         clan
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Param        request body UsernameRequest true "Username to ban"
// @Success      200  {object}  utils.BaseResponse[MessageResponse]
// @Router       /clans/{id}/bans [post]
func (ctrl *Controller) Ban(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	clanID, err := parseClanID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[UsernameRequest](c)
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Ban(userID, clanID, req.Username); err != nil {
		return nil, utils.ServiceError(err)
	}
	return MessageResponse{Message: "ok"}, nil
}

// Unban godoc
// @Summary      Unban a user (owner/deputy only)
// @Tags         clan
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Param        userId path string true "User ID"
// @Success      200  {object}  utils.BaseResponse[MessageResponse]
// @Router       /clans/{id}/bans/{userId} [delete]
func (ctrl *Controller) Unban(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	clanID, err := parseClanID(c)
	if err != nil {
		return nil, err
	}
	targetID, err := utils.ParseUUIDParam(c, "userId", "invalid user id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Unban(userID, clanID, targetID); err != nil {
		return nil, utils.ServiceError(err)
	}
	return MessageResponse{Message: "ok"}, nil
}

// Posts godoc
// @Summary      Clan feed (pinned Me Top separate, keyset cursor)
// @Tags         clan
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Param        limit query int false "Page size"
// @Param        cursor query string false "Opaque keyset cursor"
// @Success      200  {object}  utils.BaseResponse[ClanPostsResponse]
// @Router       /clans/{id}/me [get]
func (ctrl *Controller) Posts(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	clanID, err := parseClanID(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	resp, err := ctrl.service.Posts(userID, clanID, c.Query("cursor"), limit)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// CreatePost godoc
// @Summary      Create a Me post inside the clan
// @Tags         clan
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Param        request body me.CreateMeRequest true "Post content"
// @Success      201  {object}  utils.BaseResponse[me.MeResponse]
// @Router       /clans/{id}/me [post]
func (ctrl *Controller) CreatePost(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	clanID, err := parseClanID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[me.CreateMeRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.CreatePost(userID, clanID, req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Pin godoc
// @Summary      Set a clan post as Me Top (owner/deputy only)
// @Tags         clan
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Param        request body PinRequest true "Post to pin"
// @Success      200  {object}  utils.BaseResponse[MessageResponse]
// @Router       /clans/{id}/pin [post]
func (ctrl *Controller) Pin(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	clanID, err := parseClanID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[PinRequest](c)
	if err != nil {
		return nil, err
	}
	postID, err := uuid.Parse(req.PostID)
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid post id")
	}
	if err := ctrl.service.Pin(userID, clanID, postID); err != nil {
		return nil, utils.ServiceError(err)
	}
	return MessageResponse{Message: "ok"}, nil
}

// Unpin godoc
// @Summary      Remove clan Me Top (owner/deputy only)
// @Tags         clan
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Success      200  {object}  utils.BaseResponse[MessageResponse]
// @Router       /clans/{id}/pin [delete]
func (ctrl *Controller) Unpin(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	clanID, err := parseClanID(c)
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Unpin(userID, clanID); err != nil {
		return nil, utils.ServiceError(err)
	}
	return MessageResponse{Message: "ok"}, nil
}

// DeletePost godoc
// @Summary      Moderation: disable a clan post (owner/deputy only)
// @Tags         clan
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Param        postId path string true "Post ID"
// @Success      200  {object}  utils.BaseResponse[MessageResponse]
// @Router       /clans/{id}/me/{postId} [delete]
func (ctrl *Controller) DeletePost(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	clanID, err := parseClanID(c)
	if err != nil {
		return nil, err
	}
	postID, err := utils.ParseUUIDParam(c, "postId", "invalid post id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.DeletePost(userID, clanID, postID); err != nil {
		return nil, utils.ServiceError(err)
	}
	return MessageResponse{Message: "ok"}, nil
}

// DeletePostsByUser godoc
// @Summary      Moderation: disable all posts by a user in this clan (owner/deputy only)
// @Tags         clan
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Clan ID"
// @Param        userId path string true "Author user ID"
// @Success      200  {object}  utils.BaseResponse[MessageResponse]
// @Router       /clans/{id}/me/by-user/{userId} [delete]
func (ctrl *Controller) DeletePostsByUser(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	clanID, err := parseClanID(c)
	if err != nil {
		return nil, err
	}
	authorID, err := utils.ParseUUIDParam(c, "userId", "invalid user id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.DeletePostsByUser(userID, clanID, authorID); err != nil {
		return nil, utils.ServiceError(err)
	}
	return MessageResponse{Message: "ok"}, nil
}
