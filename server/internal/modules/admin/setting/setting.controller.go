package adminsetting

import (
	"strings"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *setting.Service
	logger  *zap.SugaredLogger
}

func NewController(service *setting.Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[admin_setting_controller]")}
}

type PutSettingRequest struct {
	Value models.JSONB `json:"value" binding:"required"`
}

type SettingListResponse struct {
	Items []models.AppSetting `json:"items"`
}

type SettingListSuccessResponse = utils.BaseResponse[SettingListResponse]
type SettingItemSuccessResponse = utils.BaseResponse[models.AppSetting]

// List godoc
// @Summary      Danh sách cấu hình hệ thống (admin)
// @Tags         admin-settings
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  SettingListSuccessResponse
// @Router       /admin/settings [get]
func (ctrl *Controller) List(c *gin.Context) (interface{}, error) {
	items, err := ctrl.service.List()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return SettingListResponse{Items: items}, nil
}

// Put godoc
// @Summary      Tạo/cập nhật một cấu hình hệ thống theo key (admin)
// @Tags         admin-settings
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        key path string true "Setting key"
// @Param        request body PutSettingRequest true "Setting value"
// @Success      200  {object}  SettingItemSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /admin/settings/{key} [put]
func (ctrl *Controller) Put(c *gin.Context) (interface{}, error) {
	key := strings.TrimSpace(c.Param("key"))
	if key == "" || len(key) > 100 {
		return nil, utils.NewHTTPError(400, "invalid setting key")
	}
	req, err := utils.BindJSON[PutSettingRequest](c)
	if err != nil {
		return nil, err
	}
	if key == setting.KeyUsernameChange {
		if err := setting.ValidateUsernameChangeValue(req.Value); err != nil {
			return nil, utils.NewHTTPError(400, err.Error())
		}
	}
	item, err := ctrl.service.Put(key, req.Value)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return item, nil
}
