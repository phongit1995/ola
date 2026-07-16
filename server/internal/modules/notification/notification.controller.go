package notification

import (
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
)

type Controller struct {
	service *Service
}

func NewController(service *Service) *Controller {
	return &Controller{service: service}
}

// List godoc
// @Summary      List my app notifications (friend requests, marriage proposals, ...)
// @Tags         notifications
// @Produce      json
// @Security     BearerAuth
// @Param        limit query int false "Page size"
// @Param        cursor query string false "Opaque keyset cursor from previous page's nextCursor"
// @Success      200  {object}  utils.BaseResponse[AppNotificationListResponse]
// @Router       /notifications [get]
func (ctrl *Controller) List(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	cursor := c.Query("cursor")
	resp, err := ctrl.service.List(userID, cursor, limit)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// UnreadCount godoc
// @Summary      Count my unread app notifications
// @Tags         notifications
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[map[string]int64]
// @Router       /notifications/unread-count [get]
func (ctrl *Controller) UnreadCount(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	count, err := ctrl.service.UnreadCount(userID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]int64{"count": count}, nil
}

// ReadAll godoc
// @Summary      Mark all my app notifications as read
// @Tags         notifications
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  map[string]string
// @Router       /notifications/read-all [post]
func (ctrl *Controller) ReadAll(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.MarkAllRead(userID); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "all notifications marked read"}, nil
}
