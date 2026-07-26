package egg

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
	return &Controller{service: service, logger: logger.Named("[egg_controller]")}
}

// ListPacks godoc
// @Summary      Danh sách gói đập trứng đang bật
// @Tags         egg
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  PackListResponse
// @Router       /egg/packs [get]
func (ctrl *Controller) ListPacks(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.ListPacksForUser()
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListGifts godoc
// @Summary      Danh sách quà của một gói đập trứng
// @Tags         egg
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Pack ID"
// @Success      200  {object}  GiftListResponse
// @Failure      404  {object}  utils.APIError
// @Router       /egg/packs/{id}/gifts [get]
func (ctrl *Controller) ListGifts(c *gin.Context) (interface{}, error) {
	packID, err := utils.ParseUUIDParam(c, "id", "invalid pack id")
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.ListGifts(packID)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Draw godoc
// @Summary      Đập một quả trứng trong gói
// @Tags         egg
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Pack ID"
// @Param        request body OpenPackRequest false "Idempotency"
// @Success      200  {object}  OpenResult
// @Failure      400  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /egg/packs/{id}/draws [post]
func (ctrl *Controller) Draw(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	packID, err := utils.ParseUUIDParam(c, "id", "invalid pack id")
	if err != nil {
		return nil, err
	}
	var req OpenPackRequest
	_ = c.ShouldBindJSON(&req)

	result, err := ctrl.service.OpenPack(userID, packID, req.IdempotencyKey)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return result, nil
}

// ListDraws godoc
// @Summary      Lịch sử đập trứng của tôi
// @Tags         egg
// @Produce      json
// @Security     BearerAuth
// @Param        outcome query string false "Filter: win or miss"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  DrawListResponse
// @Router       /egg/draws [get]
func (ctrl *Controller) ListDraws(c *gin.Context) (interface{}, error) {
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
