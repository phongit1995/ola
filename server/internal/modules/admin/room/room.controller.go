package adminroom

import (
	"net/http"

	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/modules/room"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *room.Service
	logger  *zap.SugaredLogger
}

func NewController(service *room.Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[admin_room_controller]")}
}

// CreateRoom godoc
// @Summary      Create room (admin)
// @Tags         admin-room
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body room.CreateRoomRequest true "Create Room"
// @Success      201  {object}  utils.BaseResponse[room.RoomResponse]
// @Router       /admin/rooms [post]
func (ctrl *Controller) CreateRoom(c *gin.Context) (interface{}, error) {
	adminID, ok := middleware.GetAdminID(c)
	if !ok {
		return nil, utils.NewHTTPError(http.StatusUnauthorized, "unauthorized")
	}
	req, err := utils.BindJSON[room.CreateRoomRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Create(adminID, req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListRooms godoc
// @Summary      List rooms (admin, includes disabled)
// @Tags         admin-room
// @Produce      json
// @Security     BearerAuth
// @Param        q query string false "Search by name"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  utils.BaseResponse[room.RoomListResponse]
// @Router       /admin/rooms [get]
func (ctrl *Controller) ListRooms(c *gin.Context) (interface{}, error) {
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListAdmin(c.Request.Context(), c.Query("q"), limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
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
// @Param        request body room.UpdateRoomRequest true "Update Room"
// @Success      200  {object}  utils.BaseResponse[room.RoomResponse]
// @Router       /admin/rooms/{id} [patch]
func (ctrl *Controller) UpdateRoom(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid room id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[room.UpdateRoomRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Update(c.Request.Context(), id, req)
	if err != nil {
		return nil, utils.ServiceError(err)
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
	id, err := utils.ParseUUIDParam(c, "id", "invalid room id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Delete(id); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "room deleted"}, nil
}

// Messages godoc
// @Summary      Get room message history (admin, includes disabled rooms)
// @Tags         admin-room
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Room ID"
// @Param        limit query int false "Page size (default 50, max 200)"
// @Param        before query string false "Cursor: message id"
// @Success      200  {object}  utils.BaseResponse[room.RoomMessagesListResponse]
// @Router       /admin/rooms/{id}/messages [get]
func (ctrl *Controller) Messages(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid room id")
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 50, 200)
	resp, err := ctrl.service.GetMessagesAdmin(c.Request.Context(), id, limit, c.Query("before"))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
