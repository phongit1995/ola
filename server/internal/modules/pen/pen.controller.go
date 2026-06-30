package pen

import (
	"strconv"

	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[pen_controller]")}
}

func parseIntQuery(c *gin.Context, key string) *int {
	s := c.Query(key)
	if s == "" {
		return nil
	}
	n, err := strconv.Atoi(s)
	if err != nil {
		return nil
	}
	return &n
}

// CreateShot godoc
// @Summary      Tạo lượt sút PEN (đặt cược + chọn hướng)
// @Tags         pen
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body CreateShotRequest true "Shot"
// @Success      201  {object}  CreateShotSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Router       /pen/shots [post]
func (ctrl *Controller) CreateShot(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[CreateShotRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.CreateShot(userID, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListOpenShots godoc
// @Summary      Danh sách lượt sút đang chờ (của người khác)
// @Tags         pen
// @Produce      json
// @Security     BearerAuth
// @Param        bet query int false "Lọc đúng mức cược"
// @Param        minBet query int false "Cược tối thiểu"
// @Param        maxBet query int false "Cược tối đa"
// @Param        sort query string false "newest | bet_desc | bet_asc"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  ShotListSuccessResponse
// @Router       /pen/shots [get]
func (ctrl *Controller) ListOpenShots(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	filter := OpenFilter{
		Bet:    parseIntQuery(c, "bet"),
		MinBet: parseIntQuery(c, "minBet"),
		MaxBet: parseIntQuery(c, "maxBet"),
		Sort:   c.Query("sort"),
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListOpenShots(userID, filter, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// ListMyOpenShots godoc
// @Summary      Lượt sút đang chờ của tôi (để huỷ)
// @Tags         pen
// @Produce      json
// @Security     BearerAuth
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  ShotListSuccessResponse
// @Router       /pen/mine [get]
func (ctrl *Controller) ListMyOpenShots(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListMyOpenShots(userID, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Catch godoc
// @Summary      Chụp một lượt PEN (chọn hướng)
// @Tags         pen
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Shot ID"
// @Param        request body CatchRequest true "Catch"
// @Success      200  {object}  CatchSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /pen/shots/{id}/catch [post]
func (ctrl *Controller) Catch(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	id, err := utils.ParseUUIDParam(c, "id", "invalid pen shot id")
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[CatchRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.CatchShot(userID, id, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return utils.NewHandlerResult(resp, 200), nil
}

// Cancel godoc
// @Summary      Huỷ lượt sút của tôi (hoàn cược)
// @Tags         pen
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "Shot ID"
// @Success      200  {object}  CancelSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /pen/shots/{id}/cancel [post]
func (ctrl *Controller) Cancel(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	id, err := utils.ParseUUIDParam(c, "id", "invalid pen shot id")
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.CancelShot(userID, id)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return utils.NewHandlerResult(resp, 200), nil
}

// History godoc
// @Summary      Lịch sử sút/chụp PEN của tôi
// @Tags         pen
// @Produce      json
// @Security     BearerAuth
// @Param        role query string false "all | shoot | catch (default all)"
// @Param        result query string false "win | lose"
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  ShotListSuccessResponse
// @Router       /pen/history [get]
func (ctrl *Controller) History(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	role := c.Query("role")
	if role != "shoot" && role != "catch" {
		role = "all"
	}
	result := c.Query("result")
	if result != "win" && result != "lose" {
		result = ""
	}
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListHistory(userID, role, result, limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// AllHistory godoc
// @Summary      Lịch sử các lượt đã xử lý của tất cả mọi người
// @Tags         pen
// @Produce      json
// @Security     BearerAuth
// @Param        limit query int false "Page size"
// @Param        offset query int false "Offset"
// @Success      200  {object}  ShotListSuccessResponse
// @Router       /pen/history/all [get]
func (ctrl *Controller) AllHistory(c *gin.Context) (interface{}, error) {
	limit := utils.ParseLimit(c, 20, 100)
	offset := utils.ParseOffset(c)
	resp, err := ctrl.service.ListAllHistory(limit, offset)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
