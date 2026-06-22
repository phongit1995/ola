package marriage

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
	return &Controller{service: service, logger: logger.Named("[marriage_controller]")}
}

// Propose godoc
// @Summary      Gửi lời cầu hôn
// @Tags         marriage
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body ProposeRequest true "Proposal"
// @Success      201  {object}  ProposeSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /marriage/proposals [post]
func (ctrl *Controller) Propose(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[ProposeRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Propose(userID, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListProposals godoc
// @Summary      Danh sách lời cầu hôn
// @Tags         marriage
// @Produce      json
// @Security     BearerAuth
// @Param        direction query string false "incoming | outgoing (default incoming)"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  ProposalListSuccessResponse
// @Router       /marriage/proposals [get]
func (ctrl *Controller) ListProposals(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	direction := c.Query("direction")
	if direction != "outgoing" {
		direction = "incoming"
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListProposals(userID, direction, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Accept godoc
// @Summary      Đồng ý lời cầu hôn
// @Tags         marriage
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Proposal ID"
// @Success      200  {object}  MarriageStatusSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /marriage/proposals/{id}/accept [post]
func (ctrl *Controller) Accept(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	id, err := utils.ParseUUIDParam(c, "id", "invalid proposal id")
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Accept(userID, id)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return utils.NewHandlerResult(resp, 200), nil
}

// Reject godoc
// @Summary      Từ chối lời cầu hôn
// @Tags         marriage
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Proposal ID"
// @Success      200  {object}  MessageSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /marriage/proposals/{id}/reject [post]
func (ctrl *Controller) Reject(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	id, err := utils.ParseUUIDParam(c, "id", "invalid proposal id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Reject(userID, id); err != nil {
		return nil, utils.ServiceError(err)
	}
	return utils.NewHandlerResult(MessageResponse{Message: "proposal rejected"}, 200), nil
}

// Cancel godoc
// @Summary      Huỷ lời cầu hôn của mình
// @Tags         marriage
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Proposal ID"
// @Success      200  {object}  MessageSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /marriage/proposals/{id} [delete]
func (ctrl *Controller) Cancel(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	id, err := utils.ParseUUIDParam(c, "id", "invalid proposal id")
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Cancel(userID, id); err != nil {
		return nil, utils.ServiceError(err)
	}
	return MessageResponse{Message: "proposal cancelled"}, nil
}

// GetStatus godoc
// @Summary      Trạng thái hôn nhân của tôi
// @Tags         marriage
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  MarriageStatusSuccessResponse
// @Router       /marriage [get]
func (ctrl *Controller) GetStatus(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.GetStatus(userID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Divorce godoc
// @Summary      Ly hôn
// @Tags         marriage
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  MessageSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /marriage/divorce [post]
func (ctrl *Controller) Divorce(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	if err := ctrl.service.Divorce(userID); err != nil {
		return nil, utils.ServiceError(err)
	}
	return utils.NewHandlerResult(MessageResponse{Message: "divorced"}, 200), nil
}
