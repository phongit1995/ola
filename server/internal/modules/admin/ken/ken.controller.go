package adminken

import (
	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[admin_ken_controller]")}
}

// Adjust godoc
// @Summary      Cộng/trừ ken cho user (admin)
// @Description  Admin tặng (grant) hoặc trừ (deduct) ken; ghi ken_transactions và bắn KEN_UPDATED
// @Tags         admin-ken
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        userId path string true "User ID"
// @Param        request body AdjustRequest true "Adjust request"
// @Success      200  {object}  AdjustSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /admin/ken/users/{userId}/adjust [post]
func (ctrl *Controller) Adjust(c *gin.Context) (interface{}, error) {
	userID, err := utils.ParseUUIDParam(c, "userId", "invalid user id")
	if err != nil {
		return nil, err
	}

	adminID, ok := middleware.GetAdminID(c)
	if !ok {
		return nil, utils.NewHTTPError(401, "admin not authenticated")
	}

	req, err := utils.BindJSON[AdjustRequest](c)
	if err != nil {
		return nil, err
	}

	resp, err := ctrl.service.Adjust(userID, adminID, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListTransactions godoc
// @Summary      Lịch sử giao dịch ken của user (admin)
// @Tags         admin-ken
// @Produce      json
// @Security     BearerAuth
// @Param        userId path string true "User ID"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  TransactionListSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Router       /admin/ken/users/{userId}/transactions [get]
func (ctrl *Controller) ListTransactions(c *gin.Context) (interface{}, error) {
	userID, err := utils.ParseUUIDParam(c, "userId", "invalid user id")
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)

	resp, err := ctrl.service.ListTransactions(userID, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
