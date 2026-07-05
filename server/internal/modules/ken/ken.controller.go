package ken

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
	return &Controller{service: service, logger: logger.Named("[ken_controller]")}
}

// Transfer godoc
// @Summary      Tặng/chuyển ken cho user khác
// @Description  Chuyển ken từ user hiện tại sang user khác; ghi 2 ken_transactions (TRANSFER_OUT/IN) và bắn KEN_UPDATED cho cả 2 phía
// @Tags         ken
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body TransferRequest true "Transfer request"
// @Success      200  {object}  TransferSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /ken/transfer [post]
func (ctrl *Controller) Transfer(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	req, err := utils.BindJSON[TransferRequest](c)
	if err != nil {
		return nil, err
	}

	resp, err := ctrl.service.Transfer(userID, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// History godoc
// @Summary      Lịch sử giao dịch ken của user hiện tại
// @Description  Danh sách ken_transactions của user đang đăng nhập, mới nhất trước; lọc theo direction (credit/debit) và phân trang
// @Tags         ken
// @Produce      json
// @Security     BearerAuth
// @Param        direction query string false "Lọc chiều giao dịch (credit=nhận, debit=chi)"
// @Param        limit     query int    false "Số bản ghi mỗi trang (mặc định 20, tối đa 100)"
// @Param        offset    query int    false "Vị trí bắt đầu (mặc định 0)"
// @Success      200  {object}  KenHistorySuccessResponse
// @Failure      401  {object}  utils.APIError
// @Router       /ken/transactions [get]
func (ctrl *Controller) History(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}

	direction := c.Query("direction")
	if direction != "credit" && direction != "debit" {
		direction = ""
	}

	resp, err := ctrl.service.History(userID, direction, utils.ParseLimit(c, 20, 100), utils.ParseOffset(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
