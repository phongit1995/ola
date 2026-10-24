package report

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
	return &Controller{service: service, logger: logger.Named("[report_controller]")}
}

// Create godoc
// @Summary      Report a user, post, comment or message
// @Description  targetType: account, post, comment, story_comment, message, room_message, reel. contextId là conversationId (message) hoặc roomId (room_message).
// @Tags         report
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body CreateReportRequest true "Report request"
// @Success      200  {object}  utils.BaseResponse[ReportResponse]
// @Router       /reports [post]
func (ctrl *Controller) Create(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[CreateReportRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Create(c.Request.Context(), userID, req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
