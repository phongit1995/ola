package announcement

import (
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[announcement_controller]")}
}

// Latest godoc
// @Summary      Thông báo đang hoạt động mới nhất
// @Tags         announcement
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  LatestAnnouncementResponse
// @Router       /announcements/latest [get]
func (ctrl *Controller) Latest(c *gin.Context) (interface{}, error) {
	item, err := ctrl.service.LatestActive()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return LatestAnnouncementResponse{Announcement: item}, nil
}
