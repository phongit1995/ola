package adminsetting

import (
	"strings"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *setting.Service
	cfg     *config.Config
	logger  *zap.SugaredLogger
}

func NewController(service *setting.Service, cfg *config.Config, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, cfg: cfg, logger: logger.Named("[admin_setting_controller]")}
}

type PutSettingRequest struct {
	Value models.JSONB `json:"value" binding:"required"`
}

type SettingEntry struct {
	Key   string       `json:"key" binding:"required"`
	Value models.JSONB `json:"value" binding:"required"`
}

type PutManySettingsRequest struct {
	Items []SettingEntry `json:"items" binding:"required,min=1,max=20,dive"`
}

const maxSettingKeyLength = 100

func validSettingKey(key string) bool {
	return key != "" && len(key) <= maxSettingKeyLength
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
	for i := range items {
		items[i] = maskSensitiveSetting(items[i])
	}
	return SettingListResponse{Items: items}, nil
}

func maskSensitiveSetting(item models.AppSetting) models.AppSetting {
	if item.Key == setting.KeyPushFirebase {
		item.Value = setting.MaskPushFirebaseValue(item.Value)
	}
	return item
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
	if !validSettingKey(key) {
		return nil, utils.NewHTTPError(400, "invalid setting key")
	}
	req, err := utils.BindJSON[PutSettingRequest](c)
	if err != nil {
		return nil, err
	}
	value, err := ctrl.prepareValue(key, req.Value)
	if err != nil {
		return nil, err
	}
	item, err := ctrl.service.Put(key, value)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	if item != nil {
		masked := maskSensitiveSetting(*item)
		item = &masked
	}
	return item, nil
}

// PutMany godoc
// @Summary      Cập nhật nhiều cấu hình hệ thống trong một transaction (admin)
// @Description  Mọi key được validate trước, sau đó ghi tất cả hoặc không ghi gì
// @Tags         admin-settings
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body PutManySettingsRequest true "Danh sách key/value"
// @Success      200  {object}  SettingListSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /admin/settings [put]
func (ctrl *Controller) PutMany(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[PutManySettingsRequest](c)
	if err != nil {
		return nil, err
	}
	entries := make([]models.AppSetting, 0, len(req.Items))
	seen := make(map[string]bool, len(req.Items))
	for _, entry := range req.Items {
		key := strings.TrimSpace(entry.Key)
		if !validSettingKey(key) {
			return nil, utils.NewHTTPError(400, "invalid setting key")
		}
		if seen[key] {
			return nil, utils.NewHTTPError(400, "duplicate setting key: "+key)
		}
		seen[key] = true
		value, err := ctrl.prepareValue(key, entry.Value)
		if err != nil {
			return nil, err
		}
		entries = append(entries, models.AppSetting{Key: key, Value: value})
	}
	items, err := ctrl.service.PutMany(entries)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	for i := range items {
		items[i] = maskSensitiveSetting(items[i])
	}
	return SettingListResponse{Items: items}, nil
}

func (ctrl *Controller) prepareValue(key string, value models.JSONB) (models.JSONB, error) {
	switch key {
	case setting.KeyTopup:
		if err := setting.ValidateTopupValue(value); err != nil {
			return nil, utils.NewHTTPError(400, err.Error())
		}
	case setting.KeyUsernameChange:
		if err := setting.ValidateUsernameChangeValue(value); err != nil {
			return nil, utils.NewHTTPError(400, err.Error())
		}
	case setting.KeyPushNotification:
		if err := setting.ValidatePushNotificationValue(value); err != nil {
			return nil, utils.NewHTTPError(400, err.Error())
		}
	case setting.KeyPushFirebase:
		if err := setting.ValidatePushFirebaseValue(value); err != nil {
			return nil, utils.NewHTTPError(400, err.Error())
		}
		encrypted, err := setting.EncryptPushFirebaseValue(ctrl.cfg, value)
		if err != nil {
			return nil, utils.ServiceError(err)
		}
		return encrypted, nil
	}
	return value, nil
}
