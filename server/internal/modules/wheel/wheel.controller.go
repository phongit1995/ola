package wheel

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
	return &Controller{service: service, logger: logger.Named("[wheel_controller]")}
}

// GetConfig godoc
// @Summary      Cấu hình vòng quay may mắn cho người chơi
// @Tags         wheel
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  PlayerConfigResponse
// @Failure      404  {object}  utils.APIError
// @Router       /wheel [get]
func (ctrl *Controller) GetConfig(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.PlayerConfig(userID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Spin godoc
// @Summary      Quay vòng quay may mắn
// @Tags         wheel
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body SpinRequest false "Idempotency"
// @Success      200  {object}  SpinResult
// @Failure      400  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /wheel/spins [post]
func (ctrl *Controller) Spin(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	var req SpinRequest
	_ = c.ShouldBindJSON(&req)

	result, err := ctrl.service.SpinFirstEnabled(userID, req.IdempotencyKey)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return result, nil
}

// ListSpins godoc
// @Summary      Lịch sử quay của tôi
// @Tags         wheel
// @Produce      json
// @Security     BearerAuth
// @Param        outcome query string false "Filter: win or miss"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  SpinListResponse
// @Router       /wheel/spins [get]
func (ctrl *Controller) ListSpins(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	outcome := c.Query("outcome")
	if outcome != "win" && outcome != "miss" {
		outcome = ""
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListHistory(userID, outcome, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
