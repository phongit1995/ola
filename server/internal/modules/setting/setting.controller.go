package setting

import (
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[setting_controller]")}
}

// TopupConfig godoc
// @Summary      Cấu hình nạp KEN (bank nhận tiền VietQR + mệnh giá) cho app
// @Description  Có X-Platform thì enabled và enabledMobile cùng là kết quả bật/tắt cho đúng nền tảng và phiên bản app đang gọi, bị ẩn thì không trả bank. Thiếu X-Platform (bản app cũ) thì trả enabled và enabledMobile như cấu hình gốc
// @Tags         settings
// @Produce      json
// @Security     BearerAuth
// @Param        X-Platform header string false "web | android | ios"
// @Param        X-App-Version header string false "Phiên bản app, ví dụ 1.0.0 (45)"
// @Success      200  {object}  TopupConfigSuccessResponse
// @Failure      401  {object}  utils.APIError
// @Router       /settings/topup [get]
func (ctrl *Controller) TopupConfig(c *gin.Context) (interface{}, error) {
	if _, err := utils.RequireUserID(c); err != nil {
		return nil, err
	}

	topup, err := ctrl.service.GetTopup()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	bank, err := ctrl.service.GetTopupBank()
	if err != nil {
		return nil, utils.ServiceError(err)
	}

	access := topup.AccessFor(
		c.GetHeader(constants.HeaderPlatform),
		c.GetHeader(constants.HeaderAppVersion),
		c.GetHeader("User-Agent"),
	)
	resp := TopupConfigResponse{
		Enabled:       access.Enabled,
		EnabledMobile: access.EnabledMobile,
		MinAmount:     topup.MinAmount,
		StepAmount:    topup.StepAmount,
		PresetAmounts: topup.PresetAmounts,
		BonusTiers:    topup.BonusTiers,
	}
	if access.ShowBank && bank.AccountNumber != "" {
		resp.Bank = &TopupBankInfo{
			BankName:      bank.BankName,
			BankBin:       bank.BankBin,
			AccountNumber: bank.AccountNumber,
			AccountName:   bank.AccountName,
			MemoTemplate:  bank.MemoTemplate,
		}
	}
	return resp, nil
}

// UsernameChangeConfig godoc
// @Summary      Cấu hình phí đổi username theo độ dài (tính bằng KEN)
// @Tags         settings
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  UsernameChangeConfigSuccessResponse
// @Failure      401  {object}  utils.APIError
// @Router       /settings/username-change [get]
func (ctrl *Controller) UsernameChangeConfig(c *gin.Context) (interface{}, error) {
	if _, err := utils.RequireUserID(c); err != nil {
		return nil, err
	}

	cfg, err := ctrl.service.GetUsernameChange()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return cfg, nil
}

// WordChainConfig godoc
// @Summary      Cấu hình phòng nối từ (bật/tắt, giá gợi ý và giá mua thêm lượt tính bằng KEN)
// @Tags         settings
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  WordChainConfigSuccessResponse
// @Failure      401  {object}  utils.APIError
// @Router       /settings/word-chain [get]
func (ctrl *Controller) WordChainConfig(c *gin.Context) (interface{}, error) {
	if _, err := utils.RequireUserID(c); err != nil {
		return nil, err
	}

	cfg, err := ctrl.service.GetWordChain()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return cfg, nil
}

// StoryConfig godoc
// @Summary      Truyện có đang bật cho app đang gọi không
// @Description  Server đọc nền tảng (web | android | ios) và phiên bản app từ header, so với cấu hình bật/tắt và danh sách bản bị tắt của nền tảng đó. Thiếu X-Platform thì tính là web
// @Tags         settings
// @Produce      json
// @Security     BearerAuth
// @Param        X-Platform header string false "web | android | ios"
// @Param        X-App-Version header string false "Phiên bản app, ví dụ 1.0.0 (45)"
// @Success      200  {object}  FeatureEnabledSuccessResponse
// @Failure      401  {object}  utils.APIError
// @Router       /settings/story [get]
func (ctrl *Controller) StoryConfig(c *gin.Context) (interface{}, error) {
	if _, err := utils.RequireUserID(c); err != nil {
		return nil, err
	}

	cfg, err := ctrl.service.GetStory()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	enabled := cfg.EnabledFor(c.GetHeader(constants.HeaderPlatform), c.GetHeader(constants.HeaderAppVersion))
	return FeatureEnabledResponse{Enabled: enabled}, nil
}
