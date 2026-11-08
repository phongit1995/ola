package giftcode

import (
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

type Controller struct {
	service *Service
}

func NewController(service *Service) *Controller {
	return &Controller{service: service}
}

// Redeem godoc
// @Summary      Nhập mã quà tặng
// @Description  Mỗi người nhận 1 lần mỗi đợt. Nhập sai mã 5 lần trong 1 phút thì bị chặn 15 phút (GIFT_CODE_TOO_MANY_ATTEMPTS)
// @Tags         gift-codes
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        X-Platform header string false "web | android | ios"
// @Param        request body RedeemRequest true "Code"
// @Success      200  {object}  utils.BaseResponse[RedeemResponse]
// @Failure      400  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Failure      409  {object}  utils.APIError
// @Failure      429  {object}  utils.APIError
// @Router       /gift-codes/redeem [post]
func (ctrl *Controller) Redeem(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[RedeemRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Redeem(RedeemInput{
		UserID:    userID,
		SessionID: sessionIDFrom(c),
		Code:      req.Code,
		Client:    setting.ClientFrom(c),
		IP:        c.ClientIP(),
	})
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

func sessionIDFrom(c *gin.Context) uuid.UUID {
	if v, ok := c.Get("session_id"); ok {
		if id, ok := v.(uuid.UUID); ok {
			return id
		}
	}
	return uuid.Nil
}
