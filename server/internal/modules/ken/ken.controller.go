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
