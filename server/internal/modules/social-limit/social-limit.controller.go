package sociallimit

import (
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
)

type Controller struct {
	service *Service
}

func NewController(service *Service) *Controller {
	return &Controller{service: service}
}

// @Summary      Today's Me and moment posting usage of the current user (limit 0 = unlimited)
// @Tags         social-limit
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  utils.BaseResponse[PostQuotaResponse]
// @Router       /social-limit/posts [get]
func (ctrl *Controller) PostQuotas(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	return ctrl.service.PostQuotas(c.Request.Context(), userID), nil
}
