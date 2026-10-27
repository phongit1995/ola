package setting

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
	return &Controller{service: service, logger: logger.Named("[setting_controller]")}
}

// TopupConfig godoc
// @Summary      Cấu hình nạp KEN (bank nhận tiền VietQR + mệnh giá) cho app
// @Description  enabled và enabledMobile cùng là kết quả bật/tắt cho đúng nền tảng và phiên bản app đang gọi, bị ẩn thì không trả bank. Thiếu X-Platform thì tính là web
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

	resp, err := ctrl.topupConfigFor(ClientFrom(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

func (ctrl *Controller) topupConfigFor(client Client) (TopupConfigResponse, error) {
	topup, err := ctrl.service.GetTopup()
	if err != nil {
		return TopupConfigResponse{}, err
	}
	bank, err := ctrl.service.GetTopupBank()
	if err != nil {
		return TopupConfigResponse{}, err
	}

	enabled := topup.EnabledFor(client.Platform, client.AppVersion)
	resp := TopupConfigResponse{
		Enabled:       enabled,
		EnabledMobile: enabled,
		MinAmount:     topup.MinAmount,
		StepAmount:    topup.StepAmount,
		PresetAmounts: topup.PresetAmounts,
		BonusTiers:    topup.BonusTiers,
	}
	if enabled && bank.AccountNumber != "" {
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
// @Description  enabled và enabledMobile cùng là kết quả bật/tắt cho đúng nền tảng và phiên bản app đang gọi. Thiếu X-Platform thì tính là web
// @Tags         settings
// @Produce      json
// @Security     BearerAuth
// @Param        X-Platform header string false "web | android | ios"
// @Param        X-App-Version header string false "Phiên bản app, ví dụ 1.0.0 (45)"
// @Success      200  {object}  UsernameChangeConfigSuccessResponse
// @Failure      401  {object}  utils.APIError
// @Router       /settings/username-change [get]
func (ctrl *Controller) UsernameChangeConfig(c *gin.Context) (interface{}, error) {
	if _, err := utils.RequireUserID(c); err != nil {
		return nil, err
	}

	resp, err := ctrl.usernameChangeConfigFor(ClientFrom(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

func (ctrl *Controller) usernameChangeConfigFor(client Client) (UsernameChangeConfigResponse, error) {
	cfg, err := ctrl.service.GetUsernameChange()
	if err != nil {
		return UsernameChangeConfigResponse{}, err
	}
	enabled := cfg.EnabledFor(client.Platform, client.AppVersion)
	return UsernameChangeConfigResponse{Enabled: enabled, EnabledMobile: enabled, Tiers: cfg.Tiers}, nil
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

// ChatBotConfig godoc
// @Summary      Bot nào đang bật và giới hạn lượt chat mỗi ngày (0 = không giới hạn)
// @Description  enabled của từng bot đã tính theo nền tảng và phiên bản app đang gọi (X-Platform, X-App-Version)
// @Tags         settings
// @Produce      json
// @Security     BearerAuth
// @Param        X-Platform header string false "web | android | ios"
// @Param        X-App-Version header string false "Phiên bản app, ví dụ 1.0.0 (45)"
// @Success      200  {object}  ChatBotPublicConfigSuccessResponse
// @Failure      401  {object}  utils.APIError
// @Router       /settings/chat-bot [get]
func (ctrl *Controller) ChatBotConfig(c *gin.Context) (interface{}, error) {
	if _, err := utils.RequireUserID(c); err != nil {
		return nil, err
	}

	resp, err := ctrl.chatBotConfigFor(ClientFrom(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

func (ctrl *Controller) chatBotConfigFor(client Client) (ChatBotPublicConfig, error) {
	cfg, err := ctrl.service.GetChatBot()
	if err != nil {
		return ChatBotPublicConfig{}, err
	}
	bots := make([]ChatBotAvailability, 0, len(ChatBotTypes()))
	for _, botType := range ChatBotTypes() {
		bots = append(bots, ChatBotAvailability{Type: botType, Enabled: cfg.Bot(botType).EnabledFor(client)})
	}
	return ChatBotPublicConfig{DailyLimit: cfg.DailyLimit, Bots: bots}, nil
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

	resp, err := ctrl.storyConfigFor(ClientFrom(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

func (ctrl *Controller) storyConfigFor(client Client) (FeatureEnabledResponse, error) {
	cfg, err := ctrl.service.GetStory()
	if err != nil {
		return FeatureEnabledResponse{}, err
	}
	return FeatureEnabledResponse{Enabled: cfg.EnabledFor(client.Platform, client.AppVersion)}, nil
}

func (ctrl *Controller) momentConfigFor(client Client) (MomentConfigResponse, error) {
	cfg, err := ctrl.service.GetMoment()
	if err != nil {
		return MomentConfigResponse{}, err
	}
	video, err := ctrl.service.GetMomentVideo()
	if err != nil {
		return MomentConfigResponse{}, err
	}
	return MomentConfigResponse{
		Enabled:          cfg.EnabledFor(client.Platform, client.AppVersion),
		VideoVipRequired: video.VipRequired,
	}, nil
}

// AppConfig godoc
// @Summary      Gộp config hệ thống cho app trong một request
// @Description  configs gồm các key topup, usernameChange, wordChain, story, chatBot, moment; nội dung mỗi key giống API riêng /settings/<tên> và đã tính theo nền tảng, phiên bản app đang gọi. Key nào lỗi thì vắng mặt, client dùng giá trị mặc định cho key đó.
// @Description  Gửi lại version đã nhận để hỏi có đổi không: không đổi thì trả notModified=true và không có configs.
// @Tags         settings
// @Produce      json
// @Security     BearerAuth
// @Param        X-Platform header string false "web | android | ios"
// @Param        X-App-Version header string false "Phiên bản app, ví dụ 1.0.0 (45)"
// @Param        keys query string false "Chỉ lấy các key này, cách nhau bởi dấu phẩy; bỏ trống là tất cả"
// @Param        version query string false "version của lần lấy trước"
// @Success      200  {object}  AppConfigSuccessResponse
// @Failure      401  {object}  utils.APIError
// @Router       /settings/app [get]
func (ctrl *Controller) AppConfig(c *gin.Context) (interface{}, error) {
	if _, err := utils.RequireUserID(c); err != nil {
		return nil, err
	}
	return collectAppConfig(ctrl.appConfigSources(), ClientFrom(c), parseAppConfigKeys(c.Query("keys")), c.Query("version"), ctrl.logger), nil
}
