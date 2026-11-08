package gift

import (
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/utils"

	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type Controller struct {
	service *Service
	logger  *zap.SugaredLogger
}

func NewController(service *Service, logger *zap.SugaredLogger) *Controller {
	return &Controller{service: service, logger: logger.Named("[gift_controller]")}
}

// Catalog godoc
// @Summary      Danh sách quà đang bán + cấu hình tặng quà
// @Tags         gifts
// @Produce      json
// @Security     BearerAuth
// @Success      200  {object}  GiftCatalogSuccessResponse
// @Router       /gifts [get]
func (ctrl *Controller) Catalog(c *gin.Context) (interface{}, error) {
	resp, err := ctrl.service.Catalog(setting.ClientFrom(c))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Send godoc
// @Summary      Tặng quà cho user khác
// @Description  Trừ KEN người tặng (GIFT_SENT), cộng sức hút + tường quà cho người nhận. source=chat tạo thêm tin nhắn loại gift, source=profile tạo thông báo. clientRequestId chống trừ KEN hai lần khi gửi lại.
// @Tags         gifts
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        request body SendGiftRequest true "Gift"
// @Success      200  {object}  SendGiftSuccessResponse
// @Failure      400  {object}  utils.APIError
// @Failure      403  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Failure      409  {object}  utils.APIError
// @Router       /gifts/send [post]
func (ctrl *Controller) Send(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	req, err := utils.BindJSON[SendGiftRequest](c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Send(setting.ClientFrom(c), userID, *req)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Wall godoc
// @Summary      Tường quà + sức hút của một user
// @Tags         gifts
// @Produce      json
// @Security     BearerAuth
// @Param        id path string true "User ID"
// @Success      200  {object}  GiftWallSuccessResponse
// @Failure      403  {object}  utils.APIError
// @Failure      404  {object}  utils.APIError
// @Router       /gifts/users/{id}/wall [get]
func (ctrl *Controller) Wall(c *gin.Context) (interface{}, error) {
	viewerID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	id, err := utils.ParseUUIDParam(c, "id", "invalid user id")
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Wall(viewerID, id)
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Received godoc
// @Summary      Lịch sử quà mình đã nhận
// @Tags         gifts
// @Produce      json
// @Security     BearerAuth
// @Param        cursor query string false "Con trỏ trang tiếp"
// @Param        limit  query int    false "Số bản ghi (mặc định 20, tối đa 50)"
// @Success      200  {object}  GiftHistorySuccessResponse
// @Router       /gifts/received [get]
func (ctrl *Controller) Received(c *gin.Context) (interface{}, error) {
	return ctrl.history(c, HistoryDirectionReceived)
}

// Sent godoc
// @Summary      Lịch sử quà mình đã tặng
// @Tags         gifts
// @Produce      json
// @Security     BearerAuth
// @Param        cursor query string false "Con trỏ trang tiếp"
// @Param        limit  query int    false "Số bản ghi (mặc định 20, tối đa 50)"
// @Success      200  {object}  GiftHistorySuccessResponse
// @Router       /gifts/sent [get]
func (ctrl *Controller) Sent(c *gin.Context) (interface{}, error) {
	return ctrl.history(c, HistoryDirectionSent)
}

func (ctrl *Controller) history(c *gin.Context, direction string) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.History(userID, direction, c.Query("cursor"), utils.ParseLimit(c, HistoryDefaultLimit, HistoryMaxLimit))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}

// Leaderboard godoc
// @Summary      Bảng xếp hạng quà
// @Description  type=sender: tổng KEN đã tặng; type=receiver: tổng sức hút nhận được. period theo giờ Việt Nam.
// @Tags         gifts
// @Produce      json
// @Security     BearerAuth
// @Param        type   query string false "sender | receiver (mặc định receiver)"
// @Param        period query string false "week | month | all (mặc định week)"
// @Param        limit  query int    false "Số dòng (mặc định 50, tối đa 100)"
// @Success      200  {object}  LeaderboardSuccessResponse
// @Router       /gifts/leaderboard [get]
func (ctrl *Controller) Leaderboard(c *gin.Context) (interface{}, error) {
	userID, err := utils.RequireUserID(c)
	if err != nil {
		return nil, err
	}
	resp, err := ctrl.service.Leaderboard(userID, c.Query("type"), c.Query("period"), utils.ParseLimit(c, LeaderboardDefaultLimit, LeaderboardMaxLimit))
	if err != nil {
		return nil, utils.ServiceError(err)
	}
	return resp, nil
}
