package room

import (
	"ola-chat-server/internal/middleware"
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
	return &Controller{service: service, logger: logger.Named("[room_controller]")}
}

func parseID(c *gin.Context) (uuid.UUID, error) {
	return uuid.Parse(c.Param("id"))
}

// CreateRoom godoc
// @Summary      Create room (admin)
// @Tags         admin-room
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body CreateRoomRequest true "Create Room"
// @Success      201  {object}  utils.BaseResponse[RoomResponse]
// @Router       /admin/rooms [post]
func (ctrl *Controller) CreateRoom(c *gin.Context) (interface{}, error) {
	adminID, ok := middleware.GetAdminID(c)
	if !ok {
		return nil, utils.NewHTTPError(http.StatusUnauthorized, "unauthorized")
	}
	var req CreateRoomRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, err.Error())
	}
	resp, err := ctrl.service.Create(adminID, &req)
	if err != nil {
		return nil, utils.NewHTTPError(utils.HTTPStatusFromError(err), err.Error())
	}
	return resp, nil
}

// ListRoomsAdmin godoc
// @Summary      List rooms (admin, includes disabled)
// @Tags         admin-room
// @Produce      json
// @Security     BearerAuth
// @Param        q query string false "Search by name"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[RoomListResponse]
// @Router       /admin/rooms [get]
func (ctrl *Controller) ListRoomsAdmin(c *gin.Context) (interface{}, error) {
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListAdmin(c.Query("q"), limit, offset)
	if err != nil {
		return nil, utils.NewHTTPError(utils.HTTPStatusFromError(err), err.Error())
	}
	return resp, nil
}

// UpdateRoom godoc
// @Summary      Update room (admin)
// @Tags         admin-room
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Room ID"
// @Param        request body UpdateRoomRequest true "Update Room"
// @Success      200  {object}  utils.BaseResponse[RoomResponse]
// @Router       /admin/rooms/{id} [patch]
func (ctrl *Controller) UpdateRoom(c *gin.Context) (interface{}, error) {
	id, err := parseID(c)
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid room id")
	}
	var req UpdateRoomRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, err.Error())
	}
	resp, err := ctrl.service.Update(id, &req)
	if err != nil {
		return nil, utils.NewHTTPError(utils.HTTPStatusFromError(err), err.Error())
	}
	return resp, nil
}

// DeleteRoom godoc
// @Summary      Delete room (admin)
// @Tags         admin-room
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Room ID"
// @Success      200  {object}  map[string]string
// @Router       /admin/rooms/{id} [delete]
func (ctrl *Controller) DeleteRoom(c *gin.Context) (interface{}, error) {
	id, err := parseID(c)
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid room id")
	}
	if err := ctrl.service.Delete(id); err != nil {
		return nil, utils.NewHTTPError(utils.HTTPStatusFromError(err), err.Error())
	}
	return map[string]string{"message": "room deleted"}, nil
}

// BrowseRooms godoc
// @Summary      Browse public rooms
// @Tags         room
// @Produce      json
// @Security     BearerAuth
// @Param        q query string false "Search by name"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[RoomListResponse]
// @Router       /rooms [get]
func (ctrl *Controller) BrowseRooms(c *gin.Context) (interface{}, error) {
	userID, _ := middleware.GetUserID(c)
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListPublic(userID, c.Query("q"), limit, offset)
	if err != nil {
		return nil, utils.NewHTTPError(utils.HTTPStatusFromError(err), err.Error())
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
	userID, _ := middleware.GetUserID(c)
	id, err := parseID(c)
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid room id")
	}
	resp, err := ctrl.service.GetByID(userID, id)
	if err != nil {
		return nil, utils.NewHTTPError(utils.HTTPStatusFromError(err), err.Error())
	}
	return resp, nil
}

// JoinRoom godoc
// @Summary      Join a room
// @Tags         room
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Room ID"
// @Success      200  {object}  utils.BaseResponse[RoomResponse]
// @Router       /rooms/{id}/join [post]
func (ctrl *Controller) JoinRoom(c *gin.Context) (interface{}, error) {
	userID, ok := middleware.GetUserID(c)
	if !ok {
		return nil, utils.NewHTTPError(http.StatusUnauthorized, "unauthorized")
	}
	id, err := parseID(c)
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid room id")
	}
	resp, err := ctrl.service.Join(userID, id)
	if err != nil {
		return nil, utils.NewHTTPError(utils.HTTPStatusFromError(err), err.Error())
	}
	return utils.NewHandlerResult(resp, http.StatusOK), nil
}

// LeaveRoom godoc
// @Summary      Leave a room
// @Tags         room
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Room ID"
// @Success      200  {object}  map[string]string
// @Router       /rooms/{id}/leave [post]
func (ctrl *Controller) LeaveRoom(c *gin.Context) (interface{}, error) {
	userID, ok := middleware.GetUserID(c)
	if !ok {
		return nil, utils.NewHTTPError(http.StatusUnauthorized, "unauthorized")
	}
	id, err := parseID(c)
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid room id")
	}
	if err := ctrl.service.Leave(userID, id); err != nil {
		return nil, utils.NewHTTPError(utils.HTTPStatusFromError(err), err.Error())
	}
	return utils.NewHandlerResult(map[string]string{"message": "left room"}, http.StatusOK), nil
}

// RoomMembers godoc
// @Summary      List room members
// @Tags         room
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Room ID"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[RoomMembersResponse]
// @Router       /rooms/{id}/members [get]
func (ctrl *Controller) RoomMembers(c *gin.Context) (interface{}, error) {
	id, err := parseID(c)
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid room id")
	}
	limit := utils.ParseLimit(c, 50, 200)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListMembers(id, limit, offset)
	if err != nil {
		return nil, utils.NewHTTPError(utils.HTTPStatusFromError(err), err.Error())
	}
	return resp, nil
}

// SendRoomMessage godoc
// @Summary      Send a message to a room
// @Tags         room
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Room ID"
// @Param        request body SendRoomMessageRequest true "Message"
// @Success      201  {object}  utils.BaseResponse[RoomMessageResponse]
// @Router       /rooms/{id}/messages [post]
func (ctrl *Controller) SendRoomMessage(c *gin.Context) (interface{}, error) {
	userID, ok := middleware.GetUserID(c)
	if !ok {
		return nil, utils.NewHTTPError(http.StatusUnauthorized, "unauthorized")
	}
	id, err := parseID(c)
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid room id")
	}
	var req SendRoomMessageRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, err.Error())
	}
	resp, err := ctrl.service.SendMessage(c.Request.Context(), userID, id, &req)
	if err != nil {
		return nil, utils.NewHTTPError(utils.HTTPStatusFromError(err), err.Error())
	}
	return resp, nil
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
	userID, ok := middleware.GetUserID(c)
	if !ok {
		return nil, utils.NewHTTPError(http.StatusUnauthorized, "unauthorized")
	}
	id, err := parseID(c)
	if err != nil {
		return nil, utils.NewHTTPError(http.StatusBadRequest, "invalid room id")
	}
	limit := utils.ParseLimit(c, 50, 200)
	resp, err := ctrl.service.GetMessages(userID, id, limit, c.Query("before"))
	if err != nil {
		return nil, utils.NewHTTPError(utils.HTTPStatusFromError(err), err.Error())
	}
	return resp, nil
}
