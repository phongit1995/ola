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
// @Tags         settings
// @Produce      json
// @Security     BearerAuth
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

	resp := TopupConfigResponse{
		Enabled:       topup.Enabled,
		MinAmount:     topup.MinAmount,
		StepAmount:    topup.StepAmount,
		PresetAmounts: topup.PresetAmounts,
		KenPerVnd:     topup.KenPerVnd,
	}
	if bank.AccountNumber != "" {
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
