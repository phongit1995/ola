package adminsetting

import (
	"context"
	"errors"
	"net/http"
	"strings"
	"time"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *setting.Service
	mail    *services.MailService
	cfg     *config.Config
	logger  *zap.SugaredLogger
}

func NewController(service *setting.Service, mail *services.MailService, cfg *config.Config, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, mail: mail, cfg: cfg, logger: logger.Named("[admin_setting_controller]")}
}

type PutSettingRequest struct {
	Value             models.JSONB `json:"value" binding:"required"`
	ExpectedUpdatedAt *time.Time   `json:"expectedUpdatedAt"`
}

type SettingEntry struct {
	Key   string       `json:"key" binding:"required"`
	Value models.JSONB `json:"value" binding:"required"`
}

type PutManySettingsRequest struct {
	Items []SettingEntry `json:"items" binding:"required,min=1,max=20,dive"`
}

type TestMailRequest struct {
	To string `json:"to" binding:"required,email,max=254"`
}

type TestMailResponse struct {
	To string `json:"to"`
}

type TestMailSuccessResponse = utils.BaseResponse[TestMailResponse]

const (
	maxSettingKeyLength = 100
	testMailTimeout     = 15 * time.Second
)

func isSecretSetting(key string) bool {
	return key == setting.KeyPushFirebase || key == setting.KeyMailResend
}

func validSettingKey(key string) bool {
	return key != "" && len(key) <= maxSettingKeyLength
}

type ChatBotDefaultsSuccessResponse = utils.BaseResponse[map[string]setting.ChatBotPrompt]

// ChatBotDefaults godoc
// @Summary      Câu lệnh hướng dẫn mặc định (trong code) của từng chat-bot (admin)
// @Tags         admin-settings
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  ChatBotDefaultsSuccessResponse
// @Router       /admin/settings/chat-bot/defaults [get]
func (ctrl *Controller) ChatBotDefaults(c *gin.Context) (interface{}, error) {
	return setting.ChatBotDefaultPrompts, nil
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
	switch item.Key {
	case setting.KeyPushFirebase:
		item.Value = setting.MaskPushFirebaseValue(item.Value)
	case setting.KeyMailResend:
		item.Value = setting.MaskMailResendValue(item.Value)
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
	var item *models.AppSetting
	if req.ExpectedUpdatedAt != nil {
		item, err = ctrl.service.PutIfUnchanged(key, value, *req.ExpectedUpdatedAt)
	} else {
		item, err = ctrl.service.Put(key, value)
	}
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
		if isSecretSetting(key) {
			return nil, utils.NewHTTPError(400, "setting "+key+" must be saved on its own")
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
		kept, err := ctrl.service.KeepStoredTopupPlatforms(value)
		if err != nil {
			return nil, utils.ServiceError(err)
		}
		if err := setting.ValidateTopupValue(kept); err != nil {
			return nil, utils.NewHTTPError(400, err.Error())
		}
		return kept, nil
	case setting.KeyUsernameChange:
		if err := setting.ValidateUsernameChangeValue(value); err != nil {
			return nil, utils.NewHTTPError(400, err.Error())
		}
	case setting.KeyWordChain:
		if err := setting.ValidateWordChainValue(value); err != nil {
			return nil, utils.NewHTTPError(400, err.Error())
		}
	case setting.KeyChatBot:
		if err := setting.ValidateChatBotValue(value); err != nil {
			return nil, utils.NewHTTPError(400, err.Error())
		}
	case setting.KeyStory:
		if err := setting.ValidateStoryValue(value); err != nil {
			return nil, utils.NewHTTPError(400, err.Error())
		}
	case setting.KeyStoryCrawler, setting.KeyStoryCrawlerRookies:
		if err := setting.ValidateStoryCrawlerValue(value); err != nil {
			return nil, utils.NewHTTPError(400, err.Error())
		}
	case setting.KeyStoryReading:
		if err := setting.ValidateStoryReadingValue(value); err != nil {
			return nil, utils.NewHTTPError(400, err.Error())
		}
	case setting.KeyMoment:
		if err := setting.ValidateMomentValue(value); err != nil {
			return nil, utils.NewHTTPError(400, err.Error())
		}
	case setting.KeyMomentVideo:
		if err := setting.ValidateMomentVideoValue(value); err != nil {
			return nil, utils.NewHTTPError(400, err.Error())
		}
	case setting.KeyMomentMediaPurge:
		if err := setting.ValidateMomentMediaPurgeValue(value); err != nil {
			return nil, utils.NewHTTPError(400, err.Error())
		}
	case setting.KeyAnalytics:
		normalized, err := setting.ValidateAnalyticsValue(value)
		if err != nil {
			return nil, utils.NewHTTPError(400, err.Error())
		}
		return normalized, nil
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
	case setting.KeyMailResend:
		input, err := setting.ValidateMailResendValue(value)
		if err != nil {
			return nil, utils.NewHTTPError(400, err.Error())
		}
		stored, err := ctrl.service.BuildMailResendValue(ctrl.cfg, input)
		if err != nil {
			return nil, utils.ServiceError(err)
		}
		return stored, nil
	}
	return value, nil
}

// TestMail godoc
// @Summary      Gửi email thử bằng cấu hình email đang dùng (admin)
// @Tags         admin-settings
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body TestMailRequest true "Địa chỉ nhận"
// @Success      200  {object}  TestMailSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /admin/settings/mail/test [post]
func (ctrl *Controller) TestMail(c *gin.Context) (interface{}, error) {
	req, err := utils.BindJSON[TestMailRequest](c)
	if err != nil {
		return nil, err
	}
	ctx, cancel := context.WithTimeout(c.Request.Context(), testMailTimeout)
	defer cancel()
	if err := ctrl.mail.SendTest(ctx, req.To); err != nil {
		if errors.Is(err, services.ErrMailNotConfigured) {
			return nil, utils.NewHTTPError(http.StatusBadRequest, "Chưa cấu hình API key Resend")
		}
		return nil, utils.NewHTTPError(http.StatusBadRequest, "Gửi email thử thất bại: "+err.Error())
	}
	return TestMailResponse{To: req.To}, nil
}
