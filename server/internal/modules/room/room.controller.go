package room

import (
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
	return &Controller{service: service, logger: logger.Named("[room_controller]")}
}

// BrowseRooms godoc
// @Summary      Browse public rooms (memberCount = online members)
// @Tags         room
// @Produce      json
// @Security     BearerAuth
// @Param        q query string false "Search by name"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[RoomListResponse]
// @Router       /rooms [get]
func (ctrl *Controller) BrowseRooms(c *gin.Context) (interface{}, error) {
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListPublic(c.Request.Context(), c.Query("q"), limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// GetRoom godoc
// @Summary      Get room detail
// @Tags         room
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Room ID"
// @Success      200  {object}  utils.BaseResponse[RoomResponse]
// @Router       /rooms/{id} [get]
func (ctrl *Controller) GetRoom(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid room id")
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.GetByID(c.Request.Context(), id)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// RoomMembers godoc
// @Summary      List online members of a room
// @Tags         room
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Room ID"
// @Success      200  {object}  utils.BaseResponse[RoomMembersResponse]
// @Router       /rooms/{id}/members [get]
func (ctrl *Controller) RoomMembers(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid room id")
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.ListMembers(c.Request.Context(), id)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// JoinRoom godoc
// @Summary      Request to join a room (returns a short-lived ticket)
// @Description  Checks capacity; if not full, returns a single-use ticket (TTL 5s) to send with the socket room:join event
// @Tags         room
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Room ID"
// @Success      200  {object}  utils.BaseResponse[JoinRoomResponse]
// @Router       /rooms/{id}/join [post]
func (ctrl *Controller) JoinRoom(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	id, err := utils.ParseUUIDParam(c, "id", "invalid room id")
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.RequestJoin(c.Request.Context(), userID, id)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// SendRoomMessage godoc
// @Summary      Send a message to a room (must have joined via socket)
// @Tags         room
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Room ID"
// @Param        request body SendRoomMessageRequest true "Message"
// @Success      201  {object}  utils.BaseResponse[RoomMessageResponse]
// @Router       /rooms/{id}/messages [post]
func (ctrl *Controller) SendRoomMessage(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	id, err := utils.ParseUUIDParam(c, "id", "invalid room id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[SendRoomMessageRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.SendMessage(c.Request.Context(), userID, id, req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// DeleteRoomMessage godoc
// @Summary      Delete own room message (hard delete, sender only)
// @Tags         room
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Room ID"
// @Param        messageId path string true "Message ID"
// @Success      200  {object}  map[string]string
// @Router       /rooms/{id}/messages/{messageId} [delete]
func (ctrl *Controller) DeleteRoomMessage(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	id, err := utils.ParseUUIDParam(c, "id", "invalid room id")
	if err != nil {
		return nil, err
	}
	messageID := c.Param("messageId")
	if messageID == "" {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid message id")
	}
	if err := ctrl.service.DeleteMessage(c.Request.Context(), userID, id, messageID); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "message deleted"}, nil
}

// RoomMessages godoc
// @Summary      Get room message history
// @Tags         room
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Room ID"
// @Param        limit query int false "Page size (default 50, max 200)"
// @Param        before query string false "Cursor: message id (timeuuid)"
// @Success      200  {object}  utils.BaseResponse[RoomMessagesListResponse]
// @Router       /rooms/{id}/messages [get]
func (ctrl *Controller) RoomMessages(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid room id")
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 50, 200)
	resp, err := ctrl.service.GetMessages(c.Request.Context(), id, limit, c.Query("before"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
