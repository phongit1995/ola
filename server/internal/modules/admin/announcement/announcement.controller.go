package adminannouncement

import (
	"ola-chat-server/internal/modules/announcement"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *announcement.Service
	logger  *zap.SugaredLogger
}

func NewController(service *announcement.Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[admin_announcement_controller]")}
}

// List godoc
// @Summary      Danh sách thông báo (admin)
// @Tags         admin-announcement
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  announcement.AnnouncementListResponse
// @Router       /admin/announcements [get]
func (ctrl *Controller) List(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.ListAll()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Create godoc
// @Summary      Tạo thông báo (admin)
// @Tags         admin-announcement
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body announcement.CreateAnnouncementRequest true "Announcement"
// @Success      200  {object}  announcement.AnnouncementResponse
// @Router       /admin/announcements [post]
func (ctrl *Controller) Create(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[announcement.CreateAnnouncementRequest](c)
	if err != nil {
		return nil, err
	}
	item, err := ctrl.service.Create(*req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return item, nil
}

// Update godoc
// @Summary      Cập nhật thông báo (admin)
// @Tags         admin-announcement
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Announcement ID"
// @Param        request body announcement.UpdateAnnouncementRequest true "Announcement"
// @Success      200  {object}  announcement.AnnouncementResponse
// @Failure      404  {object}  utils.APIError
// @Router       /admin/announcements/{id} [patch]
func (ctrl *Controller) Update(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid announcement id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[announcement.UpdateAnnouncementRequest](c)
	if err != nil {
		return nil, err
	}
	item, err := ctrl.service.Update(id, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return item, nil
}

// Delete godoc
// @Summary      Xoá thông báo (admin)
// @Tags         admin-announcement
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Announcement ID"
// @Success      200  {object}  map[string]string
// @Failure      404  {object}  utils.APIError
// @Router       /admin/announcements/{id} [delete]
func (ctrl *Controller) Delete(c *gin.Context) (interface{}, error) {
	id, err := utils.ParseUUIDParam(c, "id", "invalid announcement id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Delete(id); err != nil {
		return nil, utils.ServiceError(err)
	}
	return map[string]string{"message": "announcement deleted"}, nil
}
